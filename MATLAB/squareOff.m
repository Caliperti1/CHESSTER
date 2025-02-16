function SQ = squareOff(im)
% Square off image and isolate Board based on calculated bounds 
    bound = boardBounds(im);
    
    SQ = im([bound(1):bound(2)],[bound(3):bound(4)],:);

end


