program pku1258(input,output);
var
   f	  : array[0..200,0..200] of longint;
   d	  : array[0..200] of longint;
   v	  : array[0..200] of boolean;
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
      if f[1,i]<>0 then
	 d[i]:=f[1,i]
      else
	 d[i]:=maxlongint>>2;
   d[1]:=0;
   fillchar(v,sizeof(v),false);
   v[1]:=true;
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
	 if (i<>j)and(not v[j])and(d[j]<min) then
	 begin
	    min:=d[j];
	    minn:=j;
	 end;
      v[minn]:=true;
      for j:=1 to n do
	 if (not v[j])and(f[minn,j]<d[j]) then
	    d[j]:=f[minn,j];
   end;
   for i:=1 to n do
      if v[i] then
	 inc(answer,d[i]);
   writeln(answer);
end; { prim }
begin
   while not eof do
   begin
   init;
   prim;
   end;
end.