program pku1450(input,output);
var
   m,n	   : longint;
   answer  : double;
   cases,i : longint;
begin
   readln(cases);
   for i:=1 to cases do
   begin
      dec(cases);
      readln(n,m);
      if (not odd(n))or(not odd(m)) then
	 answer:=double(m*n)
      else
	 answer:=double(m*n)+sqrt(2)-1;
      writeln('Scenario #',i,':');
      writeln(answer:0:2);
      writeln;
   end;
end.