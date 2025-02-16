function knightMoves = knightMoves(game,row,col)
   
% finds all possible moves for a knight given a game baord(8x8x2) and a starting posiiton for the knight. returns a 1 in a positon if king can move to square.
  

   % Check Color 
    color = game(row,col,2);  
    if color == 'W'
        encolor = 'B';
    else 
        encolor = 'W';
    end
    
    % Initialize moveMat 
    knightMoves = zeros(8,8);
    
    % up 2 right 1
    if row+2 < 9 && col+1 <9
        if game(row+2,col+1,1) == '  ' || game(row+2,col+1,2) == encolor
            knightMoves(row+2,col+1) = 1;
        end
    end
    
    % up 2 left 1
    if row+2 < 9 && col-1 >0
        if game(row+2,col-1,1) == '  ' || game(row+2,col-1,2) == encolor
            knightMoves(row+2,col-1) = 1;
        end
    end
        
    % down 2 left 1
    if row-2 > 0 && col-1 >0
        if game(row-2,col-1,1) == '  ' || game(row-2,col-1,2) == encolor
            knightMoves(row-2,col-1) = 1;
        end
    end
            
    % down 2 right 1
    if row-2 > 0 && col+1 <9
        if game(row-2,col+1,1) == '  ' || game(row-2,col+1,2) == encolor
            knightMoves(row-2,col+1) = 1;
        end
    end
    
    % down 1 right 2
    if row-1 > 0 && col+2 <9
        if game(row-1,col+2,1) == '  ' || game(row-1,col+2,2) == encolor
            knightMoves(row-1,col+2) = 1;
        end
    end
     
    % down 1 left 2
    if row-1 > 0 && col-2 >0
        if game(row-1,col-2,1) == '  ' || game(row-1,col-2,2) == encolor
            knightMoves(row-1,col-2) = 1;
        end
    end
    
    % up 1 left 2
    if row+1 < 9 && col-2 >0
        if game(row+1,col-2,1) == '  ' || game(row+1,col-2,2) == encolor
            knightMoves(row+1,col-2) = 1;
        end
    end
        
    % up 1 right 2
    if row+1 < 9 && col+2 < 9
        if game(row+1,col+2,1) == '  ' || game(row+1,col+2,2) == encolor
            knightMoves(row+1,col+2) = 1;
        end
    end
    
 end