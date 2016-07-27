program pku1631(input,output);
var
   q	 : array[0..60000] of longint;
   top	 : longint;
   n	 : longint;
   a	 : array[0..50000] of longint;
   cases : longint;
procedure init;
var
   i : longint;
begin
   readln(n);
   for i:=1 to n do
      readln(a[i]);
   fillchar(q,sizeof(q),0);
   top:=0;
end; { init }
function find(worth : longint ):longint;
var
   l,r,mid : longint;
begin
   l:=1;
   r:=top;
   while l+1<r do
   begin
      mid:=(l+r)>>1;
      if q[mid]<=worth then
	 l:=mid
      else
	 r:=mid;
   end;
   exit(r);
end; { find }
procedure main;
var
   i,j : longint;
begin
   for i:=1 to n do
   begin
      if a[i]>=q[top] then
      begin
	 inc(top);
	 q[top]:=a[i];
	 continue;
      end;
      if a[i]<q[1] then
      begin
	 q[1]:=a[i];
	 continue;
      end;
      j:=find(a[i]);
      if a[i]<q[j] then
	 q[j]:=a[i];
   end;
   writeln(top);
end; { main }
begin
   readln(cases);
   while cases>0 do
   begin
      init;
      main;
      dec(cases);
   end;
end.