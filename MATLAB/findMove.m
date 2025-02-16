 function move = findMove(blank, orig, new)
  % Take original image and new image and determine coordinate that a piece left and coordinate piece moved to 
 
    % Find starting loc of piece 
    startmv = moveLoc(blank, orig, new);
    
    startsq = startmv;
    
    % Find ending loc of piece 
    endmv = moveLoc(blank, new, orig);
    
    endsq = endmv;
    
    move = [startsq;endsq];
 end 

 % Take original image and new image and determine coordinat epiece left
 % and coordinate piece moved to 
 