program pku1252(input,output);
var
   f	   : array[-3000..3000] of longint;
   v	   : array[1..6] of longint;
   cases,e : longint;
procedure init;
var
   i : longint;
begin
   for i:=1 to 6 do
      read(v[i]);
   readln;
   fillchar(f,sizeof(f),63);
   f[0]:=0;
end; { init }
function min(aa,bb : longint ):longint;
begin
   if aa>bb then
      exit(bb);
   exit(aa);
end; { min }
procedure main;
var
   i,j : longint;
begin
   for i:=1 to 6 do
   begin
      for j:=v[i]-3000 to 3000 do
	 f[j]:=min(f[j],f[j-v[i]]+1);
      for j:=3000-v[i] downto -3000 do
	 f[j]:=min(f[j],f[j+v[i]]+1);
   end;
end; { main }
procedure print;
var
   i,max,sum : longint;
begin
   sum:=0;
   max:=0;
   for i:=1 to 100 do
   begin
      inc(sum,f[i]);
      if f[i]>max then
	 max:=f[i];
   end;
   writeln((sum/100):0:2,' ',max);
end; { print }
begin
   readln(cases);
   for e:=1 to cases do
   begin
      init;
      main;
      print;
   end;
end.