 function initFirstLayer = initFirstLayer()
 % Initializes first layer for engine 
    initFirstLayer = cell(8,8);
    for i = 1:8
        for j = 1:8
            initFirstLayer{i,j} = zeros(8,8);
        end
    end
    
 end 