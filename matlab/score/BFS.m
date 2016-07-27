function [ solution ] = BFS( c , r  )
%BFS 此处显示有关此函数的摘要
%   此处显示详细说明
n = c.node_num;
q = zeros(1,200000);
in_road = zeros(1,n);
pre = zeros(1,n);
for i= 1 : 1 : r.road_length
    if r.change(i)>0
        in_road(r.road(i)) = 1;
    end;
end;
solution.in_road = in_road;
solution.road = r.road;
solution.road_length = r.road_length;
solution.branch=zeros(n);
solution.branch_length = zeros(1,n);
length = zeros(1,n);
for i= 1 : 1 : n
    length(i) = n;
end;
for i= 1 : 1 : r.road_length
    head = 0;
    tail = 1;
    v = zeros(1,n);
    length(r.road(i))=0;
    q(1) = r.road(i);
    v(r.road(i)) = 1;
    while head<tail
        head = head+1;
        now = q(head);
        for j= 1 : 1 : n
            if (c.map(now,j)+c.map(j,now)>0)&&(length(now)+1<length(j))&&(v(j)==0)&&(in_road(j)==0)
                length(j) = length(now)+1;
                pre(j) = now;
                tail = tail+1;
                q(tail) = j;
                v(j) = 1;
            end;
        end;
    end;
end;
for i= 1 : 1 : n 
    if (in_road(i)==0)&&(c.worth(i)>0)
        now = i;
        temp = 0;
        while now>0
            temp = temp+1;
            solution.branch(i,temp) = now;
            now= pre(now);
        end;
        solution.branch_length(i) = temp-1;
    end;
end;
end

