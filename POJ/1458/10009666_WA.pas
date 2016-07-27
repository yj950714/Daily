program pku1458(input,output);
var
   f	   : array[-1..800,-1..800] of longint;
   s1,s2,s : ansistring;
   i,j	   : longint;
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
      for i:=1 to length(s) do
      begin
	 if s[i]=#9 then
	    s[i]:=' ';
	 if s[i]=#10 then
	    s[i]:=' ';
	 if s[i]=#13 then
	    s[i]:=' ';
      end;
      i:=pos(s,' ');
      s1:=copy(s,1,i-1);
      s2:=copy(s,i+1,length(s));
      fillchar(f,sizeof(f),0);
      for i:=1 to length(s1) do
	 for j:=1 to length(s2) do
	 begin
	    if s1[i]=s2[j] then
	       f[i,j]:=f[i-1,j-1]+1
	    else
	       f[i,j]:=max(f[i-1,j],f[i,j-1]);
	 end;
      writeln(f[length(s1),length(s2)]);
   end;
end.