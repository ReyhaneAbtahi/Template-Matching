function output = Find(I, Threshold)

    result = 0;
    for i=1:9
        for j=1:4
            tempName = ['/home/reyhane/Desktop/Iut/ComputerVision/PDFs/CV_HW_02/Q_3_Templates/temp' num2str(i) '_' num2str(j) '.png'];
            T = imread(tempName);

            templateWidth = size(T,1);
            templateHeight = size(T,2);

            channelToCorrelate = 2;  
            correlationOutput = normxcorr2(T(:,:,channelToCorrelate), I(:,:, channelToCorrelate));

            for k=1:5
                [maxCorrValue, maxIndex] = max(abs(correlationOutput(:)));

                if maxCorrValue >= Threshold
                    [yPeak, xPeak] = ind2sub(size(correlationOutput),maxIndex(1));
                    corr_offset = [(xPeak-size(T,2)) (yPeak-size(T,1))];
                    correlationOutput(yPeak-round(templateWidth/2):yPeak+round(templateWidth/2), xPeak-round(templateHeight/2):xPeak+round(templateHeight/2), :) = 0;

                    MatchBox = I(corr_offset(2):corr_offset(2)+templateWidth, corr_offset(1):corr_offset(1)+templateHeight, :);
                    color = sum(sum(MatchBox ~= 255 & MatchBox ~= 0));

                    if color(1,1,1) == max(color)
                        result = result + i;
                    elseif color(1,1,3) == max(color)
                        result = result - i;
                    end
                    I(corr_offset(2):corr_offset(2)+templateWidth, corr_offset(1):corr_offset(1)+templateHeight, :) = 0;
                end
            end
        end
    end
    output = result;
end
