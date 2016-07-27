program maxflow(input,output);
var
   f	      : array[0..300,0..300] of longint;
   q,d	      : array[0..20000] of longint;
   n,m,answer : longint;
procedure init;
var
   i,xx,yy,cc : longint;
begin
   readln(m,n);
   fillchar(f,sizeof(f),0);
   for i:=1 to m do
   begin
      readln(xx,yy,cc);
      inc(f[xx,yy],cc);
      f[yy,xx]:=f[xx,yy];
   end;
end; { init }
function bfs():boolean;
var
   head,tail,i : longint;
begin
   for i:=1 to n do
      d[i]:=-1;
   head:=0;
   tail:=1;
   q[1]:=1;
   d[1]:=0;
   while head<tail do
   begin
      inc(head);
      for i:=1 to n do
	 if f[q[head],i]>0 then
	    if d[i]<0 then
	    begin
	       d[i]:=d[q[head]]+1;
	       inc(tail);
	       q[tail]:=i;
	    end;
   end;
   if d[n]<0 then
      exit(false);
   exit(true);
end; { bfs }
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
function dfs(now,minflow: longint ):longint;
var
   i,tmp : longint;
begin
   if now=n then
      exit(minflow);
   for i:=1 to n do
      if f[now,i]>0 then
	 if d[i]=d[now]+1 then
	 begin
	    tmp:=dfs(i,min(minflow,f[now,i]));
	    if tmp<>0 then
	    begin
	       dec(f[now,i],tmp);
	       inc(f[i,now],tmp);
	       exit(tmp);
	    end;
	 end;
   exit(0);
end; { dfs }
procedure main;
var
   tmp : longint;
begin
   answer:=0;
   while bfs() do
   begin
      tmp:=dfs(1,maxlongint>>2);
      while tmp<>0 do
      begin
	 inc(answer,tmp);
	 tmp:=dfs(1,maxlongint>>2);
      end;
   end;
   writeln(answer);
end; { main }
begin
   while not eof do
   begin
    init;
    main;
   end;
end.