function  [] = jsonMoorCheck()
% This will send a sjon with summy move data to the arduino 

% Create a serial port object
s = serialport("COM4", 9600);
s.Timeout = 10; % Set the timeout to 10 seconds

pause(2);

values = {250, 300, 150, 100, 1;};

titles = {'xorig', 'yorig', 'xnew', 'ynew', 'kill'};

moveMess = struct();
for i = 1:length(titles)
moveMess.(titles{i}) = values{i};
end


jsonString = jsonencode(moveMess);

jsonStringMess = "MOVE: " + jsonString;

jsonStringStart = "PLAY"


% Display the JSON string
disp(jsonStringMess);

% Send a message 
write(s, jsonStringStart, "string")
disp("Sent message from MATLAB: " + jsonStringMess);

% Read response message
response = readline(s);

disp("Received Message from Arduino: " + response);

clear s;
end

