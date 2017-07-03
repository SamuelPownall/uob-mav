classdef msg_named_value_float < mavlink_message
    %MAVLINK Message Class
    %Name: named_value_float	ID: 251
    %Description: Send a key-value pair as float. The use of this message is discouraged for normal packets, but a quite efficient way for testing new messages and getting experimental debug output.
            
    properties(Constant)
        ID = 251
        LEN = 18
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		value	%Floating point value (single)
		name	%Name of the debug variable (uint8[10])
	end
    
    methods
        
        %Constructor: msg_named_value_float
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_named_value_float(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_named_value_float.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_named_value_float.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putSINGLE(obj.value);
            
                for i = 1:10
                    packet.payload.putUINT8(obj.name(i));
                end
                                        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_named_value_float.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.value = payload.getSINGLE();
            
            for i = 1:10
                obj.name(i) = payload.getUINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.value,2) ~= 1
                result = 'value';                                        
            elseif size(obj.name,2) ~= 10
                result = 'name';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | named_value_float.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.value(obj,value)
            obj.value = single(value);
        end
                                    
        function set.name(obj,value)
            if value == uint8(value)
                obj.name = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | named_value_float.set.name()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end