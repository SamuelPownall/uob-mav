classdef msg_data96 < mavlink_message
	%MSG_DATA96: MAVLINK Message ID = 172
    %Description:
    %    Data packet, size 96
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    type(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    type(uint8): data type
    %    len(uint8): data length
    %    data(uint8[96]): raw data
	
	properties(Constant)
		ID = 172
		LEN = 98
	end
	
	properties
        type	%data type	|	(uint8)
        len	%data length	|	(uint8)
        data	%raw data	|	(uint8[96])
    end

    methods

        function obj = msg_data96(type,len,data,varargin)
        %MSG_DATA96: Create a new data96 message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(type,'mavlink_packet')
                    packet = type;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('type','mavlink_packet');
                end
            elseif nargin == 3
                obj.type = type;
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

                packet = mavlink_packet(msg_data96.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_data96.ID;
                
                packet.payload.putUINT8(obj.type);
                packet.payload.putUINT8(obj.len);
                for i=1:1:96
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
            
            obj.type = payload.getUINT8();
            obj.len = payload.getUINT8();
            for i=1:1:96
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.type,2) ~= 1
                result = 'type';
            elseif size(obj.len,2) ~= 1
                result = 'len';
            elseif size(obj.data,2) ~= 96
                result = 'data';

            else
                result = 0;
            end
        end

        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
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