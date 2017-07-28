classdef msg_data96 < mavlink_message
	%MSG_DATA96(packet,type,len,data): MAVLINK Message ID = 172
    %Description:
    %    Data packet, size 96
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_data96
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_data96(packet,type,len,data)
        
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
            
            elseif nargin-1 == 3
                obj.type = type;
                obj.len = len;
                obj.data = data;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.type = payload.getUINT8();
            obj.len = payload.getUINT8();
            for i=1:1:96
                obj.data(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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