program pku3615(input,output);
var
   f   : array[0..400,0..400] of longint;
   n,m : longint;
   q   : longint;
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
procedure init;
var
   i,j	    : longint;
   xx,yy,ww : longint;
begin
   fillchar(f,sizeof(f),0);
   for i:=1 to 300 do
      for j:=1 to 300 do
	 if i<>j then
	    f[i,j]:=maxlongint>>1;
   readln(n,m,q);
   for i:=1 to m do
   begin
      readln(xx,yy,ww);
      f[xx,yy]:=min(f[xx,yy],ww);
   end;
end; { init }
procedure main;
var
   i,j,k : longint;
begin
   for k:=1 to n do
      for i:=1 to n do
	 if (i<>k)and(f[i,k]<(maxlongint>>1)) then
	    for j:=1 to n do
	       f[i,j]:=min(f[i,j],max(f[i,k],f[k,j]));
end; { main }
procedure print;
var
   i	 : longint;
   xx,yy : longint;
begin
   for i:=1 to q do
   begin
      readln(xx,yy);
      if f[xx,yy]<maxlongint>>1 then
	 writeln(f[xx,yy])
      else
	 writeln(-1);
   end;
end; { print }
begin
   init;
   main;
   print;
end.