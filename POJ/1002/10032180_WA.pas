program pku1002(input,output);
type
  ansistring=string;
var
  s     :array[0..100010] of ansistring;
  number:array['A'..'Y']  of char;
  sum   :array[0..100010] of longint;
  n     :longint;
procedure previous();
begin
  number['A']:='2'; number['B']:='2'; number['C']:='2';
  number['D']:='3'; number['E']:='3'; number['F']:='3';
  number['G']:='4'; number['H']:='4'; number['I']:='4';
  number['J']:='5'; number['K']:='5'; number['L']:='5';
  number['M']:='6'; number['N']:='6'; number['O']:='6';
  number['P']:='7'; number['R']:='7'; number['S']:='7';
  number['T']:='8'; number['U']:='8'; number['V']:='8';
  number['W']:='9'; number['X']:='9'; number['Y']:='9';
end;
procedure init;
var
   i,j:longint;
begin
   readln(n);
   for i:=1 to n do
   begin
     readln(s[i]);
     while pos('-',s[i])>0 do
      delete(s[i],pos('-',s[i]),1);
     for j:=1 to length(s[i]) do
      if s[i][j] in ['A'..'Z'] then
       s[i][j]:=number[s[i][j]];
   end;
end;
procedure swap(var aa,bb:ansistring);
var
  tt:ansistring;
begin
  tt:=aa;
  aa:=bb;
  bb:=tt;
end;
procedure sort(p,q:longint);
var
  i,j:longint;
  m:ansistring;
begin
  i:=p;
  j:=q;
  m:=s[(i+j)>>1];
  repeat
   while s[i]<m do
     inc(i);
   while s[j]>m do
     dec(j);
   if i<=j then
   begin
     swap(s[i],s[j]);
     inc(i);
     dec(j);
   end;
  until i>j;
  if i<q then sort(i,q);
  if j>p then sort(p,j);
end;
procedure print(s:ansistring);
var
  i:longint;
begin
  for i:=1 to 3 do
   write(s[i]);
  write('-');
  for i:=4 to 7 do
   write(s[i]);
  write(' ');
end;
procedure main;
var
  i :longint;
  ss:longint;
  flag:boolean;
begin
  sort(1,n);
  ss:=1;
  fillchar(sum,sizeof(sum),0);
  for i:=2 to n do
   if s[i]<>s[i-1] then
   begin
     sum[i-1]:=ss;
     ss:=1;
   end
   else
     inc(ss);
   flag:=false;
   for i:=1 to n do
    if sum[i]>1 then
    begin
     flag:=true;
     print(s[i]);
     writeln(sum[i]);
    end;
   if not flag then
    writeln('No duplicates.');
end;
begin
   previous;
   init;
   main;
end.
