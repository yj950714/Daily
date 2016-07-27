program sticks(input,output);
var
   left,right,s,time : array[0..260000] of longint;
   key		     : array[0..260000] of ansistring;
   f		     : array[0..510000] of longint;
   x,y		     : array[0..260000] of ansistring;
   numberx,numbery   : array[0..260000] of longint;
   out		     : array[0..510000] of longint;
   n,root,tot	     : longint;
procedure left_rotate(var t: longint );
var
   k : longint;
begin
   k:=right[t];
   right[t]:=left[k];
   left[k]:=t;
   s[k]:=s[t];
   s[t]:=s[left[t]]+s[right[t]]+1;
   t:=k;
end; { left_rotate }
procedure right_rotate(var t :longint );
var
   k : longint;
begin
   k:=left[t];
   left[t]:=right[k];
   right[k]:=t;
   s[k]:=s[t];
   s[t]:=s[left[t]]+s[right[t]]+1;
   t:=k;
end; { right_rotate }
procedure maintain(var t : longint;flag:boolean);
begin
   if not flag then
   begin
      if s[left[left[t]]]>s[right[t]] then
	 right_rotate(t)
      else
	 if s[right[left[t]]]>s[right[t]] then
	 begin
	    left_rotate(left[t]);
	    right_rotate(t);
	 end
	 else
	    exit;
   end
   else
   begin
      if s[right[right[t]]]>s[left[t]] then
	 left_rotate(t)
      else
	 if s[left[right[t]]]>s[left[t]] then
	 begin
	    right_rotate(right[t]);
	    left_rotate(t);
	 end
	 else
	    exit;
   end;
   maintain(left[t],false);
   maintain(right[t],true);
   maintain(t,false);
   maintain(t,true);
end; { maintain }
function getfather(x :longint ):longint;
begin
   if f[x]=x then
      exit(x);
   f[x]:=getfather(f[x]);
   exit(f[x]);
end; { getfather }
procedure insect(var t: longint;k:ansistring );
begin
   if key[t]=k then
      exit;
   if t=0 then
   begin
      inc(tot);
      t:=tot;
      left[t]:=0;
      right[t]:=0;
      s[t]:=1;
      key[t]:=k;
      time[t]:=tot;
   end
   else
      if k<key[t] then
	 insect(left[t],k)
      else
	 insect(right[t],k);
end; { insect }
function find(t	: longint;k:ansistring ):boolean;
begin
   if t=0 then
      exit(false);
   if k<key[t] then
      find:=find(left[t],k)
   else
      find:=(key[t]=k)or(find(right[t],k));
end; { find }
function getnumber(t : longint;k:ansistring ):longint;
begin
   if t=0 then
      exit(-1);
   if key[t]=k then
      exit(time[t]);
   if k<key[t] then
      exit(getnumber(left[t],k))
   else
      exit(getnumber(right[t],k));
end; { getnumber }
procedure init;
var
   ch	 : char;
begin
   n:=0;
   while not eof do
   begin
      read(ch);
      inc(n);
      x[n]:='';
      while ch<>' ' do
      begin
	 x[n]:=x[n]+ch;
	 read(ch);
      end;
      readln(y[n]);
   end;
end; { init }
procedure previous;
var
   i : longint;
begin
   root:=0;
   tot:=0;
   for i:=1 to n do
   begin
      if not find(root,x[i]) then
	 insect(root,x[i]);
      numberx[i]:=getnumber(root,x[i]);
      if not find(root,y[i]) then
	 insect(root,y[i]);
      numbery[i]:=getnumber(root,y[i]);
   end;
end; { previous }
procedure main;
var
   i	     : longint;
   tmp,xx,yy : longint;
begin
   fillchar(out,sizeof(out),0);
   for i:=1 to n do
   begin
      inc(out[numberx[i]]);
      inc(out[numbery[i]]);
   end;
   tmp:=0;
   for i:=1 to tot do
      if odd(out[i]) then
	 inc(tmp);
   if (tmp<>0)and(tmp<>2) then
   begin
      writeln('Impossible');
      halt;
   end;
   for i:=1 to tot do
      f[i]:=i;
   for i:=1 to n do
   begin
      xx:=getfather(numberx[i]);
      yy:=getfather(numbery[i]);
      if xx<>yy then
	 f[yy]:=xx;
   end;
   tmp:=getfather(1);
   for i:=1 to tot do
      if getfather(i)<>tmp then
      begin
	 writeln('Impossible');
	 halt;
      end;
   writeln('Possible');
end; { main }
begin
   init;
   previous;
   main;
end.