program pku1207(input,output);
var
	i				 :longint;
	x,y				 :int64;
	answer1,answer2  :int64;
	now				 :int64;
begin
	while not eof do
	begin
		readln(x,y);
		write(x,' ',y,' ');
		if x>y then
		begin
			now:=x;
			x:=y;
			y:=now;
		end;
		answer2:=0;
		for i:=x to y do
		begin
			answer1:=1;
			now:=i;
			while now<>1 do
			begin
				if odd(now) then
					now:=3*now+1
				else
					now:=now>>1;
				inc(answer1);
			end;
			if answer1>answer2 then
				answer2:=answer1;
		end;
		writeln(answer2);
	end;
end.