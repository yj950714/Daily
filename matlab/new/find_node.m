function [ number ] = find_node( model , name )
%FIND_NODE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
number = -1;
for i = 1 : 1 : model.n
    if strcmp(model.node_name(i),name)
        number = i;
        break;
    end;
end;
end

