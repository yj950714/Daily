program pku3661(input,output);
var
   h   : array[0..10001] of longint;
   f,g : array[0..10001,-1..501] of longint;
   n,m : longint;
procedure init;
var
   i : longint;
begin
   readln(n,m);
   for i:=1 to n do
      read(h[i]);
end; { init }
function max(aa,bb :longint ):longint;
begin
   if aa>bb then
      exit(aa);
   exit(bb);
end; { max }
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
procedure main;
var
   i,j : longint;
begin
   fillchar(f,sizeof(f),0);
   fillchar(g,sizeof(g),0);
   for i:=1 to n do
      for j:=0 to m do
      begin
	 if j>1 then
	    f[i,j]:=max(f[i-1,j-1]+h[i],f[i,j]);    
	 if j=1 then
	    f[i,j]:=max(f[i,j],g[i-1,0]+h[i]);
	 if j<=m-1 then
	    g[i,j]:=max(g[i-1,j+1],f[i-1,j+1]);
	 if j=0 then
	    g[i,j]:=max(g[i-1,0],g[i,j]);
      end;
end; { main }
procedure print;
begin
   writeln(g[n,0]);
end; { print }
begin
   init;
   main;
   print;
end.