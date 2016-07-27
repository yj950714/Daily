function [ tmp_expression ] = infix_to_postfix( model , position , start , goal )
%INFIX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
maxm = max(model.infix_long) + 10;
tmp_expression = zeros(maxm,1);
if start>goal
    return;
end
if start == goal
    tmp_expression(1) = model.number_infix(position , start);
    tmp_expression(maxm) = 1;
    return;
end
counter = 0;
i = goal;
while (i > start)
    if model.number_infix(position , i) == -2
        counter = counter + 1;
    elseif model.number_infix(position , i) == -1
        counter = counter - 1;
    end
    if ((model.number_infix(position , i) == -3) || (model.number_infix(position , i) == -4)) && counter == 0
        tmp_expression = infix_to_postfix(model , position , start , i-1);
        tmp = infix_to_postfix(model , position , i+1 , goal);
        for j = 1 : 1 : tmp(maxm)
            tmp_expression(tmp_expression(maxm)+j) = tmp(j);
        end
        tmp_expression(maxm) = tmp_expression(maxm)+tmp(maxm)+1;
        if (model.number_infix(position , i) == -3)
            tmp_expression(tmp_expression(maxm)) = -1; %-1��ʾOR����
        else
            tmp_expression(tmp_expression(maxm)) = -2; %-2��ʾAND����
        end
        return ;
    end
    i = i-1;
end
tmp_expression = infix_to_postfix(model , position , start+1 , goal-1);
end

