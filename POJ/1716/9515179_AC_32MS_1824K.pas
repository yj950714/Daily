program pku_1716(input,output);
var
  first:array[-10..50010] of longint;
  next,goal,w:array[-10..500010] of longint;
  d:array[-2..50010] of longint;
  q:array[-2..2000010] of longint;
  v:array[-2..50010] of boolean;
  n,tot,max,min,ans:longint;
procedure add(xx,yy,ww:longint);
begin
  inc(tot);
  goal[tot]:=yy;
  w[tot]:=ww;
  next[tot]:=first[xx];
  first[xx]:=tot;
end;
procedure init;
var
  i,x1,y1,c1:longint;
begin
  readln(n);
  max:=0;
  min:=maxlongint>>1;
  c1:=2;
  for i:=-2 to 50010 do
   first[i]:=-100;
  for i:=1 to n do
  begin
    readln(x1,y1);
    add(y1,x1-1,-c1);
    if y1>max then
      max:=y1;
  end;
  for i:=0 to max do
  begin
    add(i-1,i,1);
    add(i,i-1,0);
  end;
  for i:=-1 to max do
   add(-2,i,0);
end;
procedure spfa();
var
  head,tail:longint;
  i,t:longint;
begin
  fillchar(v,sizeof(v),false);
  fillchar(d,sizeof(d),63);
  head:=0;
  tail:=1;
  q[1]:=-2;
  v[-2]:=true;
  d[-2]:=0;
  while head<tail do
  begin
   inc(head);
   v[q[head]]:=false;
   t:=first[q[head]];
   while t<>-100 do
   begin
    if d[q[head]]+w[t]<d[goal[t]] then
    begin
     d[goal[t]]:=d[q[head]]+w[t];
     if not v[goal[t]]  then
     begin
      inc(tail);
      q[tail]:=goal[t];
      v[goal[t]]:=true;
     end;
    end;
    t:=next[t];
   end;
  end;
end;
procedure print;
var
  i:longint;
begin
  ans:=maxlongint>>2;
  for i:=-1 to max do
   if d[i]<ans then
    ans:=d[i];
  writeln(abs(ans));
end;
begin
  init;
  spfa;
  print;
end.
