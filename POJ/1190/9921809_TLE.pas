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
   readln(n,m);
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
   for i:=ri-1 downto now do
      for j:=hi-1 downto now do
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
   for i:=1 to 20 do
   begin
      mins[i]:=mins[i-1]+2*i*i;
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