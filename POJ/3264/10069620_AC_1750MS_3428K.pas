program pku3264_line_tree(input,output);
type
   node	= record
	     left,right,x,y,minx,maxx : longint;
	  end;
var
   tree	: array[0..500000] of node;
   n,q	: longint;
   a	: array[0..200000] of longint;
   tot	: longint;
function min(aa,bb :longint ):longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
function max(aa,bb :longint ):longint;
begin
   if aa>bb then
      exit(aa);
   exit(bb);
end; { max }
procedure build(xx,yy: longint );
var
   mid,now : longint;
begin
   inc(tot);
   tree[tot].x:=xx;
   tree[tot].y:=yy;
   if xx=yy then
   begin
      tree[tot].minx:=a[xx];
      tree[tot].maxx:=a[xx];
      exit;
   end;
   now:=tot;
   mid:=(xx+yy)>>1;
   tree[now].left:=tot+1;
   build(xx,mid);
   tree[now].right:=tot+1;
   build(mid+1,yy);
   tree[now].minx:=min(tree[tree[now].left].minx,tree[tree[now].right].minx);
   tree[now].maxx:=max(tree[tree[now].left].maxx,tree[tree[now].right].maxx);
end; { build }
procedure init;
var
   i : longint;
begin
   readln(n,q);
   for i:=1 to n do
      readln(a[i]);
   build(1,n);
end; { init }
function getmax(now,xx,yy :longint ):longint;
var
   mid : longint;
begin
   if (tree[now].x=xx)and(tree[now].y=yy) then
      exit(tree[now].maxx);
   mid:=(tree[now].x+tree[now].y)>>1;
   if yy<=mid then
      exit(getmax(tree[now].left,xx,yy))
   else
      if xx>mid then
	 exit(getmax(tree[now].right,xx,yy))
      else
	 exit(max(getmax(tree[now].left,xx,mid),getmax(tree[now].right,mid+1,yy)));
end; { getmax }
function getmin(now,xx,yy :longint ):longint;
var
   mid : longint;
begin
   if (tree[now].x=xx)and(tree[now].y=yy) then
      exit(tree[now].minx);
   mid:=(tree[now].x+tree[now].y)>>1;
   if yy<=mid then
      exit(getmin(tree[now].left,xx,yy))
   else
      if xx>mid then
	 exit(getmin(tree[now].right,xx,yy))
      else
	 exit(min(getmin(tree[now].left,xx,mid),getmin(tree[now].right,mid+1,yy)));
end; { getmin }
procedure solve();
var
   i,xx,yy : longint;
begin
   for i:=1 to q do
   begin
      readln(xx,yy);
      writeln(getmax(1,xx,yy)-getmin(1,xx,yy));
   end;
end; { solve }
begin
   init;
   solve;
end.