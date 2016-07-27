program pku2299(input,output);
 var
    a,x	     : array[0..500100] of longint;
    n,answer : int64;
 procedure init;
 var
    i : longint;
 begin
    for i:=1 to n do
       readln(x[i]);
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
    writeln(answer);
 end; { print }
 begin
    readln(n);
    while n<>0 do
    begin
       init;
       merge(1,n);
       print;
       readln(n);
    end;
 end.