function SQ = squareOffRig(BW)
% NOT USED 
    % Define dimansions of board in image 
        % Can eventually mke this find edges or calculate based off camera
        % height. For now assume rig is centered on board 

    top = 75; 
    bot = 290;
    left = 20;
    right = 230;

    
    SQ = zeros(bot-top,right-left,3);
    
    % Isolate board from entire picture 
    SQ = BW([top:bot],[left:right],:);
    
end 

% Square off image and isolate Board based on known camera rig setup