function [ output ] = OR( a , b )
%MAX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
output = {(a{1}*a{2}+b{1}*b{2})/(a{2}+b{2}),a{2}+b{2}};
end

