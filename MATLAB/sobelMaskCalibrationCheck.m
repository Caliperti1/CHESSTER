function [] = sobelMaskCalibrationCheck(blank)
% Generate 12 images of sobel mask at diferent thresholds. Useful for checking calibration or demonstrating how sobel mask algorithm works.
    im = imread(blank);
    
    threshs = [.1, .2, .3, .4, .5, .6, .7, .8, .9, .95, .99, .99999];
    
    sz = size(im);
    
    sob = zeros(sz(1), sz(2),length(threshs));
    
    for i = 1:length(threshs)
        sob(:,:,i) = sobelMask(im, threshs(i));
        
        figure(1)
        subplot(length(threshs)/4,length(threshs)/(length(threshs)/4),i)
        image(sob(:,:,i))
        title("Sobel Mask (threshhold = " + threshs(i) + ")")
        
    end 
end

% generate 12 images of sobel maskl at diferent thresholds 

