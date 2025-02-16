function gameMoved = camPassForward(blank, orig, moved, gameOrig)
 % Main loop function for computer vision - passes forward updated game matrix (8x8x2) to engine 
 % Takes 3 images and one matrix 
    % blank - image of empty board from calibration 
    % orig - board before move 
    % moved - board after move 
    % gameOrig - 8x8x2 matrix representing original image
 
move = findMove(blank, orig, moved);

gameMoved = updateGame(gameOrig,move);
end


% Main loop function for computer vision 
% Takes 3 images and one matrix 
    % blank - image of empty board from calibration 
    % orig - board before move 
    % moved - board after move 
    % gameOrig - 8x8x2 matrix representing original image