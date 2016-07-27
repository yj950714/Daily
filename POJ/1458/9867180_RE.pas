program pku1458(input,output);
var
   f	      : array[0..5000,0..5000] of longint;
   s1,s2,s    : ansistring;
   i,j,answer : longint;
function max(aa,bb: longint ):longint;
begin
   if aa>bb then
      exit(aa);
   exit(bb);
end; { max }
begin
   while not eof do
   begin
      readln(s);
      s1:='';
      s2:='';
      answer:=0;
      for i:=1 to length(s) do
	 if s[i]=' ' then
	    break;
      s1:=copy(s,1,i-1);
      delete(s,1,i);
      while s[1]=' ' do
	 delete(s,1,1);
      while s[length(s)]=' ' do
	 delete(s,length(s),1);
      s2:=s;
      fillchar(f,sizeof(f),0);
      for i:=1 to length(s1) do
	 for j:=1 to length(s2) do
	 begin
	    f[i,j]:=max(f[i-1,j],f[i,j-1]);
	    if s1[i]=s2[j] then
	       f[i,j]:=max(f[i-1,j-1]+1,f[i,j]);
	    if f[i,j]>answer then
	       answer:=f[i,j];
	 end;
      writeln(answer);
   end;
end.