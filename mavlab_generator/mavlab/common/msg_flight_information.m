classdef msg_flight_information < mavlink_message
    %MAVLINK Message Class
    %Name: flight_information	ID: 264
    %Description: WIP: Information about flight since last arming
            
    properties(Constant)
        ID = 264
        LEN = 28
    end
    
    properties        
		arming_time_utc	%Timestamp at arming (microseconds since UNIX epoch) in UTC, 0 for unknown (uint64)
		takeoff_time_utc	%Timestamp at takeoff (microseconds since UNIX epoch) in UTC, 0 for unknown (uint64)
		flight_uuid	%Universally unique identifier (UUID) of flight, should correspond to name of logfiles (uint64)
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
	end
    
    methods
        
        %Constructor: msg_flight_information
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_flight_information(packet)
        
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
        
                packet = mavlink_packet(msg_flight_information.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_flight_information.ID;
                
				packet.payload.putUINT64(obj.arming_time_utc);

				packet.payload.putUINT64(obj.takeoff_time_utc);

				packet.payload.putUINT64(obj.flight_uuid);

				packet.payload.putUINT32(obj.time_boot_ms);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.arming_time_utc = payload.getUINT64();

			obj.takeoff_time_utc = payload.getUINT64();

			obj.flight_uuid = payload.getUINT64();

			obj.time_boot_ms = payload.getUINT32();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.arming_time_utc,2) ~= 1
                result = 'arming_time_utc';                                        
            elseif size(obj.takeoff_time_utc,2) ~= 1
                result = 'takeoff_time_utc';                                        
            elseif size(obj.flight_uuid,2) ~= 1
                result = 'flight_uuid';                                        
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                            
            else
                result = 0;
            end
            
        end
                                
        function set.arming_time_utc(obj,value)
            if value == uint64(value)
                obj.arming_time_utc = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                    
        function set.takeoff_time_utc(obj,value)
            if value == uint64(value)
                obj.takeoff_time_utc = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                    
        function set.flight_uuid(obj,value)
            if value == uint64(value)
                obj.flight_uuid = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                    
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                        
	end
end