function movedGame = movedGame(firstLayer,game)
% Creates a cell array of all mvoed games that can occur as result of first layer moves to be used as inputs for second layer. 

 % Empty cell array 
    movedGame = {};
    prevGame = game;
    for i = 1:8
        for j = 1:8
            for k = 1:8
                for l = 1:8
                    if firstLayer{i,j}(k,l) > 0
                        newGame  = game;
                        newGame(k,l,1) = prevGame(i,j,1);
                        newGame(k,l,2) = prevGame(i,j,2);
                        newGame(i,j,1) = "  ";
                        newGame(i,j,2) = "  ";
                        newGame = {newGame};
                        movedGame = [movedGame; newGame];
                    end
                end
            end
        end
    end
 end
 