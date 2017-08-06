clear;
clc();
echotcpip('on',14552);
tclient = tcpclient('127.0.0.1',14552);
parser = MAVLinkParser();
msg_attitude.send(tclient,1,2,3,4,5,6,7);
message = 0;
tic();

while message == 0 && toc() < 5

    if tclient.BytesAvailable > 0
        c = read(tclient,1,'uint8');
        recPacket = parser.parseChar(c);
        if isempty(recPacket) ~= 1
            if recPacket.msgid == 30
                recMsg = msg_attitude(recPacket)
                message = 1;
            end
        end      
    end

end

echotcpip('off');
clear t;