program dinic(input,output);
const maxn = 1000;
type
   graph      = array[0..maxn,0..maxn] of longint;
   numbertype = array[0..maxn] of longint;
var
   f	      : graph;
   d	      : numbertype;
   n,m	      : longint;
   q:array[0..3000] of longint;
   start,goal : longint;
   ans	      : longint;
procedure init;
var
   i,j	    : longint;
   xx,yy,zz : longint;
begin
   readln(m,n);
   start:=1;
   goal:=n;
   fillchar(f,sizeof(f),0);
   for i:=1 to m do
   begin
      readln(xx,yy,zz);
      inc(f[xx,yy],zz);
   end;
end; { init }
procedure bfs(vo :longint );
var
   i,now     : longint;
   head,tail : longint;
begin
   head:=0;
   tail:=1;
   q[1]:=vo;
   for i:=0 to n do
      d[i]:=-1;
   d[vo]:=0;
   while head<tail do
   begin
      inc(head);
      now:=q[head];
      for i:=1 to n do
	 if f[now,i]<>0 then
	    if d[i]=-1 then
	    begin
	       d[i]:=d[now]+1;
	       inc(tail);
	       q[tail]:=i;
	    end;
   end;
end; { bfs }
function dfs(now,low :longint ):longint;
var
   k,tmp : longint;
begin
   if now=goal then
      exit(low);
   dfs:=0;
   for k:=1 to n do
      if (f[now,k]>0)and(d[now]+1=d[k]) then
      begin
	 if low<f[now,k] then
	    tmp:=dfs(k,low)
	 else
	    tmp:=dfs(k,f[now,k]);
	 dec(f[now,k],tmp);
	 inc(f[k,now],tmp);
	 if tmp<>0 then
	    exit(tmp);
      end;
   exit(0);
end; { dfs }
procedure main;
begin
   bfs(start);
   while d[goal]>0 do
   begin
      ans:=ans+dfs(start,maxlongint);
      bfs(start);
   end;
end; { main }
begin
   init;
   main;
   writeln(ans);
end.
   
   