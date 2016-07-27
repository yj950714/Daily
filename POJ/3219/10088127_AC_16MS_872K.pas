program pku3219(input,output);
var
	x,y:longint;
begin
	while not eof do
	begin
		readln(x,y);
		if y and (x-y)>0 then
			writeln(0)
		else
			writeln(1);
	end;
end.