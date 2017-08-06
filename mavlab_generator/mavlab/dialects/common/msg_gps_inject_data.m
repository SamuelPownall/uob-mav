classdef msg_gps_inject_data < MAVLinkMessage
	%MSG_GPS_INJECT_DATA: MAVLink Message ID = 123
    %Description:
    %    data for injecting into the onboard GPS (used for DGPS)
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    target_system(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    len(uint8): data length
    %    data(uint8[110]): raw data (110 is enough for 12 satellites of RTCMv2)
	
	properties(Constant)
		ID = 123
		LEN = 113
	end
	
	properties
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        len	%data length	|	(uint8)
        data	%raw data (110 is enough for 12 satellites of RTCMv2)	|	(uint8[110])
    end

    methods(Static)

        function send(out,target_system,target_component,len,data,varargin)

            if nargin == 4 + 1
                msg = msg_gps_inject_data(target_system,target_component,len,data,varargin);
            elseif nargin == 2
                msg = msg_gps_inject_data(target_system);
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

        function obj = msg_gps_inject_data(target_system,target_component,len,data,varargin)
        %MSG_GPS_INJECT_DATA: Create a new gps_inject_data message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(target_system,'MAVLinkPacket')
                    packet = target_system;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('target_system','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = MAVLinkPacket(msg_gps_inject_data.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gps_inject_data.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.len);
                for i=1:1:110
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
            
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.len = payload.getUINT8();
            for i=1:1:110
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.len,2) ~= 1
                result = 'len';
            elseif size(obj.data,2) ~= 110
                result = 'data';

            else
                result = 0;
            end
        end

        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
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