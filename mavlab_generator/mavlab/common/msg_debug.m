classdef msg_debug < mavlink_handle
	%MSG_DEBUG(packet,time_boot_ms,value,ind): MAVLINK Message ID = 254
    %Description:
    %    Send a debug value. The index is used to discriminate between values. These values show up in the plot of QGroundControl as DEBUG N.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    value(single): DEBUG value
    %    ind(uint8): index of debug variable
	
	properties(Constant)
		ID = 254
		LEN = 9
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        value	%DEBUG value	|	(single)
        ind	%index of debug variable	|	(uint8)
    end

    methods

        %Constructor: msg_debug
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_debug(packet,time_boot_ms,value,ind)
        
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
                obj.time_boot_ms = time_boot_ms;
                obj.value = value;
                obj.ind = ind;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_debug.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_debug.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.value);
                packet.payload.putUINT8(obj.ind);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.value = payload.getSINGLE();
            obj.ind = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.value,2) ~= 1
                result = 'value';
            elseif size(obj.ind,2) ~= 1
                result = 'ind';

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
        
        function set.value(obj,value)
            obj.value = single(value);
        end
        
        function set.ind(obj,value)
            if value == uint8(value)
                obj.ind = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end