program poj2749(input,output);
type
	nodes=record
		x,y:longint;
	end;
var
	goal,next:array[0..5000] of longint;
	first,dfn,low,stack,color:array[0..1100] of longint;
	dist:array[0..1,0..550] of longint;
	instack:array[0..1100] of boolean;
	point:array[0..510] of nodes;
	like,hate:array[0..1100] of nodes;
	s1,s2:nodes;
	n,tot,aa,bb,top,cnt,base:longint;
procedure add(xx,yy:longint);
begin
	inc(tot);
	goal[tot]:=yy;
	next[tot]:=first[xx];
	first[xx]:=tot;
end;{ add }
procedure init;
var
	i:longint;
begin
	readln(n,aa,bb);
	readln(s1.x,s1.y,s2.x,s2.y);
	for i:=1 to n do
		readln(point[i].x,point[i].y);
	for i:=1 to n do
	begin
		dist[0,i]:=abs(point[i].x-s1.x)+abs(point[i].y-s1.y);
		dist[1,i]:=abs(point[i].x-s2.x)+abs(point[i].y-s2.y);
	end;
	base:=abs(s1.x-s2.x)+abs(s1.y-s2.y);
	for i:=1 to aa do
		readln(hate[i].x,hate[i].y);
	for i:=1 to bb do
		readln(like[i].x,like[i].y);
end;{ init }
procedure dfs(now:longint);
var
	t:longint;
begin
	inc(top);
	stack[top]:=now;
	instack[now]:=true;
	inc(cnt);
	dfn[now]:=cnt;
	low[now]:=cnt;
	t:=first[now];
	while t<>-1 do
	begin
		if dfn[goal[t]]=0 then
		begin
			dfs(goal[t]);
			if low[goal[t]]<low[now] then
				low[now]:=low[goal[t]];
		end
		else
			if (instack[goal[t]])and(dfn[goal[t]]<low[now]) then
				low[now]:=dfn[goal[t]];
		t:=next[t];
	end;
	if dfn[now]=low[now] then
	begin
		inc(color[0]);
		while true do
		begin
			color[stack[top]]:=color[0];
			instack[stack[top]]:=false;
			dec(top);
			if stack[top+1]=now then
				break;
		end;
	end;
end;{ dfs }
function tarjan(limit:longint):boolean;
var
	i,j:longint;
begin
	cnt:=0;
	tot:=0;
	top:=0;
	color[0]:=0;
	fillchar(dfn,sizeof(dfn),0);
	fillchar(stack,sizeof(stack),0);
	fillchar(instack,sizeof(instack),false);
	fillchar(first,sizeof(first),255);
	for i:=1 to aa do
	begin
		add(hate[i].x,hate[i].y+n);
		add(hate[i].y,hate[i].x+n);
		add(hate[i].x+n,hate[i].y);
		add(hate[i].y+n,hate[i].x);
	end;
	for i:=1 to bb do
	begin
		add(like[i].x,like[i].y);
		add(like[i].x+n,like[i].y+n);
		add(like[i].y,like[i].x);
		add(like[i].y+n,like[i].x+n);
	end;
	for i:=1 to n do
		for j:=i+1 to n do
		begin
			if dist[0,i]+dist[0,j]>limit then
			begin
				add(i,j+n);
				add(j,i+n);
			end;
			if dist[1,i]+dist[1,j]>limit then
			begin
				add(i+n,j);
				add(j+n,i);
			end;
			if dist[0,i]+dist[1,j]+base>limit then
			begin
				add(i,j);
				add(j+n,i+n);
			end;
			if dist[1,i]+dist[0,j]+base>limit then
			begin
				add(i+n,j+n);
				add(j,i);
			end;
		end;
	for i:=1 to n<<1 do
		if dfn[i]=0 then
			dfs(i);
	for i:=1 to n do
		if color[i]=color[i+n] then
			exit(false);
	exit(true);
end;{ tarjan }
procedure main;
var
	l,r,mid:longint;
begin
	l:=0;
	r:=5000000;
	if not tarjan(r) then
	begin
		writeln(-1);
		exit;
	end;
	while l+1<r do
	begin
		mid:=(l+r)>>1;
		if tarjan(mid) then
			r:=mid
		else
			l:=mid;
	end;
	writeln(r);
end;{ main }
begin
	init;
	main;
end.