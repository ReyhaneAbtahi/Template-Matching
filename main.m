clear; clc; close all
MyResult = zeros(1,100);
TrueResult = zeros(1,100);

PSNR = zeros(1,100);

position = [350 760];

percentage = 0;

for c = 1:100
    baseDir = '/home/reyhane/Desktop/Iut/ComputerVision/PDFs/CV_HW_02/Q_3';
    fileName = ['Image_' num2str(c) '_*.png'];
    files = dir(fullfile(baseDir, fileName));
    fullName = fullfile(baseDir, files(1).name);
    
    last_ = strfind(fullName, '_');
    TrueResult(c) = str2num(fullName(last_(end)+1:end-4));

    Original = im2double(imread(fullName));

    R = Original(:,:,1);
    G = Original(:,:,2);
    B = Original(:,:,3);

    R = medfilt2(R, [3 3]);
    G = medfilt2(G, [3 3]);
    B = medfilt2(B, [3 3]);

    Final = cat(3, R, G, B);
    
    if PSNR(c) >= 8
        MyResult(c) = Find(Final, 0.85);
    elseif PSNR(c) < 8 && PSNR(c) >= 7
        MyResult(c) = Find(Final, 0.8);
    elseif PSNR(c) < 7 && PSNR(c) >= 6
        MyResult(c) = Find(Final, 0.75);
    else
        MyResult(c) = Find(Final, 0.68);
    end    
    if MyResult(c) == TrueResult(c)
       percentage = percentage + 1;
    end
    
    RGB = insertText(Original,position,num2str(MyResult(c)),'FontSize',20,'BoxColor','white','BoxOpacity',0.4,'TextColor','green');
    
    writeName = replace(fullName, "Q_3", "Q_3_Answers");
    imwrite(RGB, writeName);

end

percentage = (percentage/c)*100;

   