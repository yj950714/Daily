
  var
  i,j,k,n,m,t,p,tmp:longint;
  a:array[0..100] of longint;
  ss,sum,max1,max2:longint;
  l:array[0..101] of longint;
procedure init;
  begin
    read(m,n);
  end;
function  dfs(i:longint):boolean;
  var
    ii,jj,min,kk:longint;
    flag:boolean;
  begin
    if i=n+1 then exit(true);
    for ii:=10 downto 1 do
     if a[ii]>0 then
       begin
         min:=maxlongint;
         for jj:=1 to m do
           if l[jj]<min then
             begin
               min:=l[jj];
               kk:=jj;
             end;
         if (l[kk]+ii>m) or (ii+kk-1>m) then continue;
         flag:=true;
         for jj:=kk to kk+ii-1 do
             if l[jj]>l[kk] then  flag:=false;
         if flag then
           begin
             dec(a[ii]);
             for jj:=kk to kk+ii-1 do
               l[jj]:=l[jj]+ii;
             if dfs(i+1) then exit(true);
             for jj:=kk to kk+ii-1 do
               l[jj]:=l[jj]-ii;
             inc(a[ii]);
           end;
       end;
     exit(false);
    end;
procedure main;
  begin
    fillchar(a,sizeof(a),0);
    fillchar(l,sizeof(l),0);
    max1:=0;
    max2:=0;
    sum:=0;
    for i:=1 to n do
      begin
        read(tmp);
        inc(a[tmp]);
        inc(sum,tmp*tmp);
        if tmp>max1 then
          begin
            max2:=max1;
            max1:=tmp;
          end
           else if tmp>max2 then
             max2:=tmp;

      end;
    if (sum<>m*m) or (m<max1+max2) then
      begin
        writeln('HUTUTU!');
        exit;
      end;
    if dfs(1) then writeln('KHOOOOB!')
     ELSE WRITELN('HUTUTU!');
  END;
begin
  readln(t);
  for p:=1 to t do
  begin
  init;
  main;
  end;
end.

