function SQ = squareOff2(blank,im)
% Square off image and isolate Board based on calculated bounds from a blank baord (This is the version of function that is used) 
    bound = boardBounds(blank);
    
    SQ = im([bound(1):bound(2)],[bound(3):bound(4)],:);

end 
