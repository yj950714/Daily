program pku2533(input,output);
var
  a,f     :array[0..2000] of longint;
  answer,n:longint;
procedure init;
var
   i:longint;
begin
   readln(n);
   for i:=1 to n do
    read(a[i]);
   readln;
   for i:=1 to n do
    f[i]:=1;
end;
procedure main;
var
   i,j:longint;
begin
   answer:=0;
   for i:=2 to n do
   begin
    for j:=i-1 downto 1 do
      if a[i]>a[j] then
        if f[j]+1>f[i] then
          f[i]:=f[j]+1;
    if f[i]>answer then
      answer:=f[i];
   end; 
   writeln(answer);
end;
begin
  while not eof do
  begin
    init;
    main;
  end;
end.
