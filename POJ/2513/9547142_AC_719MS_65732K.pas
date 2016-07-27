program sticks(input,output);
var
   f		   : array[0..500000] of longint;
   x,y		   : array[0..250000] of string[10];
   numberx,numbery : array[0..500000] of longint;
   out		   : array[0..500000] of longint;
   tire		   : array[0..1000000,'a'..'z'] of longint;
   v		   : array[0..1000000] of boolean;
   r		   : array[0..1000000] of longint;
   n,node,color	   : longint;
function getfather(x: longint ):longint;
begin
   if f[x]=x then
      exit(x);
   f[x]:=getfather(f[x]);
   exit(f[x]);
end; { getfather }
procedure insect_tire(s :string );
var
   i,now : longint;
begin
   now:=1;
   for i:=1 to length(s) do
   begin
      if tire[now,s[i]]<>0 then
	 now:=tire[now,s[i]]
      else
      begin
	 inc(node);
	 tire[now,s[i]]:=node;
	 now:=node;
      end;
   end;
   v[now]:=true;
   inc(color);
   r[now]:=color;
end; { insect_tire }
function find_tire(s :string ):boolean;
var
   now,i : longint;
begin
   now:=1;
   for i:=1 to length(s) do
   begin
      if tire[now,s[i]]=0 then
	 exit(false);
      now:=tire[now,s[i]];
   end;
   if v[now] then
      exit(true)
   else
      exit(false);
end; { find_tire }
function getnumber_tire(s :string ):longint;
var
   now,i : longint;
begin
   now:=1;
   for i:=1 to length(s) do
      now:=tire[now,s[i]];
   exit(r[now]);
end; { getnumber_tire }
procedure init;
var
   ch : char;
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
   node:=1;
   color:=0;
   for i:=1 to n do
   begin
      if not find_tire(x[i]) then
	 insect_tire(x[i]);
      numberx[i]:=getnumber_tire(x[i]);
      if not find_tire(y[i]) then
	 insect_tire(y[i]);
      numbery[i]:=getnumber_tire(y[i]);
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
   for i:=1 to color do
      if odd(out[i]) then
	 inc(tmp);
   if (tmp<>0)and(tmp<>2) then
   begin
      writeln('Impossible');
      halt;
   end;
   for i:=1 to color do
      f[i]:=i;
   for i:=1 to n do
   begin
      xx:=getfather(numberx[i]);
      yy:=getfather(numbery[i]);
      if xx<>yy then
	 f[yy]:=xx;
   end;
   tmp:=getfather(1);
   for i:=1 to color do
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