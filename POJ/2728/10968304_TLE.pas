program poj2728(input,output);
var
	x,y,h:array[0..1100] of longint;
	xx,yy,cost:array[0..510000] of longint;
	len,ww:array[0..510000] of double;
	father:array[0..1100] of longint;
	n,tot:longint;
function find(now:longint):longint;
begin
	if father[now]=now then
		exit(now);
	father[now]:=find(father[now]);
	exit(father[now]);
end;{ find }
procedure swap_int(var aa,bb:longint);
var
	tt:longint;
begin
	tt:=aa;
	aa:=bb;
	bb:=tt;
end;{ swap_int }
procedure swap(var aa,bb:double);
var
	tt:double;
begin
	tt:=aa;
	aa:=bb;
	bb:=tt;
end;{ swap }
procedure sort(p,q:longint);
var
	i,j:longint;
	mm:double;
begin
	i:=p;
	j:=q;
	mm:=ww[(i+j)>>1];
	repeat
		while ww[i]<mm do
			inc(i);
		while ww[j]>mm do
			dec(j);
		if i<=j then
		begin
			swap_int(xx[i],xx[j]);
			swap_int(yy[i],yy[j]);
			swap_int(cost[i],cost[j]);
			swap(len[i],len[j]);
			swap(ww[i],ww[j]);
			inc(i);
			dec(j);
		end;
	until i>j;
	if i<q then sort(i,q);
	if j>p then sort(p,j);
end;{ sort }
procedure init;
var
	i,j:longint;
begin
	for i:=1 to n do
		readln(x[i],y[i],h[i]);
	tot:=0;
	for i:=1 to n do
		for j:=i+1 to n do
		begin
			inc(tot);
			xx[tot]:=i;
			yy[tot]:=j;
			cost[tot]:=abs(h[i]-h[j]);
			len[tot]:=sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j]));
		end;
end;{ init }
function check(limit:double):boolean;
var
	i,now,sx,sy:longint;
	sum:double;
begin
	sum:=0;
	for i:=1 to tot do
		ww[i]:=cost[i]-len[i]*limit;
	sort(1,tot);
	for i:=1 to n do
		father[i]:=i;
	now:=0;
	for i:=1 to tot do
	begin
		sx:=find(xx[i]);
		sy:=find(yy[i]);
		if sx=sy then
			continue;
		father[sy]:=sx;
		inc(now);
		sum:=sum+ww[i];
		if now=n-1 then
			break;
	end;
	if sum>=0 then
		exit(false);
	exit(true);
end;{ check }
procedure main;
var
	l,r,mid:double;
begin
	check(1);
	l:=0.0;
	r:=100000000.0;
	while r-l>1e-5 do
	begin
		mid:=(l+r)/2;
		if check(mid) then
			r:=mid
		else
			l:=mid
	end;
	writeln(l:0:3);
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