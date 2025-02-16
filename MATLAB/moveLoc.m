function coord_conf = moveLoc(blank, pic1, pic2)
    % Analyzes two images and determines what chess move has occured between them. returns coordinates and confidences.

    % Calculate difference between two pics 
    diff = pic1 - pic2;
    
    % Sobel Mask diff
    diffmask = sobelMask(diff,0.9);
    
    %Square off diff pic using blank baord bounds
    diffmaskSQ = squareOff2(blank,diffmask);
    sizeDiffmaskSQ = size(diffmaskSQ)

    % find sqbounds from blank board    
    blankSQ = squareOff(blank);
    sizeblankSQ = size(blankSQ)
    sqBounds = sqaureBounds(blankSQ)
    
   % Search between bounds in sqBounds and add total to scores 
   
   % Should be 8x8
    sz = size(sqBounds)
    
    % Build empty matrix repersenting "scores" for each square
    scores = zeros(sz(1),sz(2));

    for i = 1:sz(1)
        for j = 1:sz(2)
            % for each "sqaure" in board find bounds from sq Bounds 
           tb = sqBounds(i,j,1);
           bb = sqBounds(i,j,2);
           lb = sqBounds(i,j,3);
           rb = sqBounds(i,j,4);

            % use bounds as limits to iterate through all pixels in that
            % "square"
            for k = tb:bb
                for p = lb:rb
                    if diffmaskSQ(k,p) > 0
                        scores(i,j) = scores(i,j) + 1;
                    end
                end
            end 
        end 
    end
    
    [max_score, max_inx] = max(scores(:));
    [X Y] = ind2sub(size(scores),max_inx);
    
    % calculate confidence 
    conf = max_score / sum(sum(scores));
    coord_conf = [X Y conf]
            
end

% Counts how many values above 0 exist in each sqaure on high tol sobel
% masked image of moved piece 

% find total of all values within bounds on sobel mask diff image 
% make 8x8 matrix of totals 

% uses the square dimesnions of one of the pics and applies it to
% difference since edges cant be found in dif image 
