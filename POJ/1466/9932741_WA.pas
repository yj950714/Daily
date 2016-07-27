program pku1466(input,output);
var
   f	  : array[0..1001,0..1001] of boolean;
   lk	  : array[0..1001] of longint;
   v	  : array[0..1001] of boolean;
   n	  : longint;
   answer : longint;
procedure init;
var
   s	       : ansistring;
   ch	       : char;
   i,j,x,y,sum : longint;
begin
   fillchar(f,sizeof(f),false);
   fillchar(lk,sizeof(lk),0);
   readln(n);
   for i:=1 to n do
   begin
      s:='';
      read(ch);
      while ch<>':' do
      begin
	 s:=s+ch;
	 read(ch);
      end;
      val(s,x);
      inc(x);
      while ch<>'(' do
	 read(ch);
      s:='';
      read(ch);
      while ch<>')' do
      begin
	 s:=s+ch;
	 read(ch);
      end;
      val(s,sum);
      for j:=1 to sum do
      begin
	 read(y);
	 inc(y);
	 f[x,y]:=true;
      end;
      readln;
   end;
end; { init }
function find(now :longint ):boolean;
var
   i : longint;
begin
   for i:=1 to n do
      if (not v[i])and(f[now,i]) then
      begin
	 v[i]:=true;
	 if (lk[i]=0)or(find(lk[i])) then
	 begin
	    lk[i]:=now;
	    exit(true);
	 end;
      end;
   exit(false);
end; { find }
procedure main;
var
   i : longint;
begin
   answer:=0;
   for i:=1 to n do
   begin
      fillchar(v,sizeof(v),false);
      if find(i) then
	 inc(answer);
   end;
   answer:=n-(answer>>1);
end; { main }
procedure print;
begin
   writeln(answer);
end; { print }
begin
   while not eof do
   begin
      init;
      main;
      print;
   end;
end.