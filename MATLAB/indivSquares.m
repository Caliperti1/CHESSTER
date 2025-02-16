function indi = indivSquares(SQ)
% NOT USED

    sqBounds = sqaureBounds(SQ);
    
    xsize = round((sqBounds(2) - sqBounds(1))/8);
    ysize = round((sqBounds(4) - sqBounds(3))/8);
    
    indi = zeros(8,8, xsize, ysize);
    
    for i = 1:8
        for j = 1:8
            indi(i,j,:,:) = SQ([sqBounds(i,j,1):sqBounds(i,j,2)],[sqBounds(i,j,3):sqBounds(i,j,4)]);
        end
    end
end

% Create 64 different matricies for each sqaure 

% building of a 4D matrix that stores each individual sqaure
% but takes for ever to run and prbably isnt necessary 

% NOT USED