function [ name1 , name2 ,name3 ] = change_to_name( graph )
%CHANGE_TO_NAME 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1 : 1 : length(graph.path)
    name1(i) = graph.rxns(graph.path(i));
for i = 1 : 1 : length(graph.solution)
    for j = 1 : 1 : graph.s_n
        if graph.branch_from(i,j)<=0
            break;
        end;
        name2(i,j) = graph.rxns(graph.branch_from(i,j));
    end;
end;

for i = 1 : 1 : length(graph.solution)
    for j = 1 : 1 : graph.s_n
        if graph.branch_to(i,j)<=0
            break;
        end;
        name3(i,j) = graph.rxns(graph.branch_to(i,j));
    end;
end;


end

