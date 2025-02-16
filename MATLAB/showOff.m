function [] = showOff(blank, orig, moved, gameOrig)
 % Plot previous board, moved board and confidence. Displays results of computer vision stage.
 
move = findMove(blank, orig, moved);

origchess = mapToChess(move(1,1),move(1,2));
movedchess = mapToChess(move(2,1),move(2,2));

gameMoved = updateGame(gameOrig,move);

figure
subplot(2,2,1)
image(orig)
title({"Pre Move", "Piece located at " + origchess,  "Confidence :  " + move(1,3)})
subplot(2,2,2)
image(moved)
title({"Post Move", "Piece located at " + movedchess,  "Confidence :  " + move(2,3)})
subplot(2,2,3)
displayBoard(gameOrig)
subplot(2,2,4)
displayBoard(gameMoved)
end

% Plot previous board, moved board and confidence 
 