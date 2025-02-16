function firstLayerOutputWeighted = firstLayerOutputWeighted(game, firstLayer, secondLayer, turn)
    % First applies weights to all of second layer moves. then chooses best second layer move and creates a scores vectpor secondLayerOutputWeighted. Then the first layer is weighted to create firstLayerOutputWeighted vector Finally the second layer is subtracted from the first and a scores vector is foudn which then uses the moveList as keys to create a dictionary. The max value is found and that key is chosen as the best move.

        % Determine color from turn
    if mod(turn,2) == 0
        team = 'B';
        enColor = 'W';
    else 
        team = 'W';
        enColor = 'B';
    end

    %initalize weights dicitonary 
    weights = [10 30 30 50 90 20]; %[pawn knight bishop rook queen check]

    % create firstLayerMoves
    firstLayerOut = firstLayerOutput(game,firstLayer,secondLayer,turn);

    % create secondLayerMoves
    secondLayerOut = secondLayerOutput(game,secondLayer);

    % Creat esecondlayer output weighted 
    secondLayerOutputWeighted = secondLayerOut;
    firstLayerOutputWeighted = firstLayerOut;

    % Add weights to second layer 

    % for eveery move in secondLayerOutput find what piece that move
    % would be taking (ADD CHECK IF TS PUTTING SOMEONE IN CHECK LATER)
    sz2 = size(secondLayerOut);
    sz1 = size(firstLayerOut);

    for i = 1:sz2(1)
        movex = secondLayerOut{i,4}(1);
        movey = secondLayerOut{i,4}(2);
        if game(movex,movey,2) == team
            if game(movex,movey,1) == 'P'
                weight = weights(1);
            end
            if game(movex,movey,1) == 'N'
                weight = weights(2);
            end
            if game(movex,movey,1) == 'B'
                weight = weights(3);
            end
            if game(movex,movey,1) == 'Q'
                weight = weights(4);
            end
            secondLayerOutputWeighted{i,5} = secondLayerOutputWeighted{i,5}*weight;
        end
    end
        % Cannot give bonus for placing hite in check yet
        
    % find best move for black for each white move 
    for j = 1:sz1(1)
        enscores = []
        for k = 1:sz2(1)
            if secondLayerOutputWeighted{k,6} == j
                enscores = [enscores,secondLayerOutputWeighted{j,5}];
            end
        bestEnMove = max(enscores);
        firstLayerOutputWeighted{j,7} = bestEnMove;
        end
    end
    
    % find weights for white moves 
    for p = 1:sz1(1)
        movex = firstLayerOut{p,4}(1);
        movey = firstLayerOut{p,4}(2);
        if game(movex,movey,2) == enColor
            if game(movex,movey,1) == 'P'
                weight = weights(1)
            end
            if game(movex,movey,1) == 'N'
                weight = weights(2)
            end
            if game(movex,movey,1) == 'B'
                weight = weights(3)
            end
            if game(movex,movey,1) == 'Q'
                weight = weights(4)
            end
            firstLayerOutputWeighted{p,5} = firstLayerOutputWeighted{i,5}*weight;
        end
    end
    
    % subtract away weights of enemy best move from positive weights 
    
    for q = 1:sz1(1)
        firstLayerOutputWeighted{q,5} = firstLayerOutputWeighted{q,5} - firstLayerOutputWeighted{q,7} + 1;
    end
end