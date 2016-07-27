program connon(input,output);
	var g:array[1..200,1..200] of longint;
	    ff:array[1..200,1..200] of longint;
	    f:array[1..200,1..200,1..200] of longint;
	    a:array[1..200,1..15] of char;
	    d:array[1..200] of longint;
	    i,j,k,l,maxn,m,n,tot,sum,ans:longint;
	procedure init;
	begin
	  readln(n,m);
	  for i:=1 to n do
	  begin
	   for j:=1 to m do
	    read(a[i,j]);
	   readln;
	  end;
	  fillchar(f,sizeof(f),0);
	end;
	function max(x,y:longint):longint;
	begin
	  if x>y then
	   exit(x)
	  else
	   exit(y);
	end;
	procedure dfs(x:longint);
	begin
	  if x>m then
	   begin
	    inc(tot);
	    g[i,tot]:=sum;
	    ff[i,tot]:=ans;
	    d[i]:=tot;
	    exit;
	   end;
	  if a[i,x]='P' then
	   begin
	    sum:=sum+1<<(x-1);
	    inc(ans);
	    dfs(x+3);
	    sum:=sum-1<<(x-1);
	    dec(ans);
	   end;
	  dfs(x+1);
	end;
	procedure make;
	begin
	  for i:=1 to d[2] do
	   for j:=1 to d[1] do
	   if  (g[1,j] and g[2,i]=0) then
	    f[2,i,j]:=ff[2,i]+ff[1,j];
	end;
	procedure dp;
	begin
	  for i:=3 to n do
	   for j:=1 to d[i] do
	    for k:=1 to d[i-1] do
	     for l:=1 to d[i-2] do
	      if (g[i,j] and g[i-1,k]=0) then
	       if (g[i,j] and g[i-2,l]=0) then
	        if (g[i-1,k] and g[i-2,l]=0) then
	         f[i,j,k]:=max(f[i,j,k],f[i-1,k,l]+ff[i,j]);
	end;
	procedure choose;
	var i,j,k:longint;
	begin
	   maxn:=-(maxlongint>>1);
	   for i:=1 to d[n] do
	    for j:=1 to d[n-1] do
	     if f[n,i,j]>maxn then
	      maxn:=f[n,i,j];
	end;
	procedure print;
	begin
	  writeln(maxn);
        end;
	begin
	 
	  init;
	  for i:=1 to n do
	  begin
	   tot:=0;
	   sum:=0;
	   ans:=0;
           dfs(1);
	  end;
	  make;
	  dp;
	  choose;
	  print;
	 
	end.