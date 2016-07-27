program pku3660(input,output);
var
   g	  : array[0..101,0..101] of boolean;
   answer : longint;
   n,m	  : longint;
procedure init;
var
   i,x,y : longint;
begin
   fillchar(g,sizeof(g),false);
   readln(n,m);
   for i:=1 to m do
   begin
      readln(x,y);
      g[x,y]:=true;
   end;
end; { init }
procedure floyd();
var
   i,j,k : longint;
begin
   for k:=1 to n do
      for i:=1 to n do
	 if (i<>k) then 
	    for j:=1 to n do
	       if (k<>j)and(i<>j) then
		  g[i,j]:=g[i,j] or(g[i,k] and g[k,j]);
end; { floyd }
procedure main;
var
   i,j : longint;
   sum : longint;
begin
   answer:=0;
   for i:=1 to n do
   begin
      sum:=0;
      for j:=1 to n do
	 if (i<>j) then
	    if (g[i,j])or(g[j,i]) then
	       inc(sum);
      if sum=n-1 then
	 inc(answer);
   end;
end; { main }
procedure print;
begin
   writeln(answer);
end; { print }
begin
   init;
   floyd;
   main;
   print;
end.