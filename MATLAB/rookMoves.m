function rookMoves = rookMoves(game,row,col)
 % Returns 8x8 with 1s in positions that the Rook can moave and zeros where it cannot 
 
    
  % Check Color 
    color = game(row,col,2);  
    if color == 'W'
        encolor = 'B';
    else 
        encolor = 'W';
    end
    
  % Initialize moveMat 
    rookMoves = zeros(8,8);
    
    % Check moves up 
    up = 1;
    while row+up <9 && (game(row+up,col,1) == '  ')
        rookMoves(row+up,col) = 1;
        up = up+1;
    end
    if row+up <9 && (game(row+up,col,2) == encolor)
        rookMoves(row+up,col) = 1;
    end
    
    
    % Check moves down 
    dn = 1;
    while (row-dn >0 && game(row-dn,col,1) == '  ')
        rookMoves(row-dn,col) = 1;
        dn = dn+1;
    end
    if row-dn >0 && (game(row-dn,col,2) == encolor)
        rookMoves(row-dn,col) = 1;
    end
    
    % Check moves left 
    lt = 1;
    while (col-lt >0 && game(row,col-lt,1) == '  ')
        rookMoves(row,col-lt) = 1;
        lt = lt+1;
    end
    if (col-lt >0 && game(row,col-lt,2) == encolor)
       rookMoves(row,col-lt) = 1;
    end
    
    % Check moves right 
    rt = 1;
    while (col+rt <9 && game(row,col+rt,1) == '  ')
        rookMoves(row,col+rt) = 1;
        rt = rt+1; 
    end
    if (col+rt <9 && game(row,col+rt,2) == encolor)
        rookMoves(row,col+rt) = 1;
    end  

 end 