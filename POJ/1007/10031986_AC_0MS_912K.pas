program pku1007(input,output);
var
  s:array[0..101] of ansistring;
  a:array[0..101] of integer;
  n,m:longint;
procedure init;
var
   i:integer;
begin
   readln(m,n);
   for i:=1 to n do
    readln(s[i]);
end;
function calc(ss:ansistring):integer;
var
  i,j:integer;
begin
  calc:=0;
  for i:=1 to m-1 do
    for j:=i+1 to m do
     if ss[i]>ss[j] then
       inc(calc);
end;
procedure swap_string(var aa,bb:ansistring);
var
   tt:ansistring;
begin
   tt:=aa;
   aa:=bb;
   bb:=tt;
end;
procedure swap_int(var aa,bb:integer);
var
  tt:integer;
begin
  tt:=aa;
  aa:=bb;
  bb:=tt;
end;
procedure main;
var
  i,j:longint;
begin
  for i:=1 to n do
   a[i]:=calc(s[i]);
  for i:=1 to n-1 do
   for j:=i+1 to n do
    if a[i]>a[j] then
    begin
      swap_string(s[i],s[j]);
      swap_int(a[i],a[j]);
    end;
end;
procedure print;
var
  i:longint;
begin
  for i:=1 to n do
    writeln(s[i]);
end;
begin
   init;
   main;
   print;
end.
