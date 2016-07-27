program pku3225(input,output);
const
	oo=140000;
type
	node=record
		left,right,x,y:longint;
		xm,cm:integer;
	end;
	node2=record
		x,y:longint;
	end;
var
	tree  		   :array[0..300000] of node;
	tot   		   :longint;
	fx,fy 	       :longint;
	number1,number2:longint;
	answer1,answer2:array[0..200000] of node2;
procedure build(xx,yy:longint);
var
	now,mid:longint;
begin
	inc(tot);
	tree[tot].x:=xx;
	tree[tot].y:=yy;
	tree[tot].xm:=0;
	tree[tot].cm:=0;
	now:=tot;
	if xx=yy then
		exit;
	mid:=(xx+yy)>>1;
	tree[now].left:=tot+1;
	build(xx,mid);
	tree[now].right:=tot+1;
	build(mid+1,yy);
end; { build }
procedure down(now:longint);
begin
	if (tree[now].cm=2)and(tree[now].xm=1) then
	begin
		if tree[now].left<>0 then
		begin
			if tree[tree[now].left].cm=2 then
				tree[tree[now].left].xm:=1-tree[tree[now].left].xm
			else
				tree[tree[now].left].cm:=1-tree[tree[now].left].cm;
		end;
		if tree[now].right<>0 then
		begin
			if tree[tree[now].right].cm=2 then
				tree[tree[now].right].xm:=1-tree[tree[now].right].xm
			else
				tree[tree[now].right].cm:=1-tree[tree[now].right].cm;
		end;
		tree[now].xm:=0;
	end
	else
	begin
		if (tree[now].cm=1)or(tree[now].cm=0) then
		begin
			if tree[now].left<>0 then
			begin
				tree[tree[now].left].cm:=tree[now].cm;
				tree[tree[now].left].xm:=0;
			end;
			if tree[now].right<>0 then
			begin
				tree[tree[now].right].cm:=tree[now].cm;
				tree[tree[now].right].xm:=0;
			end;
		end;
	end;
end; { down }
procedure insert(now,color:longint);
var
	mid:longint;
begin
	if (tree[now].x>=fx)and(tree[now].y<=fy) then
	begin
		tree[now].xm:=0;
		tree[now].cm:=color;
		exit;
	end;
	down(now);
	mid:=(tree[now].x+tree[now].y)>>1;
	if fx<=mid then
		insert(tree[now].left,color);
	if fy>mid then
		insert(tree[now].right,color);
	if tree[tree[now].left].cm<>tree[tree[now].right].cm then
		tree[now].cm:=2
	else
		tree[now].cm:=tree[tree[now].left].cm;
end; { insect }
procedure change(now:longint);
var
	mid:longint;
begin
	if (fx<=tree[now].x)and(tree[now].y<=fy) then
	begin
		if tree[now].cm<>2 then
			tree[now].cm:=1-tree[now].cm
		else
			tree[now].xm:=1-tree[now].xm;
		exit;
	end;
	down(now);
	mid:=(tree[now].x+tree[now].y)>>1;
	if fx<=mid then
		change(tree[now].left);
	if fy>mid then
		change(tree[now].right);
	if tree[tree[now].left].cm<>tree[tree[now].right].cm then
		tree[now].cm:=2
	else
		tree[now].cm:=tree[tree[now].left].cm;
end;{ change }
function make(s:ansistring):node2;
var
	ch1,ch2:char;
begin
	while pos(' ',s)>0 do
	 delete(s,pos(' ',s),1);
	ch1:=s[1];
	ch2:=s[length(s)];
	delete(s,1,1);
	delete(s,length(s),1);
	val(copy(s,1,pos(',',s)-1),make.x);
	delete(s,1,pos(',',s));
	val(s,make.y);
	make.x:=make.x*2;
	make.y:=make.y*2;
	if ch1='(' then
		inc(make.x);
	if ch2=')' then
		dec(make.y);
end;{ make }
procedure solve();
var
	state:node2;
	ch   :char;
	sx   :ansistring;
begin
	tot:=0;
	number1:=0;
	number2:=0;
	fillchar(tree,sizeof(tree),0);
	build(0,oo);
	while not eof do
	begin
		read(ch);
		readln(sx);
		state:=make(sx);
		if (state.x>state.y) then
		begin
			if (ch='I')or(ch='C') then
			begin
				fx:=0;
				fy:=oo;
				insert(1,0);
			end
			else
				continue;
		end;
		fx:=state.x;
		fy:=state.y;
		case ch of 
		  'U':insert(1,1);
		  'I':begin
				fx:=0;
				fy:=state.x-1;
				if fx<=fy then
					insert(1,0);
				fx:=state.y+1;
				fy:=oo;
				if fx<=fy then
					insert(1,0);
			end;
		  'D':insert(1,0);
		  'C':begin
				fx:=0;
				fy:=state.x-1;
				if fx<=fy then
					insert(1,0);
				fx:=state.y+1;
				fy:=oo;
				if fx<=fy then
					insert(1,0);
				fx:=state.x;
				fy:=state.y;
				change(1);
			end;
		  'S':change(1);
		end;
	end;
end; { solve }
procedure calc(now:longint);
begin
	if now=0 then
		exit;
	if tree[now].cm=1 then
	begin
		inc(number1);
		answer1[number1].x:=tree[now].x;
		answer1[number1].y:=tree[now].y;
		exit;
	end;
	down(now);
	calc(tree[now].left);
	calc(tree[now].right);
end;{ calc }
procedure merge();
var
	i:longint;
begin
	number2:=1;
	answer2[1].x:=answer1[1].x;
	answer2[1].y:=answer1[1].y;
	for i:=1 to number1-1 do
		if (answer1[i+1].y>answer2[number2].y)and(answer1[i+1].x<=answer2[number2].y+1) then
			answer2[number2].y:=answer1[i+1].y
		else
			if answer1[i+1].x>answer2[number2].y+1 then
			begin
				inc(number2);
				answer2[number2].x:=answer1[i+1].x;
				answer2[number2].y:=answer1[i+1].y;
			end;
end;{ merge }
procedure print;
var
	i:longint;
begin
	for i:=1 to number2 do
	begin
		if odd(answer2[i].x) then
			write('(')
		else
			write('[');
		write(answer2[i].x>>1);
		write(',');
		write((answer2[i].y+1)>>1);
		if odd(answer2[i].y) then
			write(')')
		else
			write(']');
		if i<>number2 then
			write(' ');
	end;
end;{ print }
begin
	assign(input,'interval.in');reset(input);
	assign(output,'interval.out');rewrite(output);
	solve();
	calc(1);
	if number1=0 then
		writeln('empty set')
	else
	begin
		merge();
		print();
	end;
	close(input);
	close(output);
end.