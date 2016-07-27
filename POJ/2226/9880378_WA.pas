program pku2226(input,output);
var
   map	 : array[0..51,0..51] of char;
   x,y	 : array[0..51,0..51] of longint;
   f	 : array[0..2500,0..2500] of boolean;
   v	 : array[0..2500] of boolean;
   lk	 : array[0..2500] of longint;
   n,m	 : longint;
   ll,rr : longint;
procedure init;
var
   i,j : longint;
begin
   readln(n,m);
   for i:=1 to n do
   begin
      for j:=1 to m do
	 read(map[i,j]);
      readln;
   end;
   fillchar(x,sizeof(x),255);
   fillchar(y,sizeof(y),255);
end; { init }
procedure make_graph();
var
   i,j : longint;
   tot : longint;
begin
   tot:=0;
   for i:=1 to n do
      for j:=1 to m do
      begin
	 if map[i,j]='.' then
	    continue
	 else
	 begin
	    if x[i,j-1]<>-1 then
	       x[i,j]:=x[i,j-1]
	    else
	    begin
	       inc(tot);
	       x[i,j]:=tot;
	    end;
	 end;
      end;
   ll:=tot+1;

   for i:=1 to m do
      for j:=1 to n do
      begin
	 if map[i,j]='.' then
	    continue
	 else
	 begin
	    if y[j-1,i]<>-1 then
	       y[j,i]:=y[j-1,i]
	    else
	    begin
	       inc(tot);
	       y[j,i]:=tot;
	    end;
	 end;
      end;
   rr:=tot;
   
   fillchar(f,sizeof(f),false);
   for i:=1 to n do
      for j:=1 to m do
	 if map[i,j]='*' then
	    f[x[i,j],y[i,j]]:=true;
end; { make_graph }
function find(now :longint ):boolean;
var
   i : longint;
begin
   for i:=ll to rr do
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
   fillchar(lk,sizeof(lk),0);
   for i:=1 to ll-1 do
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