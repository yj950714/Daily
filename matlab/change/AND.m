function [ output ] = AND( a , b )
%AND 此处显示有关此函数的摘要
%   此处显示详细说明
output = {0,1};
if a{1} < b{1};
    output{1} = a{1};
else
    output{1} = b{1};
end;
end
