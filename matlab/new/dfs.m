function [ temp ] = dfs( now , graph )
%DFS 此处显示有关此函数的摘要
%   此处显示详细说明
global dfn;
global low; 
global stack;
global top;
global instack;
global cnt;
global color_num;
global color;
cnt = cnt + 1;
dfn(now) = cnt;
low(now) = cnt;
top = top +1;
stack(top) = now;
instack(now) = 1;
for i = 1 : 1 : graph.n
    if (graph.d(now,i)>0)&&(dfn(i) == 0)
        dfs(i , graph);
        if low(i)<low(now)
            low(now) = low(i);
        end;
    elseif ((graph.d(now,i)>0)&&(instack(i) == 1)&&(dfn(i)<low(now)))
        low(now) = dfn(i);
    end;
end;
if dfn(now)==low(now)
    color_num = color_num + 1;
    while true
        color(stack(top)) = color_num;
        instack(stack(top)) = 0;
        top = top -1;
        if stack(top+1) == now
            break;
        end;
    end;
end;

end

