function firstLayerOutput = firstLayerOutput(game,firstLayer,secondLayer,turn) 
   % Checks 2nd layer  and if the move results in any opp moves that could take king then the move in the lower layer is automically turned to 0. Does tihis by loking ofr a 1 in the posiiton o king in game 
 
% Returns cell array with all info about poosible moves and binary scores
    % Determine color from turn
    if mod(turn,2) == 0
        team = 'B';
        encolor = 'W';
    else 
        team = 'W';
        encolor = 'B';
    end
    
    % find friendly king 
    for a = 1:8
        for b= 1:8
            if game(a,b,1) == 'K' && game(a,b,2) == team
                kingLocx = a;
                kingLocy = b;
            end
        end
    end
   
    % find size of movelist 
     sz = size(secondLayer)
     
    % initialize output layer cell array 
    firstLayerOutput = {};
   
     % initialize list 
    firstLayerMovesList = listMoves(firstLayer, game)
    
     % look at every possible opponent move
     for a = 1:8
         for b = 1:8
             for c = 1:sz(3)
                 % cehck if king is in a spot that theenemy could move
                 if secondLayer{a,b,c}(kingLocx,kingLocy) >0
                     % update moveList
                     firstLayerMovesList(c) = "";
                 % if move is allowed, create binary entry 
                 end
             end
         end
     end
                 
     m = 0;
     for i = 1:8
        for j = 1:8
            for k = 1:8
                for l = 1:8
                    if firstLayer{i,j}(k,l) > 0
                        m = m+1;
                        firstLayerOutput{m,1} = game(i,j,1); % first cell is piece name 
                        firstLayerOutput{m,2} = game(i,j,2); % second cell is piece color
                        firstLayerOutput{m,3} = [i,j]; % third cell is starting location of piece
                        firstLayerOutput{m,4} = [k,l]; % fourth cell is location of move 
                        firstLayerOutput{m,5} = 1; % fifth cell is score 
                        if firstLayerMovesList(m) == ""
                            firstLayerOutput{m,5} = 0; % fifth cell is score 0 if move is illegal (check)
                        end
                        firstLayerOutput{m,6} = m; % sixth cell is index for comparing to seconLayerMoves  
                        firstLayerOutput{m,7} = 0; % seventh cell is enemy's best move in response weight 
                    end
                end
            end
        end
     end
 end