function [ new_model ] = pre_calc( model )
%PRE_CALC �˴���ʾ�йش˺���
%   �˴���ʾ��ϸ˵��
model = string_to_array(model);
postfix_expression = zeros(length(model.infix_long) , max(model.infix_long)+10);
postfix_long = zeros(length(model.infix_long) , 1);
for i= 1 : 1 : length(model.infix_long)
    tmp = infix_to_postfix(model , i , 1 , model.infix_long(i));
    postfix_long(i) = tmp(length(tmp));
    for j= 1 : 1 : postfix_long(i)
        postfix_expression(i,j) = tmp(j);
    end
    disp(i);
end
model.postfix_long = postfix_long;
model.postfix_expression = postfix_expression;
new_model = model;
end

