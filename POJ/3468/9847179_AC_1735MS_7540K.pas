program tree_line(input,output);
	type
	   node = record
	         sum,mark       : int64;
	         left,right,x,y : longint;
	      end;         
	var
	   tree      : array[0..1000000] of node;
	   n,m,tot   : longint;
	   the_x,the_y,h : longint;
	   answer    : int64;
	   a         : array[0..100001] of longint;
	function min(aa,bb: longint ):longint;
	begin
	   if aa<bb then
	      exit(aa);
	   exit(bb);
	end; { min }
	function max(aa,bb :longint ):longint;
	begin
	   if aa>bb then
	      exit(aa);
	   exit(bb);
	end; { max }
	procedure build(xx,yy: longint );
	var
	   now,mid : longint;
	begin
	   inc(tot);
	   now:=tot;
	   tree[now].x:=xx;
	   tree[now].y:=yy;
	   tree[now].mark:=0;
	   tree[now].sum:=0;
	   if xx=yy then
	   begin
	      tree[now].sum:=a[xx];
	      exit;
	   end;
	   mid:=(xx+yy)>>1;
	   tree[now].left:=tot+1;
	   build(xx,mid);
	   tree[now].right:=tot+1;
	   build(mid+1,yy);
	   tree[now].sum:=tree[tree[now].left].sum+tree[tree[now].right].sum;
	end; { build }
	procedure change(now :longint );
	var
	   mid : longint;
	begin
	   inc(tree[now].sum,h*(min(tree[now].y,the_y)-max(the_x,tree[now].x)+1));
	   if (tree[now].x>=the_x)and(tree[now].y<=the_y) then
	   begin
	      inc(tree[now].mark,h);
	      exit;
	   end;
	   mid:=(tree[now].x+tree[now].y)>>1;
	   if the_x<=mid then
	      change(tree[now].left);
	   if mid<the_y then
	      change(tree[now].right);
	end; { change }
	procedure find(now :longint );
	var
	   mid : longint;
	begin
	   if (tree[now].x>=the_x)and(the_y>=tree[now].y) then
	   begin
	      inc(answer,tree[now].sum);
	      exit;
	   end;
	   inc(tree[tree[now].left].mark,tree[now].mark);
	   inc(tree[tree[now].right].mark,tree[now].mark);
	   inc(tree[tree[now].left].sum,tree[now].mark*(tree[tree[now].left].y-tree[tree[now].left].x+1));
	   inc(tree[tree[now].right].sum,tree[now].mark*(tree[tree[now].right].y-tree[tree[now].right].x+1));
	   tree[now].mark:=0;
	   mid:=(tree[now].x+tree[now].y)>>1;
	   if the_y>mid then
	      find(tree[now].right);
	   if the_x<=mid then
	      find(tree[now].left);
	end; { find }
	procedure main;
	var
	   i  : longint;
	   ch : char;
	begin
	   readln(n,m);
	   for i:=1 to n do
	      read(a[i]);
	   readln;
	   build(1,n);
	   for i:=1 to m do
	   begin
	      read(ch);
	      if ch='C' then
	      begin
	     readln(the_x,the_y,h);
	     change(1);
	      end;
	      if ch='Q' then
	      begin
	     readln(the_x,the_y);
	     answer:=0;
	     find(1);
	     writeln(answer);
	      end;
	   end;
	end; { main }
	begin
	   main;
	end.