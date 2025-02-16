%% Chesster main loop  

%% Config
controllerSerialPort = "COM11";
baudRate = 9600;
camDir = 'C:\Program Files (x86)\Java\jdk1.8.0_74\bin';
landingDir = 'C:\out';
camKillBatDir = 'C:\Users\christopher.aliperti\OneDrive - West Point\Desktop\Research\Chess\Bash\killCam.bat';

%% Initialize game parametrs 
calib = input("Press Y to recalibrate camera \n otherwise press any other key: \n","s");

if calib == "Y"
    blank = calibrateCamera(camDir, landingDir, camKillBatDir); 
else 
    blank = imread("C:\out\blank.bmp");
end

game = startGame();
turn = 0;

%% Start Game  

% initialize serial conneciton
s = serialport(controllerSerialPort, baudRate);
s.Timeout = 600; % Set timeout to 10 minutes
pause(2);

while turn >= 0
  
    if turn == 0
        % Send standby signal 
        standbyMess = "MATLAB STANDING BY \n";
        write(s, standbyMess, "string")
    end
    
    % Wait for start signal from aruino
    fromArduino = readline(s);
    disp(fromArduino)
    
    startSeq = "**";
    while ~contains(fromArduino, startSeq)
        fromArduino = readline(s);
        disp(fromArduino)
        puase(1)
    end 
    
    % Start signal
    arduinoReady =  "ARDUINO READY";
    if  contains(fromArduino, arduinoReady)
    
        orig = captureImage(camDir,landingDir,camKillBatDir);

        % ADD ANY DEBUGGING CHECKS FOR MATLAB STARTUP HERE
    
        readyMess = "MATLAB READY \n";
        write(s, readyMess, "string");
        
        turn = turn +1;
    end

    % Play signal
    arduinoPlay =  "PLAY";   
    if  contains(fromArduino, arduinoPlay)
    
       % Capture image of moved board 
       moved = captureImage(camDir,landingDir,camKillBatDir); 

       % Run Computer Vision
       gamemoved = camPassForward(blank, orig, moved, game);  
    
       % Run Engine 
       [xOrigPos, yOrigPos, xNewPos, yNewPos, xOrig, yOrig, xNew, yNew, kill] = engPassForward(game,turn);
    
       % Translate Move to Steps 

       % Missing Translation function! 
        values = {xOrig, yOrig, xNew, yNew, kill};
        
        titles = {'xo', 'yo', 'xn', 'yn', 'kill'};
        
        moveMess = struct();
        for i = 1:length(titles)
        moveMess.(titles{i}) = values{i};
        end

        
        jsonStringMess = "** MOVE:" + sprintf('{"xo":%.0f,"yo":%.0f,"xn":%.0f,"yn":%.0f,"kill":%d}', xOrig, yOrig, xNew, yNew, kill) + "\n";
        %jsonStringMess = "** MOVE:" + sprintf('{"xo":%.0f,"yo":%.0f,"xn":%.0f,"yn":%.0f,"kill":%d}', 12, 45, 78, 12, 1) + "\n";
    
        % Send Move json to arduino 
        write(s, jsonStringMess, "string");
        pause(.5)
        disp("Sent message from MATLAB: " + jsonStringMess);
    
        % Acknowledgement from Arduino 
        acknowledgment = readline(s);
        disp("Received from Arduino: " + acknowledgment);

        % update turn 
        turn = turn +2;
        
        % Dispaly Mmove 
        showOff(blank, orig, moved, game)
          
    end
    
    % Completed Move signal
    arduinoMoved =  "MOVED\n"; 
    if contains(fromArduino, arduinoMoved)
    disp(fromArduino)
        
    % Update game based on Chesster's move
    move = [xOrigPos, yOrigPos; xNewPos, yNewPos];
    game = updateGame(game, move);

    orig = captureImage(camDir,landingDir,camKillBatDir);
    turn = turn+1;
   end

end






