function [ solution ] = SPFA( r  )
%SPFA 此处显示有关此函数的摘要
%   此处显示详细说明
n = r.node_num;
start = r.start;
goal = r.goal;
dist = zeros(1,n);
for i= 1 : 1 : n
    dist(i) = -65536;
end;
pre = zeros(1,n);
v = zeros(1,n);
q = zeros(1,200000);
head = 0;
tail = 1;
q(1)=start;
v(start) = 1;
dist(start) = r.worth(start);
while (head<tail)
    head = head+1;
    now = q(head);
    for i= 1 : 1 : n
        if (r.map(now,i)>0)&&(dist(now)+r.worth(i)>dist(i))
            dist(i) = dist(now)+r.worth(i);
            pre(i) = now;
            if v(i)==0
                tail = tail +1;
                q(tail) = i;
                v(i) = 1;
            end;
        end;
    end;
end;
solution.dist = dist;
solution.road = zeros(1,n);
now = goal;
temp = 0;
while now>0
    temp = temp+1;
    solution.road(temp) = now;
    now = pre(now);
end;
for i= 1 : 1 : temp/2
    now = solution.road(i);
    solution.road(i) = solution.road(temp-i+1);
    solution.road(temp-i+1) = now;
end;
solution.road_length = temp;
solution.change = zeros(1,temp);
for i= 1 : 1 : temp
    if r.worth(solution.road(i))==1000
        solution.change(i) = 1;
    end;
end;
end

