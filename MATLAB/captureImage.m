function image = captureImage(camDir, landingDir, camKillBatDir)
% Given directory paths for camera java executable, landing directory of images and directory path for batch file this function will take 5 pictures and assign the last one to the variable imge before clearing folder.

% initiate camera
initiateCamera(camDir)

% Save current directory
origDir = pwd;

stat = 1;
% Find the number of images currently in the directory
while stat == 1
    cd(landingDir)
    a = dir('*.bmp');
    n = numel(a);

    if n > 7
        % terminate camera
        status = system([camKillBatDir]);
        
        if status == 0
            disp('Bat script executed successfully.');
        else
            disp('Error executing Bat script.');
        end
        stat = 0;
        
        % Assign selected image to return variable 
        cd(landingDir);
        
        image = imread('6.bmp');
        
      
        
    end
end

cd(origDir);
end 