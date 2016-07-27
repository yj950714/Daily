program pku2339(input,output);
type
   node	= record
	     x,y,now : longint;
	  end;
var
   f   : array[0..601,0..601] of boolean;
   lk  : array[0..601] of longint;
   v   : array[0..601] of boolean;
   ask : array[0..1001] of node;
   n,m : longint;
procedure init;
var
   i,j,x,y,z : longint;
begin
   readln(n);
   m:=0;
   for i:=1 to n do
   begin
      read(x);
      for j:=1 to x do
      begin
	 read(y,z);
	 inc(m);
	 ask[m].now:=i;
	 ask[m].x:=y;
	 ask[m].y:=z;
      end;
      readln;
   end;
end; { init }
procedure make_graph();
var
   i,j : longint;
begin
   for i:=1 to m do
      for j:=1 to m do
	 if (i<>j) then
	    if (ask[i].now<>ask[j].now) then
	    begin
	       if (ask[i].x=ask[j].x)and(ask[i].y=ask[j].y) then
	       begin
		  f[ask[i].now,ask[j].now+n]:=true;
		  f[ask[j].now,ask[i].now+n]:=true;
	       end;
	       if (ask[i].x=ask[j].y)and(ask[i].y=ask[j].x) then
	       begin
		  f[ask[i].now,ask[j].now+n]:=true;
		  f[ask[j].now,ask[i].now+n]:=true;
	       end;
	    end;
end; { make_graph }
function find(now :longint ):boolean;
var
   i : longint;
begin
   for i:=n+1 to n*2 do
      if (f[now,i])and(not v[i]) then
      begin
	 v[i]:=true;
	 if (lk[i]=0)or(find(lk[i])) then
	 begin
	    lk[i]:=now;
	    exit(true);
	 end;
      end;
   exit(false);
end; { find }
function main():longint;
var
   i : longint;
begin
   main:=0;
   for i:=1 to n do
   begin
      fillchar(v,sizeof(v),false);
      if find(i) then
	 inc(main);
   end;
end; { main }
begin
   while not eof do
   begin
   init;
   make_graph;
   writeln(main);
   end;
end.