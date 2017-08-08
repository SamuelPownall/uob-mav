%Example script demonstrating packing of messages and transmission of encoded packets

%Example data used by this script to pack the attitude message
time_boot_ms = 100000;
roll = 0.5*pi;
pitch = 0.25*pi;
yaw = -0.33*pi;
rollspeed = -pi;
pitchspeed = 0;
yawspeed = pi;

%Setup the TCP connection
address = '127.0.0.1'
port = 14552;
tclient = tcpclient(address,port);

%Create a new MAVLink attitude message (ID = 30) with initial data for the fields
message = msg_attitude(time_boot_ms,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed);
%Overwrite the roll field with new data
message.roll = 0.25*pi;

%MANUAL TRANSMISSION USING INDIVIDUAL FUNCTIONS (BETTER ERROR CHECKING)

%Pack the message into a MAVLink packet
packet = message.pack();
%Check that the message packed correctly
if ~isempty(packet);
    
    %Encode the packet as a stream of bytes
    sendBuffer = packet.encode();
    %Transmit the byte stream over the TCP connection
    write(tclient,sendBuffer);
    
end
    
%SIMPLE TRANSMISSION USING THE SEND FUNCTION (EASIER BUT ASSUMES CORRECT DATA)

%Send the message
message.send();

%Close the TCP connection and clear the object
clear tclient;