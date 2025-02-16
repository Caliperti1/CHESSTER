function pawnMoves = pawnMoves(game,row,col)
 % Returns 8x8 with 1s in positions that the pawn can moave and zeros where it cannot 
    % Check Color 
    color = game(row,col,2);
    
    % Initialize moveMat 
    pawnMoves = zeros(8,8);
    
    % Moves for white (pawns can only move forward)
    if color == 'W'
        
        % Single move forward 
        if row > 0
            pawnMoves(row-1,col) = 1;
        end
 
        % Double move forward if first move 
        if row == 7
            pawnMoves(row-2,col) = 1;
        end 
        
        % Take piece on diagnol 
        if row-1>0 && col+1<9 && game(row-1,col+1,2) == 'B'
            pawnMoves(row-1,col+1) = 1;
        end 
        if row-1>0 && col-1>0 && game(row-1,col-1,2) == 'B'
            pawnMoves(row-1,col-1) = 1;
        end
    end
    
        % Moves for black (pawns can only move forward)
    if color == 'B'
        
        % Single move forward 
        if row < 8
            pawnMoves(row+1,col) = 1;
        end
 
        % Double move forward if first move 
        if row == 2
            pawnMoves(row+2,col) = 1;
        end 
        
        % Take piece on diagnol 
        if row+1<9 && col+1<9 && game(row+1,col+1,2) == 'W'
            pawnMoves(row+1,col+1) = 1;
        end 
        if row+1<9 && col-1>0 && game(row+1,col-1,2) == 'W'
            pawnMoves(row+1,col+1) = 1;
        end
    end
        
        % en passant move 
            % Probably need move tracker for this 
            
        % Make another function for pawn promotions instead of doing it
        % insdie of this (just check if any pawns are in rows 1 and 8 and
        % cange P to Q before runnign move check (will need to find way to
        % incentivize promotion)
            
end 

% Returns 8x8 with 1s in positions that the pawn can moave and zeros where
 % it cannot 