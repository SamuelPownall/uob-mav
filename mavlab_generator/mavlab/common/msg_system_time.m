classdef msg_system_time < mavlink_message
    %MAVLINK Message Class
    %Name: system_time	ID: 2
    %Description: The system time is the time of the master clock, typically the computer clock of the main onboard computer.
            
    properties(Constant)
        ID = 2
        LEN = 12
    end
    
    properties        
		time_unix_usec	%Timestamp of the master clock in microseconds since UNIX epoch. (uint64[1])
		time_boot_ms	%Timestamp of the component clock since boot time in milliseconds. (uint32[1])
	end

    
    methods
        
        %Constructor: msg_system_time
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_system_time(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_system_time.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_system_time.ID;
                
			packet.payload.putUINT64(obj.time_unix_usec);

			packet.payload.putUINT32(obj.time_boot_ms);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_unix_usec = payload.getUINT64();

			obj.time_boot_ms = payload.getUINT32();

		end
            
        function set.time_unix_usec(obj,value)
            if value == uint64(value)
                obj.time_unix_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | system_time.set.time_unix_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | system_time.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                        
	end
end