program pku1338(input,output);
type
   longint = int64;
   node	   = ^link;
   link	   = record
		worth : longint;
		next  : node;
	     end;     
var
   heap	  : array[0..10000] of longint;
   hash	  : array[0..65537] of node;
   n,tot  : longint;
   answer : longint;
procedure swap(var aa,bb: longint );
var
   tt : longint;
begin
   tt:=aa;
   aa:=bb;
   bb:=tt;
end; { swap }
function find(x :longint ):boolean;
var
   t : node;
begin
   t:=hash[x mod 65537];
   while t<>nil do
   begin
      if t^.worth=x then
	 exit(true);
      t:=t^.next;
   end;
   exit(false);
end; { find }
procedure inn(x	:longint );
var
   t : node;
begin
   new(t);
   t^.worth:=x;
   t^.next:=hash[x mod 65537];
   hash[x mod 65537]:=t;
end; { inn }
procedure up(x: longint );
begin
   while (heap[x]<heap[x>>1])and(x<>1) do
   begin
      swap(heap[x],heap[x>>1]);
      x:=x>>1;
   end;
end; { up }
procedure down(x :longint );
begin
   while (x*2<=tot)and((heap[x]>heap[x*2])or(heap[x]>heap[x*2+1])) do
   begin
      if heap[x<<1]>heap[x*2+1] then
      begin
	 swap(heap[x],heap[x*2+1]);
	 x:=x*2+1;
      end
      else
      begin
	 swap(heap[x],heap[x*2]);
	 x:=x<<1;
      end;
   end;
end; { down }
procedure insect(x :longint );
begin
   inc(tot);
   heap[tot]:=x;
   up(tot);
end; { insect }
function delete():longint;
begin
   delete:=heap[1];
   swap(heap[1],heap[tot]);
   heap[tot]:=maxlongint>>1;
   dec(tot);
   down(1);
end; { delete }
procedure main;
var
   i : dword;
begin
   fillchar(heap,sizeof(heap),63);
   for i:=1 to 65537 do
      hash[i]:=nil;
   answer:=1;
   tot:=1;
   heap[1]:=1;
   inn(1);
   for i:=1 to n do
   begin
      answer:=delete();
      if not find(answer*2) then
      begin
	 inn(answer*2);
	 insect(answer*2);
      end;
      if not find(answer*3) then
      begin
	 inn(answer*3);
	 insect(answer*3);
      end;
      if not find(answer*5) then
      begin
	 inn(answer*5);
	 insect(answer*5);
      end;
   end;
   writeln(answer);
end; { main }
begin
   readln(n);
   while n<>0 do
   begin
      main;
      readln(n);
   end;
end.