program pku3617(input,output);
var
   s1,s2  : ansistring;
   answer : ansistring;
   n	  : longint;
procedure init;
var
   i  : longint;
   ch : char;
begin
   readln(n);
   s1:='';
   for i:=1 to n do
   begin
      readln(ch);
      s1:=s1+ch;
   end;
   s2:='';
   for i:=length(s1) downto 1 do
      s2:=s2+s1[i];
end; { init }
procedure main;
var
   i : longint;
begin
   answer:='';
   for i:=1 to n do
   begin
      if s1>s2 then
      begin
	 answer:=answer+s2[1];
	 delete(s2,1,1);
	 delete(s1,length(s1),1);
      end
      else
      begin
	 answer:=answer+s1[1];
	 delete(s1,1,1);
	 delete(s2,length(s2),1);
      end;
   end;
end; { main }
procedure print;
var
   tmp : ansistring;
begin
   while length(answer)>=80 do
   begin
      tmp:=copy(answer,1,80);
      writeln(tmp);
      delete(answer,1,80);
   end;
   if answer<>'' then
      writeln(answer);
end; { print }
begin
   init;
   main;
   print;
end.