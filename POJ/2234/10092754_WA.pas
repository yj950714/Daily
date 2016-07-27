program pku2234(input,output);
var
	n,i,x	:longint;
	answer	:longint;
	a:array[0..25] of longint;
begin
	while not eof do
	begin
		read(n);
		for i:=1 to n do
			read(a[i]);
		answer:=a[1];
		for i:=2 to n do
			answer:=answer xor x;
		if answer=0 then
			writeln('No')
		else
			writeln('Yes');
	end;
end.