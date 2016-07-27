program pku2027(input,output);
var
   n,x,y:longint;
begin
   readln(n);
   for i:=1 to n do
   begin
     readln(x,y);
     if x<y then
       writeln('NO BRAINS')
     else
       writeln('MMM BRAINS');
   end;
end.