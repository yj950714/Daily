program pku1258(input,output);
var
   x,y,w  : array[0..20000] of longint;
   n,m	  : longint;
   father : array[0..201] of longint;
   answer : longint;
procedure clean();
begin
   fillchar(f,sizeof(f),0);
   answer:=0;
   m:=0;
end; { clean }
procedure init;
var
   i,j,xx : longint;
begin
   readln(n);
   for i:=1 to n do
   begin
      father[i]:=i;
      for j:=1 to i do
      begin
	 read(xx);
	 if (xx<>0)and(i<>j) then
	 begin
	    inc(m);
	    x[m]:=i;
	    y[m]:=j;
	    w[m]:=xx;
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
   while (sum<n-1)and(now<=m) do
   begin
      inc(now);
      xx:=getfather(x[now]);
      yy:=getfather(y[now]);
      if xx=yy then
	 continue
      else
      begin
	 inc(sum);
	 inc(answer,w[now]);
	 father[xx]:=yy;
      end;
   end;
   if sum<n-1 then
      writeln(0)
   else
      writeln(answer);
end; { main }
begin
   while not eof do
   begin
      clean;
      init;
      main;
   end;
end.