function [ rxns , s_d , s_n , from ] = build_re( model )
%BUILD 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(model.mets);
m = length(model.rxns);
from = zeros(1,m*2);
temp = m;
for i = 1 : 1 : m
    if (model.rev(i) == 1)
        temp = temp + 1;
        model.rxns(temp) = strcat('--',model.rxns(i));
        from(temp) = i;
        for j = 1 : 1 : n
            model.S(j , temp) = -model.S(j , i);
        end;
    end;
end;
m = temp;
d = zeros(m,m);
list = zeros(m);
for i = 1 : 1 : n
    now = 0;
    for j = 1 : 1 : m
        if model.S(i,j)<0
            now = now + 1;
            list(now) = j;
        end;
    end;
    for j = 1 : 1 : m
        if model.S(i,j)>0
            for k = 1 : 1 : now
                if ((from(j)~=list(k))&&(from(list(k))~=j))
                    d(j,list(k)) = 1;
                end;
            end;
        end;
    end;
end;
rxns = model.rxns;
s_n = m;
s_d = d;
end

