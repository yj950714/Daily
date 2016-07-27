program pku1674(input,output);
var
	number :array[0..11000] of integer;
	v	   :array[0..11000] of boolean;
	n,cases:longint;
	answer :longint;
procedure init;
var
	i:longint;
begin
	readln(n);
	for i:=1 to n do
		read(number[i]);
	fillchar(v,sizeof(v),false);
end;{ init }
procedure main;
var
	now,i:longint;
begin
	answer:=0;
	for i:=1 to n do
	if not v[i] then
	begin
		inc(answer);
		v[i]:=true;
		now:=number[i];
		while not v[now] do
		begin
			v[now]:=true;
			now:=number[now];
		end;
	end;
end;{ main }
procedure print;
begin
	writeln(n-answer);
end;{ print }
begin
	readln(cases);
	while cases>0 do
	begin
		dec(cases);
		init;
		main;
		print;
	end;
end.