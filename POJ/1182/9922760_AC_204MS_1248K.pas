program pku1182(input,output);
var
   f,r			    : array[0..50000] of longint;
   i,n,p,x,y,a,b,ans,k,tr,t : longint;  
function find(i	: longint):longint;
var
   temp:longint;
begin
   if f[i]=i then
      exit(i);
   temp:=f[i];
   f[i]:=find(f[i]);
   r[i]:=(r[temp]+r[i]) mod 3;
   exit(f[i]);
end;
procedure union(x,y,h:longint);
var
   a,b:longint;
begin
   a:=find(x);
   b:=find(y);
   f[a]:=b;
   r[a]:=(r[y]+h-r[x]+3) mod 3;
end;
begin
   readln(n,k);
   for i:=1 to n do
      f[i]:=i;
   for i:=1 to k do
   begin
      readln(t,x,y);
      if (x>n)or(y>n) then
      begin
	 inc(ans);
	 continue;
      end;
      case t of
	1:if find(x)=find(y) then
	  begin
	     if r[x]<>r[y] then
		inc(ans)
	  end
	  else
	     union(x,y,0);
	2:begin
	     if x=y then
	     begin
		inc(ans);
		continue;
	     end;
	     if find(x)=find(y) then
	     begin
		if r[x]<>(r[y]+1) mod 3 then
		   inc(ans)
	     end
	     else
		union(x,y,1);
	  end;
      end;
   end;
   writeln(ans);
end.