function [ new_model ] = string_to_array( model )
%CALC 此处显示有关此函数的摘要
%   此处显示详细说明
% 字符串转化为对应的数组
% 数组中-1对应（，-2对应），-3表示OR，-4表示AND
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

