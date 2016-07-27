program pku2352(input,output);
var
   c	      : array[0..40000] of longint;
   x,y,answer : array[0..40000] of longint;
   n,maxx     : longint;
procedure init;
var
   i : longint;
begin
   maxx:=0;
   readln(n);
   for i:=1 to n do
   begin
      readln(x[i],y[i]);
      if x[i]>maxx then
	 maxx:=x[i];
   end;
end; { init }
function lowbit(x :longint ):longint;
begin
   exit(x and(-x));
end; { lowbit }
procedure insect(pos,w: longint );
begin
   while pos<=maxx do
   begin
      inc(c[pos],w);
      pos:=pos+lowbit(pos);
   end;
end; { insect }
function find(pos :longint ):longint;
begin
   find:=0;
   while pos>0 do
   begin
      inc(find,c[pos]);
      pos:=pos-lowbit(pos);
   end;
end; { find }
procedure main;
var
   i : longint;
begin
   for i:=1 to n do
   begin
      inc(answer[find(x[i])]);
      insect(x[i],1);
   end;
end; { main }
procedure print;
var
   i : longint;
begin
   for i:=0 to n-1 do
      writeln(answer[i]);
end; { print }
begin
   init;
   main;
   print;
end.