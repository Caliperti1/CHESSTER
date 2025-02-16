function updatedGame = updateGame(game,move)
 % Updates game matrix  based on move 
    % Original location of piece 
    origx = move(1,1);
    origy = move(1,2);
    
    %new lcoation of piece 
    movedx = move(2,1);
    movedy = move(2,2);
    
    %find name of piece that moved 
    pieceID = game(origx,origy,1);
    pieceCol = game(origx, origy,2);
    
    %change piece in updated game 
    updatedGame = game;
    updatedGame(origx, origy,1) = "  ";
    updatedGame(origx, origy,2) = "  ";
    updatedGame(movedx, movedy,1) = pieceID; 
    updatedGame(movedx, movedy,2) = pieceCol;
 
end

%Updates game based on move 