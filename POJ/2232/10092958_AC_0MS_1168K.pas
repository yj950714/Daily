program pku2232(input,output);
var
	n,i	:longint;
	c,s,f:longint;
	ss:ansistring;
begin
	while not eof do
	begin
		c:=0;s:=0;f:=0;
		readln(n);
		readln(ss);
		for i:=1 to length(ss) do
		case ss[i] of
		'C':inc(c);
		'F':inc(f);
		'S':inc(s);
		end;
		if c*s*f<>0 then
		begin
			writeln(n);
			continue;
		end;
		if (c=0)and(s*f<>0) then
		begin
			writeln(s);
			continue;
		end;
		if (s=0)and(c*f<>0) then
		begin
			writeln(f);
			continue;
		end;
		if (f=0)and(s*c<>0) then
		begin
			writeln(c);
			continue;
		end;
		if (c*s*f=0) then
			writeln(n);
	end;
end.