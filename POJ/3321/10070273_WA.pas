program pku3321(input,output);
type
   node	 = ^link;
   link	 = record
	      goal : longint;
	      next : node;
	   end;	   
var
   l,tree  : array[0..100100] of node;
   v	   : array[0..100100] of boolean;
   x,y,dfn : array[0..100100] of longint;
   c	   : array[0..100100] of longint;
   n,q,cnt : longint;
procedure add(xx,yy: longint );
var
   tt : node;
begin
   new(tt);
   tt^.next:=l[xx];
   tt^.goal:=yy;
   l[xx]:=tt;
end; { add }
function max(aa,bb :longint ):longint;
begin
   if aa>bb then
      exit(aa);
   exit(bb);
end; { max }
function min(aa,bb : longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
procedure add_tree(xx,yy :longint );
var
   tt : node;
begin
   new(tt);
   tt^.goal:=yy;
   tt^.next:=tree[xx];
   tree[xx]:=tt;
end; { add_tree }
procedure init;
var
   i,xx,yy : longint;
begin
   readln(n);
   for i:=1 to n-1 do
   begin
      readln(xx,yy);
      add(xx,yy);
      add(yy,xx);
   end;
   cnt:=0;
   readln(q);
   fillchar(v,sizeof(v),false);
end; { init }
procedure dfs1(now :longint );
var
   t : node;
begin
   v[now]:=true;
   t:=l[now];
   while t<>nil do
   begin
      if not v[t^.goal] then
      begin
	 add_tree(now,t^.goal);
	 dfs1(t^.goal);
      end;
      t:=t^.next;
   end;
end; { dfs1 }
procedure dfs(now :longint );
var
   t : node;
begin
   inc(cnt);
   dfn[now]:=cnt;
   x[now]:=cnt;
   y[now]:=cnt;
   t:=tree[now];
   while t<>nil do
   begin
      dfs(t^.goal);
      x[now]:=min(x[now],x[t^.goal]);
      y[now]:=max(y[now],y[t^.goal]);
      t:=t^.next;
   end;
end; { dfs }
function lowbit(x :longint ):longint;
begin
   exit(x and(-x));
end; { lowbit }
procedure adds(now,w :longint );
begin
   while now<=n do
   begin
      inc(c[now],w);
      now:=now+lowbit(now);
   end;
end; { adds }
function find(now : longint ):longint;
begin
   find:=0;
   while now>0 do
   begin
      inc(find,c[now]);
      now:=now-lowbit(now);
   end;
end; { find }
procedure main;
var
   ch	   : char;
   xx,i : longint;
begin
   for i:=1 to n do
      adds(i,1);
   fillchar(v,sizeof(v),true);
   for i:=1 to q do
   begin
      read(ch);
      case ch of
	'C' : begin
	   readln(xx);
	   v[xx]:=not v[xx];
	   adds(dfn[xx],-1);
	end;
	'Q' : begin
	   readln(xx);
	   writeln(find(y[xx])-find(x[xx]-1));
	end;
      end; { case }
   end;
end; { main }
begin
   init;
   dfs1(1);
   dfs(1);
   main;
end.