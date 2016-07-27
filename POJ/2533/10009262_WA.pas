program pku2533(input,output);
var
  a,f     :array[0..10000] of longint;
  answer,n:longint;
procedure init;
var
   i:longint;
begin
   readln(n);
   for i:=1 to n do
    read(a[i]);
   readln;
   fillchar(f,sizeof(f),0);
end;
procedure main;
var
   i,j:longint;
begin
   answer:=0;
   f[1]:=1;
   for i:=2 to n do
    for j:=i-1 downto 1 do
      if a[i]>a[j] then
        if f[j]+1>f[i] then
        begin
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
