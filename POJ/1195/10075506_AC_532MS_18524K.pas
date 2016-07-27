program pku1195(input,output);
var
   c	  : array[0..1500,0..1500] of int64;
   n,kk : longint;
function lowbit(x: longint ):longint;
begin
   exit(x and (-x));
end; { lowbit }
procedure insect(x,y,w :longint );
var
   k : longint;
begin
   while x<=n do
   begin
      k:=y;
      while k<=n do
      begin
	 inc(c[x,k],w);
	 k:=k+lowbit(k);
      end;
      x:=x+lowbit(x);
   end;
end; { insect }
function find(x,y :longint ):longint;
var
   k : longint;
begin
   find:=0;
   while x>0 do
   begin
      k:=y;
      while k>0 do
      begin
	 inc(find,c[x,k]);
	 k:=k-lowbit(k);
      end;
      x:=x-lowbit(x);
   end;
end; { find }
procedure main;
var
   x1,y1,x2,y2 : longint;
begin
   read(kk);
   while kk<>3 do
   begin
      case kk of
	0 : begin
	       readln(n);
	       fillchar(c,sizeof(c),0);
	    end;
	1 : begin
	       readln(x1,y1,x2);
	       inc(x1);
	       inc(y1);
	       insect(x1,y1,x2);
	    end;
	2 : begin
	       readln(x1,y1,x2,y2);
	       inc(x1); inc(y1);
	       inc(x2); inc(y2);
	       writeln(find(x2,y2)+find(x1-1,y1-1)-find(x2,y1-1)-find(x1-1,y2));
	    end;
      end; { case }
      read(kk);
   end;
end;
begin
   main;
end.