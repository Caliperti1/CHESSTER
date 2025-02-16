
function kingMoves = kingMoves(game,row,col)
    
% finds all possible moves for a king given a game baord(8x8x2) and a starting posiiton for the king. returns a 1 in a positon if king can move to square.
  
  % Check Color 
    color = game(row,col,2);  
    if color == 'W'
        encolor = 'B';
    else 
        encolor = 'W';
    end
    
  % Initialize moveMat 
   kingMoves = zeros(8,8);
    
    % Check moves up 
    if row+1 <9 && (game(row+1,col,1) == '  ')
        kingMoves(row+1,col) = 1;
    end
    if row+1 <9 && (game(row+1,col,2) == encolor)
        kingMoves(row+1,col) = 1;
    end
    
    
    % Check moves down 
    if row-1 >0 && (game(row-1,col,1) == '  ')
        kingMoves(row-1,col) = 1;
    end
    if row-1 >0 && (game(row-1,col,2) == encolor)
        kingMoves(row-1,col) = 1;
    end
    
    
    % Check moves left 
    if (col-1 >0 && game(row,col-1,1) == '  ')
        kingMoves(row,col-1) = 1;
    end
    if (col-1 >0 && game(row,col-1,2) == encolor)
       kingMoves(row,col-1) = 1;
    end
    
    % Check moves right 
    if (col+1 <9 && game(row,col+1,1) == '  ')
        kingMoves(row,col+1) = 1; 
    end
    if (col+1 <9 && game(row,col+1,2) == encolor)
        kingMoves(row,col+1) = 1;
    end  
    
     % Check moves down and left
    if row-1 >0 && col-1 >0 && game(row-1,col-1,1) == '  '
        kingMoves(row-1,col-1) = 1;
    end
    if row-1 >0 && col-1 >0 && game(row-1,col-1,2) == encolor
        kingMoves(row-1,col-1) = 1;
    end
    
    % Check moves up and left
    if row+1 <9 && col-1 >0 && game(row+1,col-1,1) == '  '
        kingMoves(row+1,col-1) = 1;
    end
    if row+1 <9 && col-1 >0 && game(row+1,col-1,2) == encolor
        kingMoves(row+1,col-1) = 1;
    end
    
    % Check moves up and right
    if row+1 <9 && col+1 <9 && game(row+1,col+1,1) == '  '
        kingMoves(row+1,col+1) = 1;
    end
    if row+1 <9 && col+1 <9 && game(row+1,col+1,2) == encolor
        kingMoves(row+1,col+1) = 1;
    end 
    
    % Check moves down and right
    if row-1 >0 && col+1 <9 && game(row-1,col+1,1) == '  '
        kingMoves(row-1,col+1) = 1;
    end
    if row-1 >0 && col+1 <9 && game(row-1,col+1,2) == encolor
        kingMoves(row-1,col+1) = 1;
    end 
  end