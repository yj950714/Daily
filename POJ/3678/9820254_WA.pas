program pku3678(input,output);
type
   node	 = ^link;
   link	 = record
	      goal : longint;
	      next : node;
	   end;	   
var
   stack,dfn,low,color : array[0..2100] of longint;
   l		       : array[0..2100] of node;
   instack	       : array[0..2100] of boolean;
   top,cnt,colour      : longint;
   n,m		       : longint;
procedure add(xx,yy :longint );
var
   t : node;
begin
   new(t);
   t^.goal:=yy;
   t^.next:=l[xx];
   l[xx]:=t;
end; { add }
procedure init;
var
   i,x,y,z : longint;
   s	   : ansistring;
begin
   readln(n,m);
   for i:=1 to m do
   begin
      read(x,y,z);
      inc(x);
      inc(y);
      readln(s);
      if s='AND' then
      begin
	 if z=0 then
	 begin
	    add(x+n,y);
	    add(y+n,x);
	 end
	 else
	 begin
	    add(y+n,x+n);
	    add(x+n,y+n);
	 end;
      end;
      if s='OR' then
      begin
	 if z=0 then
	 begin
	    add(x,y);
	    add(y,x);
	 end
	 else
	 begin
	    add(x,y+n);
	    add(y,x+n);
	 end;
      end;
      if s='XOR' then
      begin
	 if z=0 then
	 begin
	    add(x,y);
	    add(y,x);
	    add(y+n,x+n);
	    add(x+n,y+n);
	 end
	 else
	 begin
	    add(x+n,y);
	    add(y+n,x);
	    add(x,y+n);
	    add(y,x+n);
	 end;
      end;
   end;
end; { init }
procedure dfs(now :longint );
var
   t : node;
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
      begin
	 if (instack[t^.goal])and(dfn[t^.goal]<low[now]) then
	    low[now]:=dfn[t^.goal];
      end;
      t:=t^.next;
   end;
   if low[now]=dfn[now] then
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
procedure main;
var
   i : longint;
begin
   for i:=1 to n*2 do
      if dfn[i]=0 then
	 dfs(i);
end; { main }
procedure print;
var
   i : longint;
begin
   for i:=1 to n do
      if color[i]=color[i+n] then
      begin
	 writeln('NO');
	 exit;
      end;
   writeln('YES');
end; { print }
begin
   init;
   main;
   print;
end.