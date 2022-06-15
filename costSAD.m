%% SAD计算函数：对给定的两个块计算SAD值
function cost = costSAD(currentBlk,refBlk)
% Input
%       currentBlk : 当前块
%       refBlk : 参考块
% Output
%       cost : 两个块之间的误差代价（SAD）
    cost=sum(sum(abs(currentBlk-refBlk))); 
end