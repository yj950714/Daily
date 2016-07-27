program pku2421(input,output);
var
   father	: array[0..200] of longint;
   f		: array[0..200,0..200] of longint;
   x,y,w	: array[0..40000] of longint;
   n,m,q,answer	: longint;
procedure init;
var
   i,j : longint;
begin
   readln(n);
   for i:=1 to n do
      father[i]:=i;
   m:=0;
   for i:=1 to n do
   begin
      for j:=1 to n do
      begin
	 read(f[i,j]);
	 if (i<=j)and(f[i,j]<>0) then
	 begin
	    inc(m);
	    x[m]:=i;
	    y[m]:=j;
	    w[m]:=f[i,j];
	 end;
      end;
      readln;
   end;
end; { init }
procedure swap(var aa,bb :longint );
var
   tt : longint;
begin
   tt:=aa;
   aa:=bb;
   bb:=tt;
end; { swap }
procedure sort(p,q :longint );
var
   i,j,mm : longint;
begin
   i:=p;
   j:=q;
   mm:=w[(i+j)>>1];
   repeat
      while w[i]<mm do
	 inc(i);
      while w[j]>mm do
	 dec(j);
      if i<=j then
      begin
	 swap(w[i],w[j]);
	 swap(x[i],x[j]);
	 swap(y[i],y[j]);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
function getfather(x :longint ):longint;
begin
   if father[x]=x then
      exit(x);
   father[x]:=getfather(father[x]);
   exit(father[x]);
end; { getfather }
function check():boolean;
var
   i : longint;
begin
   for i:=2 to n do
      if getfather(1)<>getfather(i) then
	 exit(false);
   exit(true);
end; { check }
procedure main;
var
   i	 : longint;
   xx,yy : longint;
begin
   readln(q);
   for i:=1 to q do
   begin
      readln(xx,yy);
      xx:=getfather(xx);
      yy:=getfather(yy);
      if xx<>yy then
	 father[xx]:=yy;
   end;
   for i:=1 to m do
   begin
      xx:=getfather(x[i]);
      yy:=getfather(y[i]);
      if xx=yy then
	 continue
      else
      begin
	 inc(answer,w[i]);
	 father[xx]:=yy;
	 if check then
	    break;
      end;
   end;
   writeln(answer);
end; { main }
begin
   init;
   sort(1,m);
   main;
end.