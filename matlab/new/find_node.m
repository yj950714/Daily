function [ number ] = find_node( model , name )
%FIND_NODE 此处显示有关此函数的摘要
%   此处显示详细说明
number = -1;
for i = 1 : 1 : model.n
    if strcmp(model.node_name(i),name)
        number = i;
        break;
    end;
end;
end

