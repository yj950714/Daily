program pku1088(input,output);
var
   a,f	       : array[0..101,0..101] of longint;
   xx	       : array[1..4]of integer=(0,1,0,-1);
   yy	       : array[1..4]of integer=(1,0,-1,0);
   m,n,i,j,max : longint;
function try(x,y: longint):longint;
var
   ii,x1,y1,tmp : longint;
begin
   if f[x,y]>0 then
      exit(f[x,y]);
   tmp:=0;
   for ii:=1 to 4 do
   begin
      x1:=x+xx[ii];
      y1:=y+yy[ii];
      if (x1<=n)and(x1>0)and(y1<=m)and(y1>0) then
	 if a[x,y]>a[x1,y1] then
	 begin
	    tmp:=try(x1,y1);
	    if tmp+1>f[x,y] then
	       f[x,y]:=tmp+1;
	 end;
   end;
   exit(f[x,y]);
end;
begin
   readln(n,m);
   max:=0;
   fillchar(a,sizeof(a),63);
   fillchar(f,sizeof(f),0);
   for i:=1 to n do
      for j:=1 to m do
	 read(a[i,j]);
   for i:=1 to n do
      for j:=1 to m do
	 if try(i,j)>max then
	    max:=try(i,j);
   writeln(max+1);
end.