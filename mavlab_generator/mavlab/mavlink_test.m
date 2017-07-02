clear;
echotcpip('on',4000);
%tclient = tcpclient('127.0.0.1',14552);
tclient = tcpclient('localhost',4000);
parser = mavlink_parser();
msg = [];
messages = 0;

tmsg = msg_distance_sensor();
tmsg.time_boot_ms = 166;
tmsg.min_distance = 22;
tmsg.max_distance = 122;
tmsg.current_distance = 77;
tmsg.type = 12;
tmsg.id = 5;
tmsg.orientation = 100;
tmsg.covariance = 44;
buffer = tmsg.pack().encode();
write(tclient,buffer);

while messages < 1
   
    if tclient.BytesAvailable > 0
        c = read(tclient,1,'uint8');
        msg = parser.parseChar(c);
        if isempty(msg) ~= 1
            fprintf('MESSAGE:\tID\t%d\t\tLEN\t%d\t\tSEQ\t%d\n',msg.msgid,msg.len,msg.seq);
            switch msg.msgid
                case 132
                    msg = msg_distance_sensor(msg);
            end
            messages = messages + 1;
        end
            
    end
    
end

msg

echotcpip('off')
clear t;