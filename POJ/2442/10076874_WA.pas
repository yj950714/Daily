{为方便heap中存编号而不是具体值}
 program sequence(input,output);
 var
    a,b,pos : array[0..200000] of longint;
    heap       : array[0..200000] of longint;
    n,tot   : longint;
 procedure swap(var aa,bb: longint );
 var
    tt : longint;
 begin
    tt:=aa;
    aa:=bb;
    bb:=tt;
 end; { swap }
 procedure insect(poss :longint );
 var
    now : longint;
 begin
    inc(tot);
    heap[tot]:=poss;
    now:=tot;
    while (now<>1)and(a[heap[now]]+b[pos[heap[now]]]<a[heap[now>>1]]+b[pos[heap[now>>1]]]) do
    begin
       swap(heap[now],heap[now>>1]);
       now:=now>>1;
    end;
 end; { insect }
 procedure down(poss: longint );
 var
    now : longint;
 begin
    now:=poss;
    while (now<tot)and((a[heap[now]]+b[pos[heap[now]]]>a[heap[now<<1]]+b[pos[heap[now<<1]]])or(a[heap[now]]+b[pos[heap[now]]]>a[heap[now*2+1]]+b[pos[heap[now*2+1]]])) do
    begin
       if a[heap[now*2]]+b[pos[heap[now*2]]]<a[heap[now*2+1]]+b[pos[heap[now*2+1]]] then
       begin
      swap(heap[now],heap[now*2]);
      now:=now*2;
       end
       else
       begin
      swap(heap[now],heap[now*2+1]);
      now:=now*2+1;
       end;
    end;
 end; { down }
 procedure sort1(p,q :longint );
 var
    i,j,m : longint;
 begin
    i:=p;
    j:=q;
    m:=a[(i+j)>>1];
    repeat
       while a[i]<m do
      inc(i);
       while a[j]>m do
      dec(j);
       if i<=j then
       begin
      swap(a[i],a[j]);
      inc(i);
      dec(j);
       end;
    until i>j;
    if i<q then sort1(i,q);
    if j>p then sort1(p,j);
 end; { sort1 }
 procedure sort2(p,q :longint );
 var
    i,j,m : longint;
 begin
    i:=p;
    j:=q;
    m:=b[(i+j)>>1];
    repeat
       while b[i]<m do
      inc(i);
       while b[j]>m do
      dec(j);
       if i<=j then
       begin
      swap(b[i],b[j]);
      inc(i);
      dec(j);
       end;
    until i>j;
    if i<q then sort2(i,q);
    if j>p then sort2(p,j);
 end; { sort2 }
 procedure main;
 var
    i : longint;
 begin
    readln(n);
    fillchar(a,sizeof(a),63);
    fillchar(b,sizeof(b),63);
    for i:=1 to n do
       read(a[i]);
    readln;
    for i:=1 to n do
       read(b[i]);
    readln;
    for i:=1 to n do
       pos[i]:=1;
    tot:=0;
    sort1(1,n);
    sort2(1,n);
    for i:=1 to n do
       insect(i);
    for i:=1 to n do
    begin
       write(a[heap[1]]+b[pos[heap[1]]],' ');
       inc(pos[heap[1]]);
       down(1);
    end;
 end; { main }
 begin
    main;
 end.