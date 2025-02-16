% Create a serial port object
s = serialport("COM4", 9600);
s.Timeout = 10; % Set the timeout to 10 seconds

pause(2);

% Send a message 
message = "HELLO FROM MATLAB \n";
write(s, message, "string")
disp("Sent message from MATLAB: " + message);

% Read response message
response = readline(s);

disp("Received Message from Arduino: " + response);

clear s;
