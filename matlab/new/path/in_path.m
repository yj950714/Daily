function [ bools ] = in_path( node , graph )
%IN_PATH �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
bools = 0;
for i = 1 : 1 : length(graph.path)
    if node==graph.path(i)
        bools = 1;
    end;
end;
end

