program pku1067(input,output);
var
	m,n		:longint;
	x,y 	:longint;
	alpha 	:double;
	tmp		:longint;
begin
	alpha:=(sqrt(5)+1)/2;
	while not eof do
	begin
		readln(x,y);
		if y<x then
		begin
			tmp:=x;
			x:=y;
			y:=tmp;
		end;
		n:=y-x;
		m:=trunc(n*alpha);
		if m=x then
			writeln(0)
		else
			writeln(1);
	end;
end.