function [] = initiateCamera(dir)

    % Save the current working directory
    originalDirectory = pwd;

    try
        % Change to the specified directory
        cd(dir);

        % Command to start the Java process in the background
        command = 'start java code.SimpleRead';

        % Execute the command in the background
        system(command);

        % Restoring the original working directory
        cd(originalDirectory);

        disp('Camera initialization command sent.');

    catch
        % In case of an error, restore the original working directory
        cd(originalDirectory);
        error('Error in initiateCamera function.');
        
    end
end
