classdef msg_encapsulated_data < mavlink_message
    %MAVLINK Message Class
    %Name: encapsulated_data	ID: 131
    %Description: None
            
    properties(Constant)
        ID = 131
        LEN = 255
    end
    
    properties        
		seqnr	%sequence number (starting with 0 on every transmission) (uint16[1])
		data	%image data bytes (uint8[253])
	end

    
    methods
        
        %Constructor: msg_encapsulated_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_encapsulated_data(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_encapsulated_data.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_encapsulated_data.ID;
                
			packet.payload.putUINT16(obj.seqnr);
            
            for i = 1:253
                packet.payload.putUINT8(obj.data(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.seqnr = payload.getUINT16();
            
            for i = 1:253
                obj.data(i) = payload.getUINT8();
            end
                            
		end
            
        function set.seqnr(obj,value)
            if value == uint16(value)
                obj.seqnr = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | encapsulated_data.set.seqnr()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | encapsulated_data.set.data()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end