program pku3318(input,output);
const
   maxn	= 50;
var
   x,y,z	      : array[0..501,0..501] of int64;
   left,right,answer1 : array[0..501] of int64;
   n		      : longint;
   rand		      : array[0..501] of longint;
procedure init;
var
   i,j : longint;
begin
   readln(n);
   for i:=1 to n do
   begin
      for j:=1 to n do
	 read(x[i,j]);
      readln;
   end;
   for i:=1 to n do
   begin
      for j:=1 to n do
	 read(y[i,j]);
      readln;
   end;
   for i:=1 to n do
   begin
      for j:=1 to n do
	 read(z[i,j]);
      readln;
   end;
end; { init }
function check():boolean;
var
   i : longint;
begin
   for i:=1 to n do
      if answer1[i]<>right[i] then
	 exit(false);
   exit(true);
end; { check }
procedure main;
var
   i,j	 : longint;
   cases : longint;
begin
   randomize;
   for cases:=1 to maxn do
   begin
      for i:=1 to n do
	 rand[i]:=trunc(random(20000));
      fillchar(left,sizeof(left),0);
      for i:=1 to n do
	 for j:=1 to n do
	    inc(left[i],y[i,j]*rand[j]);
      fillchar(answer1,sizeof(answer1),0);
      for i:=1 to n do
	 for j:=1 to n do
	    inc(answer1[i],left[j]*x[i,j]);
      fillchar(right,sizeof(right),0);
      for i:=1 to n do
	 for j:=1 to n do
	    inc(right[i],rand[j]*z[i,j]);
      if not check() then
      begin
	 writeln('NO');
	 exit;
      end
   end;
   writeln('YES');
end; { main }
begin
   while not eof do
   begin
      init;
      main;
   end;
end.