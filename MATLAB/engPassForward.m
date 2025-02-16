function [xOrigPos, yOrigPos, xNewPos, yNewPos, xOrig, yOrig, xNew, yNew, kill] = engPassForward(game,turn)
% Generates a recommended move and translates it to steps for the motor
    
    % Run engine 
    rec = engine(game,turn);

    % parse engine rec for grid cooridnates 
    xOrigPos = rec{3}(1);
    yOrigPos = rec{3}(2);

    xNewPos = rec{4}(1);
    yNewPos = rec{4}(2);

    %% set transformer parameters (grid coord to steps)

    % REPLACE THIS SECTION WITH REAL MEASUREMETNS 

    % Set distance from home position to corner of actual board 
    xHomeOffset = 10; %[mm]
    yHomeOffset = 10; %[mm]

    % distance to middle of a sqaure 
    midSquare = 15; %[mm]

    % distance between sqaures 
    distSquare = 2*midSquare; %[mm]

    % Total mm in each direction 
    xOrigmm = xHomeOffset + midSquare + distSquare*xOrigPos;
    xNewmm = xHomeOffset + midSquare + distSquare*xNewPos;

    yOrigmm = yHomeOffset + midSquare + distSquare*yOrigPos;
    yNewmm = yHomeOffset + midSquare + distSquare*yNewPos;

    % Motor parameters 
    mm2rots = 8;  %[rot / mm]

    rots2steps = 2; %[steps / rots]

    % Steps 
    xOrig = xOrigmm * mm2rots * rots2steps;
    yOrig = yOrigmm * mm2rots * rots2steps;

    xNew = xNewmm * mm2rots * rots2steps;
    yNew = yNewmm * mm2rots * rots2steps;


    %% Set kill 
    if mod(turn,2) == 0
    team = 'B';
    encolor = 'W';
    else 
    team = 'W';
    encolor = 'B';
    end
    % Leaving team in for when castling feature is added

    if game(xNewPos,yNewPos,2) == encolor
        kill = 1;
    else
        kill = 0;
    end
    
    
end

