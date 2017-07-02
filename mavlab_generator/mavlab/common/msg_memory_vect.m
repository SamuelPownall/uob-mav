classdef msg_memory_vect < mavlink_message
    %MAVLINK Message Class
    %Name: memory_vect	ID: 249
    %Description: Send raw controller memory. The use of this message is discouraged for normal packets, but a quite efficient way for testing new messages and getting experimental debug output.
            
    properties(Constant)
        ID = 249
        LEN = 36
    end
    
    properties        
		address	%Starting address of the debug variables (uint16[1])
		ver	%Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below (uint8[1])
		type	%Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14 (uint8[1])
		value	%Memory contents at specified address (int8[32])
	end

    
    methods
        
        %Constructor: msg_memory_vect
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_memory_vect(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_memory_vect.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_memory_vect.ID;
                
			packet.payload.putUINT16(obj.address);

			packet.payload.putUINT8(obj.ver);

			packet.payload.putUINT8(obj.type);
            
            for i = 1:32
                packet.payload.putINT8(obj.value(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.address = payload.getUINT16();

			obj.ver = payload.getUINT8();

			obj.type = payload.getUINT8();
            
            for i = 1:32
                obj.value(i) = payload.getINT8();
            end
                            
		end
            
        function set.address(obj,value)
            if value == uint16(value)
                obj.address = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | memory_vect.set.address()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.ver(obj,value)
            if value == uint8(value)
                obj.ver = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | memory_vect.set.ver()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | memory_vect.set.type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.value(obj,value)
            if value == int8(value)
                obj.value = int8(value);
            else
                fprintf(2,'MAVLAB-ERROR | memory_vect.set.value()\n\t Input "value" is not of type "int8"\n');
            end
        end
                        
	end
end