program pku2027(input,output);
var
   x,y:longint;
begin
   while not eof do
   begin
     readln(x,y);
     if x<y then
       writeln('NO BRAINS')
     else
       writeln('MMM BRAINS');
   end;
end.