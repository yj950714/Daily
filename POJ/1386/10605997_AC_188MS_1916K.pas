program poj1386(input,output);
var
	first:array[0..30] of longint;
	next,goal:array[0..200000] of longint;
	v:array[0..1005] of boolean;
	rudo,chudo:array[0..30] of longint;
	n,answer,tot,cases:longint;
procedure dfs(x:longint);
var
	t:longint;
begin
	inc(answer);
	t:=first[x];
	v[x]:=true;
	while t<>-1 do
	begin
		if not v[goal[t]] then
			dfs(goal[t]);
		t:=next[t];
	end;
end;{ dfs }
procedure add(xx,yy:longint);
begin
	inc(tot);
	goal[tot]:=yy;
	next[tot]:=first[xx];
	first[xx]:=tot;
end;{ add }
procedure init;
var
	i:longint;
	s:ansistring;
begin
	readln(n);
	for i:=1 to 26 do
	begin
		rudo[i]:=0;
		chudo[i]:=0;
		v[i]:=false;
		first[i]:=-1;
	end;
	tot:=0;
	for i:=1 to n do
	begin
		readln(s);
		add(ord(s[1])-ord('a')+1,ord(s[length(s)])-ord('a')+1);
		inc(rudo[ord(s[length(s)])-ord('a')+1]);
		inc(chudo[ord(s[1])-ord('a')+1]);
	end;
end;{ init }
procedure main;
var
	head,tail:longint;
	i,s1,s2,s3,num:longint;
begin
	num:=0;s1:=0;s2:=0;s3:=0;
	for i:=1 to 26 do
		if (rudo[i]+chudo[i]<>0) then
		begin
			inc(num);
			if (rudo[i]+1=chudo[i]) then
			begin
				inc(s1);
				head:=i;
			end
			else
				if (rudo[i]=chudo[i]) then
					inc(s2)
				else
					if chudo[i]+1=rudo[i] then
						inc(s3);
			tail:=i;
		end;
	answer:=0;
	if (s1<>0) then 
		dfs(head)
	else
		dfs(tail);
	if num=answer then
	begin
		if ((s1=1)and(s3=1)and(s2=num-2))or(s2=num) then
			writeln('Ordering is possible.')
		else
			writeln('The door cannot be opened.')
	end
	else
		writeln('The door cannot be opened.');
end;{ main }
begin
	readln(cases);
	while cases>0 do
	begin
		dec(cases);
		init;
		main;
	end;
end.