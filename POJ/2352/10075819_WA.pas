program pku2352(input,output);
var
   c	      : array[0..40000] of longint;
   x,y,answer : array[0..40000] of longint;
   n	      : longint;
procedure init;
var
   i : longint;
begin
   readln(n);
   for i:=1 to n do
      readln(x[i],y[i]);
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
procedure insect(pos,w :longint );
begin
   while pos<=n do
   begin
      inc(c[pos],w);
      pos:=pos+(pos and(-pos));
   end;
end; { insect }
function find(pos :longint ):longint;
begin
   find:=0;
   while pos>0 do
   begin
      inc(find,c[pos]);
      pos:=pos-(pos and(-pos));
   end;
end; { find }
procedure main;
var
   i : longint;
begin
   for i:=1 to n do
   begin
      inc(answer[find(y[i])]);
      insect(y[i],1);
   end;
end; { main }
procedure print;
var
   i : longint;
begin
   for i:=0 to n-1 do
      writeln(answer[i]);
end; { print }
begin
   init;
   sort(1,n);
   main;
   print;
end.