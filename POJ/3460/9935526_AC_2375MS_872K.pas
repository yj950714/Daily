program pku3460(input,output);
type
   numbertype = array[0..16] of integer;
var
   state   : numbertype;
   n,sum   : integer;
   depth   : integer;
   flag	   : boolean;
   v,cases : integer;
function check(a: numbertype ):integer;
var
   sum,i : integer;
begin
   sum:=0;
   for i:=1 to n-1 do
      if a[i+1]<>a[i]+1 then
	 inc(sum);
   exit(sum+1);
end; { check }
procedure init;
var
   i : integer;
begin
   readln(n);
   for i:=1 to n do
      read(state[i]);
end; { init }
procedure change(x,y,z :longint );
var
   i,now : longint;
   tmp	 : numbertype;
begin
   fillchar(tmp,sizeof(tmp),0);
   for i:=1 to x-1 do
      tmp[i]:=state[i];
   now:=x-1;
   for i:=y+1 to z do
   begin
      inc(now);
      tmp[now]:=state[i];
   end;
   for i:=x to y do
   begin
      inc(now);
      tmp[now]:=state[i];
   end;
   for i:=z+1 to n do
      tmp[i]:=state[i];
   state:=tmp;
end; { change }
procedure dfs(now: integer );
var
   i,j,k : integer;
   tmp	 : numbertype;
begin
   if now>depth then
      exit;
   for i:=1 to n do
      if state[i]>state[i+1] then
	 break;
   if i=n then
      flag:=true;
   sum:=check(state);
   if (sum-3*(depth-now+1)>=0) then
      exit;
   if flag then
      exit;
   tmp:=state;
   for i:=1 to n-1 do
      for j:=i to n-1 do
	 for k:=j+1 to n do
	 begin
	    change(i,j,k);
	    dfs(now+1);
	    state:=tmp;
	    if flag then
	       exit;
	 end;
end; { dfs }
procedure main;
begin
   for depth:=0 to 4 do
   begin
      flag:=false;
      dfs(0);
      if flag then
	 break;
   end;
   if flag then
      writeln(depth)
   else
      writeln('5 or more');
end; { main }
begin
   readln(cases);
   for v:=1 to cases do
   begin
      init;
      main;
   end;
end.