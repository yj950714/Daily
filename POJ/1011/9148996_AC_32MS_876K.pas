program goldd;
    type integer=longint;
    var gold:array[0..70] of integer;
        n,maxnum,sum,num,next:integer;
        flag:boolean;
        vis:array[0..70] of boolean;
    procedure swap(var x,y:integer);
        var p:integer;
    begin
      p:=x;
      x:=y;
      y:=p;
    end;
    procedure qs(f,r:integer);
        var i,j,x:integer;
    begin
      randomize;
      i:=f;
      j:=r;
      x:=gold[random(r-f+1)+f];
      repeat
        while gold[i]>x do
          inc(i);
        while gold[j]<x do
          dec(j);
        if i<=j then
          begin
            swap(gold[i],gold[j]);
            inc(i);
            dec(j);
          end;
      until i>j;
      if f<j then qs(f,j);
      if i<r then qs(i,r);
    end;
    procedure dfs(which,had,length,pos:integer);
        var i,j,temp:integer;
    begin
      if (which=num) and (had=length) then
        begin
          flag:=true;
          exit;
        end;
      if had=length then
        begin
          inc(which);
          had:=0;
          pos:=2;
        end;
      temp:=0;
      if flag=false then
        begin
          for i:=pos to n do
            if (not vis[i]) and (had+gold[i]<=length) and (gold[i]<>temp) then
              begin
                vis[i]:=true;
                dfs(which,had+gold[i],length,i+1);
                vis[i]:=false;
                temp:=gold[i];
                if (had=0) then
                  exit;
              end;
        end;
    end;
    procedure deal;
        var i,j,temp:integer;
            flagg:boolean;
    begin
      flag:=false;
      flagg:=false;
      for i:=gold[1] to (sum div 2) do
        if sum mod i=0 then
          begin
            fillchar(vis,sizeof(vis),0);
            num:=sum div i;
            vis[1]:=true;
            next:=2;
            dfs(1,gold[1],i,next);
            if flag=true then
              begin
                flagg:=true;
                temp:=i;
              end;
            if flagg=true then
              break;
          end;
      if flagg=true then
        writeln(temp)
      else
        writeln(sum);
    end;
    procedure init;
        var i,j:integer;
    begin
      while not eof do
        begin
          readln(n);
          if n=0 then exit;
          sum:=0;
          for i:=1 to n do
            begin
              read(gold[i]);
              inc(sum,gold[i]);
            end;
          qs(1,n);
          deal;
        end;
    end;
begin
  //assign(input,'loongau.in');reset(input);
  //assign(output,'loongau.out');rewrite(output);
  init;
  //close(input);
  //close(output);
end.