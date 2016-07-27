program pku2752(input,output);
var
   s	  : ansistring;
   next	  : array[0..500000] of longint;
   answer : array[0..500000] of longint;
   total  : longint;
   i,j	  : longint;
begin
   while not eof do
   begin
      readln(s);
      fillchar(next,sizeof(next),0);
      j:=0;
      next[1]:=0;
      for i:=2 to length(s) do
      begin
	 while (s[i]<>s[j+1])and(j>0) do
	    j:=next[j];
	 if s[i]=s[j+1] then
	    inc(j);
	 next[i]:=j;
      end;
      total:=0;
      i:=length(s);
      while i<>0 do
      begin
	 inc(total);
	 answer[total]:=i;
	 i:=next[i];
      end;
      for i:=total downto 1 do
	 write(answer[i],' ');
      writeln;
   end;
end.