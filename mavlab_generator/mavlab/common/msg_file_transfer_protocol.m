classdef msg_file_transfer_protocol < mavlink_message
    %MAVLINK Message Class
    %Name: file_transfer_protocol	ID: 110
    %Description: File transfer message
            
    properties(Constant)
        ID = 110
        LEN = 254
    end
    
    properties        
		target_network	%Network ID (0 for broadcast) (uint8[1])
		target_system	%System ID (0 for broadcast) (uint8[1])
		target_component	%Component ID (0 for broadcast) (uint8[1])
		payload	%Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification. (uint8[251])
	end

    
    methods
        
        %Constructor: msg_file_transfer_protocol
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_file_transfer_protocol(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_file_transfer_protocol.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_file_transfer_protocol.ID;
                
			packet.payload.putUINT8(obj.target_network);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);
            
            for i = 1:251
                packet.payload.putUINT8(obj.payload(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.target_network = payload.getUINT8();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();
            
            for i = 1:251
                obj.payload(i) = payload.getUINT8();
            end
                            
		end
            
        function set.target_network(obj,value)
            if value == uint8(value)
                obj.target_network = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | file_transfer_protocol.set.target_network()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | file_transfer_protocol.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | file_transfer_protocol.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.payload(obj,value)
            if value == uint8(value)
                obj.payload = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | file_transfer_protocol.set.payload()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end