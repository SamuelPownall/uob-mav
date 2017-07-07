clear;
%echotcpip('on',4000);
tclient = tcpclient('127.0.0.1',14552);
%tclient = tcpclient('localhost',4000);
parser = mavlink_parser();
msg = [];
messages = 0;

while messages < 100

    if tclient.BytesAvailable > 0
        c = read(tclient,1,'uint8');
        msg = parser.parseChar(c);
        if isempty(msg) ~= 1
            fprintf('MESSAGE:\tID\t%d\t\tLEN\t%d\t\tSEQ\t%d\n',msg.msgid,msg.len,msg.seq);
            messages = messages + 1;
        end      
    end

end

%echotcpip('off')
clear t;