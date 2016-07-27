program pku2723(input,output);
type
	node=record
		x,y:longint;
	end;
var
	first:array[0..5100] of longint;
	goal,next:array[0..30000] of longint;
	dfn,low,stack,color:array[0..5100] of longint;
	instack:array[0..5100] of boolean;
	key:array[0..1500] of node;
	door:array[0..3000] of node;
	cnt,top,tot:longint;
	n,m:longint;
procedure clean();
var
	i:longint;
begin
	fillchar(next,sizeof(next),0);
	fillchar(goal,sizeof(goal),0);
	for i:=0 to n<<2 do
		first[i]:=-1;
	tot:=0;
end;{ clean }
procedure add(xx,yy:longint);
begin
	inc(tot);
	goal[tot]:=yy;
	next[tot]:=first[xx];
	first[xx]:=tot;
end;{ add }
procedure dfs(now:longint);
var
	t:longint;
begin
	inc(cnt);
	dfn[now]:=cnt;
	low[now]:=cnt;
	inc(top);
	stack[top]:=now;
	instack[now]:=true;
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
function tarjan():boolean;
var
	i:longint;
begin
	fillchar(dfn,sizeof(dfn),0);
	fillchar(low,sizeof(low),0);
	fillchar(color,sizeof(color),0);
	cnt:=0;
	fillchar(stack,sizeof(stack),0);
	fillchar(instack,sizeof(instack),false);
	for i:=1 to n<<2 do
		if dfn[i]=0 then
			dfs(i);
	for i:=1 to n<<1 do
		if color[i]=color[i+(n<<1)] then
			exit(false);
	exit(true);
end;{ tarjan }
procedure main;
var
	i,l,r,mid:longint;
begin
	for i:=1 to n do
	begin
		readln(key[i].x,key[i].y);
		inc(key[i].x);
		inc(key[i].y);
	end;
	for i:=1 to m do
	begin
		readln(door[i].x,door[i].y);
		inc(door[i].x);
		inc(door[i].y);
	end;
	l:=-1;
	r:=m+1;
	while l+1<r do
	begin
		mid:=(l+r)>>1;
		clean();
		for i:=1 to n do
		begin
			add(key[i].x,key[i].y+(n<<1));
			add(key[i].y,key[i].x+(n<<1));
		end;
		for i:=1 to mid do
		begin
			add(door[i].x+(1<<n),door[i].y);
			add(door[i].y+(1<<n),door[i].x);
		end;
		if tarjan() then
			l:=mid
		else
			r:=mid;
	end;
	writeln(l);
end;{ main }
begin
	readln(n,m);
	while (n<>0)or(m<>0) do
	begin
		main;
		readln(n,m);
	end;
end.