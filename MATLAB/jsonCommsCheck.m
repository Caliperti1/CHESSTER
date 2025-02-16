function  [] = jsonCommsCheck()

% Create a serial port object
s = serialport("COM4", 9600);
s.Timeout = 10; % Set the timeout to 10 seconds

pause(2);


game = startGame();

turn = 1;

[xorig, yorig, xnew, ynew, kill] = engPassForward(game,turn);

values = {xorig, yorig, xnew, ynew, kill};

titles = {'xorig', 'yorig', 'xnew', 'ynew', 'kill'};

moveMess = struct();
for i = 1:length(titles)
moveMess.(titles{i}) = values{i};
end


jsonString = jsonencode(moveMess);

jsonStringMess = "MOVE: " + jsonString;


% Display the JSON string
disp(jsonStringMess);

% Send a message 
write(s, jsonStringMess, "string")
disp("Sent message from MATLAB: " + jsonStringMess);

% Read response message
response = readline(s);

disp("Received Message from Arduino: " + response);

clear s;
end

