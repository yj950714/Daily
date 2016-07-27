program pku_3159(input,output);
var
  first:array[0..30001] of integer;
  next,goal,w:array[0..150001] of longint;
  n,m,tot:longint;
  d:array[0..30001] of longint;
  v:array[0..30001] of boolean;
  stack:array[0..40000] of longint;
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
  readln(n,m);
  tot:=0;
  for i:=1 to  n do
   first[i]:=-1;
  for i:=1 to m do
  begin
    readln(x1,y1,c1);
    add(x1,y1,c1);
  end;
end;
procedure spfa;
var
  top,now:longint;
  t,i:longint;
begin
  fillchar(d,sizeof(d),63);
  fillchar(v,sizeof(v),false);
  d[1]:=0;
  top:=0;
  for i:=1 to n do
  begin
   inc(top);
   stack[top]:=i;
   v[i]:=true;
  end;
  while top<>0 do
  begin
    now:=stack[top];
    dec(top);
    v[now]:=false;
    t:=first[now];
    while t<>-1 do
    begin
      if d[now]+w[t]<d[goal[t]] then
      begin
        d[goal[t]]:=d[now]+w[t];
        if not v[goal[t]] then
        begin
          inc(top);
          stack[top]:=goal[t];
          v[goal[t]]:=true;
        end;
      end;
      t:=next[t];
    end;
  end;
end;
procedure print;
begin
 writeln(d[n]);
end;
begin
  init;
  spfa;
  print;
end.
