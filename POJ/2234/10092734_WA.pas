program pku2234(input,output);
var
	n,i,x	:longint;
	answer	:longint;
begin
	while not eof do
	begin
		read(n);
		read(answer);
		for i:=2 to n do
		begin
			read(x);
			answer:=answer xor x;
		end;
		if answer=0 then
			writeln('No')
		else
			writeln('Yes');
		readln;
	end;
end.