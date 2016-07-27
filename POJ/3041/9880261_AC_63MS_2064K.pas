program pku3041(input,output);
var
   f   : array[0..1100,0..1100] of boolean;
   v   : array[0..1100] of boolean;
   lk  : array[0..1100] of longint;
   n,m : longint;
procedure init;
var
   i,xx,yy : longint;
begin
   fillchar(f,sizeof(f),false);
   readln(n,m);
   for i:=1 to m do
   begin
      readln(xx,yy);
      f[xx,yy+n]:=true;
   end;
end; { init }
function find(now :longint ):boolean;
var
   i : longint;
begin
   for i:=n+1 to n+n do
      if (not v[i])and(f[now,i]) then
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
function main:longint;
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
      writeln(main);
   end;
end.