function [ new_graph ] = Tarjan( graph )
%TARJAN 此处显示有关此函数的摘要
%   此处显示详细说明
global dfn;
global low; 
global stack;
global top;
global instack;
global cnt;
global color_num;
global color;
dfn = zeros(1,graph.n);
low = zeros(1,graph.n);
color = zeros(1,graph.n);
stack = zeros(1,graph.n);
instack = zeros(1,graph.n);
cnt = 0;
top = 0;
color_num = 0;
for i = 1 : 1 : graph.n
    if dfn(i) == 0
        dfs(i,graph);
    end;
end;
new_graph = graph;
new_graph.color = color;
new_graph.new_n = color_num;
new_graph.new_d = zeros(color_num , color_num);
for i = 1 : 1 : graph.n
    for j = 1 : 1 : graph.n
        if (graph.d(i,j)>0)&&(color(i)~=color(j))
            new_graph.new_d(color(i),color(j)) = 1;
        end;
    end;
end;

end


