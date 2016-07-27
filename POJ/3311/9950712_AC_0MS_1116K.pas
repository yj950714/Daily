program pku3311(input,output);
type
   node	= record
	     now,state : longint;
	  end;
var
   q : array[0..50000] of node;
   f : array[0..12,0..12] of longint;
   d : array[0..12,0..3000] of longint;
   v : array[0..12,0..3000] of boolean;
   n : longint;
procedure init;
var
   i,j,k : longint;
begin
   inc(n);
   for i:=1 to n do
   begin
      for j:=1 to n do
	 read(f[i,j]);
      readln;
   end;
end; { init }
procedure spfa();
var
   head,tail,i : longint;
   new	       : node;
begin
   q[1].now:=1;
   q[1].state:=1;
   fillchar(v,sizeof(v),false);
   fillchar(d,sizeof(d),63);
   d[1,1]:=0;
   v[1,1]:=true;
   head:=0;
   tail:=1;
   while head<tail do
   begin
      inc(head);
      v[q[head].now,q[head].state]:=false;
      for i:=1 to n do
	 if f[q[head].now,i]>0 then
	 begin
	    new.now:=i;
	    new.state:=q[head].state or (1<<(i-1));
	    if d[q[head].now,q[head].state]+f[q[head].now,i]<d[new.now,new.state] then
	    begin
	       d[new.now,new.state]:=d[q[head].now,q[head].state]+f[q[head].now,i];
	       if not v[new.now,new.state] then
	       begin
		  inc(tail);
		  q[tail]:=new;
		  v[new.now,new.state]:=true;
	       end;
	    end;
	 end;
   end;
end; { spfa }
procedure print;
begin
   writeln(d[1,(1<<n)-1]);
end; { print }
begin
   readln(n);
   while n<>0 do
   begin
      init;
      spfa;
      print;
      readln(n);
   end;
end.