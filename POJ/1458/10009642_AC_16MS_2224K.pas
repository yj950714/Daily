program poj1458;
var
  s,s1,s2:ansistring;
  i,j,L1,L2:longint;
  f:array[0..500,0..500]of longint;
function max(x,y:longint):longint;
begin
  if x>y then max:=x
  else max:=y;
end;
begin
  repeat
    readln(s);
    for i:=1 to length(s) do
    begin
      if s[i]=#9 then s[i]:=' ';
      if s[i]=#10 then s[i]:=' ';
      if s[i]=#13 then s[i]:=' ';
    end;
    s1:=copy(s,1,pos(' ',s)-1);
    s2:=copy(s,pos(' ',s)+1,length(s));
    L1:=length(s1);
    L2:=length(s2);
    fillchar(f,sizeof(f),0);
    for i:=1 to L1 do
    for j:=1 to L2 do
    if s1[i]=s2[j] then f[i,j]:=f[i-1,j-1]+1
    else f[i,j]:=max(f[i-1,j],f[i,j-1]);
    writeln(f[L1,L2]);
  until eof;
end.