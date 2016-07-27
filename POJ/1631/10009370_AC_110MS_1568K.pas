program pku1631(input,output);
var
   max	   : array[0..50000] of longint;
   a,pos   : array[0..50000] of longint;
   f	   : array[0..50000] of longint;
   n,cases : longint;
   answer  : longint;
procedure init;
var
   i : longint;
begin
   readln(n);
   fillchar(max,sizeof(max),0);
   for i:=1 to n do
   begin
      pos[i]:=i;
      readln(a[i]);
   end;
   fillchar(f,sizeof(f),0);
end; { init }
function lowbit(x :longint ):longint;
begin
   exit(x and (-x));
end; { lowbit }
procedure insect(x,w : longint );
begin
   while x<=n do
   begin
      if w>max[x] then
	 max[x]:=w;
      x:=x+lowbit(x);
   end;
end; { insect }
function find(x	:longint ):longint;
begin
   find:=0;
   while x>0 do
   begin
      if max[x]>find then
	 find:=max[x];
      x:=x-lowbit(x);
   end;
end; { find }
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
   m1:=a[(i+j)>>1];
   m2:=pos[(i+j)>>1];
   repeat
      while (a[i]<m1)or((a[i]=m1)and(pos[i]<m2)) do
	 inc(i);
      while (a[j]>m1)or((a[j]=m1)and(pos[j]>m2)) do
	 dec(j);
      if i<=j then
      begin
	 swap(a[i],a[j]);
	 swap(pos[i],pos[j]);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
procedure main;
var
   i : longint;
begin
   answer:=0;
   for i:=1 to n do
   begin
      f[pos[i]]:=find(pos[i])+1;
      insect(pos[i],f[pos[i]]);
      if f[pos[i]]>answer then
	 answer:=f[pos[i]];
   end;
   writeln(answer);
end; { main }
begin
   readln(cases);
   while cases>0 do
   begin
      init;
      sort(1,n);
      main;
      dec(cases);
   end;
end.
