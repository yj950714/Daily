program pku2636(input,output);
var
   sum,n,cases,x,i,j : longint;
begin
   readln(cases);
   for i:=1 to cases do
   begin
      sum:=0;
      read(n);
      for j:=1 to n do
      begin
	 read(x);
	 sum:=sum+x;
      end;
      readln;
      writeln(sum-n+1);
   end;
end.