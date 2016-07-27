program pku1083(input,output);
var
	cover:array[0..801] of integer;
	x,y,n:longint;
	cases:longint;
	i,j:longint;
	answer:longint;
procedure swap(var aa,bb:longint);
var
	tt:longint;
begin
	tt:=aa;
	aa:=bb;
	bb:=tt;
end;
begin
	readln(cases);
	while cases>0 do
	begin
		dec(cases);
		fillchar(cover,sizeof(cover),0);
		readln(n);
		for i:=1 to n do
		begin
			readln(x,y);
			if x>y then
				swap(x,y);
			if not odd(x) then
				dec(x);
			if odd(y) then
				inc(y);
			for j:=x to y do
				inc(cover[j]);
		end;
		answer:=0;
		for i:=1 to 800 do
			if cover[i]>answer then
				answer:=cover[i];
		writeln(answer*10);
	end;
end.