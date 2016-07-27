program pku1046(input,output);
type
   node	= record
	     x,y,z : longint;
	  end;
const
   oo = 10000000;
var
   color  : array[1..16] of node;
   now	  : node;
   answer : byte;
procedure init;
var
   i : longint;
begin
   for i:=1 to 16 do
      readln(color[i].x,color[i].y,color[i].z);
end; { init }
function calc(x1,x2 : node ):double;
begin
   exit(sqrt(sqr(x1.x-x2.x)+sqr(x1.y-x2.y)+sqr(x1.z-x2.z)));
end; { calc }
procedure main;
var
   i   : byte;
   min : double;
begin
   readln(now.x,now.y,now.z);
   while (now.x<>-1)or(now.y<>-1)or(now.z<>-1) do
   begin
      min:=oo;
      for i:=1 to 16 do
	 if calc(color[i],now)<min then
	 begin
	    answer:=i;
	    min:=calc(color[i],now);
	 end;
      write('(',now.x,',',now.y,',',now.z,') ');
      write('maps to ');
      writeln('(',color[answer].x,',',color[answer].y,',',color[answer].z,')');
      readln(now.x,now.y,now.z);
   end;
end; { main }
begin
   init;
   main;
end.