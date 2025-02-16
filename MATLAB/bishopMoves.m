function bishopMoves = bishopMoves(game,row,col)
   % finds all possible moves for a bishop given a game baord(8x8x2) and a starting posiiton for the bishop
   
   % Check Color 
    color = game(row,col,2);  
    if color == 'W'
        encolor = 'B';
    else 
        encolor = 'W';
    end
    
    % Initialize moveMat 
    bishopMoves = zeros(8,8);
    
    % Check moves down and left
    dnlt = 1;
    while row-dnlt >0 && col-dnlt >0 && game(row-dnlt,col-dnlt,1) == '  '
        bishopMoves(row-dnlt,col-dnlt) = 1;
        dnlt = dnlt+1;
    end
    if row-dnlt >0 && col-dnlt >0 && game(row-dnlt,col-dnlt,2) == encolor
        bishopMoves(row-dnlt,col-dnlt) = 1;
    end
    
    % Check moves up and left
    uplt = 1;
    while row+uplt < 9 && col-uplt > 0 && game(row+uplt,col-uplt,1) == '  '
        bishopMoves(row+uplt,col-uplt) = 1;
        uplt = uplt+1;
    end
    if row+uplt < 9 && col-uplt >0 && game(row+uplt,col-uplt,2) == encolor
        bishopMoves(row+uplt,col-uplt) = 1;
    end
    
    % Check moves up and right
    uprt = 1;
    while row+uprt < 9 && col+uprt <9 && game(row+uprt,col+uprt,1) == '  '
        bishopMoves(row+uprt,col+uprt) = 1;
        uprt = uprt+1;
    end
    if row+uprt < 9 && col+uprt <9 && game(row+uprt,col+uprt,2) == encolor
        bishopMoves(row+uprt,col+uprt) = 1;
    end
        
    % Check moves down and right
    dnrt = 1;
    while row-dnrt > 0 && col+dnrt <9 && game(row-dnrt,col+dnrt,1) == '  '
        bishopMoves(row-dnrt,col+dnrt) = 1;
        dnrt = dnrt+1
    end
    if row-dnrt > 0 && col+dnrt <9 && game(row-dnrt,col+dnrt,2) == encolor
        bishopMoves(row-dnrt,col+dnrt) = 1;
    end
   
 end