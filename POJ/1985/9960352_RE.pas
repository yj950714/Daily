program pku1985(input,output);
type
   node	= ^link;
   link	= record 
	     goal,w : longint;
	     next   : node;
	  end;	    
var
   l   : array[0..5000] of node;
   d   : array[0..5000] of longint;
   v   : array[0..5000] of boolean;
   n,m : longint;
procedure add(xx,yy,ww :longint );
var
   tt : node;
begin
   new(tt);
   tt^.next:=l[xx];
   tt^.goal:=yy;
   tt^.w:=ww;
   l[xx]:=tt;
end; { add }
procedure init;
var
   i,xxx,yyy,www : longint;
begin
   readln(n,m);
   for i:=1 to n do
      l[i]:=nil;
   for i:=1 to m do
   begin
      readln(xxx,yyy,www);
      add(xxx,yyy,www);
      add(yyy,xxx,www);
   end;
end; { init }
procedure dfs(now,dist : longint );
var
   t : node;
begin
   d[now]:=dist;
   t:=l[now];
   while t<>nil do
   begin
      if not v[t^.goal] then
      begin
	 v[t^.goal]:=true;
	 dfs(t^.goal,dist+t^.w);
      end;
      t:=t^.next;
   end;
end; { dfs }
procedure main;
var
   i,maxn,maxl : longint;
begin
   fillchar(d,sizeof(d),0);
   fillchar(v,sizeof(v),false);
   v[1]:=true;
   dfs(1,0);
   maxl:=0;
   for i:=1 to n do
      if d[i]>maxl then
      begin
	 maxl:=d[i];
	 maxn:=i;
      end;
   fillchar(d,sizeof(d),0);
   fillchar(v,sizeof(v),false);
   v[maxn]:=true;
   dfs(maxn,0);
   maxl:=0;
   for i:=1 to n do
      if d[i]>maxl then
	 maxl:=d[i];
   writeln(maxl);
end; { main }
begin
   init;
   main;
end.