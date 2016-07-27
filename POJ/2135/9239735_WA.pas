program minflow(input,output);
type
   node	= ^link;
   link	= record
	     goal,c,w : longint;
	     next     : node;
	  end;
var
   l	     : array[0..1001] of node;
   v	     : array[0..1001] of boolean;
   q	     : array[0..10000] of integer;
   d	     : array[0..1001] of longint;
   num	     : array[0..1001] of longint;
   min	     : array[0..1001] of longint;
   pre	     : array[0..1001] of longint;
   ans1,ans2 : longint;
   n,m	     : longint;
   s,t	     : longint;
procedure add(xx,yy,ww,zz: longint );
var
   tt : node;
begin
   new(tt);
   tt^.goal:=yy;
   tt^.c:=ww;
   tt^.w:=zz;
   tt^.next:=l[xx];
   l[xx]:=tt;
end; { add }
procedure init;
var
   i	    : longint;
   x1,y1,z1 : longint;
begin
   readln(n,m);
   for i:=0 to n+1 do
      l[i]:=nil;
   for i:=1 to m do
   begin
      readln(x1,y1,z1);
      add(x1,y1,1,z1);
      add(y1,x1,1,z1);
   end;
   s:=0;
   t:=n+1;
   add(s,1,2,0);
   add(n,t,2,0);
end; { init }
function spfa(vo :longint ):boolean;
var
   tt		 : node;
   head,tail,now : longint;
   i		 : integer;
begin
   fillchar(num,sizeof(num),0);
   fillchar(pre,sizeof(pre),0);
   fillchar(v,sizeof(v),false);
   for i:=0 to n+1 do
      d[i]:=maxlongint>>2;
   head:=0;
   tail:=1;
   q[1]:=vo;
   v[vo]:=true;
   d[vo]:=0;
   min[vo]:=maxlongint>>1;
   new(tt);
   while head<tail do
   begin
      inc(head);
      now:=q[head];
      v[q[head]]:=false;
      tt:=l[q[head]];
      while tt<>nil do
      begin
	 if tt^.c>0 then
	    if d[now]+tt^.w<d[tt^.goal] then
	    begin
	       d[tt^.goal]:=d[now]+tt^.w;
	       if min[now]<tt^.c then
		  min[tt^.goal]:=min[now]
	       else
		  min[tt^.goal]:=tt^.c;
	       pre[tt^.goal]:=now;
	       if not v[tt^.goal] then
	       begin
		  inc(tail);
		  q[tail]:=tt^.goal;
		  v[tt^.goal]:=true;
	       end;
	    end;
	 tt:=tt^.next;
      end;
   end;
   if d[t]=maxlongint>>2 then
      exit(false);
   now:=n+1;
   while now<>0 do
   begin
      tt:=l[pre[now]];
      while tt<>nil do
      begin
	 if tt^.goal=now then
	 begin
	    tt^.c:=tt^.c-min[n+1];
	    break;
	 end;
	 tt:=tt^.next;
      end;
      tt:=l[now];
      while tt<>nil do
      begin
	 if tt^.goal=pre[now] then
	 begin
	    tt^.c:=tt^.c+min[n+1];
	    break;
	 end;
	 tt:=tt^.next;
      end;
      now:=pre[now];
   end;
   exit(true);
end; { spfa }
procedure main;
begin
   while spfa(0) do
   begin
      inc(ans1,min[n+1]);
      inc(ans2,min[n+1]*d[n+1]);
   end;
end; { main }
procedure print;
begin
   //writeln(ans1);
   writeln(ans2);
end; { print }
begin
   init;
   main;
   print;
end.
