program pku1190(input,output);
const
   maxr	= 30;
   maxh	= 30;
var
   n,m,answer : longint;
   minv	      : array[0..21] of int64;
   mins	      : array[0..21] of int64;
procedure init;
begin
   readln(n);
   readln(m);
end; { init }
procedure dfs(now,v,ri,hi,s :longint );
var
   i,r,h,ss,maxv : longint;
begin
   if v<minv[now] then
      exit;
   if s+mins[now]>=answer then
      exit;
   maxv:=0;
   for i:=1 to now do
      inc(maxv,(ri-i)*(ri-i)*(hi-i));
   if maxv<v then
      exit;
   if now=0 then
   begin
      ss:=s+ri*ri;
      if ss<answer then
	 answer:=ss;
      exit;
   end;
   for r:=ri-1 downto now do
      for h:=hi-1 downto now do
	 dfs(now-1,v-r*r*h,r,h,s+ri*ri-r*r+2*r*h);
end; { dfs }
procedure main;
var
   i,r,h : longint;
begin
   answer:=19950714;
   mins[0]:=1;
   minv[0]:=0;
   for i:=1 to m do
   begin
      minv[i]:=minv[i-1]+i*i*i;
      mins[i]:=mins[i-1]+2*i*i+2*i-1;
   end;
   for r:=maxh downto m do
      for h:=maxh downto m do
	 dfs(m-1,n-r*r*h,r,h,2*r*h);
end; { main }
procedure print;
begin
   if answer=19950714 then
      writeln(0)
   else
      writeln(answer);
end; { print }
begin
   init;
   main;
   print;
end.