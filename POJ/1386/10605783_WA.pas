program pku1386(input,output);
var
	first:array[0..27] of longint;
	have:array[0..27] of boolean;
	next,goal:array[0..110000] of longint;
	v:array[0..27] of boolean;
	tot:longint;
	rudo,chudo:array[0..27] of longint;
	n,cases:longint;
	flag:boolean;
procedure add(xx,yy:longint);
begin
	inc(tot);
	goal[tot]:=yy;
	next[tot]:=first[xx];
	first[xx]:=tot;
end;{ add }
procedure init;
var
	s:ansistring;
	i:longint;
begin
	fillchar(have,sizeof(have),false);
	fillchar(v,sizeof(v),false);
	fillchar(rudo,sizeof(rudo),0);
	fillchar(chudo,sizeof(chudo),0);
	readln(n);
	tot:=0;
	flag:=true;
	for i:=1 to 26 do
		first[i]:=-1;
	for i:=1 to n do
	begin
		readln(s);
		have[ord(s[1])-ord('a')+1]:=true;
		have[ord(s[length(s)])-ord('a')+1]:=true;
		add(ord(s[1])-ord('a')+1,ord(s[length(s)])-ord('a')+1);
		inc(chudo[ord(s[1])-ord('a')+1]);
		inc(rudo[ord(s[length(s)])-ord('a')+1]);
	end;
end;{ init }
procedure floodfill(now:longint);
var
	t:longint;
begin
	v[now]:=true;
	t:=first[now];
	while t<>-1 do
	begin
		if not v[goal[t]] then
			floodfill(goal[t]);
		t:=next[t];
	end;
end;{ floodfill }
procedure main;
var
	i,s1,s2:longint;
begin
	floodfill(1);
	for i:=1 to 26 do
		if (have[i])and(not v[i]) then
		begin
			flag:=false;
			exit;
		end;
	s1:=0;
	s2:=0;
	for i:=1 to 26 do
		if have[i] then
		begin
			if rudo[i]-chudo[i]=1 then
				inc(s1)
			else
				if chudo[i]-rudo[i]=1 then
					inc(s2)
				else
					if abs(chudo[i]-rudo[i])>1 then
						flag:=false;
		end;
	if (s1<>0)or(s2<>0) then
		if (s1<>1)or(s2<>1) then
			flag:=false;
end;{ main }
procedure print;
begin
	if flag then
		writeln('Ordering is possible.')
	else
		writeln('The door cannot be opened.');
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