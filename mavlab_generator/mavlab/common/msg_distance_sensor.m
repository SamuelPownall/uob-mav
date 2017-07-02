classdef msg_distance_sensor < mavlink_message
    %MAVLINK Message Class
    %Name: distance_sensor	ID: 132
    %Description: None
            
    properties(Constant)
        ID = 132
        LEN = 14
    end
    
    properties        
		time_boot_ms	%Time since system boot (uint32[1])
		min_distance	%Minimum distance the sensor can measure in centimeters (uint16[1])
		max_distance	%Maximum distance the sensor can measure in centimeters (uint16[1])
		current_distance	%Current distance reading (uint16[1])
		type	%Type from MAV_DISTANCE_SENSOR enum. (uint8[1])
		id	%Onboard ID of the sensor (uint8[1])
		orientation	%Direction the sensor faces from MAV_SENSOR_ORIENTATION enum. (uint8[1])
		covariance	%Measurement covariance in centimeters, 0 for unknown / invalid readings (uint8[1])
	end

    
    methods
        
        %Constructor: msg_distance_sensor
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_distance_sensor(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_distance_sensor.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_distance_sensor.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putUINT16(obj.min_distance);

			packet.payload.putUINT16(obj.max_distance);

			packet.payload.putUINT16(obj.current_distance);

			packet.payload.putUINT8(obj.type);

			packet.payload.putUINT8(obj.id);

			packet.payload.putUINT8(obj.orientation);

			packet.payload.putUINT8(obj.covariance);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.min_distance = payload.getUINT16();

			obj.max_distance = payload.getUINT16();

			obj.current_distance = payload.getUINT16();

			obj.type = payload.getUINT8();

			obj.id = payload.getUINT8();

			obj.orientation = payload.getUINT8();

			obj.covariance = payload.getUINT8();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.min_distance(obj,value)
            if value == uint16(value)
                obj.min_distance = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.min_distance()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.max_distance(obj,value)
            if value == uint16(value)
                obj.max_distance = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.max_distance()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.current_distance(obj,value)
            if value == uint16(value)
                obj.current_distance = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.current_distance()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.id(obj,value)
            if value == uint8(value)
                obj.id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.orientation(obj,value)
            if value == uint8(value)
                obj.orientation = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.orientation()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.covariance(obj,value)
            if value == uint8(value)
                obj.covariance = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | distance_sensor.set.covariance()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end