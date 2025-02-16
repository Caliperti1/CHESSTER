 function inputLayer = initSecondLayer(movedGame)
 % initializes second layer for engine 
 
    sz = size(movedGame);
    inputLayer = cell(8,8,sz(1));
    for i = 1:8
        for j = 1:8
            for m =1:sz(1)
            inputLayer{i,j,m} = zeros(8,8);
            end
        end
    end
    
 end 