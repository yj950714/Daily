program pku3264(input,output);
var
   f,g : array[0..200001,0..18] of longint;
   n,q : longint;
procedure init;
var
   i : longint;
begin
   readln(n,q);
   for i:=1 to n do
   begin
      readln(f[i,0]);
      g[i,0]:=f[i,0];
   end;
end; { init }
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
function max(aa,bb :longint ):longint;
begin
   if aa>bb then
      exit(aa);
   exit(bb);
end; { max }
procedure main;
var
   i,j : longint;
begin
   for j:=1 to trunc(ln(n)/ln(2)) do
      for i:=1 to n do
	 if i+1<<(j-1)>n then
	    break
	 else
	 begin
	    f[i,j]:=min(f[i,j-1],f[i+1<<(j-1),j-1]);
	    g[i,j]:=max(g[i,j-1],g[i+1<<(j-1),j-1]);
	 end;
end; { main }
procedure solve();
var
   i,x,y,t : longint;
begin
   for i:=1 to q do
   begin
      readln(x,y);
      t:=trunc(ln(y-x+1)/ln(2));
      writeln(max(g[x,t],g[y-1<<t+1,t])-min(f[x,t],f[y-1<<t+1,t]));
   end;
end; { solve }
begin
   init;
   main;
   solve;
end.