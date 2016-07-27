program merge_sort(input,output);
var
   a,x	    : array[0..2000] of longint;
   n,answer : longint;
   cases,v  : longint;
procedure init;
var
   i : longint;
begin
   read(n);
   for i:=1 to n do
      read(x[i]);
   readln;
   answer:=0;
end; { init }
procedure merge(p,q : longint);
var
   mid,i,j,pos : longint;
begin
   if p>=q then exit;
   mid:=(p+q)>>1;
   merge(p,mid);
   merge(mid+1,q);
   i:=p;
   j:=mid+1;
   pos:=p;
   while (i<=mid)and(j<=q) do
   begin
      if x[i]>x[j] then
      begin
	 a[pos]:=x[j];
	 inc(answer,mid-i+1);
	 inc(pos);
	 inc(j);
	 continue;
      end
      else
      begin
	 a[pos]:=x[i];
	 inc(pos);
	 inc(i);
	 continue;
      end;
   end;
   while i<=mid do
   begin
      a[pos]:=x[i];
      inc(pos);
      inc(i);
   end;
   while j<=q do
   begin
      a[pos]:=x[j];
      inc(pos);
      inc(j);
   end;
   for i:=p to q do
      x[i]:=a[i];
end; { merge }
procedure print;
begin
   writeln('Scenario #',v,':');
   writeln(answer);
   writeln;
end; { print }
begin
   readln(cases);
   for v:=1 to cases do
   begin
      init;
      merge(1,n);
      print;
   end;
end.