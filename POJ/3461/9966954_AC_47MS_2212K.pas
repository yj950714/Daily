program pku3461(input,output);
var
   a,b	  : ansistring;
   next	  : array[0..20000] of longint;
   cases  : longint;
   i,j,k  : longint;
   answer : longint;
begin
   readln(cases);
   for k:=1 to cases do
   begin
      readln(b);
      readln(a);
      fillchar(next,sizeof(next),0);
      j:=0;
      next[1]:=0;
      for i:=2 to length(b) do
      begin
	 while (b[j+1]<>b[i])and(j>0) do
	    j:=next[j];
	 if b[j+1]=b[i] then
	    inc(j);
	 next[i]:=j;
      end;
      j:=0;
      answer:=0;
      for i:=1 to length(a) do
      begin
	 while (j>0)and(a[i]<>b[j+1]) do
	    j:=next[j];
	 if a[i]=b[j+1] then
	    inc(j);
	 if j=length(b) then
	 begin
	    inc(answer);
	    j:=next[j];
	 end;
      end;
      writeln(answer);
   end;
end.