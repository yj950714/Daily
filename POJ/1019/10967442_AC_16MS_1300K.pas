program poj1019(input,output);
var
	f:array[0..50000] of int64;
	cases:longint;
	n:int64;
procedure main;
var
	s:ansistring;
	i:longint;
begin
	f[1]:=1;
	for i:=2 to 50000 do
	begin
		str(i,s);
		f[i]:=f[i-1]+length(s);
	end;
end;{ main }
procedure init;
begin
	readln(n);
end;{ init }
procedure print;
var
	i:longint;
	s:ansistring;
begin
	for i:=1 to 50000 do
		if n-f[i]>0 then
			n:=n-f[i]
		else
			break;
	for i:=1 to i do
	begin
		str(i,s);
		if n>length(s) then
			n:=n-length(s)
		else
		begin
			writeln(s[n]);
			exit;
		end;
	end;
end;{ print }
begin
	main;
	readln(cases);
	while cases>0 do
	begin
		init;
		print;
		dec(cases);
	end;
end.