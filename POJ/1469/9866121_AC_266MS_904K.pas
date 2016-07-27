program pku1469(input,output);
var
   f	   : array[0..101,0..301] of boolean;
   lk	   : array[0..301] of longint;
   v	   : array[0..301] of boolean;
   n,m,p,k : longint;
procedure init;
var
   i,j,x,y : longint;
begin
   fillchar(f,sizeof(f),false);
   fillchar(lk,sizeof(lk),0);
   readln(m,n);
   for i:=1 to m do
   begin
      read(x);
      for j:=1 to x do
      begin
	 read(y);
	 f[i,y]:=true;
      end;
      readln;
   end;
end; { init }
function find(now :longint ):boolean;
var
   i : longint;
begin
   for i:=1 to n do
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
   for i:=1 to m do
   begin
      fillchar(v,sizeof(v),false);
      if find(i) then
	 inc(main);
   end;
end; { main }
begin
   readln(p);
   for k:=1 to p do
   begin
      init;
      if (main=m) then
	 writeln('YES')
      else
	 writeln('NO');
   end;
end.