classdef msg_vision_position_estimate < MAVLinkMessage
	%MSG_VISION_POSITION_ESTIMATE: MAVLink Message ID = 102
    %Description:
    %    No description available
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    usec(uint64): Timestamp (microseconds, synced to UNIX time or since system boot)
    %    x(single): Global X position
    %    y(single): Global Y position
    %    z(single): Global Z position
    %    roll(single): Roll angle in rad
    %    pitch(single): Pitch angle in rad
    %    yaw(single): Yaw angle in rad
	
	properties(Constant)
		ID = 102
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

    methods(Static)

        function send(out,usec,x,y,z,roll,pitch,yaw,varargin)

            if nargin == 7 + 1
                msg = msg_vision_position_estimate(usec,x,y,z,roll,pitch,yaw,varargin);
            elseif nargin == 2
                msg = msg_vision_position_estimate(usec);
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

        function obj = msg_vision_position_estimate(usec,x,y,z,roll,pitch,yaw,varargin)
        %MSG_VISION_POSITION_ESTIMATE: Create a new vision_position_estimate message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(usec,'MAVLinkPacket')
                    packet = usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('usec','MAVLinkPacket');
                end
            elseif nargin >= 7 && isempty(varargin{1})
                obj.usec = usec;
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
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

                packet = MAVLinkPacket(msg_vision_position_estimate.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_vision_position_estimate.ID;
                
                packet.payload.putUINT64(obj.usec);
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);

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
                MAVLink.throwTypeError('value','uint64');
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