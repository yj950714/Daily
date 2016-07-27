program pku3481(input,output);
var
	left,right,key,s,th:array[0..200000] of longint;
	tot,root:longint;
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
	maintain(t,false);
	maintain(t,true);
end;{ maintain }
procedure insert(var now,k,u:longint);
begin
	if now=0 then
	begin
		inc(tot);
		now:=tot;
		s[now]:=1;
		left[now]:=0;
		right[now]:=0;
		key[now]:=k;
		th[now]:=u;
	end
	else
	begin
		inc(s[now]);
		if k<key[now] then
			insert(left[now],k,u)
		else
			insert(right[now],k,u);
		maintain(now,k>=key[now]);
	end;
end;{ insert }
function delete(var t:longint;k:longint):longint;
begin
	dec(s[t]);
	if (k=key[t])or((k<key[t])and(left[t]=0))or((k>key[t])and(right[t]=0)) then
	begin
		delete:=key[t];
		if left[t]*right[t]=0 then
			t:=left[t]+right[t]
		else
			key[t]:=delete(left[t],k+1);
	end
	else
		if k<key[t] then
			delete:=delete(left[t],k)
		else
			delete:=delete(right[t],k);
end;{ delete }
function get_max_number(t:longint):longint;
begin
	if t=0 then
		exit(19950714);
	get_max_number:=get_max_number(right[t]);
	if get_max_number=19950714 then
		get_max_number:=t;
end;{ get_max_number }
function get_min_number(t:longint):longint;
begin
	if t=0 then
		exit(19950714);
	get_min_number:=get_min_number(left[t]);
	if get_min_number=19950714 then
		get_min_number:=t;
end;{ get_min_number }
procedure main;
var
	x,y,z:longint;
begin
	root:=0;
	tot:=0;
	read(x);
	while x<>0 do
	begin
		if x=1 then
		begin
			readln(y,z);
			insert(root,z,y);
		end;
		if x=2 then
			if s[root]=0 then
				writeln(0)
			else
			begin
				y:=get_max_number(root);
				writeln(th[y]);
				delete(root,key[y]);
			end;
		if x=3 then
			if s[root]=0 then
				writeln(0)
			else
			begin
				y:=get_min_number(root);
				writeln(th[y]);
				delete(root,key[y]);
			end;
		read(x);
	end;
end;{ main }
begin
	main;
end.
				