program pku2355(input,output);
var
	f	:array[0..10010] of longint;
	d	:array[0..10010] of longint;
	l,c	:array[1..3] of longint;
	x,y	:longint;
	n	:longint;
procedure init;
var
	i:longint;
begin
	for i:=1 to 3 do
		read(l[i]);
	for i:=1 to 3 do
		read(c[i]);
	readln;
	readln(n);
	readln(x,y);
	d[1]:=0;
	for i:=2 to n do
		readln(d[i]);
end;
procedure main;
var
	i,j:longint;
begin
	fillchar(f,sizeof(f),63);
	for i:=0 to x do
		f[i]:=0;
	for i:=x+1 to y do
	begin
		for j:=i-1 downto x do
		begin
			if d[i]-d[j]>l[3] then
				break;
			if (d[i]-d[j]<=l[1])and(f[j]+c[1]<f[i]) then
				f[i]:=f[j]+c[1];
			if (d[i]-d[j]<=l[2])and(f[j]+c[2]<f[i]) then
				f[i]:=f[j]+c[2];
			if (d[i]-d[j]<=l[3])and(f[j]+c[3]<f[i]) then
				f[i]:=f[j]+c[3];
		end;
	end;
	writeln(f[y]);
end;
begin
	init;
	main;
end.