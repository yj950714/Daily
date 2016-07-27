program pku3207(input,output);
type
  node=^link;
  link=record
    goal:longint;
    next:node;
  end;
  node2=record
    x,y:longint;
  end;
var
   l            :array[0..1100] of node;
   dfn,low,stack:array[0..2000] of longint;
   n,m,top,cnt  :longint;
   instack      :array[0..2000] of boolean;
   ask          :array[0..500] of  node2;
   color        :array[0..2000] of longint;
   colour       :longint;
procedure add(xx,yy:longint);
var
  t:node;
begin
  new(t);
  t^.goal:=yy;
  t^.next:=l[xx];
  l[xx]:=t;
end;

procedure swap(var aa,bb:longint);
var
  tt:longint;
begin
  tt:=aa;
  aa:=bb;
  bb:=tt;
end;

procedure init;
var
  i:longint;
begin
  readln(n,m);
  for i:=1 to m do
  begin
   readln(ask[i].x,ask[i].y);
   inc(ask[i].x);
   inc(ask[i].y);
   if ask[i].y<ask[i].x then
    swap(ask[i].x,ask[i].y);
  end;
end;

procedure make_graph();
var
  i,j:longint;
begin
  for i:=1 to m do
   for j:=1 to m do
   if (i<>j) then
   begin
    if (ask[j].x>ask[i].x)and(ask[j].x<ask[i].y)and(ask[j].y>ask[i].y) then
    begin
     add(i,j+m);
     add(i+m,j);
    end;
    if (ask[j].y>ask[i].x)and(ask[j].y<ask[i].y)and(ask[j].x<ask[i].x) then
    begin
     add(i,j+m);
     add(i+m,j);
    end;
   end;
end;
procedure dfs(now:longint);
var
  t:node;
begin
  inc(cnt);
  dfn[now]:=cnt;
  low[now]:=cnt;
  inc(top);
  stack[top]:=now;
  instack[now]:=true;
  t:=l[now];
  while t<>nil do
  begin
   if dfn[t^.goal]=0 then
   begin
     dfs(t^.goal);
     if low[t^.goal]<low[now] then
      low[now]:=low[t^.goal];
   end
   else
   begin
     if (instack[t^.goal])and(dfn[t^.goal]<low[now])  then
      low[now]:=dfn[t^.goal];
   end;
   t:=t^.next;
  end;
  if dfn[now]=low[now] then
  begin
    inc(colour);
    while true do
    begin
     color[stack[top]]:=colour;
     instack[stack[top]]:=false;
     dec(top);
     if stack[top+1]=now then
      break;
    end;
  end;
end;
procedure main;
var
  i:longint;
begin
  for i:=1 to m*2 do
   if dfn[i]=0 then
    dfs(i);
  for i:=1 to m do
   if color[i]=color[i+m] then
   begin
    writeln('the evil panda is lying again');
    exit;
   end;
  writeln('panda is telling the truth...');
end;
begin
  init;
  make_graph;
  main;
end.
