function recMove = engine(game,turn);
% Runs all layers of pruned decision tree engine and returns a cell array with all relevant information for recommended move (odd turns are alwaywhite)

    % Create first layer
    firstLay = firstLayer(game,turn);
    
    %create second layer 
    secondLay = secondLayer(game,firstLay,turn);
    
    % Create weighted moves mat 
    firstLayOutputWeighted = firstLayerOutputWeighted(game, firstLay, secondLay, turn);
    
    % find max weight 
    sz = size(firstLayOutputWeighted);
    scores = [];
    
    for r = 1:sz(1);
        scores = [scores, firstLayOutputWeighted{r,5}];
        [score, loc] = max(scores);
    end
    
    recMove = {};
    for v = 1:7
        recMove{v} = firstLayOutputWeighted{loc,v};
    end  

end