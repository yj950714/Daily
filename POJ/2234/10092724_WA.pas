program pku2234(input,output);
var
	n,i,x	:longint;
	answer	:longint;
begin
	while not eof do
	begin
		read(n);
		answer:=0;
		for i:=1 to n do
		begin
			read(x);
			answer:=answer xor x;
		end;
		if answer>0 then
			writeln('Yes')
		else
			writeln('No');
		readln;
	end;
end.