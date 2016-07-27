program pku2785(input,output);
const
   oo = 4194303;
type
   node	= ^link;
   link	= record
	     worth : longint;
	     next  : node;
	  end;	   
var
   hash	    : array[-4194303..4194303] of node;
   a,b,c,d  : array[0..4010] of longint;
   n,answer : int64;
procedure insect(x: longint );
var
   s : longint;
   t : node;
begin
   s:=x mod oo;
   new(t);
   t^.worth:=x;
   t^.next:=hash[s];
   hash[s]:=t;
end; { insect }
function find(x	:longint ):boolean;
var
   s : longint;
   t : node;
begin
   s:=x mod oo;
   t:=hash[s];
   while t<>nil do
   begin
      if t^.worth=x then
	 exit(true);
      t:=t^.next;
   end;
   exit(false);
end; { find }
procedure main;
var
   i,j : longint;
begin
   for i:=-oo to oo do
      hash[i]:=nil;
   readln(n);
   for i:=1 to n do
      readln(a[i],b[i],c[i],d[i]);
   for i:=1 to n do
      for j:=1 to n do
	 if not find(a[i]+b[j]) then
	    insect(a[i]+b[j]);
   answer:=0;
   for i:=1 to n do
      for j:=1 to n do
	 if find(-(c[i]+d[j])) then
	    inc(answer);
   writeln(answer);
end; { main }
begin
   main;
end.