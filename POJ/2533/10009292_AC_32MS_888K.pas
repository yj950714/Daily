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
end;
procedure main;
var
   i,j:longint;
begin
   answer:=0;
   for i:=1 to n do
   begin
    f[i]:=1;
    for j:=1 to i-1 do
      if a[i]>a[j] then
        if f[j]+1>f[i] then
          f[i]:=f[j]+1;
    if f[i]>answer then
      answer:=f[i];
   end;
   writeln(answer);
end;
begin
    init;
    main; 
end.
