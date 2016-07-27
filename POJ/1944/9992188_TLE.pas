program pku1944(input,output);
type
   node	= record
	     x,y : integer;
	  end;
var
   n,p	  : integer;
   answer : integer;
   a	  : array[0..10001] of node;
   line	  : array[0..10001] of node;
procedure swap(var aa,bb: integer );
var
   t : integer;
begin
   t:=aa;
   aa:=bb;
   bb:=t;
end; { swap }
procedure init;
var
   i : integer;
begin
   readln(n,p);
   for i:=1 to p do
   begin
      readln(a[i].x,a[i].y);
      if a[i].x>a[i].y then
	 swap(a[i].x,a[i].y);
   end;
end; { init }
procedure sort(p,q :longint );
var
   i,j,m1,m2 : integer;
begin
   i:=p;
   j:=q;
   m1:=line[(i+j)>>1].x;
   m2:=line[(i+j)>>1].y;
   repeat
      while (line[i].x<m1)or((line[i].x=m1)and(line[i].y<m2)) do
	 inc(i);
      while (line[j].x>m1)or((line[j].x=m1)and(line[j].y>m2)) do
	 dec(j);
      if i<=j then
      begin
	 swap(line[i].x,line[j].x);
	 swap(line[i].y,line[j].y);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
procedure main;
var
   tot	 : integer;
   i,j	 : integer;
   xx,yy : integer;
   sum	 : integer;
begin
   answer:=maxint;
   for i:=1 to n do
   begin
      tot:=0;
      for j:=1 to p do
	 if (a[j].x<i)and(a[j].y>=i) then
	 begin
	    inc(tot);
	    line[tot].x:=a[j].y;
	    line[tot].y:=a[j].y+(n-(a[j].y-a[j].x));
	 end
	 else
	 begin
	    inc(tot);
	    line[tot].x:=a[j].x;
	    line[tot].y:=a[j].y;
	 end;
      sort(1,tot);
      sum:=0;
      xx:=line[1].x;
      yy:=line[1].y;
      for j:=2 to tot do
      begin
	 if line[j].x>yy then
	 begin
	    inc(sum,yy-xx);
	    xx:=line[j].x;
	    yy:=line[j].y;
	    continue;
	 end
	 else
	    if line[j].y>yy then
	       yy:=line[j].y;
      end;
      inc(sum,yy-xx);
      if sum<answer then
	 answer:=sum;
   end;
end; { main }
procedure print;
begin
   writeln(answer);
end; { print }
begin
   init;
   main;
   print;
end.