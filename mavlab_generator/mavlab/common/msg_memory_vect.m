classdef msg_memory_vect < mavlink_message
    %MAVLINK Message Class
    %Name: memory_vect	ID: 249
    %Description: Send raw controller memory. The use of this message is discouraged for normal packets, but a quite efficient way for testing new messages and getting experimental debug output.
            
    properties(Constant)
        ID = 249
        LEN = 36
    end
    
    properties        
		address	%Starting address of the debug variables (uint16)
		ver	%Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below (uint8)
		type	%Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14 (uint8)
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
        
            errorField = obj.verify();
            if errorField == 0
        
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
                                        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.address = payload.getUINT16();

			obj.ver = payload.getUINT8();

			obj.type = payload.getUINT8();
            
            for i = 1:32
                obj.value(i) = payload.getINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.address,2) ~= 1
                result = 'address';                                        
            elseif size(obj.ver,2) ~= 1
                result = 'ver';                                        
            elseif size(obj.type,2) ~= 1
                result = 'type';                                        
            elseif size(obj.value,2) ~= 32
                result = 'value';                            
            else
                result = 0;
            end
            
        end
                                
        function set.address(obj,value)
            if value == uint16(value)
                obj.address = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.ver(obj,value)
            if value == uint8(value)
                obj.ver = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.value(obj,value)
            if value == int8(value)
                obj.value = int8(value);
            else
                mavlink.throwTypeError('value','int8');
            end
        end
                        
	end
end