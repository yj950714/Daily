program pku2406(input,output);
var
   i,j	: longint;
   s	: ansistring;
   next	: array[0..1200000] of longint;
begin
   readln(s);
   while s<>'.' do
   begin
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
      if (length(s) mod (length(s)-next[length(s)])=0) then
	 writeln((length(s) div (length(s)-next[length(s)])))
      else
	 writeln(1);
      readln(s);
   end;
end.