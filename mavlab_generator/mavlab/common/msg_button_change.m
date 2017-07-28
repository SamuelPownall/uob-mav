classdef msg_button_change < mavlink_message
	%MSG_BUTTON_CHANGE(packet,time_boot_ms,last_change_ms,state): MAVLINK Message ID = 257
    %Description:
    %    Report button state change
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    last_change_ms(uint32): Time of last change of button state
    %    state(uint8): Bitmap state of buttons
	
	properties(Constant)
		ID = 257
		LEN = 9
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        last_change_ms	%Time of last change of button state	|	(uint32)
        state	%Bitmap state of buttons	|	(uint8)
    end

    methods

        %Constructor: msg_button_change
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_button_change(packet,time_boot_ms,last_change_ms,state)
        
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
                obj.last_change_ms = last_change_ms;
                obj.state = state;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_button_change.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_button_change.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putUINT32(obj.last_change_ms);
                packet.payload.putUINT8(obj.state);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.last_change_ms = payload.getUINT32();
            obj.state = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.last_change_ms,2) ~= 1
                result = 'last_change_ms';
            elseif size(obj.state,2) ~= 1
                result = 'state';

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
        
        function set.last_change_ms(obj,value)
            if value == uint32(value)
                obj.last_change_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.state(obj,value)
            if value == uint8(value)
                obj.state = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end