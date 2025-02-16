function [] = squareOffTestFig(blank)
% Generates figure to test effectiveness of calibration and square off 

    sobim = sobelMask(blank, 0.99999);
    
    board = squareOff(blank);
    
    
    figure(1)
    subplot(3,1,1)
    image(blank)
    subplot(3,1,2)
    image(sobim)
    subplot(3,1,3)
    image(board)


end
