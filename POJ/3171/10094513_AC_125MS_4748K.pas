program pku3171(input,output);
type
	node=record
		left,right,x,y:longint;
		minn:longint;
	end;
var
	tree:array[0..180000] of node;
	f	:array[0..90000] of longint;
	start,final,cost:array[0..11000] of longint;
	n,m,e:longint;
	tot:longint;
	maxl:longint;
function min(aa,bb:longint):longint;
begin
	if aa<bb then
		exit(aa);
	exit(bb);
end;{ min }
procedure build(xx,yy:longint);
var
	now,mid:longint;
begin
	inc(tot);
	now:=tot;
	tree[now].x:=xx;
	tree[now].y:=yy;
	if xx=yy then
	begin
		tree[now].minn:=19950714;
		exit;
	end;
	mid:=(xx+yy)>>1;
	tree[now].left:=tot+1;
	build(xx,mid);
	tree[now].right:=tot+1;
	build(mid+1,yy);
	tree[now].minn:=19950714;
end;{ build }
procedure change(now,poss,worth:longint);
var
	mid:longint;
begin
	if tree[now].x=tree[now].y then
	begin
		tree[now].minn:=worth;
		exit;
	end;
	mid:=(tree[now].x+tree[now].y)>>1;
	if poss<=mid then
		change(tree[now].left,poss,worth)
	else
		change(tree[now].right,poss,worth);
	tree[now].minn:=min(tree[tree[now].left].minn,tree[tree[now].right].minn);
end;{ change }
function find(now,xx,yy:longint):longint;
var
	mid:longint;
begin
	if (tree[now].x=xx)and(tree[now].y=yy) then
		exit(tree[now].minn);
	mid:=(tree[now].x+tree[now].y)>>1;
	if yy<=mid then
		exit(find(tree[now].left,xx,yy))
	else
		if xx>mid then
			exit(find(tree[now].right,xx,yy))
		else
			exit(min(find(tree[now].left,xx,mid),find(tree[now].right,mid+1,yy)));
end;{ find }
procedure swap(var aa,bb:longint);
var
	tt:longint;
begin
	tt:=aa;
	aa:=bb;
	bb:=tt;
end;{ swap }
procedure sort(p,q:longint);
var
	i,j,mid:longint;
begin
	i:=p;
	j:=q;
	mid:=final[(i+j)>>1];
	repeat
		while final[i]<mid do
			inc(i);
		while final[j]>mid do
			dec(j);
		if i<=j then
		begin
			swap(start[i],start[j]);
			swap(final[i],final[j]);
			swap(cost[i],cost[j]);
			inc(i);
			dec(j);
		end;
	until i>j;
	if i<q then sort(i,q);
	if j>p then sort(p,j);
end;{ sort }
procedure init;
var
	i:longint;
begin
	readln(n,m,e);
	tot:=0;
	maxl:=0;
	for i:=1 to n do
	begin
		readln(start[i],final[i],cost[i]);
		if final[i]>maxl then
			maxl:=final[i];
	end;
	build(0,maxl);
	sort(1,n);
end;{ init }
function max(aa,bb:longint):longint;
begin
	if aa>bb then
		exit(aa);
	exit(bb);
end;{ max}
procedure main;
var
	i,j:longint;
begin
	fillchar(f,sizeof(f),63);
	change(1,m,0);
	f[m]:=0;
	for i:=1 to n do
	begin
		j:=find(1,max(start[i]-1,0),final[i]);
		if j+cost[i]<f[final[i]] then
		begin
			f[final[i]]:=j+cost[i];
			change(1,final[i],f[final[i]]);
		end;
	end;
end;{ main }
procedure print;
begin
	if f[e]>=19950714 then
		writeln(-1)
	else
		writeln(f[e]);
end;{ print }
begin
	init;
	main;
	print;
end.
