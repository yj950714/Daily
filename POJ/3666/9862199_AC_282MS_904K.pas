program grading(input,output);
var
   f	  : array[0..1,0..2001] of longint;
   a,b	  : array[0..2001] of longint;
   n,i	  : longint;
   answer : int64;
procedure init;
var
   i : longint;
begin
   answer:=maxlongint;
   readln(n);
   for i:=1 to n do
      readln(a[i]);
   b:=a;
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
   i,j,m : longint;
begin
   i:=p;
   j:=q;
   m:=b[(i+j)>>1];
   repeat
      while b[i]<m do
	 inc(i);
      while b[j]>m do
	 dec(j);
      if i<=j then
      begin
	 swap(b[i],b[j]);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
procedure main;
var
   i,j,now,old : longint;
begin
   now:=1;
   sort(1,n);
   f[now,1]:=abs(a[1]-b[1]);
   for i:=2 to n do
      f[now,i]:=min(f[now,i-1],abs(a[1]-b[i]));
   for i:=2 to n do
   begin
      old:=now;
      now:=1-now;
      f[now,1]:=f[old,1]+abs(a[i]-b[1]);
      for j:=2 to n do
	 f[now,j]:=min(f[old,j]+abs(a[i]-b[j]),f[now,j-1]);
   end;
   if f[now,n]<answer then
      answer:=f[now,n];
end; { main }
procedure print;
begin
   writeln(answer);
end; { print }
begin
   init;
   main;
   for i:=1 to n do
   begin
      a[i]:=-a[i];
      b[i]:=-b[i];
   end;
   main;
   print;
end.