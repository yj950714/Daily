program pku1183(input,output);
var
   x,y : int64;
begin
   readln(x);
   y:=x+trunc(sqrt(x*x+1));
   while true do
   begin
      if ((x*y+1) mod (y-x)=0) then
	 break;
      dec(y);
   end;
   writeln(y+((x*y+1) div (y-x)));
end.