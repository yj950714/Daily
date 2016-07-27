program pku_1364(input,output);
var
  first:array[-10..200] of longint;
  next,goal,w:array[-10..200] of longint;
  d,num:array[-10..101] of longint;
  n,m,tot:longint;
  q:array[-10..1000] of longint;
  v:array[-10..101] of boolean;
procedure add(xx,yy,ww:longint);
begin
  inc(tot);
  w[tot]:=ww;
  goal[tot]:=yy;
  next[tot]:=first[xx];
  first[xx]:=tot;
end;
procedure clean;
var
  i:longint;
begin
  for i:=-1 to 101 do
    first[i]:=-1;
  tot:=0;
  fillchar(next,sizeof(next),0);
  fillchar(goal,sizeof(goal),0);
  fillchar(w,sizeof(w),0);
end;
procedure init;
var
  i,x1,y1,c1:longint;
  ch:char;
begin
  for i:=1 to m do
  begin
   read(x1,y1);
   read(ch);
   read(ch);
   if ch='g' then
   begin
     read(ch);
     readln(c1);
     add(x1+y1,x1-1,-1-c1);
   end
   else
   begin
     read(ch);
     readln(c1);
     add(x1-1,x1+y1,c1-1);
   end;
  end;
end;
function spfa:boolean;
var
  head,tail,t,i:longint;
begin
  fillchar(d,sizeof(d),63);
  fillchar(v,sizeof(v),false);
  fillchar(num,sizeof(num),0);
  head:=0;
  tail:=0;
  for i:=0 to n do
  if first[i]<>-1 then
  begin
    inc(tail);
    q[tail]:=i;
    inc(num[i]);
    v[i]:=true;
  end;
  while head<tail do
  begin
    inc(head);
    if head=1000 then
      head:=1;
    v[q[head]]:=false;
    t:=first[q[head]];
    while t<>-1 do
    begin
     if d[q[head]]+w[t]<d[goal[t]] then
     begin
       d[goal[t]]:=d[q[head]]+w[t];
       if not v[goal[t]] then
       begin
         inc(tail);
         if tail=1000 then
          tail:=1;
         q[tail]:=goal[t];
         inc(num[goal[t]]);
         if num[goal[t]]>n+1 then
           exit(false);
         v[q[tail]]:=true;
       end;
     end;
     t:=next[t];
    end;
  end;
  exit(true);
end;
begin
  clean;
  read(n);
  while n<>0 do
  begin
    readln(m);
    init;
    if spfa() then
     writeln('lamentable kingdom')
    else
     writeln('successful conspiracy');
    clean;
    read(n);
  end;
end.
