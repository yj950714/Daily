program pku3750(input,output);
var
   v:array[0..100] of boolean;
   s:array[0..100] of ansistring;
   n,l,start:longint;
   sum,now:longint;
procedure init;
var
	ss:ansistring;
	i:longint;
begin
	readln(n);
	for i:=1 to n do
		readln(s[i]);
	readln(ss);
	val(copy(ss,1,pos(',',ss)-1),start);
	delete(ss,1,pos(',',ss));
	val(ss,l);
end;
procedure main;
var
	number:longint;
begin
	fillchar(v,sizeof(v),false);
	sum:=n;
	now:=start;
	number:=1;
	while sum>0 do
	begin
		while (number<l)or(v[now]) do
		begin
			inc(now);
			if now=n+1 then
				now:=1;
			if not v[now] then
				inc(number);
		end;
		writeln(s[now]);
		v[now]:=true;
		number:=1;
		dec(sum);
		if sum=0 then
			break;
		while v[now] do
		begin
			inc(now);
			if now=n+1 then
				now:=1;
		end;
	end;
end;
begin
	init;
	main;
end.