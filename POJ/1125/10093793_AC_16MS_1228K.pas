program pku1125(input,output);
var
	f:array[0..300,0..300] of longint;
	n:longint;
procedure init;
var
	i,j,s,x,y:longint;
begin
	fillchar(f,sizeof(f),30);
	for i:=1 to n do
	begin
		read(s);
		for j:=1 to s do
		begin
			read(x,y);
			f[i,x]:=y;
		end;
		readln;
	end;
	for i:=1 to n do
		f[i,i]:=0;
end;{ init }
procedure main;
var
	i,j,k:longint;
	answer,max,people:longint;
begin
	for k:=1 to n do
		for i:=1 to n do
			for j:=1 to n do
				if f[i,k]+f[k,j]<f[i,j] then
					f[i,j]:=f[i,k]+f[k,j];
	answer:=19950714;
	for i:=1 to n do
	begin
		max:=0;
		for j:=1 to n do
			if (i<>j)and(f[i,j]>max) then
				max:=f[i,j];
		if max<answer then
		begin
			answer:=max;
			people:=i;
		end;
	end;
	writeln(people,' ',answer);
end;{ main }
begin
	readln(n);
	while n<>0 do
	begin
		init;
		main;
		readln(n);
	end;
end.