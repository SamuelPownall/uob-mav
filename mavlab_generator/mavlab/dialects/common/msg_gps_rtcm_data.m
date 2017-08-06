classdef msg_gps_rtcm_data < MAVLinkMessage
	%MSG_GPS_RTCM_DATA: MAVLink Message ID = 233
    %Description:
    %    WORK IN PROGRESS! RTCM message for injecting into the onboard GPS (used for DGPS)
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    flags(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    flags(uint8): LSB: 1 means message is fragmented
    %    len(uint8): data length
    %    data(uint8[127]): RTCM message (may be fragmented)
	
	properties(Constant)
		ID = 233
		LEN = 127
	end
	
	properties
        flags	%LSB: 1 means message is fragmented	|	(uint8)
        len	%data length	|	(uint8)
        data	%RTCM message (may be fragmented)	|	(uint8[127])
    end

    methods(Static)

        function send(out,flags,len,data,varargin)

            if nargin == 3 + 1
                msg = msg_gps_rtcm_data(flags,len,data,varargin);
            elseif nargin == 2
                msg = msg_gps_rtcm_data(flags);
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

        function obj = msg_gps_rtcm_data(flags,len,data,varargin)
        %MSG_GPS_RTCM_DATA: Create a new gps_rtcm_data message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(flags,'MAVLinkPacket')
                    packet = flags;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('flags','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.flags = flags;
                obj.len = len;
                obj.data = data;
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

                packet = MAVLinkPacket(msg_gps_rtcm_data.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gps_rtcm_data.ID;
                
                packet.payload.putUINT8(obj.flags);
                packet.payload.putUINT8(obj.len);
                for i=1:1:127
                    packet.payload.putUINT8(obj.data(i));
                end

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
            
            obj.flags = payload.getUINT8();
            obj.len = payload.getUINT8();
            for i=1:1:127
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.flags,2) ~= 1
                result = 'flags';
            elseif size(obj.len,2) ~= 1
                result = 'len';
            elseif size(obj.data,2) ~= 127
                result = 'data';

            else
                result = 0;
            end
        end

        function set.flags(obj,value)
            if value == uint8(value)
                obj.flags = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.len(obj,value)
            if value == uint8(value)
                obj.len = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end