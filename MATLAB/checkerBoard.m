function cb = checkerBoard()
% Creates blank checkerboard pattern for plotting 
 
    wb = ones(8,8,3);
    
    bb =  zeros(8,8,3);
    
    cb = [bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;
        bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;
        bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;
        bb wb bb wb bb wb bb wb;
        wb bb wb bb wb bb wb bb;];
    
end

% Make blank Board 
 
 