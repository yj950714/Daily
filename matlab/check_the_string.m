function [ flag ] = check_the_string( s )
%CHECK_THE_STRING 此处显示有关此函数的摘要
%   此处显示详细说明
flag = 1;
for i=1:1:length(s);
    if s(i) == '(' || s(i) == ')' || s(i) == ' ';
        flag = 0;
    end;
end;

