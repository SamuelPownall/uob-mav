classdef msg_attitude < MAVLinkMessage
	%MSG_ATTITUDE: MAVLink Message ID = 30
    %Description:
    %    The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    roll(single): Roll angle (rad, -pi..+pi)
    %    pitch(single): Pitch angle (rad, -pi..+pi)
    %    yaw(single): Yaw angle (rad, -pi..+pi)
    %    rollspeed(single): Roll angular speed (rad/s)
    %    pitchspeed(single): Pitch angular speed (rad/s)
    %    yawspeed(single): Yaw angular speed (rad/s)
	
	properties(Constant)
		ID = 30
		LEN = 28
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        roll	%Roll angle (rad, -pi..+pi)	|	(single)
        pitch	%Pitch angle (rad, -pi..+pi)	|	(single)
        yaw	%Yaw angle (rad, -pi..+pi)	|	(single)
        rollspeed	%Roll angular speed (rad/s)	|	(single)
        pitchspeed	%Pitch angular speed (rad/s)	|	(single)
        yawspeed	%Yaw angular speed (rad/s)	|	(single)
    end

    methods(Static)

        function send(out,time_boot_ms,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed,varargin)

            if nargin == 7 + 1
                msg = msg_attitude(time_boot_ms,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed,varargin);
            elseif nargin == 2
                msg = msg_attitude(time_boot_ms);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_attitude(time_boot_ms,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed,varargin)
        %MSG_ATTITUDE: Create a new attitude message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_boot_ms,'MAVLinkPacket')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_boot_ms','MAVLinkPacket');
                end
            elseif nargin >= 7 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
                obj.rollspeed = rollspeed;
                obj.pitchspeed = pitchspeed;
                obj.yawspeed = yawspeed;
            elseif nargin ~= 0
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_attitude.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_attitude.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.rollspeed);
                packet.payload.putSINGLE(obj.pitchspeed);
                packet.payload.putSINGLE(obj.yawspeed);

            else
                packet = [];
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.rollspeed = payload.getSINGLE();
            obj.pitchspeed = payload.getSINGLE();
            obj.yawspeed = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';
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
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.roll(obj,value)
            obj.roll = single(value);
        end
        
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
        
        function set.yaw(obj,value)
            obj.yaw = single(value);
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