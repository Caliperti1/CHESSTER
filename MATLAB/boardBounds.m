function bounds = boardBounds(im)
    % ID edges of the board by starting at middle of sboel masked image and finding coordinate of first edge in each direction. trims matrix to be square with n-1 off that edge dimension.
    
    % Recommended Sobel threshold o .75 to .8 to ensure no mid edges
    % detected but maxmimum length of outer edges detected 
    
    % meant to be run on image on empty board
    % Apply sobel Mask at .75 tol 
    

    sob = sobelMask(im, .9999);

    % ID starting point for search (middle of image)
    sz = size(sob)
    midrow = round(sz(1)/2);
    midcol = round(sz(2)/2);
    
    %initialize edge counters at 0 
    left = 0;
    right = 0;
    top = 0;
    bot = 0;
    
    %initialize moves at 0
    moveleft = 0;
    moveright = 0;
    moveup = 0;
    movedown = 0;
    
    %start at center and continue moving one sqaure to left until edge is
    %found
    while moveleft ~= 255 
        
        moveleft = sob(midrow,midcol - left);
        left = left+1;
    end 
    
    %start at center and continue moving one sqaure to right until edge is
    %found
    while moveright ~= 255 
        
        moveright = sob(midrow,midcol + right);
        right = right+1;
    end 
    
    %start at center and continue moving one sqaure up until edge is
    %found
    while moveup ~= 255 
        
        moveup = sob(midrow - top, midcol);
        top = top+1;
    end 

    
    %start at center and continue moving one sqaure down until edge is
    %found
    while movedown ~= 255 
        
        movedown = sob(midrow + bot, midcol);
        bot = bot+1;
    end 
    
    
    % Turn cooindates in single vector 
    left = midcol - left;
    right = midcol + right;
    top = midrow - top;
    bot = midrow + bot;
    
    bounds = [top, bot, left, right]
end
