function secondLayerOutput = secondLayerOutput(game,secondLayer)
% Translates output of second layer into 7 cell array format used in rest of model.
    % initialize secondLayerMoves 
     secondLayerOutput = {};
     
    %size of secondLyer 
    sz = size(secondLayer);
        
     m = 0;
     for i = 1:sz(1)
        for j = 1:sz(2)
            for k = 1:sz(3)
                for a = 1:8
                    for b =1:8
                        if secondLayer{i,j,k}(a,b) > 0
                            m = m+1;
                             secondLayerOutput{m,1} = game(i,j,1); % first cell is piece name 
                             secondLayerOutput{m,2} = game(i,j,2); % second cell is piece color
                             secondLayerOutput{m,3} = [i,j]; % third cell is starting location of piece
                             secondLayerOutput{m,4} = [a,b]; % fourth cell is location of move 
                             secondLayerOutput{m,5} = 1; % fifth cell is score 
                             secondLayerOutput{m,6} = k; % sixth cell is index corresponding to first layer move that this is in response to 
                        end
                    end
                end
            end
        end
     end
 end