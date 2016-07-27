program pku1962(input,output);
var
	f,w:array[0..21000] of longint;
	n:longint;
	cases:longint;
procedure init;
var
	i:longint;
begin
	readln(n);
	for i:=0 to n do
	begin
		w[i]:=0;
		f[i]:=i;
	end;
end;
procedure union(x,y:longint);
begin
	f[x]:=y;
	w[x]:=abs(y-x) mod 1000;
end;
function find(x:longint):longint;
begin
	if f[x]=x then
		exit(x);
	find(f[x]);
	w[x]:=w[x]+w[f[x]];
	f[x]:=find(f[x]);
	exit(f[x]);
end;
procedure main;
var
	xx,yy:longint;
	ch:char;
begin
	read(ch);
	while ch<>'O' do
	begin
		case ch of
		'E':begin
				readln(xx);
				find(xx);
				writeln(w[xx]);
			end;
		'I':begin
				readln(xx,yy);
				union(xx,yy);
			end;
		end;
		read(ch);
	end;
end;
begin
	readln(cases);
	while cases>0 do
	begin
		dec(cases);
		init;
		main;
	end;
end.