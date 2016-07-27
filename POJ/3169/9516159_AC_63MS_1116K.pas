program pku_3169(input,output);
type
   node=^link;
   link=record
     goal,w:longint;
     next:node;
   end;
var
  l:array[0..2000] of node;
  d,num:array[0..2000] of longint;
  q:array[0..20000] of longint;
  v:array[0..2000] of boolean;
  tot,n,t1,t2:longint;
procedure add(xx,yy,ww:longint);
var
   t:node;
begin
   new(t);
   t^.next:=l[xx];
   t^.goal:=yy;
   t^.w:=ww;
   l[xx]:=t;
end;
procedure init;
var
  i,x1,y1,c1:longint;
begin
  readln(n,t1,t2);
  for i:=0 to n do
   l[i]:=nil;
  for i:=1 to t1 do
  begin
    readln(x1,y1,c1);
    add(x1,y1,c1);
  end;
  for i:=1 to t2 do
  begin
    readln(x1,y1,c1);
    add(y1,x1,-c1);
  end;
end;
function spfa():longint;
var
  top,i,now:longint;
  t:node;
begin
  fillchar(v,sizeof(v),false);
  fillchar(num,sizeof(num),0);
  for i:=0 to n do
   d[i]:=maxlongint>>2;
  top:=0;
  for i:=1 to n do
   if l[i]<>nil then
   begin
     inc(top);
     q[top]:=i;
     inc(num[i]);
     v[i]:=true;
   end;
  d[1]:=0;
  while top<>0 do
  begin
    now:=q[top];
    dec(top);
    v[now]:=false;
    t:=l[now];
    while t<>nil do
    begin
      if d[now]+t^.w<d[t^.goal] then
      begin
       d[t^.goal]:=d[now]+t^.w;
       if not v[t^.goal] then
       begin
         inc(top);
         inc(num[t^.goal]);
         if num[t^.goal]>n+1 then
           exit(-1);
         q[top]:=t^.goal;
         v[t^.goal]:=true;
       end;
      end;
      t:=t^.next;
    end;
  end;
  if d[n]=maxlongint>>2 then
    exit(-2);
  exit(d[n]);
end;
function spfa2():longint;
var
   head,tail,i:longint;
   t:node;
begin
   for i:=1 to  n do
    d[i]:=maxlongint>>2;
   fillchar(v,sizeof(v),false);
   head:=0;
   tail:=0;
   for i:=1 to n do
    if l[i]<>nil then
    begin
     inc(tail);
     q[tail]:=i;
     v[i]:=true;
     inc(num[i]);
    end;
   d[1]:=0;
   while head<tail do
   begin
     inc(head);
     v[q[head]]:=false;
     t:=l[q[head]];
     while t<>nil do
     begin
      if d[q[head]]+t^.w<d[t^.goal] then
      begin
        d[t^.goal]:=d[q[head]]+t^.w;
        if not v[t^.goal] then
        begin
          inc(tail);
          inc(num[t^.goal]);
          if num[t^.goal]>n+1 then
           exit(-1);
          q[tail]:=t^.goal;
          v[t^.goal]:=true;
        end;
      end;
      t:=t^.next;
     end;
   end;
   if d[n]=maxlongint>>2 then
    exit(-2);
   exit(d[n]);
end;
begin
  init;
  writeln(spfa2());
end.
