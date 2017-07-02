classdef msg_scaled_pressure3 < mavlink_message
    %MAVLINK Message Class
    %Name: scaled_pressure3	ID: 143
    %Description: Barometer readings for 3rd barometer
            
    properties(Constant)
        ID = 143
        LEN = 14
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		press_abs	%Absolute pressure (hectopascal) (single[1])
		press_diff	%Differential pressure 1 (hectopascal) (single[1])
		temperature	%Temperature measurement (0.01 degrees celsius) (int16[1])
	end

    
    methods
        
        %Constructor: msg_scaled_pressure3
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_scaled_pressure3(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_scaled_pressure3.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_scaled_pressure3.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putSINGLE(obj.press_abs);

			packet.payload.putSINGLE(obj.press_diff);

			packet.payload.putINT16(obj.temperature);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.press_abs = payload.getSINGLE();

			obj.press_diff = payload.getSINGLE();

			obj.temperature = payload.getINT16();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_pressure3.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.press_abs(obj,value)
            obj.press_abs = single(value);
        end
                                
        function set.press_diff(obj,value)
            obj.press_diff = single(value);
        end
                                    
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_pressure3.set.temperature()\n\t Input "value" is not of type "int16"\n');
            end
        end
                        
	end
end