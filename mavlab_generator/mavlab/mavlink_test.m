clear all;
clc;

echotcpip('on',14552);
t = tcpclient('localhost',14552);
parser = mavlink_parser();

tic();
msgRec = [];
msgSend = msg_gimbal_home_offset_calibration_result(1)
bufferSend = msgSend.pack().encode();

write(t, bufferSend);

while toc() < 0.5
    if t.BytesAvailable > 0
        c = read(t,1);
        packetRec = parser.parseChar(uint8(c));
        if ~isempty(packetRec)
            msgRec = packetRec.unpack();
            if msgRec.msgid == 205
                msgRec
            end    
        end
    end
end

echotcpip('off');