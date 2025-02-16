function moveList = listMoves(firstLayer,game)
 % lists all moves available from first layer 
 
 % Empty string array 
    moveList = {}
    
    for i = 1:8
        for j =1:8
            for k=1:8
                for l = 1:8
                    if firstLayer{i,j}(k,l) > 0
                        newMove = game(i,j,1) + mapToChessPlot(k,l);
                        moveList = [moveList,newMove];
                    end
                end
            end
        end
    end
 end