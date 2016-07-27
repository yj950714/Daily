program pku3368(input,output);
type
   node	= record
	     left,right,x,y,maxl,maxr,sum : longint;
	  end;
var
   tree	   : array[0..300000] of node;
   a	   : array[0..100010] of longint;
   n,q,tot : longint;
function max(aa,bb: longint):longint;
begin
   if aa>bb then
      exit(aa);
   exit(bb);
end; { max }
function min(aa,bb :longint ): longint;
begin
   if aa<bb then
      exit(aa);
   exit(bb);
end; { min }
procedure build(xx,yy :longint );
var
   now,mid : longint;
begin
   inc(tot);
   now:=tot;
   tree[now].x:=xx;
   tree[now].y:=yy;
   if xx=yy then
   begin
      tree[now].maxl:=1;
      tree[now].maxr:=1;
      tree[now].sum:=1;
      exit;
   end;
   mid:=(xx+yy)>>1;
   tree[now].left:=tot+1;
   build(xx,mid);
   tree[now].right:=tot+1;
   build(mid+1,yy);
   if a[tree[tree[now].left].x]=a[tree[tree[now].right].x] then
      tree[now].maxl:=(mid-xx+1)+tree[tree[now].right].maxl
   else
      tree[now].maxl:=tree[tree[now].left].maxl;
   if a[tree[tree[now].left].y]=a[tree[tree[now].right].y] then
      tree[now].maxr:=(yy-mid)+tree[tree[now].left].maxr
   else
      tree[now].maxr:=tree[tree[now].right].maxr;
   tree[now].sum:=max(tree[tree[now].left].sum,tree[tree[now].right].sum);
   if a[tree[tree[now].left].y]=a[tree[tree[now].right].x] then
      tree[now].sum:=max(tree[now].sum,tree[tree[now].left].maxr+tree[tree[now].right].maxl);
   tree[now].sum:=max(tree[now].sum,tree[now].maxl);
   tree[now].sum:=max(tree[now].sum,tree[now].maxr);
end; { build }
procedure init;
var
   i : longint;
begin
   tot:=0;
   readln(q);
   for i:=1 to n do
      read(a[i]);
   readln;
   build(1,n);
end; { init }
function getans(now,xx,yy :longint ):longint;
var
   mid : longint;
   tmp : longint;
begin
   tmp:=0;
   if (tree[now].x=xx)and(tree[now].y=yy) then
      exit(tree[now].sum);
   mid:=(tree[now].x+tree[now].y)>>1;
   if yy<=mid then
      exit(getans(tree[now].left,xx,yy))
   else
      if xx>mid then
	 exit(getans(tree[now].right,xx,yy))
      else
      begin
	 tmp:=max(tmp,getans(tree[now].left,xx,mid));
	 tmp:=max(tmp,getans(tree[now].right,mid+1,yy));
	 exit(tmp);
      end;
end; { getans }
procedure solve();
var
   i,x,y : longint;
begin
   for i:=1 to q do
   begin
      readln(x,y);
      writeln(getans(1,x,y));
   end;
end; { solve }
begin
   read(n);
   while n<>0 do
   begin
      init;
      solve;
      read(n);
   end;
end.