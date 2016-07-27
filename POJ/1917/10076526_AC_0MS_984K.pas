program pku1917(input,output);
var
   s	 : array[0..6] of ansistring;
   ss,x	 : ansistring;
   cases : longint;
   i,tmp : longint;
begin
   readln(cases);
   while cases>0 do
   begin
      dec(cases);
      readln(ss);
      x:=ss;

      while pos('<',x)>0 do
	 delete(x,pos('<',x),1);
      while pos('>',x)>0 do
	 delete(x,pos('>',x),1);
      
      for i:=1 to 5 do
	 s[i]:='';
      
      tmp:=pos('<',ss);
      s[1]:=copy(ss,1,tmp-1);
      delete(ss,1,tmp);
      
      tmp:=pos('>',ss);
      s[2]:=copy(ss,1,tmp-1);
      delete(ss,1,tmp);
      
      tmp:=pos('<',ss);
      s[3]:=copy(ss,1,tmp-1);
      delete(ss,1,tmp);
      
      tmp:=pos('>',ss);
      s[4]:=copy(ss,1,tmp-1);
      delete(ss,1,tmp);
      
      s[5]:=ss;
      
      s[0]:=s[4]+s[3]+s[2]+s[5];

      readln(ss);
      tmp:=pos('...',ss);
      insert(s[0],ss,tmp);
      tmp:=pos('...',ss);
      delete(ss,tmp,3);
      writeln(x);
      writeln(ss);
   end;
end.
