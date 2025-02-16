function blank = calibrateCamera (camDir, landingDir, camKillBatDir)
    % This funciton allows the user to capture an image of the blank baord and confirm that the camera is operating operating properly. Later versions of this funciton with interface with Arduino to calibrate motors and allow for calibration to occer from Chesser control box, not matlab terminal.

   % Prompt user to clear board 
   confirm = "N";

   while confirm == "N"
       ready = input("Clear Board and place in desingated position \n  Press any button when ready to calibrate: \n ", "s")
    
       if ready ~=  ""
           
           blank = captureImage(camDir, landingDir, camKillBatDir);
            
           squareOffTestFig(blank);
           
           confirm = input("Press Y to confirm calibration otherwise press N to take a new image","s")
    
            % If confirmed, rename the file to 'blank'
            currentFileName = fullfile(landingDir, '5.bmp')
            if confirm == "Y"
                newFileName = fullfile(landingDir, 'blank.bmp'); 
                movefile(currentFileName, newFileName);
                blank = newFileName;
                fprintf('File renamed to %s\n', blank);
            end
       end
   end

    % clear folder of everything except calibation image 
        delete('0.bmp');
        delete('1.bmp');
        delete('2.bmp');
        delete('3.bmp');
        delete('4.bmp');
        delete('5.bmp');
        delete('6.bmp');
end
