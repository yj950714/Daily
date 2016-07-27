program pku3411(input,output);
type
   node	 = ^link;
   link	 = record
	      goal,ci,pi,wi : integer;
	      next	    : node;
	   end;		    
   node2 = record	    
	      state,now	: longint;
	   end;
var
   l   : array[0..11] of node;
   d   : array[0..11,0..1024] of longint;
   v   : array[0..11,0..1024] of boolean;
   q   : array[0..20000] of node2;
   n,m : longint;
procedure add(xx,yy,cc,ww,pp: longint );
var
   t : node;
begin
   new(t);
   t^.goal:=yy;
   t^.ci:=cc;
   t^.wi:=ww;
   t^.pi:=pp;
   t^.next:=l[xx];
   l[xx]:=t;
end; { add }
procedure init;
var
   i,xx,yy,cc,pp,ww : longint;
begin
   readln(n,m);
   for i:=1 to n do
      l[i]:=nil;
   for i:=1 to m do
   begin
      readln(xx,yy,cc,ww,pp);
      add(xx,yy,cc,ww,pp);
   end;
end; { init }
procedure spfa();
var
   head,tail : longint;
   newstate  : node2;
   t	     : node;
begin
   head:=0;
   tail:=1;
   q[1].now:=1;
   q[1].state:=1;
   fillchar(v,sizeof(v),false);
   fillchar(d,sizeof(d),63);
   d[1,1]:=0;
   v[1,1]:=true;
   while head<tail do
   begin
      inc(head);
      v[q[head].now,q[head].state]:=false;
      t:=l[q[head].now];
      while t<>nil do
      begin
	 if (q[head].state)and(1<<(t^.ci-1))>0 then
	 begin
	    newstate.now:=t^.goal;
	    newstate.state:=(q[head].state)or(1<<(t^.goal-1));
	    if d[q[head].now,q[head].state]+t^.wi<d[newstate.now,newstate.state] then
	    begin
	       d[newstate.now,newstate.state]:=d[q[head].now,q[head].state]+t^.wi;
	       if not v[newstate.now,newstate.state] then
	       begin
		  inc(tail);
		  q[tail]:=newstate;
		  v[newstate.now,newstate.state]:=true;
	       end;
	    end;
	 end
	 else
	 begin
	    newstate.now:=t^.goal;
	    newstate.state:=(q[head].state)or(1<<(t^.goal-1));
	    if d[q[head].now,q[head].state]+t^.pi<d[newstate.now,newstate.state] then
	    begin
	       d[newstate.now,newstate.state]:=d[q[head].now,q[head].state]+t^.pi;
	       if not v[newstate.now,newstate.state] then
	       begin
		  inc(tail);
		  q[tail]:=newstate;
		  v[newstate.now,newstate.state]:=true;
	       end;
	    end;
	 end;
	 t:=t^.next;
      end;
   end;
end; { spfa }
procedure print;
var
   i,answer : longint;
begin
   answer:=maxlongint;
   for i:=0 to 1024 do
      if d[n,i]<answer then
	 answer:=d[n,i];
   if answer<19950714 then
      writeln(answer)
   else
      writeln('impossible');
end; { print }
begin
   init;
   spfa;
   print;
end.