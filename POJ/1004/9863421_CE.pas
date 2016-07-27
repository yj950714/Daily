program pku1004(input,output);
var
   sum,tmp:double;
   i      :longint;
begin
   sum:=0;
   for i:=1 to 12 do
   begin
      readln(tmp);
      inc(sum,tmp);
   end;
   write('$');
   writeln(sum/12:0:2);
end.