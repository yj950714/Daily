program pku1325(input,output);
var
   f	 : array[0..201,0..201] of boolean;
   lk	 : array[0..201] of longint;
   v	 : array[0..201] of boolean;
   n,m,k : longint;
procedure init;
var
   i,ii,xx,yy : longint;
begin
   fillchar(f,sizeof(f),false);
   fillchar(lk,sizeof(lk),0);
   for i:=1 to k do
   begin
      readln(ii,xx,yy);
      f[xx,yy+n]:=true;
   end;
end; { init }
function find(now : longint):boolean;
var
   i : longint;
begin
   for i:=n+1 to n+m do
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
   exit(main);
end; { main }
begin
   read(n);
   while n<>0 do
   begin
      readln(m,k);
      init;
      writeln(main);
      read(n);
   end;
end.