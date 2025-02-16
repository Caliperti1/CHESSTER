
  function queenMoves = queenMoves(game,row,col)
     % Returns 8x8 with 1s in positions that the Queen can moave and zeros where it cannot 
 
  % Check Color 
    color = game(row,col,2);  
    if color == 'W'
        encolor = 'B';
    else 
        encolor = 'W';
    end
    
  % Initialize moveMat 
    queenMoves = zeros(8,8);
    
    % Check moves up 
    up = 1;
    while row+up <9 && (game(row+up,col,1) == '  ')
        queenMoves(row+up,col) = 1;
        up = up+1;
    end
    if row+up <9 && (game(row+up,col,2) == encolor)
        queenMoves(row+up,col) = 1;
    end
    
    
    % Check moves down 
    dn = 1;
    while (row-dn >0 && game(row-dn,col,1) == '  ')
        queenMoves(row-dn,col) = 1;
        dn = dn+1;
    end
    if row-dn >0 && (game(row-dn,col,2) == encolor)
        queenMoves(row-dn,col) = 1;
    end
    
    % Check moves left 
    lt = 1;
    while (col-lt >0 && game(row,col-lt,1) == '  ')
        queenMoves(row,col-lt) = 1;
        lt = lt+1;
    end
    if (col-lt >0 && game(row,col-lt,2) == encolor)
       queenMoves(row,col-lt) = 1;
    end
    
    % Check moves right 
    rt = 1;
    while (col+rt <9 && game(row,col+rt,1) == '  ')
        queenMoves(row,col+rt) = 1;
        rt = rt+1; 
    end
    if (col+rt <9 && game(row,col+rt,2) == encolor)
        queenMoves(row,col+rt) = 1;
    end  
    
     % Check moves down and left
    dnlt = 1;
    while row-dnlt >0 && col-dnlt >0 && game(row-dnlt,col-dnlt,1) == '  '
        queenMoves(row-dnlt,col-dnlt) = 1;
        dnlt = dnlt+1;
    end
    if row-dnlt >0 && col-dnlt >0 && game(row-dnlt,col-dnlt,2) == encolor
        queenMoves(row-dnlt,col-dnlt) = 1;
    end
    
    % Check moves up and left
    uplt = 1;
    while row+uplt < 9 && col-uplt > 0 && game(row+uplt,col-uplt,1) == '  '
        queenMoves(row+uplt,col-uplt) = 1;
        uplt = uplt+1;
    end
    if row+uplt < 9 && col-uplt >0 && game(row+uplt,col-uplt,2) == encolor
        queenMoves(row+uplt,col-uplt) = 1;
    end
    
    % Check moves up and right
    uprt = 1;
    while row+uprt < 9 && col+uprt <9 && game(row+uprt,col+uprt,1) == '  '
        queenMoves(row+uprt,col+uprt) = 1;
        uprt = uprt+1;
    end
    if row+uprt < 9 && col+uprt <9 && game(row+uprt,col+uprt,2) == encolor
        queenMoves(row+uprt,col+uprt) = 1;
    end
        
    % Check moves down and right
    dnrt = 1;
    while row-dnrt > 0 && col+dnrt <9 && game(row-dnrt,col+dnrt,1) == '  '
        queenMoves(row-dnrt,col+dnrt) = 1;
        dnrt = dnrt+1
    end
    if row-dnrt > 0 && col+dnrt <9 && game(row-dnrt,col+dnrt,2) == encolor
        queenMoves(row-dnrt,col+dnrt) = 1;
    end

  end 