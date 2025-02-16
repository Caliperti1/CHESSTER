function indi = indivSquares2(im,sqBounds)
% NOT USED
    xsize = round(sqBounds(2) - sqBounds(1));
    ysize = round(sqBounds(4) - sqBounds(3));
    
    indi = zeros(8,8, xsize, ysize);
    
    for i = 1:8
        for j = 1:8
            indi(i,j,:,:) = im([sqBounds(i,j,1):sqBounds(i,j,2)],[sqBounds(i,j,3):sqBounds(i,j,4)]);
        end
    end
end

% Create 64 different matricies for each sqaure given square bounds

% This version is useful if you want to appl th edimensions from another
% image to this one
