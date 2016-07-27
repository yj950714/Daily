program pku_1716(input,output);
var
  first:array[-10..10001] of longint;
  next,goal,w:array[-10..10001] of longint;
  d:array[-10..10001] of longint;
  q:array[-10..10010] of longint;
  v:array[-10..10010] of boolean;
  n,tot,max,ans:longint;
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
  i,x1,y1:longint;
begin
  readln(n);
  max:=0;
  for i:=-10 to 10001 do
   first[i]:=-1;
  for i:=1 to n do
  begin
    readln(x1,y1);
    add(y1,x1-1,-2);
    if y1>max then
      max:=y1;
  end;
  for i:=0 to max do
  begin
    add(i-1,i,1);
    add(i,i-1,0);
  end;
  for i:=-1 to max do
   add(max+1,i,0);
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
  q[1]:=max+1;
  v[max+1]:=true;
  d[max+1]:=0;
  while head<>tail do
  begin
   inc(head);
   if head=10010 then
    head:=1;
   t:=first[q[head]];
   while t<>-1 do
   begin
    if d[q[head]]+w[t]<d[goal[t]] then
    begin
     d[goal[t]]:=d[q[head]]+w[t];
     if not v[goal[t]]  then
     begin
      inc(tail);
      if tail=10010 then
       tail:=1;
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
