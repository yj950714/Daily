function [ bools ] = in_path( node , graph )
%IN_PATH 此处显示有关此函数的摘要
%   此处显示详细说明
bools = 0;
for i = 1 : 1 : length(graph.path)
    if node==graph.path(i)
        bools = 1;
    end;
end;
end

