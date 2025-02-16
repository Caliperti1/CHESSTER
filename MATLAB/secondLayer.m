function secondLayer = secondLayer(game,firstLayer,turn)
 % Generates second layer of pruned decision tree for engine 
 
    % Determine color from turn
    if mod(turn,2) == 0
        team = 'B';
        encolor = 'W';
    else 
        team = 'W';
        encolor = 'B';
    end
    
    % inititate input layer 
    inputLayer = movedGame(firstLayer,game);
    
    % initialize second layer move matrix 
    secondLayer = initSecondLayer(inputLayer)
    
    % find all possible enemy moves for each of the games in the input
    % layer
    sz = size(inputLayer); % number of moves to analyze from input layer
    
    for g = 1:sz(1)
        for m = 1:8
            for n = 1:8
                if inputLayer{g}(m,n,2) == encolor
                    if inputLayer{g}(m,n,1) == 'P'
                       secondLayer{m,n,g} = pawnMoves(inputLayer{g},m,n);
                    end
                    if inputLayer{g}(m,n,1) == 'R'
                       secondLayer{m,n,g} = rookMoves(inputLayer{g},m,n);
                    end
                    if inputLayer{g}(m,n,1) == 'N'
                       secondLayer{m,n,g} = knightMoves(inputLayer{g},m,n);
                    end
                    if inputLayer{g}(m,n,1) == 'B'
                       secondLayer{m,n,g} = bishopMoves(inputLayer{g},m,n);
                    end
                    if inputLayer{g}(m,n,1) == 'Q'
                       secondLayer{m,n,g} = queenMoves(inputLayer{g},m,n);
                    end
                    if inputLayer{g}(m,n,1) == 'K'
                       secondLayer{m,n,g} = kingMoves(inputLayer{g},m,n);
                    end
                end
            end
        end
    end
       
 end