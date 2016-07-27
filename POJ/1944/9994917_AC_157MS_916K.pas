{$inline on}
program pku1944(input,output);
type
   node	= record
	     x,y : integer;
	  end;
var
   n,p	  : integer;
   answer : integer;
   a	  : array[0..10001] of node;
   next	  : array[0..1001] of integer;
procedure swap(var aa,bb: integer ); inline;
var
   t : integer;
begin
   t:=aa;
   aa:=bb;
   bb:=t;
end; { swap }
procedure init; inline;
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
procedure sort(p,q :longint ); inline;
var
   i,j,m1,m2 : integer;
begin
   i:=p;
   j:=q;
   m1:=a[(i+j)>>1].x;
   m2:=a[(i+j)>>1].y;
   repeat
      while (a[i].x<m1)or((a[i].x=m1)and(a[i].y<m2)) do
	 inc(i);
      while (a[j].x>m1)or((a[j].x=m1)and(a[j].y>m2)) do
	 dec(j);
      if i<=j then
      begin
	 swap(a[i].x,a[j].x);
	 swap(a[i].y,a[j].y);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
procedure main; inline;
var
   i,j	 : integer;
   xx,yy : integer;
   sum	 : integer;
begin
   answer:=maxint;
   for i:=1 to n do
   begin
      sum:=0;
      fillchar(next,sizeof(next),0);
      for j:=1 to p do
	 if (a[j].x<i)and(a[j].y>=i) then
	 begin
	    if a[j].x>next[1] then
	       next[1]:=a[j].x;
	    if next[a[j].y]<n+1 then
	       next[a[j].y]:=n+1;
	 end
	 else
	 begin
	    if next[a[j].x]<a[j].y then
	       next[a[j].x]:=a[j].y;
	 end;
      for j:=1 to n do
	 if next[j]>0 then
	 begin
	    xx:=j;
	    yy:=next[j];
	    break;
	 end;
      inc(sum,yy-xx);
      for j:=xx+1 to n do
      begin
	 if next[j]=0 then
	    continue;
	 if j>yy then
	 begin
	    inc(sum,next[j]-j);
	    xx:=j;
	    yy:=next[j];
	 end
	 else
	    if next[j]>yy then
	    begin
	       inc(sum,next[j]-yy);
	       xx:=j;
	       yy:=next[j];
	    end;
      end;
      if sum<answer then
	 answer:=sum;
   end;
end; { main }
procedure print; inline;
begin
   writeln(answer);
end; { print }
begin
   init;
   main;
   print;
end.