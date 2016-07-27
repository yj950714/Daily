program pku1298(input,output);
var
   s    :ansistring;
   i,tmp:longint;
begin
   readln(s);
   while s<>'ENDOFINPUT' do
   begin
        if (s='START')or(s='END') then
        begin
                readln(s);
                continue;
        end;
        for i:=1 to length(s) do
        if s[i] in ['A'..'Z'] then
        begin
                tmp:=ord(s[i])-ord('A')+1;
                tmp:=(tmp+20)mod 26+1;
                s[i]:=chr(tmp+ord('A')-1); 
        end;
        writeln(s);
        readln(s);
   end;
end.
