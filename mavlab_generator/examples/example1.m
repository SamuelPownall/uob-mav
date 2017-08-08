%Example script demonstrating use of the tcpclient object

%IP Address to connect to (in this case the local address).
address = '127.0.0.1'
%Port to connect to (should be a routing port in MAVProxy).
port = 14552;
%Create the TCP connection and an object to handle the connection called tclient
tclient = tcpclient(address,port);

%Loop for 1 minute
tic();
while toc() < 60
    
    %If bytes have been received over the TCP connection
    if tclient.BytesAvailable > 0
        %Read the first received byte of information
        byte = read(tclient,1,'uint8');
    end
    
end

%Close the TCP connection and clear the object
clear tclient;