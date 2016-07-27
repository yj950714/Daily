program gift(input,output);
type
	node=^link;
	link=record
		goal,w:longint;
		next:node;
	end;
var
	l:array[0..200] of node;
	rank:array[0..200] of longint;
	d:array[0..200] of longint;
	v:array[0..200] of boolean;
	q:array[0..500000] of longint;
	n,limit,answer:longint;
procedure add(xx,yy,ww:longint);
var
	t:node;
begin
	new(t);
	t^.goal:=yy;
	t^.w:=ww;
	t^.next:=l[xx];
	l[xx]:=t;
end;{ add }
procedure init;
var
	i,j,xxx,www,s:longint;
begin
	readln(limit,n);
	for i:=1 to n do
	begin
		readln(www,rank[i],s);
		add(0,i,www);
		for j:=1 to s do
		begin
			readln(xxx,www);
			add(xxx,i,www);
		end;
	end;
end;{ init }
function maxx(aa,bb:longint):longint;
begin
	if aa>bb then
		exit(aa);
	exit(bb);
end;{ maxx }
procedure spfa(min,max:longint);
var
	head,tail:longint;
	t:node;
begin
	fillchar(d,sizeof(d),63);
	fillchar(v,sizeof(v),false);
	head:=0;
	tail:=1;
	q[1]:=0;
	v[0]:=true;
	d[0]:=0;
	while head<tail do
	begin
		inc(head);
		v[q[head]]:=false;
		t:=l[q[head]];
		while t<>nil do
		begin
			if (min<=rank[t^.goal])and(rank[t^.goal]<=max) then
			begin
				if d[q[head]]+t^.w<d[t^.goal] then
				begin
					d[t^.goal]:=d[q[head]]+t^.w;
					if not v[t^.goal] then
					begin
						inc(tail);
						q[tail]:=t^.goal;
						v[t^.goal]:=true;
					end;
				end;
			end;
			t:=t^.next;
		end;
	end;
end;{ spfa }
procedure main;
var
	i:longint;
begin
	answer:=maxlongint>>2;
	for i:=maxx(0,rank[1]-limit) to rank[1] do
	begin
		spfa(i,i+limit);
		if d[1]<answer then
			answer:=d[1];
	end;
end;{ main }
procedure print;
begin
	writeln(answer);
end;{ print }
begin

	init;
	main;
	print;

end.