program pku2136(input,output);
var
	map   :array[0..73,'A'..'Z'] of boolean;
	number:array['A'..'Z'] of integer;
	max:longint;
procedure init;
var
	s:ansistring;
	i,j:longint;
begin
	fillchar(map,sizeof(map),false);
	fillchar(number,sizeof(number),0);
	for i:=1 to 4 do
	begin
		readln(s);
		for j:=1 to length(s) do
		if (s[j] in ['A'..'Z']) then	
			inc(number[s[j]]);
	end;
end;{ init }
procedure main();
var
	ch:char;
	i:longint;
begin
	max:=0;
	for ch:='A' to 'Z' do
	if number[ch]>max then
		max:=number[ch];
	for ch:='A' to 'Z' do
		for i:=max downto max-number[ch]+1 do
			map[i,ch]:=true;
	for i:=1 to max do
		for ch:='A' to 'Z' do
		begin	
			if (map[i,ch]) then
				write('*')
			else
				write(' ');
			if ch<>'Z' then
				write(' ');
			if ch='Z' then
				writeln;
		end;
	for ch:='A' to 'Z' do
	begin
		write(ch);
		if ch<>'Z' then
			write(' ')
		else
			writeln;
	end;
end;{ main }
begin
	init;
	main;
end.