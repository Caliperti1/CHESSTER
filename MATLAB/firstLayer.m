function firstLayer = firstLayer(game, turn)
 % Takes an 8x8x2 game matrix and produces an 8x8 cell array  with  each cell being the moves the piece in the corresponding positon can perform  
  
 % Determine color from turn
    if mod(turn,2) == 0
        team = 'B';
        encolor = 'W';
    else 
        team = 'W';
        encolor = 'B';
    end

    % initialize move matrix 
    firstLayer = initFirstLayer();
    

    %populate first layer
    for m = 1:8
        for n = 1:8
            if game(m,n,2) == team
                if game(m,n,1) == 'P'
                    firstLayer{m,n} = pawnMoves(game,m,n);
                end
                if game(m,n,1) == 'R'
                    firstLayer{m,n} = rookMoves(game,m,n);
                end
                if game(m,n,1) == 'B'
                    firstLayer{m,n} = bishopMoves(game,m,n);
                end
                if game(m,n,1) == 'N'
                    firstLayer{m,n} = knightMoves(game,m,n);
                end
                if game(m,n,1) == 'Q'
                    firstLayer{m,n} = queenMoves(game,m,n);
                end
                if game(m,n,1) == 'K'
                    firstLayer{m,n} = kingMoves(game,m,n);
                end
            end
        end
    end
    
 end 