program pku1961(input,output);
var
   n	 : longint;
   ch	 : char;
   s	 : ansistring;
   next	 : array[0..1000100] of longint;
   i,j	 : longint;
   cases : longint;
begin
   readln(n);
   cases:=0;
   while n<>0 do
   begin
      inc(cases);
      s:='';
      for i:=1 to n do
      begin
	 read(ch);
	 s:=s+ch;
      end;
      readln;
      fillchar(next,sizeof(next),0);
      j:=0;
      next[1]:=0;
      for i:=2 to length(s) do
      begin
	 while (j>0)and(s[i]<>s[j+1]) do
	    j:=next[j];
	 if s[i]=s[j+1] then
	    inc(j);
	 next[i]:=j;
      end;
      writeln('Test case #',cases);
      for i:=2 to length(s) do
	 if ((i mod (i-next[i]))=0)and((i div (i-next[i]))>1) then
	    writeln(i,' ',i div (i-next[i]));
      writeln;
      readln(n);
   end;
end.