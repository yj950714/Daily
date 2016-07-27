program pku1274(input,output);
var
   f   : array[0..301,0..301] of boolean;
   v   : array[0..301] of boolean;
   lk  : array[0..301] of longint;
   n,m : longint;
procedure init;
var
   i,j,x,y : longint;
begin
   readln(n,m);
   fillchar(f,sizeof(f),false);
   fillchar(lk,sizeof(lk),0);
   for i:=1 to n do
   begin
      read(x);
      for j:=1 to x do
      begin
	 read(y);
	 f[y,i]:=true;
      end;
   end;
end; { init }
function find(now :longint ):boolean;
var
   i : longint;
begin
   for i:=1 to m do
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
   while not eof do
   begin
      init;
      writeln(main);
   end;
end.