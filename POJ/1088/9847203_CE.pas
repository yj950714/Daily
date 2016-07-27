var v:array[0..101,0..101] of boolean;
    a,f:array[0..101,0..101] of longint;
    xx:array[1..4]of integer=(0,1,0,-1);
    yy:array[1..4]of integer=(1,0,-1,0);
    m,n,k,i,j,max:longint;
procedure try(x,y:longint);
var ii,x1,y1:longint;
begin
   if f[x,y]<>0 then
     exit(f[x,y]);
   for ii:=1 to 4 do
   begin
    x1:=x+xx[ii];
    y1:=y+yy[ii];
    if a[x,y]>a[x1,y1] then
     if not v[x1,y1] then
      if f[x,y]+1>f[x1,y1] then
       begin
        v[x,y]:=true;
        f[x1,y1]:=f[x,y]+1;
        try(x1,y1);
        v[x,y]:=false;
       end;
   end;
end;
begin
   readln(m,n);
   for i:=0 to 101 do
    for j:=0 to 101 do
     begin
      a[i,j]:=maxlongint div 2;
      f[i,j]:=0;
      v[i,j]:=false;
     end;
   for i:=1 to m do
   begin
    for j:=1 to n do
     read(a[i,j]);
     readln;
    end;
   for i:=1 to m do
    for j:=1 to n do
     try(i,j);
   for i:=1 to m do
    for j:=1 to n do
     if f[i,j]>max then
      max:=f[i,j];
   writeln(max+1);
end.