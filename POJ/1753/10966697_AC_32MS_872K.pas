program poj1753(input,output);
var
	map,tmp:array[0..5,0..5] of boolean;
	answer:integer;
	fx:array[1..5] of integer=(0,0,1,-1,0);
	fy:array[1..5] of integer=(1,-1,0,0,0);
function min(aa,bb:integer):integer;
begin
	if aa<bb then
		exit(aa);
	exit(bb);
end;{ min }
procedure init;
var
	ch:char;
	i,j:integer;
begin
	for i:=1 to 4 do
	begin
		for j:=1 to 4 do
		begin
			read(ch);
			if ch='w' then
				map[i,j]:=true
			else
				map[i,j]:=false;
		end;
		readln;
	end;
end;{ init }
procedure change(xx,yy:integer);
var
	i,newx,newy:integer;
begin
	for i:=1 to 5 do
	begin
		newx:=xx+fx[i];
		newy:=yy+fy[i];
		if (newx<1)or(newx>4)or(newy<1)or(newy>4) then
			continue;
		tmp[newx,newy]:=not tmp[newx,newy];
	end;
end;{ change }
function calc1(state:integer):integer;
var
	i,j:integer;
begin
	calc1:=0;
	for i:=1 to 4 do
		for j:=1 to 4 do
			tmp[i,j]:=map[i,j];
	for i:=1 to 4 do
		if (state and (1<<(i-1)))>0 then
		begin
			change(1,i);
			inc(calc1);
		end;
	for i:=2 to 4 do
		for j:=1 to 4 do
			if tmp[i-1,j] then
			begin
				change(i,j);
				inc(calc1);
			end;
	for i:=1 to 4 do
		for j:=1 to 4 do
			if tmp[i,j] then
				exit(30000);
end;{ calc1 }
function calc2(state:integer):integer;
var
	i,j:integer;
begin
	calc2:=0;
	for i:=1 to 4 do
		for j:=1 to 4 do
			tmp[i,j]:=map[i,j];
	for i:=1 to 4 do
		if (state and (1<<(i-1)))>0 then
		begin
			change(1,i);
			inc(calc2);
		end;
	for i:=2 to 4 do
		for j:=1 to 4 do
			if not tmp[i-1,j] then
			begin
				change(i,j);
				inc(calc2);
			end;
	for i:=1 to 4 do
		for j:=1 to 4 do
			if not tmp[i,j] then
				exit(30000);
end;{ calc2 }
procedure main;
var
	i:integer;
begin
	answer:=maxint;
	for i:=0 to 15 do
	begin
		answer:=min(answer,calc1(i));
		answer:=min(answer,calc2(i));
	end;
        if answer=30000 then
           writeln('Impossible')
        else
	   writeln(answer);
end;{ main }
begin
	init;
	main;
end.