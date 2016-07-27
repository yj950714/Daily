function [ new_model ] = build( model , start , goal , p , solution)
%BUILD 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(model.mets);
m = length(model.rxns);
for i = 1 : 1 : n
    for j = 1 : 1 : m
        model.S(i,j) = model.S(i,j) * p(j);
    end;
end;
for i = 1 : 1 : m
    new_model.worth(i) = 1/abs(p(j));
end;
new_model.solution = solution;

d = zeros(m,m);
list = zeros(m);
for i = 1 : 1 : n
    now = 0;
    for j = 1 : 1 : m
        if model.S(i,j)<0
            now = now + 1;
            list(now) = j;
        end;
    end;
    for j = 1 : 1 : m
        if model.S(i,j)>0
            for k = 1 : 1 : now
                d(j,list(k)) = 1;
            end;
        end;
    end;
    disp(i);
end;
new_model.node_name = model.rxns;
new_model.d = d;
new_model.n = m;
new_model.start = start;
new_model.goal = goal;
end

