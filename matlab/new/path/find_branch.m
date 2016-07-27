function [ branch_from , branch_to ] = find_branch( graph )
%FIND_BRANCH 此处显示有关此函数的摘要
%   此处显示详细说明
branch = zeros(length(graph.solution),graph.s_n);
for t = 1 : 1 : length(graph.solution)
    dist = zeros(1,graph.s_n);
    for i = 1 : 1 : graph.s_n
        dist(i) = graph.s_n*2;
    end;
    v = zeros(1,graph.s_n);
    q = zeros(1,graph.s_n+1);
    pre = zeros(1,graph.s_n);
    head = 0;
    tail = 1;
    q(1) = graph.solution(t);
    dist(q(1)) = 0;
    v(q(1)) = 1;
    while head<tail
        head = head + 1;
        now = q(head);
        v(now) = 0;
        for i = 1 : 1 : graph.s_n
            if (graph.s_d(now,i)>0)&&(dist(now)+1<dist(i))
                dist(i) = dist(now)+1;
                pre(i) = now;
                if (v(i)==0)
                    tail = tail + 1;
                    q(tail) = i;
                    v(i) = 1;
                end;
            end;
        end;
    end;
    mind = graph.s_n*2;
    minn = -1;
    for i = 1 : 1 : length(graph.path)
        if dist(graph.path(i))+(length(graph.path)-i)<mind
            mind = dist(graph.path(i))+(length(graph.path)-i);
            minn = graph.path(i);
        end;
    end;
    if minn==-1
        branch(t,1) = -1;
        continue;
    end;
    now = minn;
    tmp = dist(now)+1;
    while now~=0
        branch(t,tmp) = now;
        tmp = tmp - 1;
        now = pre(now);
    end;
    tmp = dist(minn)+2;
    for i = 1 : 1 : length(graph.path)
        if minn==graph.path(i)
            break;
        end;
    end;
    for j = i+1 : 1 : length(graph.path)
        branch(t,tmp) = graph.path(j);
        tmp = tmp + 1;
    end;
end;
branch_from = branch;

for i = 1 : 1 : graph.s_n
    for j = 1 : 1 : i
        tmp = graph.s_d(i,j);
        graph.s_d(i,j) = graph.s_d(j,i);
        graph.s_d(j,i) = tmp;
    end;
end;
branch = zeros(length(graph.solution),graph.s_n);
for t = 1 : 1 : length(graph.solution)
    dist = zeros(1,graph.s_n);
    for i = 1 : 1 : graph.s_n
        dist(i) = graph.s_n*2;
    end;
    v = zeros(1,graph.s_n);
    q = zeros(1,graph.s_n+1);
    pre = zeros(1,graph.s_n);
    head = 0;
    tail = 1;
    q(1) = graph.solution(t);
    dist(q(1)) = 0;
    v(q(1)) = 1;
    while head<tail
        head = head + 1;
        now = q(head);
        v(now) = 0;
        for i = 1 : 1 : graph.s_n
            if (graph.s_d(now,i)>0)&&(dist(now)+1<dist(i))
                dist(i) = dist(now)+1;
                pre(i) = now;
                if (v(i)==0)
                    tail = tail + 1;
                    q(tail) = i;
                    v(i) = 1;
                end;
            end;
        end;
    end;
    mind = graph.s_n*2;
    minn = -1;
    for i = 1 : 1 : length(graph.path)
        if dist(graph.path(i))+(length(graph.path)-i)<mind
            mind = dist(graph.path(i))+(length(graph.path)-i);
            minn = graph.path(i);
        end;
    end;
    if minn==-1
        branch(t,1) = -1;
        continue;
    end;
    now = minn;
    tmp = 1;
    for i = 1 : 1 : length(graph.path)
        if graph.path(i) == minn
            break;
        end;
    end;
    for j = length(graph.path) : -1 : i+1
        branch(t,tmp) = graph.path(j);
        tmp = tmp + 1;
    end;
    while now~=0
        branch(t,tmp) = now;
        tmp = tmp + 1;
        now = pre(now);
    end;
end;
branch_to = branch;
end

