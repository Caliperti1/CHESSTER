function game = startGame()
    % Initiates a game matrix and resets pieces to starting positons 

    colors = ["B" "B" "B" "B" "B" "B" "B" "B";
        "B" "B" "B" "B" "B" "B" "B" "B";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "W" "W" "W" "W" "W" "W" "W" "W";
        "W" "W" "W" "W" "W" "W" "W" "W"];
        
    pieces = flipud(["R" "N" "B" "Q" "K" "B" "N" "R";
        "P" "P" "P" "P" "P" "P" "P" "P";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "  " "  " "  " "  " "  " "  " "  " "  ";
        "P" "P" "P" "P" "P" "P" "P" "P";
        "R" "N" "B" "Q" "K" "B" "N" "R"]);
        s
%     if opt == 'color'
%         game = gameBoardColors; 
%     elseif opt == 'no color'
%         game = gameBoard;
%     else 
%         game = 'opt must = color or no color'
%     end 

    game = strings(8,8,2);
    game(:,:,1) = pieces;
    game(:,:,2) = colors;
    
    
    
end 

 
 % Start a game by establishing a Game matrix containing the names of
 % pieces 


 
 