program pku1833(input,output);
var
   a	 : array[0..2000] of longint;
   n	 : longint;
   k	 : longint;
   cases : longint;
procedure init;
var
   i : longint;
begin
   fillchar(a,sizeof(a),0);
   readln(n,k);
   for i:=1 to n do
      read(a[i]);
   readln;
end; { init }
procedure swap(var aa,bb :longint );
var
   tt : longint;
begin 
   tt:=aa;
   aa:=bb;
   bb:=tt;
end; { swap }
procedure main;
var
   i   : longint;
   x,y : longint;
begin  
   while k>0 do
   begin
      dec(k);
      i:=n;
      while (i>0)and(a[i]>a[i+1]) do
	 dec(i);
      x:=i;
      if i=0 then
      begin
	 for i:=1 to n do
	    a[i]:=i;
      end
      else
      begin
	 a[0]:=maxint;
	 y:=0;
	 for i:=x+1 to n do
	    if (a[i]>a[x])and(a[i]<a[y]) then
	       y:=i;
	 swap(a[x],a[y]);
	 for i:=1 to (n-x)>>1 do
	    swap(a[x+i],a[n-i+1]);
      end;
   end;
end; { main }
procedure print;
var
   i : longint;
begin
   for i:=1 to n-1 do
      write(a[i],' ');
   writeln(a[n]);
end; { print }
begin
   readln(cases);
   while cases>0 do
   begin
      dec(cases);
      init;
      main;
      print;
   end;
end.