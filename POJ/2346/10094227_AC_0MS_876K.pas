program pku2346(input,output);
var
	f:array[0..5,0..45] of int64;
	answer:array[0..11] of int64;
	n:longint;
	i,j,k:longint;
begin
	fillchar(f,sizeof(f),0);
	for i:=0 to 9 do
		f[1,i]:=1;
	for i:=1 to 5 do
		for j:=0 to 45 do
			if f[i-1,j]>0 then
			for k:=0 to 9 do
				if j+k<=45 then
					f[i,j+k]:=f[i,j+k]+f[i-1,j];
	answer[0]:=0;
	for i:=1 to 5 do
	begin	
		answer[i]:=0;
		for j:=0 to 45 do
			inc(answer[i],f[i,j]*f[i,j]);
	end;
	readln(n);
	writeln(answer[n>>1]);
end.