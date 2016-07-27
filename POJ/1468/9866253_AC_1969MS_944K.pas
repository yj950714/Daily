program pku1468(input,output);
type
   node	= record
	     x1,y1,x2,y2 : longint;
	  end;
var
   a	    : array[0..5001] of node;
   answer,n : longint;
function cover(x,y :longint ):boolean;
begin
   if (a[y].x1<=a[x].x1)and(a[x].x2<=a[y].x2) then
      if (a[y].y1<=a[x].y1)and(a[x].y2<=a[y].y2) then
	 exit(true);
   exit(false);
end; { cover }
procedure init;
var
   i : longint;
begin
   readln(n);
   for i:=1 to n do
      readln(a[i].x1,a[i].x2,a[i].y1,a[i].y2);
end; { init }
procedure main;
var
   i,j : longint;
begin
   answer:=0;
   for i:=n downto 1 do
   begin
      for j:=n downto 1 do
	 if i<>j then 
	    if cover(i,j) then
	    begin
	       inc(answer);
	       break;
	    end;
   end;
end; { main }
begin
   while not eof do
   begin
   init;
   main;
   writeln(answer);
   end;
end.