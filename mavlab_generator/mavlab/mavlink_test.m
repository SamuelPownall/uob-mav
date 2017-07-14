clear;
clc();
tclient = tcpclient('127.0.0.1',14552);
parser = mavlink_parser();
packet = [];
msg = [];
tic();

scr = get(groot,'screensize');

angles = figure('units','pixels','position',[scr(3)/16,scr(4)/16,6.5*scr(3)/16,13*scr(4)/16]);

subplot(3,1,1)
pitch = animatedline();
labelGraph('Pitch Angle (rad)');

subplot(3,1,2)
roll = animatedline();
labelGraph('Roll Angle (rad)');

subplot(3,1,3)
yaw = animatedline();
labelGraph('Yaw Angle (rad)');

rates = figure('units','pixels','position',[8.5*scr(3)/16,scr(4)/16,6.5*scr(3)/16,13*scr(4)/16]);

subplot(3,1,1)
pitchRate = animatedline();
labelGraph('Pitch Rate (rad/s)');

subplot(3,1,2)
rollRate = animatedline();
labelGraph('Roll Rate (rad/s)');

subplot(3,1,3)
yawRate = animatedline();
labelGraph('Yaw Rate (rad/s)');

while toc() <= 20

    if tclient.BytesAvailable > 0
        c = read(tclient,1,'uint8');
        packet = parser.parseChar(c);
        if isempty(packet) ~= 1
            if packet.msgid == 30
                time = toc();
                msg = packet.unpack();
                addpoints(pitch,time,double(msg.pitch));
                addpoints(roll,time,double(msg.roll));
                addpoints(yaw,time,double(msg.yaw));
                addpoints(pitchRate,time,double(msg.pitchspeed));
                addpoints(rollRate,time,double(msg.rollspeed));
                addpoints(yawRate,time,double(msg.yawspeed));
                drawnow;
            end
        end      
    end

end

clear t;

function labelGraph(param)

    axis([0 20 -pi pi]);
    xlabel('Time (s)');
    ylabel(param);
    set(gca,'ytick',-pi:pi/2:pi);
    set(gca,'yticklabel',{'-\pi','-\pi/2','0','\pi/2','\pi'});

end