function [ flag ] = check_the_string( s )
%CHECK_THE_STRING �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
flag = 1;
for i=1:1:length(s);
    if s(i) == '(' || s(i) == ')' || s(i) == ' ';
        flag = 0;
    end;
end;

