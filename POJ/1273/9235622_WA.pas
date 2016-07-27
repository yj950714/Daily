program dinic(input,output);
var
   f	   : array[0..1000,0..1000] of longint;
   d	   : array[0..1000] of longint;
   q	   : array[0..2000] of longint;
   m,n,ans : longint;
procedure init;
var
   i,xx,yy,zz : longint;
begin
   ans:=0;
   fillchar(f,sizeof(f),0);
   readln(m,n);
   for i:=1 to m do
   begin
      readln(xx,yy,zz);
      inc(f[xx,yy],zz);
   end;
end; { init }
function bfs:boolean;
var
   head,tail : longint;
   i,now     : longint;
begin
   for i:=1 to n do
      d[i]:=-1;
   head:=0;
   tail:=1;
   d[1]:=0;
   q[1]:=1;
   while head<tail do
   begin
      inc(head);
      now:=q[head];
      for i:=1 to n do
	 if f[now,i]>0 then
	    if d[i]=-1 then
	    begin
	       d[i]:=d[now]+1;
	       inc(tail);
	       q[tail]:=i;
	    end;
   end;
   if d[n]<>-1 then
      exit(true)
   else
      exit(false);
end; { bfs }
function dfs(now,low :longint ):longint;
var
   tmp,i : longint;
begin
   if now=n then
      exit(low);
   dfs:=0;
   for i:=1 to n do
      if (d[now]+1=d[i])and(f[now,i]>0) then
      begin
	 if f[now,i]<low then
	    tmp:=dfs(i,f[now,i])
	 else
	    tmp:=dfs(i,low);
	 if tmp<>0 then
	 begin
	    inc(f[i,now],tmp);
	    dec(f[now,i],tmp);
	    exit(tmp);
	 end;
      end;
   exit(0);
end; { dfs }
procedure main;
var
   tmpp	: longint;
begin
   while bfs do
   begin
      tmpp:=dfs(1,maxlongint);
      while tmpp>0 do
      begin
	 inc(ans,tmpp);
	 tmpp:=dfs(1,maxlongint);
      end;
   end;
end; { main }
procedure print;
begin
   writeln(ans);
end; { print }
begin
   init;
   main;
   print;
end.
	 