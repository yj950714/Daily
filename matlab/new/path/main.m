function [ answer ] = main( model , start , goal , p , solution )
%MAIN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
graph = build(model , start , goal , p , solution);
[graph.rxns , graph.s_d , graph.s_n , graph.from ] = build_re(m);
graph.path = SPFA(graph);
[graph.branch_from , graph.branch_to] = find_branch(graph);
[graph.path_name , graph.branch_from_name , graph.branch_to_name] = change_to_name(graph);
answer = graph;
end

