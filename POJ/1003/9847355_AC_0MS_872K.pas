program card(input,output);
const
   maxn	= 10000;
var
   n,sum : double;
   i	 : longint;
begin
   readln(n);
   while n<>0 do
   begin
      sum:=0;
      for i:=2 to maxn do
      begin
	 sum:=sum+(1/i);
	 if sum>=n then
	    break;
      end;
      writeln(i-1,' ','card(s)');
      readln(n);
   end;
end.