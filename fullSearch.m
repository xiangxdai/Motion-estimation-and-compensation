%% 全搜索算法：Full Search/Exhaustive Search
function [motionVect,blk_center,counter, tStop] = fullSearch(imgP, imgI, mbSize, wind)
% Input
%   	img : 当前帧
%   	imgI : 参考帧
%   	mbSize : MB尺寸
%   	wind : 搜索窗口大小（2wind+1）×（2wind+1）
% Ouput
%   	motionVect : 整像素精度MV
%   	blk_center：中心点坐标
%       counter：搜索次数
%       tStop：搜索运行时间
    [row, col] = size(imgP);
    blk_center = zeros(2, row*col/(mbSize^2)); 
    %定义每个宏块中心点位置
    motionVect = zeros(2,row*col/(mbSize^2)); %定义每个宏块运动矢量
    costs = ones(2*wind+1,2*wind+1)*100000;
    counter = 0; %搜索的点数之和
    mb_cnt= 1;
    tic; 
    for i = 1:mbSize:row-mbSize+1     %当前帧起始行搜索范围，步长是块数 
        for j = 1:mbSize:col-mbSize+1 %当前帧起始列搜索范围，步长是块数
            for m= -wind: wind
                for n= -wind: wind
                    ref_blk_row = i+m; %参考帧搜索框起始行
                    ref_blk_col = j+n; %参考帧搜索框起始列
                    %超出搜索范围
                    if (ref_blk_row<1||ref_blk_row+mbSize-1>row||ref_blk_col<1||ref_blk_col+mbSize-1>col)                     
                        continue;                                                            
                    end
                    %计算SAD
                    costs(m+wind+1,n+wind+1) =...
                        costSAD(imgP(i:i+mbSize-1,j:j+mbSize-1),imgI(ref_blk_row:ref_blk_row+mbSize-1,ref_blk_col:ref_blk_col+mbSize-1));
                    counter = counter+1;
                end
            end
      
            blk_center(1,mb_cnt) = i+ mbSize/2-1; %记录中心点行坐标                     
            blk_center(2,mb_cnt) = j+ mbSize/2-1; %记录中心点列坐标
            [dx,dy]=minCost(costs); %找出有最小代价的块的下标
            motionVect(1,mb_cnt) = dx-wind-1; %垂直运动矢量
            motionVect(2,mb_cnt) = dy-wind-1; %水平运动矢量
            mb_cnt = mb_cnt+1;
            costs = ones(2*wind+1,2*wind+1)*100000; %重新赋值
         end
    end 
    tStop = toc;  
 
end