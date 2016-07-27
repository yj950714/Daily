program dinic(input,output);
var
   f	       : array[0..250,0..250] of longint;
   number      : array[0..2500] of longint;
   q	       : array[0..2000] of longint;
   n,m,ans,s,t : longint;
procedure init;
var
   x,y,c : longint;
   i	 : longint;
begin
   readln(m,n);
   s:=1;
   t:=n;
   fillchar(f,sizeof(f),0);
   for i:=1 to m do
   begin
      readln(x,y,c);
      inc(f[x,y],c);
   end;
end; { init }
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
function bfs(): boolean;
var
   head,tail : longint;
   now,i     : longint;
begin
   fillchar(number,sizeof(number),0);
   head:=0;
   tail:=1;
   q[1]:=s;
   number[s]:=1;
   while head<tail do
   begin
      inc(head);
      now:=q[head];
      for i:=1 to n do
	 if f[now,i]>0 then
	    if number[i]=0 then
	    begin
	       number[i]:=number[now]+1;
	       inc(tail);
	       q[tail]:=i;
	    end;
   end;
   if number[t]=0 then
      exit(false);
   exit(true);
end; { bfs }
function dfs(now,flow :longint ):longint;
var
   tmp,i : longint;
begin
   if now=t then
      exit(flow);
   for i:=1 to n do
      if number[i]=number[now]+1 then
	 if f[now,i]>0 then
	 begin
	    tmp:=dfs(i,min(flow,f[now,i]));
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
   tmp : longint;
begin
   ans:=0;
   while bfs() do
   begin
      tmp:=dfs(s,maxlongint>>2);
      while tmp<>0 do
      begin
	 inc(ans,tmp);
	 tmp:=dfs(s,maxlongint>>2);
      end;
   end;
   writeln(ans);
end; { main }
begin
  while not eof do
  begin
   init;
   main;
  end;
end.
   
   