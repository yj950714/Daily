program pku3460(input,output);
type
   numbertype = array[0..16] of integer;
var
   state     : numbertype;
   n	     : integer;
   top,depth : integer;
   flag	     : boolean;
   v,cases   : integer;
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
procedure dfs(a: numbertype; now:integer );
var
   i,j,k,l,sum : integer;
   b,c,tmp     : numbertype;
begin
   fillchar(b,sizeof(b),0);
   if now>depth then
      exit;
   for i:=1 to n do
      if a[i]>a[i+1] then
	 break;
   if i=n then
      flag:=true;
   sum:=check(a);
   if (sum-3*(depth-now+1)>=0) then
      exit;
   if flag then
      exit;
   for i:=1 to n do
      for j:=i to n do
      begin
	 for k:=i to j do
	    tmp[k-i+1]:=a[k];
	 top:=0;
	 for k:=1 to n do
	    if (k<i)or(k>j) then
	    begin
	       inc(top);
	       c[top]:=a[k];
	    end;
	 for k:=1 to top+1 do
	 begin
	    b:=c;
	    for l:=top downto k do
	       b[l+(j-i+1)]:=b[l];
	    for l:=k to k+(j-i) do
	       b[l]:=tmp[l-k+1];
	    dfs(b,now+1);
	 end;
      end;
end; { dfs }
procedure main;
begin
   for depth:=0 to 4 do
   begin
      flag:=false;
      dfs(state,0);
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