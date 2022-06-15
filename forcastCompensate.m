%% 求预测帧的函数：由给定的运动矢量进行运动补偿计算预测帧
function imgCompensate = forcastCompensate(imgI, motionVect, mbSize)
% Input
%       imgI : 参考帧
%       motionVect : MV（dx为垂直分量，dy为水平分量）
%   	mbSize : MB尺寸
% Ouput
%   	imgComp : 运动补偿后的图像
    [row,col]=size(imgI);
    mb_cnt=1;
    for i = 1:mbSize:row-mbSize+1                
        for j = 1:mbSize:col-mbSize+1 
             ref_blk_row=i+motionVect(1,mb_cnt); %参考帧搜索块起始行
             ref_blk_col=j+motionVect(2,mb_cnt); %参考帧搜索块起始列
             imgCompensate(i:i+mbSize-1,j:j+mbSize-1)=imgI(ref_blk_row:ref_blk_row+mbSize-1,ref_blk_col:ref_blk_col+mbSize-1);   
             mb_cnt=mb_cnt+1;
        end
    end
end
