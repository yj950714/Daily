program pku3662(input,output);
type
   node	 = ^link;
   link	 = record
	      goal : longint;
	      w	   : int64;
	      next : node;
	   end;	   
   node2 = record
	      now  : longint;
	      suml : int64;
	   end;	   
var
   l	    : array[0..2001] of node;
   d	    : array[0..2001,0..2001] of boolean;
   q	    : array[0..40001] of node2;
   v	    : array[0..2001,0..2001] of boolean;
   n,m,maxk : longint;
procedure add(xx,yy: longint; ww:int64 );
var
   t : node;
begin
   new(t);
   t^.w:=ww;
   t^.goal:=yy;
   t^.next:=l[xx];
   l[xx]:=t;
end; { add }
procedure init;
var
   i,xxx,yyy,www : longint;
begin
   readln(n,m,maxk);
   for i:=1 to n do
      l[i]:=nil;
   for i:=1 to m do
   begin
      read(xxx,yyy,www);
      add(xxx,yyy,www);
      add(yyy,xxx,www);
   end;
end; { init }
function spfa(kill : int64 ):boolean;
var
   head,tail,i : longint;
   t	       : node;
begin
   fillchar(d,sizeof(d),false);
   fillchar(v,sizeof(v),false);
   head:=0;
   tail:=1;
   q[1].now:=1;
   q[1].suml:=0;
   d[1,0]:=true;
   v[1,0]:=true;
   while head<tail do
   begin
      inc(head);
      v[q[head].now,q[head].suml]:=false;
      t:=l[q[head].now];
      while t<>nil do
      begin
	 if t^.w>kill then
	 begin
	    if q[head].suml<>maxk then
	       if not d[t^.goal,q[head].suml+1] then
	       begin
		  d[t^.goal,q[head].suml+1]:=true;
		  if not v[t^.goal,q[head].suml+1] then
		  begin
		     inc(tail);
		     q[tail].now:=t^.goal;
		     q[tail].suml:=q[head].suml+1;
		     v[t^.goal,q[head].suml+1]:=true;
		  end;
	       end;
	 end
	 else
	 begin
	    if not d[t^.goal,q[head].suml] then
	    begin
	       d[t^.goal,q[head].suml]:=true;
	       if not v[t^.goal,q[head].suml] then
	       begin
		  inc(tail);
		  q[tail].now:=t^.goal;
		  q[tail].suml:=q[head].suml;
		  v[t^.goal,q[head].suml]:=true;
	       end;
	    end;
	 end;
	 t:=t^.next;
      end;
   end;
   for i:=0 to maxk do
      if d[n,i] then
	 exit(true);
   exit(false);
end; { spfa }
procedure main;
var
   left,right,mid : longint;
begin
   if not spfa(maxlongint>>4) then
   begin
      writeln(-1);
      exit;
   end;
   if spfa(0) then
   begin
      writeln(0);
      exit;
   end;
   left:=0;
   right:=2000000;
   while left+1<right do
   begin
      mid:=(left+right)>>1;
      if spfa(mid) then
	 right:=mid
      else
	 left:=mid;
   end;
   writeln(right);
end; { main }
begin
   init;
   main;
end.