clear;
echotcpip('on',4000);
%tclient = tcpclient('127.0.0.1',14552);
tclient = tcpclient('localhost',4000);
parser = mavlink_parser();
msg = [];
messages = 0;

tmsg = msg_distance_sensor([],166,22,122,77,12,33,100,44);
packet = tmsg.pack();
if ~isempty(packet)
    buffer = packet.encode();
    write(tclient,buffer);
else
    echotcpip('off');
    error('IT BROKE')
end

while messages < 1
   
    if tclient.BytesAvailable > 0
        c = read(tclient,1,'uint8');
        msg = parser.parseChar(c);
        if isempty(msg) ~= 1
            fprintf('MESSAGE:\tID\t%d\t\tLEN\t%d\t\tSEQ\t%d\n',msg.msgid,msg.len,msg.seq);
            messages = messages + 1;
            switch msg.msgid
                case 132
                    msg = msg.unpack();
            end
        end
            
    end
    
end

msg

echotcpip('off')
clear t;