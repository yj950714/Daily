program pku1001(input,output);
type
   number = array[0..100] of integer;
var
   power    : integer;
   s,s1,s2  : ansistring;
   x,answer : number;
   n	    : longint;
procedure init;
begin
   readln(s);
   s1:=copy(s,1,pos(' ',s)-1);
   delete(s,1,pos(' ',s));
   val(s,power);
   n:=length(s1)-pos('.',s1);
   delete(s1,pos('.',s1),1);
   n:=n*power;
   while s1[1]='0' do
      delete(s1,1,1);
end; { init }
procedure change();
var
   i : longint;
begin
   x[0]:=length(s1);
   for i:=1 to length(s1) do
      x[i]:=ord(s1[length(s1)+1-i])-48;
   answer:=x;
end; { change }
function multiply(x,y :number ):number;
var
   i,j : longint;
begin
   fillchar(multiply,sizeof(multiply),0);
   multiply[0]:=x[0]+y[0]-1;
   for i:=1 to x[0] do
      for j:=1 to y[0] do
      begin
	 inc(multiply[i+j-1],x[i]*y[j]);
	 inc(multiply[i+j],multiply[i+j-1] div 10);
	 multiply[i+j-1]:=multiply[i+j-1] mod 10;
      end;
   if multiply[multiply[0]+1]>0 then
      inc(multiply[0]);
end; { multiply }
procedure main;
var
   i : longint;
begin
   for i:=1 to power-1 do
      answer:=multiply(answer,x);
   s1:='';
   s2:='';
   for i:=answer[0] downto n+1 do
      s1:=s1+chr(answer[i]+48);
   for i:=n downto 1 do
      s2:=s2+chr(answer[i]+48);
   s:=s1+'.'+s2;
   while s[1]='0' do
      delete(s,1,1);
   while s[length(s)]='0' do
      delete(s,length(s),1);
   if s[length(s)]='.' then
      delete(s,length(s),1);
end; { main }
procedure print;
begin
   if s='' then
      writeln(0)
   else
      writeln(s);
end; { print }
begin
  while not eof do
  begin
   init;
   change;
   main;
   print;
  end;
end.