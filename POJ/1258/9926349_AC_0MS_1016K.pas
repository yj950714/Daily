program pku1258(input,output);
var
   f	  : array[0..200,0..200] of longint;
   d	  : array[0..200] of longint;
   n	  : longint;
   answer : longint;
procedure init;
var
   i,j : longint;
begin
   readln(n);
   fillchar(f,sizeof(f),0);
   for i:=1 to n do
      for j:=1 to n do
	 read(f[i,j]);
   readln;
   for i:=1 to n do
      d[i]:=f[1,i];
end; { init }
procedure prim;
var
   i,j	    : longint;
   min,minn : longint;
begin
   answer:=0;
   for i:=1 to n-1 do
   begin
      min:=maxlongint;
      for j:=1 to n do
	 if (d[j]>0)and(d[j]<min) then
	 begin
	    min:=d[j];
	    minn:=j;
	 end;
      inc(answer,d[minn]);
      d[minn]:=0;
      for j:=1 to n do
	 if (d[j]>0)and(f[minn,j]<d[j]) then
	    d[j]:=f[minn,j];
   end;
   writeln(answer);
end; { prim }
begin
  while not eof do
  begin
   init;
   prim;
  end;
end.