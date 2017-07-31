classdef msg_gps_inject_data < mavlink_message
	%MSG_GPS_INJECT_DATA: MAVLINK Message ID = 123
    %Description:
    %    data for injecting into the onboard GPS (used for DGPS)
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    target_system(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_gps_inject_data(target_system,target_component,len,data,varargin)
        %Create a new gps_inject_data message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(target_system,'mavlink_packet')
                    packet = target_system;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('target_system','mavlink_packet');
                end
            
            elseif nargin == 4
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.len = len;
                obj.data = data;
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

                packet = mavlink_packet(msg_gps_inject_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gps_inject_data.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.len);
                for i=1:1:110
                    packet.payload.putUINT8(obj.data(i));
                end

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
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.len(obj,value)
            if value == uint8(value)
                obj.len = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end