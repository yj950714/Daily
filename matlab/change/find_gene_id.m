function [ position ] = find_gene_id( model , gene_name )
%FIND_GENG_ID 此处显示有关此函数的摘要
%   此处显示详细说明
position = -1;
for i = 1 : 1 : length(model.genes)
    if strcmp(gene_name , model.genes(i))
        position = i;
        return;
    end
end
end