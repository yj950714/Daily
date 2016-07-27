program pku1946(input,output);
const
   MAXW	= 10000000;
var
   f	  : array[0..25,0..110,0..110] of longint;
   n,e,d  : longint;
   answer : longint;
procedure init;
begin
   readln(n,e,d);
   fillchar(f,sizeof(f),63);
end; { init }
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
procedure main;
var
   i,j,k,l : longint;
begin
   f[1,0,0]:=0;
   for i:=1 to n do
      for j:=0 to d do
	 for k:=0 to e do
	    if f[i,j,k]<19950714 then
	       for l:=1 to e do
	       begin
		  if (j+l<=d)and(k+l*l<=e) then
		     f[i,j+l,k+l*l]:=min(f[i,j,k]+1,f[i,j+l,k+l*l]);
		  f[i+1,j,j]:=min(f[i+1,j,j],f[i,j,k]);
	       end;
   answer:=MAXW;
   for i:=0 to e do
      if f[n,d,i]<answer then
	 answer:=f[n,d,i];
end; { main }
procedure print;
begin
   writeln(answer);
end; { print }
begin
   init;
   main;
   print;
end.