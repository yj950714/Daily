program pku3659(input,output);
type
   node	= ^link;
   link	= record
	     goal : longint;
	     next : node;
	  end;	  
var
   l	: array[0..10001] of node;
   v	: array[0..10001] of boolean;
   tree	: array[0..10001,0..60] of longint;
   f	: array[0..2,0..10001] of longint;
   n	: longint;
procedure add(xx,yy: longint );
var
   tt : node;
begin
   new(tt);
   tt^.goal:=yy;
   tt^.next:=l[xx];
   l[xx]:=tt;
end; { add }
procedure init;
var
   i,x,y : longint;
begin
   readln(n);
   for i:=1 to n do
      l[i]:=nil;
   for i:=1 to n-1 do
   begin
      readln(x,y);
      add(x,y);
      add(y,x);
   end;
   fillchar(tree,sizeof(tree),0);
   fillchar(f,sizeof(f),63);
   fillchar(v,sizeof(v),false);
   v[1]:=true;
   f[2,0]:=0;
end; { init }
procedure dfs(now : longint );
var
   t : node;
begin
   t:=l[now];
   while t<>nil do
   begin
      if not v[t^.goal] then
      begin
	 v[t^.goal]:=true;
	 inc(tree[now,0]);
	 tree[now,tree[now,0]]:=t^.goal;
	 dfs(t^.goal);
      end;
      t:=t^.next;
   end;
end; { dfs }
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
procedure dp(now : longint );
var
   i	    : longint;
   sum,minw : longint;
   flag	    : boolean;
begin  
   if now=0 then
      exit;
   if tree[now,0]=0 then
   begin
      f[0,now]:=1;
      f[1,now]:=maxlongint>>2;
      f[2,now]:=0;
      exit;
   end;
   for i:=1 to tree[now,0] do
      dp(tree[now,i]);
   sum:=0;
   for i:=1 to tree[now,0] do
      sum:=sum+min(f[0,tree[now,i]],min(f[1,tree[now,i]],f[2,tree[now,i]]));
   f[0,now]:=sum+1;
   sum:=0;
   for i:=1 to tree[now,0] do
      sum:=sum+min(f[0,tree[now,i]],f[1,tree[now,i]]);
   f[2,now]:=sum;
   flag:=false;
   sum:=0;
   for i:=1 to tree[now,0] do
      if f[1,tree[now,i]]>=f[0,tree[now,i]] then
      begin
	 sum:=sum+f[0,tree[now,i]];
	 flag:=true;
      end
      else
	 sum:=sum+f[1,tree[now,i]];
   if flag then
      f[1,now]:=sum
   else
   begin
      minw:=maxlongint>>1;
      for i:=1 to tree[now,0] do
	 if f[0,tree[now,i]]-f[1,tree[now,i]]<minw then
	    minw:=f[0,tree[now,i]]-f[1,tree[now,i]];
      sum:=sum+minw;
      f[1,now]:=sum;
   end;
end; { dp }
procedure print;
begin
   writeln(min(f[0,1],f[1,1]));
end; { print }
begin
   init;
   dfs(1);
   dp(1);
   print;
end.