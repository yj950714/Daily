program poj2965(input,output);
const
	maxh= 50;
var
	map:array[0..5,0..5] of boolean;
	x,y:array[0..200] of longint;
	depth:longint;
	flag:boolean;
procedure init;
var
	i,j:integer;
	ch:char;
begin
	for i:=1 to 4 do
	begin
		for j:=1 to 4 do
		begin
			read(ch);
			if ch='-' then
				map[i,j]:=true
			else
				map[i,j]:=false;
		end;
		readln;
	end;
end;{ init }
function check():boolean;
var
	i,j:longint;
begin
	for i:=1 to 4 do
		for j:=1 to 4 do
		if not map[i,j] then
			exit(false);
	exit(true);
end;{ check }
procedure dfs(now:longint);
var
	i,j,k:longint;
begin
	if now=depth+1 then
	begin
		if check() then
			flag:=true;
		exit;
	end;
	for i:=1 to 4 do
		for j:=1 to 4 do
		begin
			for k:=1 to 4 do
			begin
				map[i,k]:=not map[i,k];
				map[k,j]:=not map[k,j];
			end;
			map[i,j]:=not map[i,j];
			x[now]:=i;
			y[now]:=j;
			dfs(now+1);
			if flag then
				exit;
			map[i,j]:=not map[i,j];
			for k:=1 to 4 do
			begin
				map[i,k]:=not map[i,k];
				map[k,j]:=not map[k,j];
			end;
		end;
end;{ dfs }
procedure main;
var
	i:longint;
begin
	for depth:=0 to maxh do
	begin
		flag:=false;
		dfs(1);
		if flag then
			break;
	end;
	writeln(depth);
	for i:=1 to depth do
		writeln(x[i],' ',y[i]);
end;{ main }
begin
	init;
	main;
end.