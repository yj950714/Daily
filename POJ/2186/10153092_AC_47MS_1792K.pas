program pku2186(input,output);
type
	node=^link;
	link=record
		goal:longint;
		next:node;
	end;
var
	l:array[0..11000] of node;
	color:array[0..11000] of longint;
	out:array[0..11000] of longint;
	n,m:longint;
	dfn,low:array[0..11000] of longint;
	stack:array[0..20000] of longint;
	instack:array[0..11000] of boolean;
	colour,cnt,top:longint;
	answer,answer_color,sum:longint;
procedure add(xx,yy:longint);
var
	tt:node;
begin
	new(tt);
	tt^.goal:=yy;
	tt^.next:=l[xx];
	l[xx]:=tt;
end;{ add }
procedure init;
var
	i,xx,yy:longint;
begin
	readln(n,m);
	for i:=1 to n do
	begin
		instack[i]:=false;
		dfn[i]:=0;
		low[i]:=0;
		color[i]:=0;
		out[i]:=0;
		l[i]:=nil;
	end;
	for i:=1 to m do
	begin
		readln(xx,yy);
		add(xx,yy);
	end;
end;{ init }
procedure dfs(now:longint);
var
	t:node;
begin
	inc(cnt);
	dfn[now]:=cnt;
	low[now]:=cnt;
	inc(top);
	stack[top]:=now;
	instack[now]:=true;
	t:=l[now];
	while t<>nil do
	begin
		if dfn[t^.goal]=0 then
		begin
			dfs(t^.goal);
			if low[t^.goal]<low[now] then
				low[now]:=low[t^.goal];
		end
		else
		begin
			if (instack[t^.goal])and(dfn[t^.goal]<low[now]) then
				low[now]:=dfn[t^.goal];
		end;
		t:=t^.next;
	end;
	if dfn[now]=low[now] then
	begin
		inc(colour);
		while true do
		begin
			color[stack[top]]:=colour;
			instack[stack[top]]:=false;
			dec(top);
			if stack[top+1]=now then
				break;
		end;
	end;
end;{ dfs }
procedure tarjan();
var
	i:longint;
begin
	colour:=0;
	for i:=1 to n do
	if dfn[i]=0 then
		dfs(i);
end;{ tarjan }
procedure main;
var
	t:node;
	i:longint;
begin
	for i:=1 to n do
	begin
		t:=l[i];
		while t<>nil do
		begin
			if color[i]<>color[t^.goal] then
				inc(out[color[i]]);
			t:=t^.next;
		end;
	end;
	answer_color:=0;
	sum:=0;
	answer:=0;
	for i:=1 to colour do
		if out[i]=0 then
		begin
			inc(sum);
			answer_color:=i;
		end;
	if sum=0 then
		answer:=n;
	if sum>=2 then
		answer:=0;
	if sum=1 then
	begin
		for i:=1 to n do
			if color[i]=answer_color then
				inc(answer);
	end;
end;{ main }
procedure print;
begin
	writeln(answer);
end;{ print }
begin
	init;
	tarjan;
	main;
	print;
end.