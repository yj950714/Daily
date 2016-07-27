program pku1190(input,output);
const
   maxr	= 3000;
   maxh	= 3000;
var
   n,m,answer : longint;
   minv	      : array[0..21] of int64;
   mins	      : array[0..21] of int64;
procedure init;
begin
   readln(n);
   readln(m);
end; { init }
procedure dfs(now,ri,hi,si,vi : longint );
var
   i,j	: longint;
   maxv	: longint;
begin
   if (ri<=0)or(hi<=0)or(vi>n) then
      exit;
   if now=0 then
   begin
      if vi=n then
	 if si<answer then
	    answer:=si;
      exit;
   end;
   if si+mins[now]>answer then
      exit;
   if vi+minv[now]>n then
      exit;
   maxv:=0;
   for i:=now downto 1 do
      inc(maxv,(ri-i)*(ri-i)*(hi-i));
   if vi+maxv<n then
      exit;
   for i:=ri downto now do
      for j:=hi downto now do
	 if now=m then
	    dfs(now-1,i,j,si+2*i*j+i*i,vi+i*i*j)
	 else
	    dfs(now-1,i,j,si+2*i*j,vi+i*i*j);
end; { dfs }
procedure main;
var
   i,j : longint;
begin
   answer:=maxlongint;
   mins[0]:=1;
   for i:=1 to 20 do
   begin
      mins[i]:=mins[i-1]+2*i*i+2*i-1;
      minv[i]:=minv[i-1]+i*i*i;
   end;
   dfs(m,n+1,n+1,0,0);
end; { main }
procedure print;
begin
   if answer<>0 then
      writeln(answer)
   else
      writeln(0);
end; { print }
begin
   init;
   main;
   print;
end.