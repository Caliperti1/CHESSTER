function boardFig = displayBoard(game)
    % Creates figure of digital repersentation of current board given game
    % matrix(8x82)
 
    cb = checkerBoard();
    
    vec = linspace(1,64,8);
    pos = zeros(8,8,2);
    
    % Positions for a8 - d8 - a5 - d5  
    for i =1:4
        for j=1:4
            pos(i,j,:) = [64 - vec(i)-2, vec(j)+2];
        end
    end   

    % Positions for a4 - d4 - a1 - d1
    for i =1:4
        for j=5:8
            pos(i,j,:) = [64-vec(i)-2, vec(j)-2];
        end
    end   
    
    % Positions for e8 - e5 - h5 - h8 
    for i =5:8
        for j=1:4
            pos(i,j,:) = [64-vec(i)+2, vec(j)+2];
        end
    end  
    
% Positions for h4 - h1 - e1 - e4
    for i =5:8
        for j=5:8
            pos(i,j,:) = [64-vec(i)+2, vec(j)-2];
        end
    end  
    
    hold on 
    image(cb)
    for row = 1:8
        for col = 1:8
            x = pos(row, col, 2);
            y = pos(row, col, 1);
            if game(row,col,2) == 'W'
                text(x, y, game{row, col,1}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','color','r','fontweight','bold');
            else 
                text(x, y, game{row, col,1}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle','color','b','fontweight','bold');
            end    
        end
    end
    xticklabels({'h' 'g' 'f' 'e' 'd' 'c' 'b' 'a'})
    yticklabels({'8' '7' '6' '5' '4' '3' '2' '1'})
    hold off
    
end

% Display Board 