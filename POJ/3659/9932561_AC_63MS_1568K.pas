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
   tree	: array[0..10001] of node;
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
   begin
      tree[i]:=nil;
      l[i]:=nil;
   end;
   for i:=1 to n-1 do
   begin
      readln(x,y);
      add(x,y);
      add(y,x);
   end;
   fillchar(f,sizeof(f),63);
   fillchar(v,sizeof(v),false);
   v[1]:=true;
   f[2,0]:=0;
end; { init }
procedure dfs(now : longint );
var
   t,tt	: node;
begin
   t:=l[now];
   while t<>nil do
   begin
      if not v[t^.goal] then
      begin
	 v[t^.goal]:=true;
	 new(tt);
	 tt^.goal:=t^.goal;
	 tt^.next:=tree[now];
	 tree[now]:=tt;
	 dfs(t^.goal);
      end;
      t:=t^.next;
   end;
end; { dfs }
function min(aa,bb : longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
procedure dp(now : longint );
var
   t	    : node;
   sum,minw : longint;
   flag	    : boolean;
begin  
   if now=0 then
      exit;
   if tree[now]=nil then
   begin
      f[0,now]:=1;
      f[1,now]:=maxlongint>>2;
      f[2,now]:=0;
      exit;
   end;
   t:=tree[now];
   while t<>nil do
   begin
      dp(t^.goal);
      t:=t^.next;
   end;
   sum:=0;
   t:=tree[now];
   while t<>nil do
   begin
      sum:=sum+min(f[0,t^.goal],min(f[1,t^.goal],f[2,t^.goal]));
      t:=t^.next;
   end;
   {for i:=1 to tree[now,0] do
      sum:=sum+min(f[0,tree[now,i]],min(f[1,tree[now,i]],f[2,tree[now,i]]));}
   f[0,now]:=sum+1;
   sum:=0;
   t:=tree[now];
   while t<>nil do
   begin
      sum:=sum+min(f[0,t^.goal],f[1,t^.goal]);
      t:=t^.next;
   end;
   {for i:=1 to tree[now,0] do
      sum:=sum+min(f[0,tree[now,i]],f[1,tree[now,i]]);}
   f[2,now]:=sum;
   flag:=false;
   sum:=0;
   t:=tree[now];
   while t<>nil do
   begin
      if f[1,t^.goal]>=f[0,t^.goal] then
      begin
	 sum:=sum+f[0,t^.goal];
	 flag:=true;
      end
      else
	 sum:=sum+f[1,t^.goal];
      t:=t^.next;
   end;
   if flag then
      f[1,now]:=sum
   else
   begin
      minw:=maxlongint>>1;
      t:=tree[now];
      while t<>nil do
      begin
	 if f[0,t^.goal]-f[1,t^.goal]<minw then
	    minw:=f[0,t^.goal]-f[1,t^.goal];
	 t:=t^.next;
      end;
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