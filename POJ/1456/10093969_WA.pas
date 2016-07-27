program pku1456(input,output);
var
	x,w		:array[0..11000] of longint;
	f		:array[0..11000] of longint;
	n,maxt	:longint;
	answer	:longint;
procedure swap(var aa,bb:longint);
var
	tt:longint;
begin
	tt:=aa;
	aa:=bb;
	bb:=tt;
end;
procedure sort(p,q:longint);
var
	i,j,m:longint;
begin
	i:=p;
	j:=q;
	m:=w[(i+j)>>1];
	repeat
		while w[i]>m do
			inc(i);
		while w[j]<m do
			dec(j);
		if i<=j then
		begin
			swap(w[i],w[j]);
			swap(x[i],x[j]);
			inc(i);
			dec(j);
		end;
	until i>j;
	if i<q then sort(i,q);
	if j>p then sort(p,j);
end;
function getfather(x:longint):longint;
begin
	if f[x]=x then
		exit(f[x]);
	f[x]:=getfather(f[x]);
	exit(f[x]);
end;
procedure init;
var
	i:longint;
begin
	read(n);
	maxt:=0;
	for i:=1 to n do
	begin
		read(w[i],x[i]);
		if x[i]>maxt then
			maxt:=x[i];
	end;
	for i:=0 to maxt do
		f[i]:=i;
end;
procedure main;
var
	i,xx:longint;
	sum:longint;
begin
	sort(1,n);
	answer:=0;
	sum:=0;
	for i:=1 to n do
	begin
		xx:=getfather(x[i]);
		if xx=0 then
			continue;
		inc(sum);
		inc(answer,w[i]);
		f[xx]:=xx-1;
		if sum>=maxt then
			break;
	end;
	writeln(answer);
end;
begin
	while not eof do
	begin
		init;
		main;
	end;
end.