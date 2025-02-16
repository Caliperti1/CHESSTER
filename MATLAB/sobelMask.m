function sob = sobelMask(im, thresh)
% Sobel Mask - Finds edges and genertes an edge map image 

    %use greyScale function to normalzie values between 0 and 1
    gs = greyScale(im);
   
    % define Mask (3x3 matrix that will be used for convolution)
    maskX = [1 2 1; 0 0 0; -1 -2 -1];
    maskY = maskX';
    
    % Perform convolution of mask over image in X and Y 
    % 'same' parameter returns only center convolution matrix that is same
    % size as im
    H = conv2(double(gs), maskX, 'same');
    V = conv2(double(gs), maskY, 'same');
    
    % Find magnitude of convolutions
    E = sqrt(H.*H + V.*V);
    
    sob = uint8((E > thresh) * 255);
    
end 

