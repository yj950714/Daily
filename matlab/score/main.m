function [ outs ] = main( matrix,n,m,solution,p,start,goal )
%MAIN 此处显示有关此函数的摘要
%   matrix表示流平衡之后的化学计量矩阵
% n表示反应物数量，m表示反应数量，每列为一个反应
% solution为一个0,1的一维数组，第i位为1表示第i个反应物受到了调控（产量提升/下降）
%start为起始反应物（葡萄糖）对应的反应物编号，goal为目标反应物对应的反应物编号
c = build(matrix,n,m,solution,p,start,goal);
r = SPFA(c);
outs = BFS(c,r);
% outs输出中in_road表示第i个受改造影响的反应物是否在主路径上（1表示在）
% road表示主路径一次经过的反应物节点编号
% road_length表示主路径的长度
% branch_length为一维数组，第i位为0的话表示i节点不是一个改造的反应物节点或者是改造的节点但是已经在主路径上了
% branch_length中第i位不为0，说明i节点是非主路径上的改造节点，这里的值表示了该节点到主路径的最短距离
% branch与branch_length相对应，对应其中非主路径改造节点到主路径的路径。
end

