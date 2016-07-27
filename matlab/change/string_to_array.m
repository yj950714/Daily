function [ new_model ] = string_to_array( model )
%CALC �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% �ַ���ת��Ϊ��Ӧ������
% ������-1��Ӧ����-2��Ӧ����-3��ʾOR��-4��ʾAND
model.number_infix = zeros(length(model.grRules),150);
model.infix_long = zeros(length(model.grRules),1);
for i = 1 : 1 : length(model.grRules)
    expression = model.grRules{i};
    top  = 0;
    j = 1;
    len = length(expression);
    while (j<=len)
        if expression(j) == ' '
            j = j+1;
            continue;
        end
        if expression(j) == '('
            top = top+1;
            model.number_infix(i,top) = -1;
            j = j+1;
            continue;
        end
        if expression(j) == ')'
            top = top+1;
            model.number_infix(i,top) = -2;
            j = j+1;
            continue;
        end
        k = j;
        s = '';
        while (k <= len) && (expression(k) ~= ' ') && (expression(k) ~= ')')
            s = strcat(s , expression(k));
            k = k+1;
        end
        top = top+1;
        j = k;
        if strcmp(s , 'AND')
            model.number_infix(i,top) = -4;
        elseif strcmp(s , 'OR')
            model.number_infix(i,top) = -3;
        else
            model.number_infix(i,top) = find_gene_id(model , s);
        end
    end
    model.infix_long(i) = top;
end
new_model = model;
end

