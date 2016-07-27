program pku1163(input,output);
var
   a,b:array[1..1000,1..1000] of longint;
   n:byte;
procedure  init;
var
   i,j:integer;
begin
   readln(n);
   for i:=1 to n do
   begin
      for j:=1 to i do
	 read(a[i,j]);
      readln;
   end;
   for i:= 1 to n do
      b[n,i]:=a[n,i];
end;
procedure main;
var
   i,j:integer;
begin
   for i:=n-1 downto 1 do
      for j:=1 to i do
      begin
	 if b[i+1,j]>b[i+1,j+1] then
	    b[i,j]:=a[i,j]+b[i+1,j]
	 else
	    b[i,j]:=a[i,j]+b[i+1,j+1];
      end;
end;
begin
   init;
   main;
   write(b[1,1]);
end.