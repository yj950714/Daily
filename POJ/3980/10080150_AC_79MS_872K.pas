program pku3980(input,output);
var
   x,y:longint;
begin
   while not eof do
   begin
     readln(x,y);
     writeln(x mod y);
   end;
end.