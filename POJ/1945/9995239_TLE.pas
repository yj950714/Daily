program pku1945(input,output);
type
   link	 = ^node;
   node	 = record
	      x,y  : longint;
	      next : link;
	   end;	   
   node2 = record
	      step  : byte;
	      x,y,w : longint;
	   end;	    
var
   hash	: array[0..1000000] of link;
   heap	: array[0..1000000] of longint;
   q	: array[0..1000000] of node2;
   n,m	: longint;
   tot	: longint;
   tail	: longint;
function gcd(aa,bb: longint ):longint;
begin
   if bb=0 then
      exit(aa);
   exit(gcd(bb,aa mod bb));
end; { gcd }
procedure swap(var aa,bb :longint );
var
   tt : longint;
begin
   tt:=aa;
   aa:=bb;
   bb:=tt;
end; { swap }
function calc(now : node2 ):longint;
begin
   calc:=0;
   while now.y<n do
   begin
      inc(calc);
      now.y:=now.y<<1;
   end;
   inc(calc,now.step);
end; { calc }
function find(now : node2 ):boolean;
var
   tt : link;
begin
   tt:=hash[(now.x*now.y) mod 999983];
   while tt<>nil do
   begin
      if (tt^.x=now.x)and(tt^.y=now.y) then
	 exit(true);
      tt:=tt^.next;
   end;
   exit(false);
end; { find }
procedure insect_hash(now :node2 );
var
   t : link;
begin
   new(t);
   t^.x:=now.x;
   t^.y:=now.y;
   t^.next:=hash[(now.x*now.y)mod 999983];
   hash[(now.x*now.y)mod 999983]:=t;
end; { insect_hash }
procedure up(now: longint );
begin
   while now>1 do
   begin
      if q[heap[now]].w<q[heap[now>>1]].w then
      begin
	 swap(heap[now],heap[now>>1]);
	 now:=now>>1;
      end
      else
	 exit;
   end;
end; { up }
procedure down(now :longint );
begin
   while (now<<1)<=tot do
   begin
      if ((now<<1)<tot)and(q[heap[now<<1]].w>q[heap[(now<<1)+1]].w) then
      begin
	 if q[heap[now]].w>q[heap[(now<<1)+1]].w then
	 begin
	    swap(heap[now],heap[(now<<1)+1]);
	    now:=(now<<1)+1;
	 end;
      end
      else
	 if q[heap[now]].w>q[heap[now<<1]].w then
	 begin
	    swap(heap[now],heap[now<<1]);
	    now:=now<<1;
	 end
	 else
	    exit;
   end;
end; { down }
procedure insect(now :node2 );
begin
   if now.x>now.y then
      swap(now.x,now.y);
   now.w:=calc(now);
   if (now.x>m)or(now.y>m)or(n mod gcd(now.x,now.y)<>0)or(find(now)) then
      exit;
   if (now.x=n)or(now.y=n) then
   begin
      writeln(now.step);
      halt;
   end;
   insect_hash(now);
   inc(tail);
   q[tail]:=now;
   inc(tot);
   heap[tot]:=tail;
   up(tot);
end; { insect }
procedure main;
var
   i	   : longint;
   tmp,new : node2;
begin
   for i:=0 to 1000000 do
      hash[i]:=nil;
   readln(n);
   m:=n*2;
   if m>32767 then
      m:=32767;
   
   tail:=1;
   q[1].x:=1;
   q[1].y:=0;
   q[1].w:=0;
   q[1].step:=0;

   insect_hash(q[1]);
   
   tot:=1;
   heap[1]:=1;

   while tot>0 do
   begin
      if (q[heap[1]].x=n)or(q[heap[1]].y=n) then
      begin
	 writeln(q[heap[1]].step);
	 exit;
      end;
      tmp:=q[heap[1]];
      swap(heap[1],heap[tot]);
      dec(tot);
      down(1);

      new:=tmp;
      new.x:=2*new.x;
      inc(new.step);
      insect(new);

      new:=tmp;
      new.y:=2*new.y;
      inc(new.step);
      insect(new);

      new:=tmp;
      if new.x-new.y>0 then
      begin
	 inc(new.step);
	 new.x:=new.x-new.y;
	 insect(new);
      end;

      new:=tmp;
      if new.y-new.x>0 then
      begin
	 inc(new.step);
	 new.y:=new.y-new.x;
	 insect(new);
      end;

      new:=tmp;
      if new.x<>0 then
      begin
	 inc(new.step);
	 new.y:=new.x*2;
	 insect(new);
      end;

      new:=tmp;
      if new.y<>0 then
      begin
	 inc(new.step);
	 new.x:=new.y*2;
	 insect(new);
      end;

      new:=tmp;
      inc(new.x,new.y);
      inc(new.step);
      insect(new);

      new:=tmp;
      inc(new.y,new.x);
      inc(new.step);
      insect(new);
   end;
end; { main }
begin
   main;
end.