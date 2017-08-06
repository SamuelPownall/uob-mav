function [outString] = MAVParam(paramID)
%MAVPARAM Pads a paramater ID string up to 16 bytes.
%Description:
%    Pads the end of an input paramater ID string with whitespace and a null character up to a
%    length of 16 bytes. Useful for the msg_param_set ID field.
%Arguments:
%    paramID(string): The paramater ID string to be padded

    %Fill the spring with spaces
    outString(1:16) = ' ';
    %Add a null character
    outString(size(paramID,2)+1) = 0;
    %Overwrite the first n characters with the supplied paramID;
    outString(1:size(paramID,2)) = paramID;
    outString = outString(1:16);

end