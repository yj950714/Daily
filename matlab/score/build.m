function [ answer ] = build( matrix,n,m,solution,p,start,goal )
%BUILD 此处显示有关此函数的摘要

answer.map=zeros(m);
answer.worth=zeros(1,m);
answer.node_num = m;
answer.start = start;
answer.goal = goal;
for i=1 : 1 : m
    if (solution(i)>0)
        answer.worth(i) = 1000;
    else
        answer.worth(i) = -2;
    end;
end;
 
for i= 1 : 1 : n
    for j= 1 : 1 : m
        matrix(i,j) = matrix(i,j) * p(j);
    end;
end;

for i= 1 : 1 : n
    num = 0;
    temp = zeros(1,m);
    for j=1 : 1 : m
        if matrix(i,j)>0
            num = num +1;
            temp(num) = j;
        end;
    end;
    for j=1 : 1 : m
        if matrix(i,j)<0
            for k=1 : 1 : num
                answer.map(temp(k),j) = 1;
            end;
        end;
    end;
end;
end

