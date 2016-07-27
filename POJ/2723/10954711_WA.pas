program pku2723(input,output);
var
	first:array[0..5100] of longint;
	goal,next:array[0..30000] of longint;
	dfn,low,stack,color:array[0..5100] of longint;
	instack:array[0..5100] of boolean;
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
		if color[i]=color[i+n] then
			exit(false);
	exit(true);
end;{ tarjan }
procedure main;
var
	i,xx,yy,answer:longint;
	flag:boolean;
begin
	for i:=1 to n do
	begin
		readln(xx,yy);
		inc(xx);
		inc(yy);
		add(xx,yy+(n<<1));
		add(yy,xx+(n<<1));
	end;
	flag:=true;
	for i:=1 to m do
	begin
		readln(xx,yy);
		inc(xx);
		inc(yy);
		add(xx+(n<<1),yy);
		add(yy+(n<<1),xx);
		if (not tarjan())and(flag) then
		begin
			flag:=false;
			answer:=i-1;
		end;
	end;
	if not flag then
		writeln(answer)
	else
		writeln(m);
end;{ main }
begin
	readln(n,m);
	while (n<>0)or(m<>0) do
	begin
		clean();
		main;
		readln(n,m);
	end;
end.