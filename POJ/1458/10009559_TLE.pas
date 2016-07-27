program pku1458(input,output);
var
   f	   : array[-1..800,-1..800] of longint;
   s1,s2,s : ansistring;
   i,j	   : longint;
   ch	   : char;
function max(aa,bb: longint ):longint;
begin
   if aa>bb then
      exit(aa);
   exit(bb);
end; { max }
begin
   while not eof do
   begin
      s:='';
      s1:='';
      s2:='';
      while not eoln do
      begin
	 read(ch);
	 if (ch=' ')and(s1='') then
	 begin
	    s1:=s;
	    s:='';
	 end
	 else
	    if ch in ['a'..'z'] then
	       s:=s+ch;
      end;
      s2:=s;
      writeln(s1);
      writeln(s2);
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