function [ path ] = SFPA( graph )
%SFPA 此处显示有关此函数的摘要
%   此处显示详细说明
q = zeros(1 , 200000);
dist = zeros(1 , graph.n);
for i = 1 : 1 : graph.n
    dist(i) = 2147482647;
end;
c = zeros(graph.n , graph.n);
v = zeros(1 , graph.n);
pre = zeros(1 , graph.n);
head = 0;
tail = 1;
dist(graph.start) = 0;
q(1) = graph.start;
v(graph.start) = 1;
c(graph.start,graph.start) = 1;
while head<tail
    head = head + 1;
    now = q(head);
    v(now) = 0;
    for i = 1 : 1 : graph.n
        if (graph.d(now,i)>0)&&(dist(now)+graph.worth(i)<dist(i))&&(c(now,i)==0)
            dist(i) = dist(now) + graph.worth(i);
            pre(i) = now;
            for j = 1 : 1 : graph.n
                c(i,j) = c(now,j);
            end;
            c(i,i) = 1;
            if v(i)==0
                tail = tail + 1;
                q(tail) = i;
                v(i) = 1;
            end;
        end;
    end;
    disp(tail);
end;
disp(dist(graph.goal));
now = graph.goal;
while now~=0
    disp(now);
    now = pre(now);
end;
end

