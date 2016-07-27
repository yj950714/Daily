function [ answer ] = SPFA( graph )
%BFS 此处显示有关此函数的摘要
%   此处显示详细说明
dist = zeros(1,graph.n);
for i = 1 : 1 : graph.n
    dist(i) = graph.n*2;
end;
v = zeros(1,graph.n);
q = zeros(1,graph.n+1);
pre = zeros(1,graph.n);

head = 0;
tail = 1;
q(1) = graph.start;
dist(graph.start) = 0;
v(graph.start) = 1;
while (head<tail)
    head = head + 1 ;
    now = q(head);
    v(now) = 0;
    for i = 1 : 1 : graph.n
        if (graph.d(now,i)>0)&&(dist(now)+graph.worth(i)<dist(i))
            dist(i) = dist(now)+graph.worth(i);
            pre(i) = now;
            if (v(i)==0)
                tail = tail + 1;
                q(tail) = i;
                v(i) = 1;
            end;
        end;
    end;
end;

len = 0;
now = graph.goal;
while now~=0
    len = len + 1 ;
    now = pre(now);
end;
answer = zeros(1,len);
tmp = len;
now = graph.goal;
while now~=0
    answer(tmp) = now;
    tmp = tmp - 1;
    now = pre(now);
end;

end

