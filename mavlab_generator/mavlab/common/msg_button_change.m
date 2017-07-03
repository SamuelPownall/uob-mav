classdef msg_button_change < mavlink_message
    %MAVLINK Message Class
    %Name: button_change	ID: 257
    %Description: Report button state change
            
    properties(Constant)
        ID = 257
        LEN = 9
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		last_change_ms	%Time of last change of button state (uint32)
		state	%Bitmap state of buttons (uint8)
	end
    
    methods
        
        %Constructor: msg_button_change
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_button_change(packet)
        
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
        
                packet = mavlink_packet(msg_button_change.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_button_change.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putUINT32(obj.last_change_ms);

				packet.payload.putUINT8(obj.state);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_button_change.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.last_change_ms = payload.getUINT32();

			obj.state = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
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
                fprintf(2,'MAVLAB-ERROR | button_change.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.last_change_ms(obj,value)
            if value == uint32(value)
                obj.last_change_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | button_change.set.last_change_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.state(obj,value)
            if value == uint8(value)
                obj.state = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | button_change.set.state()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end