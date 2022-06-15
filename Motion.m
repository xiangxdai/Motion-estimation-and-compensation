clc;clear %格式化

mbSize = 8;      % 块尺寸为8*8
wind = 5;			  % 匹配次数为(2wind+1)*(2wind+1)

imgI = imread('18.png');     % 定义参考帧
img = imread('20.png');      % 定义当前帧
subplot(341); imshow(imgI); title('参考帧');
subplot(342); imshow(img); title('当前帧');

%转为灰色图像
imgI = double(rgb2gray(imgI));
img = double(rgb2gray(img));


%基于块的全搜索算法 
[motionVect, blk_center,counter,t1] = fullSearch(img, imgI, mbSize, wind); 

subplot(345); imshow(uint8(img)); title('FS运动矢量图'); hold on
% 参考帧指向当前帧
%将图像序列的每一帧分成许多互不重叠的宏块，
%对每个宏块到参考帧某一给定特定搜索范围内根据一定的匹配准则找出与之最相似的匹配块
%两者间的相对位移即为运动矢量
y = blk_center(1, : );
x = blk_center(2, : );
v = -motionVect(1, : );
u = -motionVect(2, : ); 
quiver(x, y, u, v, 'g');
hold on

%运动补偿后的图像：根据运动矢量计算预测帧，并传输残差帧
%通过先前的局部图像和运动矢量来预测、补偿当前的局部图像
imgComp = forcastCompensate(imgI, motionVect, mbSize); 

subplot(346); imshow(uint8(imgComp));
title('FS预测帧');
 
imgErr = img - imgComp; %残差帧
cal = Calibration(imgErr); %标定
subplot(347); imshow(cal); title('FS残差帧');
 
%根据运动矢量指明的位置及残差帧重建图像
rebuild = imgComp + imgErr; 
subplot(348); imshow(uint8(rebuild)); title('FS重建帧');

fprintf('匹配准则是绝对误差和，\t块大小是%d，\t搜索范围w大小是%d\n',mbSize,wind)
fprintf('全搜索的搜索次数是%d，\t搜索时间是%6.8f s\n',counter,t1)


%基于块的三步法搜索算法 
[motionVect1, blk_center1,counter1,t2] = TSSearch(img, imgI, mbSize, wind);  

subplot(349); imshow(uint8(img)); title('TSS运动矢量图'); hold on
% 参考帧指向当前帧
y1 = blk_center1(1, : );
x1 = blk_center1(2, : );
v1 = -motionVect1(1, : );
u1 = -motionVect1(2, : ); 
quiver(x, y, u, v, 'g');
hold on

%运动补偿后的图像：根据运动矢量计算预测帧，并传输残差帧
imgComp1 = forcastCompensate(imgI, motionVect1, mbSize); 

subplot(3,4,10); imshow(uint8(imgComp1));
title('TSS预测帧');
 
imgErr1 = img - imgComp1; %残差帧
cal1 = Calibration(imgErr1); %标定
subplot(3,4,11); imshow(cal1); title('TSS残差帧');
 
%根据运动矢量指明的位置及残差帧重建图像
rebuild1 = imgComp1 + imgErr1; 
subplot(3,4,12); imshow(uint8(rebuild1)); title('TSS重建帧');

fprintf('三步法搜索的搜索次数是%d，\t搜索时间是%6.8f s\n',counter1,t2)





