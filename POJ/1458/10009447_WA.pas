program pku1458(input,output);
var
   f	      : array[-1..800,-1..800] of longint;
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
      s2:=s;
      fillchar(f,sizeof(f),0);
      for i:=1 to length(s1) do
	 for j:=1 to length(s2) do
	 begin
	    if s1[i]=s2[j] then
	       f[i,j]:=f[i-1,j-1]+1
	    else
	       if f[i-1,j]>f[i,j-1] then
		  f[i,j]:=f[i-1,j]
	       else
		  f[i,j]:=f[i,j-1];
	    if f[i,j]>answer then
	       answer:=f[i,j];
	 end;
      writeln(f[length(s1),length(s2)]);
   end;
end.