classdef msg_hil_optical_flow < mavlink_message
    %MAVLINK Message Class
    %Name: hil_optical_flow	ID: 114
    %Description: Simulated optical flow from a flow sensor (e.g. PX4FLOW or optical mouse sensor)
            
    properties(Constant)
        ID = 114
        LEN = 44
    end
    
    properties        
		time_usec	%Timestamp (microseconds, synced to UNIX time or since system boot) (uint64[1])
		integration_time_us	%Integration time in microseconds. Divide integrated_x and integrated_y by the integration time to obtain average flow. The integration time also indicates the. (uint32[1])
		time_delta_distance_us	%Time in microseconds since the distance was sampled. (uint32[1])
		integrated_x	%Flow in radians around X axis (Sensor RH rotation about the X axis induces a positive flow. Sensor linear motion along the positive Y axis induces a negative flow.) (single[1])
		integrated_y	%Flow in radians around Y axis (Sensor RH rotation about the Y axis induces a positive flow. Sensor linear motion along the positive X axis induces a positive flow.) (single[1])
		integrated_xgyro	%RH rotation around X axis (rad) (single[1])
		integrated_ygyro	%RH rotation around Y axis (rad) (single[1])
		integrated_zgyro	%RH rotation around Z axis (rad) (single[1])
		distance	%Distance to the center of the flow field in meters. Positive value (including zero): distance known. Negative value: Unknown distance. (single[1])
		temperature	%Temperature * 100 in centi-degrees Celsius (int16[1])
		sensor_id	%Sensor ID (uint8[1])
		quality	%Optical flow quality / confidence. 0: no valid flow, 255: maximum quality (uint8[1])
	end

    
    methods
        
        %Constructor: msg_hil_optical_flow
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_optical_flow(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_hil_optical_flow.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_hil_optical_flow.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putUINT32(obj.integration_time_us);

			packet.payload.putUINT32(obj.time_delta_distance_us);

			packet.payload.putSINGLE(obj.integrated_x);

			packet.payload.putSINGLE(obj.integrated_y);

			packet.payload.putSINGLE(obj.integrated_xgyro);

			packet.payload.putSINGLE(obj.integrated_ygyro);

			packet.payload.putSINGLE(obj.integrated_zgyro);

			packet.payload.putSINGLE(obj.distance);

			packet.payload.putINT16(obj.temperature);

			packet.payload.putUINT8(obj.sensor_id);

			packet.payload.putUINT8(obj.quality);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.integration_time_us = payload.getUINT32();

			obj.time_delta_distance_us = payload.getUINT32();

			obj.integrated_x = payload.getSINGLE();

			obj.integrated_y = payload.getSINGLE();

			obj.integrated_xgyro = payload.getSINGLE();

			obj.integrated_ygyro = payload.getSINGLE();

			obj.integrated_zgyro = payload.getSINGLE();

			obj.distance = payload.getSINGLE();

			obj.temperature = payload.getINT16();

			obj.sensor_id = payload.getUINT8();

			obj.quality = payload.getUINT8();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_optical_flow.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.integration_time_us(obj,value)
            if value == uint32(value)
                obj.integration_time_us = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_optical_flow.set.integration_time_us()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.time_delta_distance_us(obj,value)
            if value == uint32(value)
                obj.time_delta_distance_us = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_optical_flow.set.time_delta_distance_us()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.integrated_x(obj,value)
            obj.integrated_x = single(value);
        end
                                
        function set.integrated_y(obj,value)
            obj.integrated_y = single(value);
        end
                                
        function set.integrated_xgyro(obj,value)
            obj.integrated_xgyro = single(value);
        end
                                
        function set.integrated_ygyro(obj,value)
            obj.integrated_ygyro = single(value);
        end
                                
        function set.integrated_zgyro(obj,value)
            obj.integrated_zgyro = single(value);
        end
                                
        function set.distance(obj,value)
            obj.distance = single(value);
        end
                                    
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_optical_flow.set.temperature()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.sensor_id(obj,value)
            if value == uint8(value)
                obj.sensor_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_optical_flow.set.sensor_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.quality(obj,value)
            if value == uint8(value)
                obj.quality = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_optical_flow.set.quality()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end