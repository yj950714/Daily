program hotel(input,output);
var
	head,tail:array[0..5000] of longint;
	limit,size,n,m:longint;
	can:array[0..61000] of boolean;
	bj,maxl,maxr,maxp,maxb:array[0..5000] of longint;
procedure build();
var
	i:longint;
begin
	limit:=trunc(sqrt(n+1));
	size:=(n+1) div limit;
	if ((n+1) mod limit=0) then
		dec(size);
	for i:=0 to size do
	begin
		head[i]:=i*limit;
		tail[i]:=(i+1)*limit-1;
	end;
	tail[size]:=n;
	for i:=0 to size do
	begin
		maxl[i]:=tail[i]-head[i]+1;
		maxr[i]:=tail[i]-head[i]+1;
		maxp[i]:=tail[i]-head[i]+1;
		maxb[i]:=head[i];
		bj[i]:=0;
	end;
end;{ build }
procedure init;
begin
	readln(n,m);
	dec(n);
	fillchar(can,sizeof(can),true);
	build();
end;{ init }
procedure update(now:longint);
var
	i,last:longint;
begin
	if bj[now]=1 then
	begin
		maxl[now]:=tail[now]-head[now]+1;
		maxr[now]:=tail[now]-head[now]+1;
		maxp[now]:=tail[now]-head[now]+1;
		maxb[now]:=head[now];
		exit;
	end;
	if bj[now]=-1 then
	begin
		maxl[now]:=0;
		maxr[now]:=0;
		maxp[now]:=0;
		maxb[now]:=head[now];
		exit;
	end;
	maxl[now]:=tail[now]-head[now]+1;
	for i:=head[now] to tail[now] do
		if not can[i] then
		begin
			maxl[now]:=i-head[now];
			break;
		end;
	maxr[now]:=tail[now]-head[now]+1;
	for i:=tail[now] downto head[now] do
		if (not can[i]) then
		begin
			maxr[now]:=tail[now]-i;
			break;
		end;
	last:=head[now];
	maxp[now]:=0;
	maxb[now]:=head[now];
	for i:=head[now] to tail[now] do
		if not can[i] then
		begin
			if i-last>maxp[now] then
			begin
				maxp[now]:=i-last;
				maxb[now]:=last;
			end;
			last:=i+1;
		end;
	if not can[last] then
		inc(last);
	if tail[now]+1-last>maxp[now] then
	begin
		maxp[now]:=tail[now]+1-last;
		maxb[now]:=last;
	end;
end;{ update }
procedure blank(l,r:longint);
var
	ll,rr,i:longint;
begin
	ll:=l div limit;
	rr:=r div limit;
	if bj[ll]<>0 then
	begin
		if bj[ll]=1 then
			for i:=head[ll] to tail[ll] do
				can[i]:=true
		else
			for i:=head[ll] to tail[ll] do
				can[i]:=false;
		bj[ll]:=0;
	end;
	if bj[rr]<>0 then
	begin
		if bj[rr]=1 then
			for i:=head[rr] to tail[rr] do
				can[i]:=true
		else
			for i:=head[rr] to tail[rr] do
				can[i]:=false;
		bj[rr]:=0;
	end;	
	if ll=rr then
	begin
		for i:=l to r do
			can[i]:=true;
		update(ll);
		exit;
	end;
	for i:=l to tail[ll] do
		can[i]:=true;
	update(ll);
	for i:=head[rr] to r do
		can[i]:=true;
	update(rr);
	for i:=ll+1 to rr-1 do
	begin
		bj[i]:=1;
		update(i);
	end;
end;{ blank }
procedure use(l,r:longint);
var
	ll,rr,i:longint;
begin
	ll:=l div limit;
	rr:=r div limit;
	if bj[ll]<>0 then
	begin
		if bj[ll]=1 then
			for i:=head[ll] to tail[ll] do
				can[i]:=true
		else
			for i:=head[ll] to tail[ll] do
				can[i]:=false;
		bj[ll]:=0;
	end;
	if bj[rr]<>0 then
	begin
		if bj[rr]=1 then
			for i:=head[rr] to tail[rr] do
				can[i]:=true
		else
			for i:=head[rr] to tail[rr] do
				can[i]:=false;
		bj[rr]:=0;
	end;	
	if ll=rr then
	begin
		for i:=l to r do
			can[i]:=false;
		update(ll);
		exit;
	end;
	for i:=l to tail[ll] do
		can[i]:=false;
	update(ll);
	for i:=head[rr] to r do
		can[i]:=false;
	update(rr);
	for i:=ll+1 to rr-1 do
	begin
		bj[i]:=-1;
		update(i);
	end;
end;{ use }
function find(l:longint):longint;
var
	i,sum,pp,now,ss:longint;
begin
	if maxp[0]>=l then
	begin
		find:=maxb[0];
		now:=head[0];
		while now<=tail[0] do
		begin
			ss:=0;
			while (can[now])and(now<=tail[0]) do
			begin
				inc(ss);
				inc(now);
			end;
			if ss>=l then
			begin
				find:=now-ss;
				break;
			end;
			inc(now);
		end;
		use(find,find+l-1);
		exit;
	end;
	sum:=maxr[0];
	pp:=tail[0]-maxr[0]+1;
	for i:=1 to size do
	begin
		if sum+maxl[i]>=l then
		begin
			find:=pp;
			use(pp,pp+l-1);
			exit;
		end
		else
		begin
			if maxp[i]>=l then
			begin
				find:=maxb[i];
				now:=head[i];
				while now<=tail[i] do
				begin
					ss:=0;
					while (can[now])and(now<=tail[i]) do
					begin
						inc(ss);
						inc(now);
					end;
					if ss>=l then
					begin
						find:=now-ss;
						break;
					end;
					inc(now);
				end;
				use(find,find+l-1);
				exit;
			end;
			if maxl[i]=tail[i]-head[i]+1 then
				sum:=sum+maxl[i]
			else
			begin
				pp:=tail[i]-maxr[i]+1;
				sum:=maxr[i];
			end;
		end;
	end;
	exit(-1);
end;{ find }
procedure main;
var
	i,xx,yy,ww:longint;
begin
	for i:=1 to m do
	begin
		read(xx);
		if xx=1 then
		begin
			readln(yy);
			writeln(find(yy)+1);
		end
		else
		begin
			readln(yy,ww);
			blank(yy-1,yy+ww-2);
		end;
	end;
end;{ main }
begin
	init;
	main;
end.