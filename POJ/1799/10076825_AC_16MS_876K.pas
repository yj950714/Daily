program pku1799(input,output);
var
   n,cases,i : longint;
   r,answer  : double;
begin
   readln(cases);
   for i:=1 to cases do
   begin
      writeln('Scenario #',i,':');
      readln(r,n);
      answer:=r*sin(pi/n)/(1+sin(pi/n));
      writeln(answer:0:3);
      writeln;
   end;
end.