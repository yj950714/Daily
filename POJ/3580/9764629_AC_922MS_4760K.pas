program syj_splay;  
const
   maxn=100000+5;  
   oo=maxlongint shr 1;  
var
   n,root,task	      : longint;  
   a,son,l,r,b1,b2,mi : array[0..maxn+maxn]of longint;  
function min(x,y : longint):longint;  
begin
   if x<y then
      min:=x  
   else
      min:=y;  
end; { min }
procedure init;  
var
   i:longint;  
begin
   readln(n);  
   root:=n+2;  
   for i:=2 to n+1 do
   begin
      readln(a[i]);
      l[i]:=i-1;
      son[i]:=i;
      mi[i]:=a[i];  
   end;  
   l[n+2]:=n+1;
   son[1]:=1;
   son[n+2]:=n+2;
   mi[0]:=oo;
   mi[1]:=oo;
   mi[n+2]:=oo;
   a[1]:=oo;
   a[n+2]:=oo;  
   n:=n+2;  
end; { init }
procedure update(i:longint);  
begin
   son[i]:=son[l[i]]+son[r[i]]+1;  
   mi[i]:=min(min(mi[l[i]],mi[r[i]]),a[i]);  
end; { update }
procedure left(var i:longint);  
var
   j:longint;  
begin
   j:=r[i];
   r[i]:=l[j];
   l[j]:=i;  
   update(i);
   update(j);  
   i:=j;  
end; { left }
procedure right(var i:longint);  
var
   j:longint;  
begin
   j:=l[i];
   l[i]:=r[j];
   r[j]:=i;  
   update(i);
   update(j);  
   i:=j;  
end; { right }
procedure put1(i,j:longint);  
begin
   if i=0 then
      exit;  
   a[i]:=a[i]+j;
   mi[i]:=mi[i]+j;  
   b1[i]:=b1[i]+j;  
end; { put1 }
procedure put2(i:longint);  
var
   z:longint;  
begin
   if i=0 then
      exit;  
   z:=l[i];
   l[i]:=r[i];
   r[i]:=z;  
   b2[i]:=1-b2[i];  
end; { put2 }
procedure up(var i:longint;k:longint);  
begin
   if i=0 then
      exit;  
   if b1[i]>0 then
   begin
      put1(l[i],b1[i]);
      put1(r[i],b1[i]);  
      b1[i]:=0;  
   end;  
   if b2[i]>0 then
   begin
      put2(l[i]);
      put2(r[i]);  
      b2[i]:=0;  
   end;  
   if k<=son[l[i]] then
   begin
      up(l[i],k);
      right(i);  
   end
   else
      if k>son[l[i]]+1 then
      begin
	 up(r[i],k-son[l[i]]-1);
	 left(i);  
      end;  
end; { up }
procedure work;  
var i,j,k,kk,c,z:longint;  
   st:string;  
begin
   readln(task);  
   for task:=1 to task do
   begin
      readln(st);  
      while st[length(st)]=' ' do
	 delete(st,length(st),1);st:=st+' ';  
      if (st[1]='A') then
	 c:=1
      else
	 if (st[1]='R')and(st[4]='E') then
	    c:=2
	 else
	    if (st[1]='R')and(st[4]='O') then
	       c:=3
	    else
	       if (st[1]='I') then
		  c:=4
	       else
		  if (st[1]='D') then
		     c:=5
		  else
		     c:=6;  
      delete(st,1,pos(' ',st));  
      val(copy(st,1,pos(' ',st)-1),i,z);  
      delete(st,1,pos(' ',st));  
      if length(st)>1 then
      begin
	 val(copy(st,1,pos(' ',st)-1),j,z);  
	 delete(st,1,pos(' ',st));  
	 if length(st)>1 then
	    val(copy(st,1,length(st)-1),k,z);  
      end;  
      case c of
	1:begin
	     inc(i);inc(j);  
	     up(root,i-1);
	     up(root,j+1);  
	     put1(r[l[root]],k);  
	  end;  
	2:begin
	     inc(i);inc(j);  
	     up(root,i-1);
	     up(root,j+1);  
	     put2(r[l[root]]);  
	  end;  
	3:begin
	     inc(i);inc(j);  
	     up(root,i-1);
	     up(root,j+1);
	     k:=k mod (j-i+1);  
	     if k>0 then
	     begin
		kk:=r[l[root]];  
		up(kk,j-k-i+1);  
		up(r[kk],k);  
		z:=r[kk];
		r[z]:=kk;
		r[l[root]]:=z;
		r[kk]:=0;  
		update(r[z]);
		update(z);  
	     end;  
	  end;  
	4:begin
	     inc(i);  
	     inc(n);
	     a[n]:=j;
	     mi[n]:=j;
	     j:=n;  
	     up(root,i);
	     r[j]:=r[root];
	     r[root]:=j;  
	     update(j);
	     update(root);  
	  end;  
	5:begin
	     inc(i);  
	     up(root,i);  
	     up(r[root],1);  
	     l[r[root]]:=l[root];
	     root:=r[root];  
	     update(root);  
	  end;  
	6:begin
	     inc(i);inc(j);  
	     up(root,i-1);
	     up(root,j+1);  
	     writeln(mi[r[l[root]]]);  
	  end;  
      end;  
   end;  
end; { work }
begin 
   init;  
   work;   
end. 