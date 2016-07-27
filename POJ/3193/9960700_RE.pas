program pku3193(input,output);
var
   a,b	  : array[0..2000] of ansistring;
   n,m	  : longint;
   answer : longint;
procedure init;
var
   i,j,tmp : longint;
begin
   readln(m,n);
   for i:=1 to m do
   begin
      readln(a[i]);
      tmp:=pos(' ',a[i]);
      while tmp>0 do
      begin
	 delete(a[i],tmp,1);
	 tmp:=pos(' ',a[i]);
      end;
      tmp:=pos('.',a[i]);
      while tmp>0 do
      begin
	 delete(a[i],tmp,1);
	 tmp:=pos('.',a[i]);
      end;
      tmp:=pos(',',a[i]);
      while tmp>0 do
      begin
	 delete(a[i],tmp,1);
	 tmp:=pos(',',a[i]);
      end;
      tmp:=pos('?',a[i]);
      while tmp>0 do
      begin
	 delete(a[i],tmp,1);
	 tmp:=pos('?',a[i]);
      end;
      for j:=1 to length(a[i]) do
	 a[i][j]:=upcase(a[i][j]);
   end;
end; { init }
procedure swap(var aa,bb :ansistring );
var
   tt : ansistring;
begin
   tt:=aa;
   aa:=bb;
   bb:=tt;
end; { swap }
procedure sort(p,q :longint );
var
   mid : ansistring;
   i,j : longint;
begin
   i:=p;
   j:=q;
   mid:=a[(i+j)>>1];
   repeat
      while a[i]<mid do
	 inc(i);
      while a[j]>mid do
	 dec(j);
      if i<=j then
      begin
	 swap(a[i],a[j]);
	 inc(i);
	 dec(j);
      end;
   until i>j;
   if i<q then sort(i,q);
   if j>p then sort(p,j);
end; { sort }
procedure change();
var
   i   : longint;
   tot : longint;
begin
   sort(1,m);
   tot:=0;
   b[0]:='';
   for i:=1 to m do
      if a[i]<>b[tot] then
      begin
	 inc(tot);
	 b[tot]:=a[i];
      end;
   for i:=1 to tot do
      a[i]:=b[i];
   b[tot+1]:='z';//最大值
   m:=tot;
end; { change }
function get_min(now :ansistring ):longint;
var
   l,r,mid : longint;
begin
   l:=0;
   r:=n+1;
   while l+1<r do
   begin
      mid:=(l+r)>>1;
      if now>=a[mid] then
	 l:=mid
      else
	 r:=mid-1;
   end;
   exit(l);
end; { get_min }
function get_max(now :ansistring ):longint;
var
   l,r,mid : longint;
begin
   l:=0;
   r:=n+1;
   while l+1<r do
   begin
      mid:=(l+r)>>1;
      if now>=a[mid] then
	 r:=mid
      else
	 l:=mid+1;
   end;
   exit(r);
end; { get_max }
procedure main;
var
   i,j,tmp,x,y : longint;
   s	   : ansistring;
begin
   for i:=1 to m do
   begin
      readln(s);
      tmp:=pos(' ',s);
      while tmp>0 do
      begin
	 delete(s,tmp,1);
	 tmp:=pos(' ',s);
      end;
      tmp:=pos('.',s);
      while tmp>0 do
      begin
	 delete(s,tmp,1);
	 tmp:=pos('.',s);
      end;
      tmp:=pos(',',s);
      while tmp>0 do
      begin
	 delete(s,tmp,1);
	 tmp:=pos(',',s);
      end;
      tmp:=pos('?',s);
      while tmp>0 do
      begin
	 delete(s,tmp,1);
	 tmp:=pos('?',s);
      end;
      for j:=1 to length(s) do
	 s[j]:=upcase(s[j]);
      x:=get_min(s);
      y:=get_max(s);
      for j:=x to y do
	 if pos(s,a[j])=1 then
	 begin
	    inc(answer);
	    break;
	 end;
   end;
end; { main }
procedure print;
begin
   writeln(answer);
end; { print }
begin
   init;
   change;
   main;
   print;
end.