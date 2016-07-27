program interval(input,output);
type
   node	= ^link;
   link	= record
	     goal,w : longint;
	     next   : node;
	  end;
var
   l	     : array[-10..10001] of node;
   d	     : array[-10..10001] of longint;
   q	     : array[-10..20000] of longint;
   v	     : array[-10..10001] of boolean;
   n,max,ans : longint;
procedure add(xx,yy,ww: longint );
var
   tt : node;
begin
   new(tt);
   tt^.next:=l[xx];
   tt^.goal:=yy;
   tt^.w:=ww;
   l[xx]:=tt;
end; { add }
procedure init;
var
   i	    : longint;
   x1,y1,w1 : longint;
begin
   readln(n);
   max:=0;
   for i:=0 to 10000 do
      l[i]:=nil;
   for i:=1 to n do
   begin
      readln(x1,y1,);
      add(y1,x1-1,-2);
      if y1>max then
	 max:=y1;
   end;
   for i:=1 to max do
   begin
      add(i,i-1,0);
      add(i-1,i,1);
   end;
   for i:=0 to max do
      add(-1,i,0);
end; { init }
procedure  spfa();
var
   head,tail : longint;
   tt	     : node;
begin
   fillchar(v,sizeof(v),false);
   fillchar(d,sizeof(d),63);
   head:=0;
   tail:=1;
   d[-1]:=0;
   v[-1]:=true;
   q[1]:=-1;
   new(tt);
   while head<tail do
   begin
      inc(head);
      v[q[head]]:=false;
      tt:=l[q[head]];
      while tt<>nil do
      begin
	 if d[q[head]]+tt^.w<d[tt^.goal] then
	 begin
	    d[tt^.goal]:=d[q[head]]+tt^.w;
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
end; { spfa }
procedure make;
var
   i   : longint;
begin
   ans:=maxlongint>>2;
   for i:=0 to max do
      if d[i]<ans then
	 ans:=d[i];
end; { make }
procedure print;
begin
   writeln(abs(ans));
end; { print }
begin
   init;
   spfa();
   make;
   print;
end.