program pku2232(input,output);
var
	a:array[0..105] of char;
	n,i	:longint;
	c,s,f:longint;
begin
	while not eof do
	begin
		c:=0;s:=0;f:=0;
		readln(n);
		for i:=1 to n-1 do
		begin
			read(a[i]);
			read(a[i+1]);
			case a[i] of 
			'C':inc(c);
			'F':inc(f);
			'S':inc(s);
			end;
		end;
		read(a[n]);
		case a[n] of 
		'C':inc(c);
		'S':inc(s);
		'F':inc(f);
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
		if (s=0)and(c*f=0) then
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
			writeln(c+s+f);
	end;
end.