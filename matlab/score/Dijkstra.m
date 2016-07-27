function [ ans ] = Dijkstra( r , n ,start , goal)
%DIJKSTRA 此处显示有关此函数的摘要
%   此处显示详细说明
dist = zeros(1,n);
for i= 1 : 1 : n
    dist(i) = n;
end;
pre = zeros(1,n);
v = zeros(1,n);
dist(start) = r.worth(start);
for i=1 : 1 : n
    mind = n;
    minn = 0;
    for j=1 : 1 : n
        if (v(j)==0)&&(dist(j)<mind)
            mind = dist(j);
            minn = j;
        end;
    end;
    disp(minn);
    v(minn) = 1;
    for j=1 : 1 : n
        if ((v(j)==0)&&(r.map(minn,j)>0)&&(dist(minn)+r.worth(j)<dist(j)))
            dist(j) = dist(minn)+r.worth(j);
            pre(j) = minn;
        end;
    end;
end;
ans = dist(goal);
end

