program pku1258(input,output);
var
   x,y,w  : array[0..20000] of longint;
   n,m	  : longint;
   father : array[0..201] of longint;
   answer : longint;
procedure init;
var
   i,j,xx : longint;
begin
   readln(n);
   m:=0;
   for i:=1 to n do
      for j:=1 to n do
      begin
	 read(xx);
	 if (xx>0)and(i<>j) then
	 begin
	    inc(m);
	    x[m]:=i;
	    y[m]:=j;
	    w[m]:=xx;
	 end;
      end;
   for i:=1 to n do
      father[i]:=i;
end; { init }
procedure swap(var aa,bb :longint );
var
   tt : longint;
begin
   tt:=aa;
   aa:=bb;
   bb:=tt;
end; { swap }
procedure sort(p,q : longint);
var
   i,j,mid : longint;
begin
   i:=p;
   j:=q;
   mid:=w[(i+j)>>1];
   repeat
      while w[i]<mid do
	 inc(i);
      while w[j]>mid do
	 dec(j);
      if i<=j then
      begin
	 swap(x[i],x[j]);
	 swap(y[i],y[j]);
	 swap(w[i],w[j]);
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
      exit(father[x]);
   father[x]:=getfather(father[x]);
   exit(father[x]);
end; { getfather }
procedure main;
var
   sum	     : longint;
   xx,yy,now : longint;
begin
   sort(1,m);
   answer:=0;
   sum:=0;
   now:=0;
   for now:=1 to m do
   begin
      xx:=getfather(x[now]);
      yy:=getfather(y[now]);
      if xx=yy then
	 continue
      else
      begin
	 father[xx]:=yy;
	 inc(sum);
	 inc(answer,w[now]);
      end;
      if sum=n-1 then
	 break;
   end;
   writeln(answer);
end; { main }
begin
   while not eof do
   begin
      init;
      main;
   end;
end.