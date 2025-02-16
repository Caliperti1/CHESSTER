function squareBounds = sqaureBounds(SQ) 

    % Divide dimesnions by 8 to create incements 
    sz = size(SQ);
    LRincr = round(sz(2) / 8);
    UDincr = round(sz(1) / 8);
    
    % Create a vactor of left / right bounds 
    LRBounds = [1];
    for i = 1:8
        LRBounds(1+i) = LRBounds(i) + LRincr;
    end
    
    % Create a vactor of up / down bounds 
    UDBounds = [1];
    for i = 1:8
        UDBounds(1+i) = UDBounds(i) + UDincr;
    end
    
    % correct for rounding 
    if UDBounds(9) > sz(1)
        UDBounds(9) = sz(1)
    end
    
    if LRBounds(9) > sz(2)
        LRBounds(9) = sz(2)
    end
    
    %Create array that stores [top, bot, left, right] for each square array
    %should be 64x4

        sqaureBounds = zeros(8,8,4);
   for i = 1:8
       for j = 1:8
        squareBounds(i,j,1) = UDBounds(i);
        squareBounds(i,j,2) =  UDBounds(i +1);
        squareBounds(i,j,3) =  LRBounds(j);
        squareBounds(i,j,4) = LRBounds(j+1);
       end
   end
   
end

% Create library of bounds for 64 squares 
% NOT USED