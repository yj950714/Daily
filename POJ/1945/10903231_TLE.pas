program usaco_power(input,output);
const
	maxpower= 20000;
type
	nodes=record
		x,y:longint;
	end;
	size_balance_tree=object
		root,tot:longint;
		s,left,right:array[0..1000000] of longint;
		key:array[0..1000000] of nodes;
		procedure clean;
		procedure left_rotate(var t:longint);
		procedure right_rotate(var t:longint);
		procedure maintain(var t:longint;flag:boolean);
		procedure insert(var t:longint;xx:nodes);
		function find(t:longint;xx:nodes):boolean;
	end;
	node=record
		x,y,w,step:longint;
	end;
	Theap=object
		tot:longint;
		list:array[0..500000] of node;
		procedure clean;
		procedure swap(var aa,bb:longint);
		procedure up(now:longint);
		procedure down(now:longint);
		procedure insert(now:node);
		function delete():node;
	end;
procedure size_balance_tree.clean();
begin
	root:=0;
	tot:=0;
	fillchar(left,sizeof(left),0);
	fillchar(right,sizeof(right),0);
	fillchar(s,sizeof(s),0);
	fillchar(key,sizeof(key),0);
end;
procedure size_balance_tree.left_rotate(var t:longint);
var
	k:longint;
begin
	k:=right[t];
	right[t]:=left[k];
	left[k]:=t;
	s[k]:=s[t];
	s[t]:=s[left[t]]+s[right[t]]+1;
	t:=k;
end;
procedure size_balance_tree.right_rotate(var t:longint);
var
	k:longint;
begin
	k:=left[t];
	left[t]:=right[k];
	right[k]:=t;
	s[k]:=s[t];
	s[t]:=s[left[t]]+s[right[t]]+1;
	t:=k;
end;
procedure size_balance_tree.maintain(var t:longint;flag:boolean);
begin
	if not flag then
	begin
		if s[left[left[t]]]>s[right[t]] then
			size_balance_tree.right_rotate(t)
		else
			if s[right[left[t]]]>s[right[t]] then
			begin
				size_balance_tree.left_rotate(left[t]);
				size_balance_tree.right_rotate(t);
			end
			else
				exit;
	end
	else
	begin
		if s[right[right[t]]]>s[left[t]] then
			size_balance_tree.left_rotate(t)
		else
			if s[left[right[t]]]>s[left[t]] then
			begin
				size_balance_tree.right_rotate(right[t]);
				size_balance_tree.left_rotate(t);
			end
			else
				exit;
	end;
	size_balance_tree.maintain(left[t],false);
	size_balance_tree.maintain(right[t],true);
	size_balance_tree.maintain(t,false);
	size_balance_tree.maintain(t,true);
end;
procedure size_balance_tree.insert(var t:longint;xx:nodes);
begin
	if t=0 then
	begin
		inc(tot);
		t:=tot;
		left[t]:=0;
		right[t]:=0;
		s[t]:=1;
		key[t]:=xx;
	end
	else
	begin
		inc(s[t]);
		if (xx.x*maxpower+xx.y)<(key[t].x*maxpower+key[t].y) then
			size_balance_tree.insert(left[t],xx)
		else
			size_balance_tree.insert(right[t],xx);
		size_balance_tree.maintain(t,xx.x*maxpower+xx.y>=key[t].x*maxpower+key[t].y);
	end;
end;
function size_balance_tree.find(t:longint;xx:nodes):boolean;
begin
	if t=0 then
		exit(false);
	if (key[t].x=xx.x)and(key[t].y=xx.y) then
		exit(true);
	if (xx.x*maxpower+xx.y)<(key[t].x*maxpower+key[t].y) then
		exit(size_balance_tree.find(left[t],xx))
	else
		exit(size_balance_tree.find(right[t],xx));
end;


procedure Theap.clean();
begin
	fillchar(list,sizeof(list),0);
	tot:=0;
end;
procedure Theap.swap(var aa,bb:longint);
var
	tt:longint;
begin
	tt:=aa;
	aa:=bb;
	bb:=tt;
end;
procedure Theap.up(now:longint);
begin
	while (now>1)and(list[now].w<list[now>>1].w) do
	begin
		Theap.swap(list[now].x,list[now>>1].x);
		Theap.swap(list[now].y,list[now>>1].y);
		Theap.swap(list[now].w,list[now>>1].w);
		Theap.swap(list[now].step,list[now>>1].step);
		now:=now>>1;
	end;
end;
procedure Theap.down(now:longint);
var
	tmp:longint;
begin
	while (now*2<=tot) do
	begin
		tmp:=now*2;
		if (tmp+1<=tot)and(list[tmp+1].w<list[tmp].w) then
			inc(tmp);
		if list[tmp].w<list[now].w then
		begin
			Theap.swap(list[now].x,list[tmp].x);
			Theap.swap(list[now].y,list[tmp].y);
			Theap.swap(list[now].w,list[tmp].w);
			Theap.swap(list[now].step,list[tmp].step);
			now:=tmp;
		end
		else
			break;
	end;
end;
procedure Theap.insert(now:node);
begin
	inc(tot);
	list[tot]:=now;
	Theap.up(tot);
end;
function Theap.delete():node;
begin
	delete:=list[1];
	Theap.swap(list[1].x,list[tot].x);
	Theap.swap(list[1].y,list[tot].y);
	Theap.swap(list[1].w,list[tot].w);
	Theap.swap(list[1].step,list[tot].step);	
	dec(tot);
	Theap.down(1);
end;

var
	tree:size_balance_tree;
	heap:Theap;
	goal,answer:longint;
function gcd(a,b:longint):longint;
begin
	if b=0 then
		exit(a);
	exit(gcd(b,a mod b));
end;{ gcd }
function f(now:node):longint;
var
	tmp:longint;
begin
	f:=0;
	tmp:=now.y;
	if tmp=0 then
		exit(maxlongint);
	while tmp<goal do
	begin
		tmp:=tmp+tmp;
		inc(f);
	end;
	f:=f+now.step<<1;
end;{ f }
procedure swap(var aa,bb:longint);
var
	tt:longint;
begin
	tt:=aa;
	aa:=bb;
	bb:=tt;
end;{ swap }
procedure init;
var
	now:node;
	new:nodes;
begin
	readln(goal);
	tree.clean();
	heap.clean();
	now.x:=0;
	now.y:=1;
	now.step:=0;
	now.w:=f(now);
	new.x:=0;
	new.y:=1;
	tree.insert(tree.root,new);
	heap.insert(now);
end;{ init }
function operand(now:node;flag:longint):node;
begin
	case flag of
		1:begin
			operand.x:=now.x;
			operand.y:=now.x+now.y;
			operand.step:=now.step+1;
		end;
		2:begin
			operand.x:=now.x+now.y;
			operand.y:=now.y;
			operand.step:=now.step+1;
		end;
		3:begin
			operand.x:=now.y-now.x;
			operand.y:=now.y;
			operand.step:=now.step+1;
		end;
		4:begin
			operand.x:=now.x;
			operand.y:=now.y-now.x;
			operand.step:=now.step+1;
		end;
		5:begin
			operand.x:=now.x+now.x;
			operand.y:=now.y;
			operand.step:=now.step+1;
		end;
		6:begin
			operand.x:=now.x;
			operand.y:=now.x+now.x;
			operand.step:=now.step+1;
		end;
		7:begin
			operand.x:=now.y+now.y;
			operand.y:=now.y;
			operand.step:=now.step+1;
		end;
		8:begin
			operand.x:=now.x;
			operand.y:=now.y+now.y;
			operand.step:=now.step+1;
		end;
	end;
	if operand.y<operand.x then
		swap(operand.x,operand.y);
end;{ operand }
procedure expand(now:node);
var
	newstate:node;
	pd:nodes;
	i:longint;
begin
	for i:=1 to 8 do
	begin
		newstate:=operand(now,i);
		if not ((newstate.x<=100)and(newstate.y<=50000)) then
			continue;
		if newstate.y=0 then
			continue;
		if (goal mod gcd(newstate.x,newstate.y))<>0 then
			continue;
		newstate.w:=f(newstate);
		pd.x:=newstate.x;
		pd.y:=newstate.y;
		if tree.find(tree.root,pd) then
			continue;
		tree.insert(tree.root,pd);
		heap.insert(newstate);
	end;
end;{ expand }
procedure A_star;
var
	state:node;
begin
	while heap.tot<>0 do
	begin
		state:=heap.delete();
		if (state.x=goal)or(state.y=goal) then
		begin
			answer:=state.step;
			exit;
		end;
		expand(state);
	end;
end;{ A_star }
procedure print;
begin
	writeln(answer);
end;{ print }
begin
	init;
	A_star;
	print;
end.