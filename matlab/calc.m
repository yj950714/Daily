function [ answer ] = calc( model ,expression )
%CALC expressionΪ�ַ�����ʽ
%   �˴���ʾ��ϸ˵��
answer = {-1,0};
if check_the_string(expression);
    answer = get_the_real_worth(model , expression);
else
    expression = strtrim(expression); %ȥ��ǰ��ո��Է���һ
    len = length(expression);
    counter = 0;
    temp = '';
    i = 1;
    while (i <= len);
        if expression(i) == '(';
            counter = counter + 1;
        end;
        if expression(i) == ')';
            counter = counter - 1;
        end
        if expression(i) == ' ' && counter == 0;
            operator = '';
            tail_point = i-1;
            i = i+1;
            while (expression(i) ~= ' ');
                operator = strcat(operator , expression(i));
                i = i+1;
            end
            if strcmp(operator , 'OR');
                answer = OR(calc(model , expression(1:tail_point)) , calc(model , expression(i+1:len)));
                return;
            end;
            if strcmp(operator , 'AND');
                answer = AND(calc(model , expression(1:tail_point)) , calc(model , expression(i+1:len)));
                return;
            end;
        end;
        i = i+1;
    end
    if answer{1} == -1;
        answer = calc(model , expression(2:len-1));
    end;
end;
end
