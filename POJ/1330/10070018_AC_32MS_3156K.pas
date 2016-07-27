program pku1330(input,output);
type
   node	= ^link;
   link	= record
	     goal : longint;
	     next : node;
	  end;
var
   tree	   : array[0..31000] of node;
   eurl	   : array[0..30000] of longint;
   depth   : array[0..30000] of longint;
   pos	   : array[0..31000] of longint;
   f	   : array[0..21000,0..20] of longint;
   v	   : array[0..11000] of boolean;
   root	   : longint;
   n,tot   : longint;
   i,cases : longint;
function max(aa,bb: longint ):longint;
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
procedure add(xx,yy :longint );
var
   tt : node;
begin
   new(tt);
   tt^.goal:=yy;
   tt^.next:=tree[xx];
   tree[xx]:=tt;
end; { add }
procedure delete();
var
   tt : node;
begin
   for i:=1 to n do
      while tree[i]<>nil do
      begin
	 tt:=tree[i];
	 tree[i]:=tt^.next;
	 dispose(tt);
      end;
end; { delete }
procedure init;
var
   i,xx,yy : longint;
begin
   readln(n);
   fillchar(v,sizeof(v),false);
   for i:=1 to n-1 do
   begin
      readln(xx,yy);
      add(xx,yy);
      v[yy]:=true;
   end;
   for i:=1 to n do
      if not v[i] then
      begin
	 root:=i;
	 break;
      end;
   for i:=1 to n do
      pos[i]:=-1;
   tot:=0;
end; { init }
procedure dfs(now,dep :longint );
var
   t : node;
begin
   inc(tot);
   eurl[tot]:=now;
   depth[tot]:=dep;
   if pos[now]=-1 then
      pos[now]:=tot;
   t:=tree[now];
   while t<>nil do
   begin
      dfs(t^.goal,dep+1);
      inc(tot);
      eurl[tot]:=now;
      depth[tot]:=dep;
      t:=t^.next;
   end;
end; { dfs }
procedure Sparse_Table();
var
   i,j : longint;
begin
   for i:=1 to tot do
      f[i,0]:=i;
   for j:=1 to trunc(ln(tot)/ln(2)) do
      for i:=1 to tot do
	 if i+1<<(j-1)>tot then
	    break
	 else
	 begin
	    if depth[f[i,j-1]]<depth[f[i+1<<(j-1),j-1]] then
	       f[i,j]:=f[i,j-1]
	    else
	       f[i,j]:=f[i+1<<(j-1),j-1];
	 end;
end; { Sparse_Table }
procedure solve();
var
   x,y,t,xx,yy : longint;
begin
   readln(x,y);
   xx:=pos[x];
   yy:=pos[y];
   x:=min(xx,yy);
   y:=max(xx,yy);
   t:=trunc(ln(y-x+1)/ln(2));
   if depth[f[x,t]]<depth[f[y-1<<t+1,t]] then
      writeln(eurl[f[x,t]])
   else
      writeln(eurl[f[y-1<<t+1,t]]);
end; { solve }
begin
   for i:=1 to 10001 do
      tree[i]:=nil;
   readln(cases);
   while cases>0 do
   begin
      dec(cases);
      delete();
      init;
      dfs(root,0);
      Sparse_Table();
      solve();
   end;
end.