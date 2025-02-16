function possMoves = possMoves(game)
% Returns cell array of all possible moves without weights 
% col 1 - piece type 
% col 2 - piece coloe 
% col 3 - current location 
% col 4 - possible move location 
% col 5 - weight score of move (1 becuase seond layer not applied)
% col 6 - index of move (important for when moves are omitted for check)
% col 7 - best enemy counter move weight (0 becuase seond layer not applied)

    firstLay = firstLayer(game,1);
    secondLay = secondLayer(game,firstLay,1);
    possMoves = firstLayerOutput(game,firstLay,secondLay,1);

end 


