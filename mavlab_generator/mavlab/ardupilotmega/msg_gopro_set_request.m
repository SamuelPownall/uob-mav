classdef msg_gopro_set_request < mavlink_message
	%MSG_GOPRO_SET_REQUEST(packet,target_system,target_component,cmd_id,value): MAVLINK Message ID = 218
    %Description:
    %    Request to set a GOPRO_COMMAND with a desired
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    cmd_id(uint8): Command ID
    %    value(uint8): Value
	
	properties(Constant)
		ID = 218
		LEN = 4
	end
	
	properties
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        cmd_id	%Command ID	|	(uint8)
        value	%Value	|	(uint8)
    end

    methods

        %Constructor: msg_gopro_set_request
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gopro_set_request(packet,target_system,target_component,cmd_id,value)
        
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
            
            elseif nargin-1 == 4
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.cmd_id = cmd_id;
                obj.value = value;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_gopro_set_request.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gopro_set_request.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.cmd_id);
                packet.payload.putUINT8(obj.value);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.cmd_id = payload.getUINT8();
            obj.value = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.cmd_id,2) ~= 1
                result = 'cmd_id';
            elseif size(obj.value,2) ~= 1
                result = 'value';

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
        
        function set.cmd_id(obj,value)
            if value == uint8(value)
                obj.cmd_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.value(obj,value)
            if value == uint8(value)
                obj.value = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end