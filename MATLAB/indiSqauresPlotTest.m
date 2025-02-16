function [] = indiSqauresPlotTest(blank)
    % Creates subplot of 64 individual segmented squares to test effectiveness of sqBounds functions
    im = imread(blank);
   
    board = squareOff(im);
    
    sqBounds = sqaureBounds(board);
    
    % Plot all 64 sqaure individually
    
    k = 1;
    for i = 1:8
        for j = 1:8
            sqaure = board([sqBounds(i,j,1):sqBounds(i,j,2)],[sqBounds(i,j,3):sqBounds(i,j,4)],:);
            figure(10)
            subplot(8,8,k)
            image(sqaure)
            
            k = k+1;
        end
    end


end