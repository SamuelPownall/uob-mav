classdef msg_global_vision_position_estimate < mavlink_message
	%MSG_GLOBAL_VISION_POSITION_ESTIMATE: MAVLINK Message ID = 101
    %Description:
    %    No description available
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    usec(uint64): Timestamp (microseconds, synced to UNIX time or since system boot)
    %    x(single): Global X position
    %    y(single): Global Y position
    %    z(single): Global Z position
    %    roll(single): Roll angle in rad
    %    pitch(single): Pitch angle in rad
    %    yaw(single): Yaw angle in rad
	
	properties(Constant)
		ID = 101
		LEN = 32
	end
	
	properties
        usec	%Timestamp (microseconds, synced to UNIX time or since system boot)	|	(uint64)
        x	%Global X position	|	(single)
        y	%Global Y position	|	(single)
        z	%Global Z position	|	(single)
        roll	%Roll angle in rad	|	(single)
        pitch	%Pitch angle in rad	|	(single)
        yaw	%Yaw angle in rad	|	(single)
    end

    methods

        function obj = msg_global_vision_position_estimate(usec,x,y,z,roll,pitch,yaw,varargin)
        %Create a new global_vision_position_estimate message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(usec,'mavlink_packet')
                    packet = usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('usec','mavlink_packet');
                end
            
            elseif nargin == 7
                obj.usec = usec;
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_global_vision_position_estimate.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_global_vision_position_estimate.ID;
                
                packet.payload.putUINT64(obj.usec);
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.usec = payload.getUINT64();
            obj.x = payload.getSINGLE();
            obj.y = payload.getSINGLE();
            obj.z = payload.getSINGLE();
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.usec,2) ~= 1
                result = 'usec';
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';

            else
                result = 0;
            end
        end

        function set.usec(obj,value)
            if value == uint64(value)
                obj.usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.x(obj,value)
            obj.x = single(value);
        end
        
        function set.y(obj,value)
            obj.y = single(value);
        end
        
        function set.z(obj,value)
            obj.z = single(value);
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
        
    end

end