function [ answer ] = calc_postfix( model , position )
%CALC_POSTFIX 此处显示有关此函数的摘要
%   此处显示详细说明
stack = zeros(model.postfix_long(position) , 2);
top = 0;
answer = {0,1};
for i=1 : 1 : model.postfix_long(position)
    if model.postfix_expression(position,i)>=0
        top = top+1;
        stack(top,1) = model.postfix_expression(position,i);
        stack(top,2) = 1;
    elseif model.postfix_expression(position,i) == -1
        top = top-2;
        tmp = OR({stack(top+1,1),stack(top+1,2)},{stack(top+2,1),stack(top+2,2)});
        top = top+1;
        stack(top,1) = tmp{1};
        stack(top,2) = tmp{2};
    elseif  model.postfix_expression(position,i) == -2
        top = top-2;
        tmp = AND({stack(top+1,1),stack(top+1,2)},{stack(top+2,1),stack(top+2,2)});
        top = top+1;
        stack(top,1) = tmp{1};
        stack(top,2) = tmp{2};
    end
    disp(top);
    disp(stack);
end
if top == 1
    answer = {stack(1,1),stack(1,2)};
end

