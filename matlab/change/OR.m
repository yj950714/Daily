function [ output ] = OR( a , b )
%MAX 此处显示有关此函数的摘要
%   此处显示详细说明
output = {(a{1}*a{2}+b{1}*b{2})/(a{2}+b{2}),a{2}+b{2}};
end

