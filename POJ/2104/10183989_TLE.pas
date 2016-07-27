program zoj2112(input,output);
type
	node=record
		left,right,x,y,root:longint;
	end;
var
	tree			:array[0..250000] of node;
	left,right,key,s:array[0..3000000] of longint;
	n,q				:longint;
	cases			:longint;
	tot,nodes		:longint;
	max,min			:longint;
	a				:array[0..110000] of longint;
procedure left_rotate(var t:longint);
var
	k:longint;
begin
	k:=right[t];
	right[t]:=left[k];
	left[k]:=t;
	s[k]:=s[t];
	s[t]:=s[left[t]]+s[right[t]]+1;
	t:=k;
end;{ left_rotate }
procedure right_rotate(var t:longint);
var
	k:longint;
begin
	k:=left[t];
	left[t]:=right[k];
	right[k]:=t;
	s[k]:=s[t];
	s[t]:=s[left[t]]+s[right[t]]+1;
	t:=k;
end;{ right_rotate }
procedure maintain(var t:longint;flag:boolean);
begin
	if not flag then
	begin
		if s[left[left[t]]]>s[right[t]] then
			right_rotate(t)
		else
			if s[right[left[t]]]>s[right[t]] then
			begin
				left_rotate(left[t]);
				right_rotate(t);
			end
			else
				exit;
	end
	else
	begin
		if s[right[right[t]]]>s[left[t]] then
			left_rotate(t)
		else
			if s[left[right[t]]]>s[left[t]] then
			begin
				right_rotate(right[t]);
				left_rotate(t);
			end
			else
				exit;
	end;
	maintain(left[t],false);
	maintain(right[t],true);
	maintain(t,true);
	maintain(t,false);
end;{ maintain }
procedure insert(var t:longint;k:longint);
begin
	if t=0 then
	begin
		inc(tot);
		t:=tot;
		s[t]:=1;
		left[t]:=0;
		right[t]:=0;
		key[t]:=k;
	end
	else
	begin
		inc(s[t]);
		if k<key[t] then
			insert(left[t],k)
		else
			insert(right[t],k);
		maintain(t,k>=key[t]);
	end;
end;{ insert }
function delete(var t:longint;k:longint):longint;
begin
	dec(s[t]);
	if (key[t]=k)or((k>key[t])and(right[t]=0))or((k<key[t])and(left[t]=0)) then
	begin
		delete:=key[t];
		if left[t]*right[t]=0 then
			t:=left[t]+right[t]
		else
			key[t]:=delete(left[t],k+1);
	end
	else
		if k>=key[t] then
			delete:=delete(right[t],k)
		else
			delete:=delete(left[t],k);
end;{ delete }
function rank(t,k:longint):longint;
begin
	if t=0 then
		exit(1);
	if k<=key[t] then
		exit(rank(left[t],k))
	else
		exit(s[left[t]]+1+rank(right[t],k));
end;{ rank }
procedure build(xx,yy:longint);
var
	now,mid,i:longint;
begin
	inc(nodes);
	tree[nodes].x:=xx;
	tree[nodes].y:=yy;
	tree[nodes].root:=0;
	now:=nodes;
	for i:=xx to yy do
		insert(tree[nodes].root,a[i]);
	if xx=yy then
		exit;
	mid:=(xx+yy)>>1;
	tree[now].left:=nodes+1;
	build(xx,mid);
	tree[now].right:=nodes+1;
	build(mid+1,yy);
end;{ build }
function getsum(now,xx,yy,ww:longint):longint;
var
	mid:longint;
begin
	if (tree[now].x=xx)and(tree[now].y=yy) then
		exit(rank(tree[now].root,ww)-1);
	mid:=(tree[now].x+tree[now].y)>>1;
	if yy<=mid then
		exit(getsum(tree[now].left,xx,yy,ww))
	else
		if xx>mid then
			exit(getsum(tree[now].right,xx,yy,ww))
		else
			exit(getsum(tree[now].left,xx,mid,ww)+getsum(tree[now].right,mid+1,yy,ww));
end;{ getsum }
procedure change(now,pos,xx,yy:longint);
var
	mid:longint;
begin
	if (tree[now].x=tree[now].y) then
	begin
		key[tree[now].root]:=yy;
		exit;
	end;
	delete(tree[now].root,xx);
	insert(tree[now].root,yy);
	mid:=(tree[now].x+tree[now].y)>>1;
	if pos<=mid then
		change(tree[now].left,pos,xx,yy)
	else
		change(tree[now].right,pos,xx,yy);
end;{ change }
function calc(xx,yy,kk:longint):longint;
var
	l,r,mid:longint;
begin
	l:=min-1;
	r:=max+1;
	while l+1<r do
	begin
		mid:=(l+r)>>1;
		if getsum(1,xx,yy,mid)>kk-1 then
			r:=mid
		else
			l:=mid;
	end;
	exit(l);
end;{ calc }
procedure init;
var
	i:longint;
begin
	fillchar(tree,sizeof(tree),0);
	fillchar(s,sizeof(s),0);
	fillchar(key,sizeof(key),0);
	readln(n,q);
	max:=0;
	min:=maxlongint;
	for i:=1 to n do
	begin
		read(a[i]);
		if a[i]>max then
			max:=a[i];
		if a[i]<min then
			min:=a[i];
	end;
	readln;
	tot:=0;
	nodes:=0;
end;{ init }
procedure main;
var
	i,xx,yy,kk:longint;
	ch:char;
begin
	for i:=1 to q do
	begin
			readln(xx,yy,kk);
			if (kk<=(yy-xx+1))and(kk>0) then
				writeln(calc(xx,yy,kk));
	end;
end;{ main }
begin
		init;
		build(1,n);
                main;
end.