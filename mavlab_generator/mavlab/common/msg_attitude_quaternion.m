classdef msg_attitude_quaternion < mavlink_handle
	%MSG_ATTITUDE_QUATERNION(packet,time_boot_ms,q1,q2,q3,q4,rollspeed,pitchspeed,yawspeed): MAVLINK Message ID = 31
    %Description:
    %    The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would be expressed as (1 0 0 0).
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    q1(single): Quaternion component 1, w (1 in null-rotation)
    %    q2(single): Quaternion component 2, x (0 in null-rotation)
    %    q3(single): Quaternion component 3, y (0 in null-rotation)
    %    q4(single): Quaternion component 4, z (0 in null-rotation)
    %    rollspeed(single): Roll angular speed (rad/s)
    %    pitchspeed(single): Pitch angular speed (rad/s)
    %    yawspeed(single): Yaw angular speed (rad/s)
	
	properties(Constant)
		ID = 31
		LEN = 32
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        q1	%Quaternion component 1, w (1 in null-rotation)	|	(single)
        q2	%Quaternion component 2, x (0 in null-rotation)	|	(single)
        q3	%Quaternion component 3, y (0 in null-rotation)	|	(single)
        q4	%Quaternion component 4, z (0 in null-rotation)	|	(single)
        rollspeed	%Roll angular speed (rad/s)	|	(single)
        pitchspeed	%Pitch angular speed (rad/s)	|	(single)
        yawspeed	%Yaw angular speed (rad/s)	|	(single)
    end

    methods

        %Constructor: msg_attitude_quaternion
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_attitude_quaternion(packet,time_boot_ms,q1,q2,q3,q4,rollspeed,pitchspeed,yawspeed)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
            
            elseif nargin-1 == 8
                obj.time_boot_ms = time_boot_ms;
                obj.q1 = q1;
                obj.q2 = q2;
                obj.q3 = q3;
                obj.q4 = q4;
                obj.rollspeed = rollspeed;
                obj.pitchspeed = pitchspeed;
                obj.yawspeed = yawspeed;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_attitude_quaternion.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_attitude_quaternion.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.q1);
                packet.payload.putSINGLE(obj.q2);
                packet.payload.putSINGLE(obj.q3);
                packet.payload.putSINGLE(obj.q4);
                packet.payload.putSINGLE(obj.rollspeed);
                packet.payload.putSINGLE(obj.pitchspeed);
                packet.payload.putSINGLE(obj.yawspeed);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.q1 = payload.getSINGLE();
            obj.q2 = payload.getSINGLE();
            obj.q3 = payload.getSINGLE();
            obj.q4 = payload.getSINGLE();
            obj.rollspeed = payload.getSINGLE();
            obj.pitchspeed = payload.getSINGLE();
            obj.yawspeed = payload.getSINGLE();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.q1,2) ~= 1
                result = 'q1';
            elseif size(obj.q2,2) ~= 1
                result = 'q2';
            elseif size(obj.q3,2) ~= 1
                result = 'q3';
            elseif size(obj.q4,2) ~= 1
                result = 'q4';
            elseif size(obj.rollspeed,2) ~= 1
                result = 'rollspeed';
            elseif size(obj.pitchspeed,2) ~= 1
                result = 'pitchspeed';
            elseif size(obj.yawspeed,2) ~= 1
                result = 'yawspeed';

            else
                result = 0;
            end
        end

        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.q1(obj,value)
            obj.q1 = single(value);
        end
        
        function set.q2(obj,value)
            obj.q2 = single(value);
        end
        
        function set.q3(obj,value)
            obj.q3 = single(value);
        end
        
        function set.q4(obj,value)
            obj.q4 = single(value);
        end
        
        function set.rollspeed(obj,value)
            obj.rollspeed = single(value);
        end
        
        function set.pitchspeed(obj,value)
            obj.pitchspeed = single(value);
        end
        
        function set.yawspeed(obj,value)
            obj.yawspeed = single(value);
        end
        
    end

end