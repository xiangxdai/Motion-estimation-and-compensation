%% 求具有最小绝对误差和值的函数：找出具有最小代价的块的下标
function [dx,dy] = minCost(costs)
% Input
%       costs : 包含当前宏块所有运动估计误差代价的SAD矩阵
% Output
%       dx : MV的垂直分量（行位移）
%       dy : MV的水平分量（列位移）

    minc = min(min(costs));
    [dx, dy] = find(costs == minc);
    dx = dx(1);
    dy = dy(1);    
end