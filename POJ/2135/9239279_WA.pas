program minflow(input,output);
var
   f	     : array[0..1010,0..1010] of longint;
   pre	     : array[0..1010] of longint;
   w	     : array[0..1010,0..1010] of longint;
   q	     : array[0..10000] of longint;
   d	     : array[0..1010] of longint;
   min	     : array[0..1010] of longint;
   num	     : array[0..1010] of longint;
   v	     : array[0..1010] of boolean;
   ans1,ans2 : longint;
   m,n	     : longint;
procedure init;
var
   i	       : longint;
   xx,yy,zz,ww : longint;
begin
   ans1:=0;
   ans2:=0;
   readln(n,m);
   inc(n);
   fillchar(f,sizeof(f),0);
   fillchar(w,sizeof(w),0);
   for i:=1 to m do
   begin
      readln(xx,yy,ww);
      f[xx,yy]:=1;
      f[yy,xx]:=0;
      w[xx,yy]:=ww;
      w[yy,xx]:=0-ww;
   end;
   f[n-1,n]:=2;
   f[0,1]:=2;
   w[n-1,n]:=1;
   w[n,n-1]:=1;
   w[0,1]:=1;
   w[1,0]:=1;
end; { init }
function spfa(vo :longint ):boolean;
var
   head,tail : longint;
   now,i     : longint;
begin
   fillchar(v,sizeof(v),false);
   fillchar(num,sizeof(num),0);
   v[vo]:=true;
   for i:=0 to n do
   begin
      min[i]:=maxlongint>>2;
      d[i]:=maxlongint>>2;
   end;
   d[vo]:=0;
   head:=0;
   tail:=1;
   q[1]:=vo;
   while head<tail do
   begin
      inc(head);
      now:=q[head];
      v[now]:=false;
      for i:=0 to n do
	 if f[now,i]>0 then
	    if d[now]+w[now,i]<d[i] then
	    begin
	       pre[i]:=now;
	       d[i]:=d[now]+w[now,i];
	       if f[now,i]<min[now] then
		  min[i]:=f[now,i]
	       else
		  min[i]:=min[now];
	       if not v[i] then
	       begin
		  inc(tail);
		  q[tail]:=i;
		  v[i]:=true;
		  inc(num[i]);
	       end;
	       if num[i]>n then
	       begin
		  writeln('no solution');
		  halt;
	       end;
	    end;
   end;
   if d[n]=maxlongint>>2 then
      exit(false);
   now:=n;
   while now<>0 do
   begin
      dec(f[pre[now],now],min[n]);
      inc(f[now,pre[now]],min[n]);
      now:=pre[now];
   end;
   exit(true);
end; { spfa }
procedure main;
begin
   while spfa(0) do
   begin
      inc(ans1,min[n]);
      inc(ans2,min[n]*d[n]);
   end;
end; { main }
procedure print;
begin
   writeln(ans2-4);
end; { print }
begin
   init;
   main;
   print;
end.