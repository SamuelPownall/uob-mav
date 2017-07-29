classdef msg_file_transfer_protocol < mavlink_handle
	%MSG_FILE_TRANSFER_PROTOCOL(packet,target_network,target_system,target_component,payload): MAVLINK Message ID = 110
    %Description:
    %    File transfer message
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    target_network(uint8): Network ID (0 for broadcast)
    %    target_system(uint8): System ID (0 for broadcast)
    %    target_component(uint8): Component ID (0 for broadcast)
    %    payload(uint8[127]): Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
	
	properties(Constant)
		ID = 110
		LEN = 127
	end
	
	properties
        target_network	%Network ID (0 for broadcast)	|	(uint8)
        target_system	%System ID (0 for broadcast)	|	(uint8)
        target_component	%Component ID (0 for broadcast)	|	(uint8)
        payload	%Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.	|	(uint8[127])
    end

    methods

        %Constructor: msg_file_transfer_protocol
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_file_transfer_protocol(packet,target_network,target_system,target_component,payload)
        
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
                obj.target_network = target_network;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.payload = payload;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_file_transfer_protocol.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_file_transfer_protocol.ID;
                
                packet.payload.putUINT8(obj.target_network);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:127
                    packet.payload.putUINT8(obj.payload(i));
                end

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.target_network = payload.getUINT8();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            for i=1:1:127
                obj.payload(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.target_network,2) ~= 1
                result = 'target_network';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.payload,2) ~= 127
                result = 'payload';

            else
                result = 0;
            end
        end

        function set.target_network(obj,value)
            if value == uint8(value)
                obj.target_network = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
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
        
        function set.payload(obj,value)
            if value == uint8(value)
                obj.payload = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end