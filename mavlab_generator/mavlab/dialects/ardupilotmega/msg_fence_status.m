classdef msg_fence_status < MAVLinkMessage
	%MSG_FENCE_STATUS: MAVLink Message ID = 162
    %Description:
    %    Status of geo-fencing. Sent in extended
	    status stream when fencing enabled
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    breach_time(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    breach_time(uint32): time of last breach in milliseconds since boot
    %    breach_count(uint16): number of fence breaches
    %    breach_status(uint8): 0 if currently inside fence, 1 if outside
    %    breach_type(uint8): last breach type (see FENCE_BREACH_* enum)
	
	properties(Constant)
		ID = 162
		LEN = 8
	end
	
	properties
        breach_time	%time of last breach in milliseconds since boot	|	(uint32)
        breach_count	%number of fence breaches	|	(uint16)
        breach_status	%0 if currently inside fence, 1 if outside	|	(uint8)
        breach_type	%last breach type (see FENCE_BREACH_* enum)	|	(uint8)
    end

    methods(Static)

        function send(out,breach_time,breach_count,breach_status,breach_type,varargin)

            if nargin == 4 + 1
                msg = msg_fence_status(breach_time,breach_count,breach_status,breach_type,varargin);
            elseif nargin == 2
                msg = msg_fence_status(breach_time);
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

        function obj = msg_fence_status(breach_time,breach_count,breach_status,breach_type,varargin)
        %MSG_FENCE_STATUS: Create a new fence_status message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(breach_time,'MAVLinkPacket')
                    packet = breach_time;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('breach_time','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.breach_time = breach_time;
                obj.breach_count = breach_count;
                obj.breach_status = breach_status;
                obj.breach_type = breach_type;
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

                packet = MAVLinkPacket(msg_fence_status.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_fence_status.ID;
                
                packet.payload.putUINT32(obj.breach_time);
                packet.payload.putUINT16(obj.breach_count);
                packet.payload.putUINT8(obj.breach_status);
                packet.payload.putUINT8(obj.breach_type);

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
            
            obj.breach_time = payload.getUINT32();
            obj.breach_count = payload.getUINT16();
            obj.breach_status = payload.getUINT8();
            obj.breach_type = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.breach_time,2) ~= 1
                result = 'breach_time';
            elseif size(obj.breach_count,2) ~= 1
                result = 'breach_count';
            elseif size(obj.breach_status,2) ~= 1
                result = 'breach_status';
            elseif size(obj.breach_type,2) ~= 1
                result = 'breach_type';

            else
                result = 0;
            end
        end

        function set.breach_time(obj,value)
            if value == uint32(value)
                obj.breach_time = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.breach_count(obj,value)
            if value == uint16(value)
                obj.breach_count = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.breach_status(obj,value)
            if value == uint8(value)
                obj.breach_status = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.breach_type(obj,value)
            if value == uint8(value)
                obj.breach_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end