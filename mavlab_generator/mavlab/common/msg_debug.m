classdef msg_debug < mavlink_message
    %MAVLINK Message Class
    %Name: debug	ID: 254
    %Description: Send a debug value. The index is used to discriminate between values. These values show up in the plot of QGroundControl as DEBUG N.
            
    properties(Constant)
        ID = 254
        LEN = 9
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		value	%DEBUG value (single[1])
		ind	%index of debug variable (uint8[1])
	end

    
    methods
        
        %Constructor: msg_debug
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_debug(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_debug.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_debug.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putSINGLE(obj.value);

			packet.payload.putUINT8(obj.ind);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.value = payload.getSINGLE();

			obj.ind = payload.getUINT8();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | debug.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.value(obj,value)
            obj.value = single(value);
        end
                                    
        function set.ind(obj,value)
            if value == uint8(value)
                obj.ind = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | debug.set.ind()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end