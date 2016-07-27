program pku1548(input,output);
var
   f   : array[0..1000] of longint;
   x,y : array[0..1000] of longint;
   n   : longint;
procedure swap(var aa,bb: longint );
var
   tt : longint;
begin
   tt:=aa;
   aa:=bb;
   bb:=tt;
end; { swap }
procedure sort(p,q :longint );
var
   i,j,m1,m2 : longint;
begin
   i:=p;
   j:=q;
   m1:=x[(i+j)>>1];
   m2:=y[(i+j)>>1];
   repeat
      while (x[i]<m1)or((x[i]=m1)and(y[i]<m2)) do
	 inc(i);
      while (x[j]>m1)or((x[j]=m1)and(y[j]>m2)) do
	 dec(j);
      if i<=j then
      begin
	 swap(x[i],x[j]);
	 swap(y[i],y[j]);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
function main():longint;
var
   i,j : longint;
begin
   main:=0;
   fillchar(f,sizeof(f),0);
   for i:=1 to n do
      for j:=i-1 downto 1 do
	 if (y[i]<y[j]) then
	    if f[j]+1>f[i] then
	    begin
	       f[i]:=f[j]+1;
	       if f[i]>main then
		  main:=f[i];
	    end;
   inc(main);
end; { main }
begin
   readln(x[1],y[1]);
   while (x[1]<>-1)and(y[1]<>-1) do
   begin
      n:=2;
      readln(x[2],y[2]);
      while x[n]+y[n]<>0 do
      begin
	 inc(n);
	 readln(x[n],y[n]);
      end;
      sort(1,n);
      writeln(main);
      fillchar(x,sizeof(x),0);
      fillchar(y,sizeof(y),0);
      readln(x[1],y[1]);
   end;
end.