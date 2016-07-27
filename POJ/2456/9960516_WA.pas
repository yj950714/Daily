program pku2456(input,output);
var
   x	  : array[0..100010] of longint;
   n,c	  : longint;
   answer : longint;
procedure init;
var
   i : longint;
begin
   readln(n,c);
   for i:=1 to n do
      readln(x[i]);
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
   i,j,m : longint;
begin
   i:=p;
   j:=q;
   m:=x[(i+j)>>1];
   repeat
      while x[i]<m do
	 inc(i);
      while x[j]>m do
	 dec(j);
      if i<=j then
      begin
	 swap(x[i],x[j]);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
function check(limit : longint ):boolean;
var
   sum	 : longint;
   i,now : longint;
begin
   now:=1;
   sum:=1;
   for i:=1 to n do
   begin
      if x[i]-x[now]>=limit then
      begin
	 now:=i;
	 inc(sum);
      end;
      if sum>=c then
	 exit(true);
   end;
   exit(false);
end; { check }
procedure dichotomy;
var
   l,r,mid : longint;
begin
   l:=1;
   r:=x[n];
   while l+1<r do
   begin
      mid:=(l+r)>>1;
      if check(mid) then
	 l:=mid
      else
	 r:=mid-1;
   end;
   answer:=l;
end; { dichotomy }
procedure print;
begin
   writeln(answer);
end; { print }
begin
   init;
   sort(1,n);
   dichotomy;
   print;
end.