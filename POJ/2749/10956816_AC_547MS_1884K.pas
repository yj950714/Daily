program poj2749(input,output);
type
	nodes=record
		x,y:longint;
	end;
var
	map:array[0..1010,0..1010] of boolean;
	dfn,low,stack,color:array[0..1100] of longint;
	dist:array[0..1,0..550] of longint;
	instack:array[0..1100] of boolean;
	point:array[0..510] of nodes;
	like,hate:array[0..1100] of nodes;
	s1,s2:nodes;
	n,aa,bb,top,cnt,base:longint;
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
	i:longint;
begin
	inc(top);
	stack[top]:=now;
	instack[now]:=true;
	inc(cnt);
	dfn[now]:=cnt;
	low[now]:=cnt;
	for i:=1 to n*2 do
	if map[now,i] then
	begin
		if dfn[i]=0 then
		begin
			dfs(i);
			if low[i]<low[now] then
				low[now]:=low[i];
		end
		else
			if (instack[i])and(dfn[i]<low[now]) then
				low[now]:=dfn[i];
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
	top:=0;
	color[0]:=0;
	fillchar(map,sizeof(map),false);
	fillchar(dfn,sizeof(dfn),0);
	fillchar(stack,sizeof(stack),0);
	fillchar(instack,sizeof(instack),false);
	for i:=1 to aa do
	begin
		map[hate[i].x,hate[i].y+n]:=true;
		map[hate[i].y,hate[i].x+n]:=true;
		map[hate[i].x+n,hate[i].y]:=true;
		map[hate[i].y+n,hate[i].x]:=true;
	end;
	for i:=1 to bb do
	begin
		map[like[i].x,like[i].y]:=true;
		map[like[i].x+n,like[i].y+n]:=true;
		map[like[i].y,like[i].x]:=true;
		map[like[i].y+n,like[i].x+n]:=true;
	end;
	for i:=1 to n do
		for j:=i+1 to n do
		begin
			if dist[0,i]+dist[0,j]>limit then
			begin
				map[i,j+n]:=true;
				map[j,i+n]:=true;
			end;
			if dist[1,i]+dist[1,j]>limit then
			begin
				map[i+n,j]:=true;
				map[j+n,i]:=true;
			end;
			if dist[0,i]+dist[1,j]+base>limit then
			begin
				map[i,j]:=true;
				map[j+n,i+n]:=true;
			end;
			if dist[1,i]+dist[0,j]+base>limit then
			begin
				map[i+n,j+n]:=true;
				map[j,i]:=true;
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