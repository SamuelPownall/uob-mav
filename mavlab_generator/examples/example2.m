%Example script demonstrating receiving of packets and decoding of messages

%Setup the TCP connection
address = '127.0.0.1'
port = 14552;
tclient = tcpclient(address,port);

%Create a MAVLinkParser object to handle parsing of messages
parser = MAVLinkParser();

%Read packets for 5 minutes
tic();
while toc() < 5*60
    
    %If bytes have been received over the TCP connection
    if tclient.BytesAvailable > 0
        
        %Read the first received byte of information
        byte = read(tclient,1,'uint8');
        %Parse the current byte of information
        packet = parser.parseChar(byte);
        
        %Check whether the parser returned a packet
        if ~isempty(packet)
            
            %Switch case runs different code depending on the msgid within the packet
            switch(packet.msgid)
                
                %If the ID is 0 decode the packet as a heartbeat message
                case 0
                    message = msg_heartbeat(packet);
                    
                %If the ID is 30 decode the packet as an attitude message
                case 30
                    message = msg_attitude(packet);
                    
                %Otherwise the packet msgid is not supported by this script
                otherwise
                    disp('Unsupported');
                    
            end
        end
    end
end

%Close the TCP connection and clear the object
clear tclient;