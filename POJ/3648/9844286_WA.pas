program pku3648(input,output);
type
   link	 = ^node;
   node	 = record
	      goal : longint;
	      next : link;
	   end;	   
   node2 = record
	      x,y : longint;
	   end;
var
   last		       : array[0..200] of char;
   l,newmap	       : array[0..200] of link;
   q		       : array[0..300] of longint;
   rudo		       : array[0..200] of longint;
   fight	       : array[0..300] of longint;
   color,stack,dfn,low : array[0..200] of longint;
   answer	       : array[0..200] of longint;
   instack	       : array[0..200] of boolean;
   ask		       : array[0..10000] of node2;
   n,m,top,cnt,colour  : longint;
procedure add(xx,yy    : longint );
var
   t : link;
begin
   new(t);
   t^.next:=l[xx];
   t^.goal:=yy;
   l[xx]:=t;
end; { add }
procedure clean();
var
   i : longint;
   t : link;
begin
   for i:=1 to 300 do
      answer[i]:=-1;
   for i:=1 to 200 do
   begin
      t:=l[i];
      while t<>nil do
      begin
	 l[i]:=t^.next;
	 dispose(t);
	 t:=l[i];
      end;
      l[i]:=nil;
   end;
   for i:=1 to 200 do
   begin
      t:=newmap[i];
      while t<>nil do
      begin
	 newmap[i]:=t^.next;
	 dispose(t);
	 t:=newmap[i];
      end;
      newmap[i]:=nil;
   end;
   for i:=1 to 300 do
      answer[i]:=-1;
   fillchar(dfn,sizeof(dfn),0);
   fillchar(low,sizeof(low),0);
   fillchar(rudo,sizeof(rudo),0);
   fillchar(stack,sizeof(stack),0);
   fillchar(color,sizeof(color),0);
   colour:=0;
   top:=0;
   cnt:=0;
end; { clean }
function make(s :ansistring ):node2;
var
   tmp,i : longint;
   ch	 : char;
   ss	 : ansistring;
begin
   make.x:=0;
   make.y:=0;
   i:=1;
   ss:='';
   while (s[i] in ['0'..'9']) do
   begin
      ss:=ss+s[i];
      inc(i);
   end;
   val(ss,make.x);
   if s[i]='w' then
      inc(make.x,n);
   delete(s,1,i);
   while s[1]=' ' do
      delete(s,1,1);
   ss:=copy(s,1,length(s)-1);
   delete(s,1,length(s)-1);
   val(ss,make.y);
   if s='w' then
      inc(make.y,n);
   {tmp:=pos(' ',s);
   ch:=s[tmp-1];
   ss:=copy(s,1,tmp-1);
   val(ss,make.x);
   inc(make.x);
   if ch='w' then
      make.x:=make.x+n;
   delete(s,1,tmp);
   ch:=s[length(s)];
   ss:=copy(s,1,length(s)-1);
   val(ss,make.y);
   inc(make.y);
   if ch='w' then
      make.y:=make.y+n;}
end; { make }
procedure init;
var
   i : longint;
   s : ansistring;
begin
   for i:=1 to m do
   begin
      readln(s);
      ask[i]:=make(s);
   end;
end; { init }
procedure make_graph();
var
   i,xx,yy : longint;
begin
   add(2*n+1,1);
   add(n+1,3*n+1);
   for i:=1 to m do
   begin
      add(ask[i].x,ask[i].y+2*n);
      add(ask[i].y,ask[i].x+2*n);
   end;
   for i:=2 to n do
   begin
      xx:=i;
      yy:=i+n;
      add(xx,yy+2*n);
      add(yy,xx+2*n);
      //以下代码代考虑
      add(xx+2*n,yy);
      add(yy+2*n,xx);
   end;
end; { make_graph }
procedure dfs(now :longint );
var
   t : link;
begin
   inc(cnt);
   dfn[now]:=cnt;
   low[now]:=cnt;
   inc(top);
   stack[top]:=now;
   instack[now]:=true;
   t:=l[now];
   while t<>nil do
   begin
      if dfn[t^.goal]=0 then
      begin
	 dfs(t^.goal);
	 if low[t^.goal]<low[now] then
	    low[now]:=low[t^.goal];
      end
      else
	 if (instack[t^.goal])and(dfn[t^.goal]<low[now]) then
	    low[now]:=dfn[t^.goal];
      t:=t^.next;
   end;
   if dfn[now]=low[now] then
   begin
      inc(colour);
      while true do
      begin
	 instack[stack[top]]:=false;
	 color[stack[top]]:=colour;
	 dec(top);
	 if stack[top+1]=now then
	    break;
      end;
   end;
end; { dfs }
procedure tarjan();
var
   i : longint;
begin
   for i:=1 to 4*n do
      if dfn[i]=0 then
	 dfs(i);
end; { tarjan }
function check_result():boolean;
var
   i : longint;
begin
   for i:=1 to 2*n do
      if color[i]=color[i+2*n] then
	 exit(false);
   exit(true);
end; { check_result }
procedure add_new_edge(xx,yy :longint );
var
   t : link;
begin
   new(t);
   t^.goal:=yy;
   t^.next:=newmap[xx];
   newmap[xx]:=t;
end; { add_new_edge }
procedure shrink();
var
   i : longint;
   t : link;
begin
   for i:=1 to 4*n do
   begin
      t:=l[i];
      while t<>nil do
      begin
	 if color[i]<>color[t^.goal] then
	 begin
	    inc(rudo[i]);
	    add_new_edge(t^.goal,i);
	 end;
	 t:=t^.next;
      end;
   end;
   for i:=1 to 2*n do
   begin
      fight[color[i]]:=color[i+2*n];
      fight[color[i+2*n]]:=color[i];
   end;
end; { shrink }
procedure top_sort();
var
   head,tail,i : longint;
   t	       : link;
begin
   head:=0;
   tail:=0;
   for i:=1 to n*4 do
      if rudo[i]=0 then
      begin
	 inc(tail);
	 q[tail]:=i;
      end;
   while head<tail do
   begin
      inc(head);
      t:=newmap[q[head]];
      if answer[q[head]]=-1 then
      begin
	 answer[q[head]]:=0;
	 answer[fight[q[head]]]:=1;
      end;
      while t<>nil do
      begin
	 dec(rudo[t^.goal]);
	 if rudo[t^.goal]=0 then
	 begin
	    inc(tail);
	    q[tail]:=t^.goal;
	 end;
	 t:=t^.next;
      end;
   end;
end; { top_sort }
procedure slove();
var
   i : longint;
begin
   for i:=1 to n do
      if answer[color[i]]=answer[color[3*n+1]] then
	 last[i-1]:='h';
   for i:=n+1 to 2*n do
      if answer[color[i]]=answer[color[3*n+1]] then
	 last[i-n-1]:='w';
   for i:=1 to n-1 do
      write(i,last[i],' ');
   writeln;
end; { slove }
begin
   clean;
   readln(n,m);
   while n+m<>0 do
   begin
      init();
      make_graph();
      tarjan();
      if (check_result) then
      begin
	 shrink();
	 top_sort();
	 slove();
      end
      else
	 writeln('bad luck');
      clean();
      readln(n,m);
   end;
end.