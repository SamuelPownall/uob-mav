classdef msg_optical_flow < mavlink_message
    %MAVLINK Message Class
    %Name: optical_flow	ID: 100
    %Description: Optical flow from a flow sensor (e.g. optical mouse sensor)
            
    properties(Constant)
        ID = 100
        LEN = 26
    end
    
    properties        
		time_usec	%Timestamp (UNIX) (uint64[1])
		flow_comp_m_x	%Flow in meters in x-sensor direction, angular-speed compensated (single[1])
		flow_comp_m_y	%Flow in meters in y-sensor direction, angular-speed compensated (single[1])
		ground_distance	%Ground distance in meters. Positive value: distance known. Negative value: Unknown distance (single[1])
		flow_x	%Flow in pixels * 10 in x-sensor direction (dezi-pixels) (int16[1])
		flow_y	%Flow in pixels * 10 in y-sensor direction (dezi-pixels) (int16[1])
		sensor_id	%Sensor ID (uint8[1])
		quality	%Optical flow quality / confidence. 0: bad, 255: maximum quality (uint8[1])
	end

    
    methods
        
        %Constructor: msg_optical_flow
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_optical_flow(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_optical_flow.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_optical_flow.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putSINGLE(obj.flow_comp_m_x);

			packet.payload.putSINGLE(obj.flow_comp_m_y);

			packet.payload.putSINGLE(obj.ground_distance);

			packet.payload.putINT16(obj.flow_x);

			packet.payload.putINT16(obj.flow_y);

			packet.payload.putUINT8(obj.sensor_id);

			packet.payload.putUINT8(obj.quality);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.flow_comp_m_x = payload.getSINGLE();

			obj.flow_comp_m_y = payload.getSINGLE();

			obj.ground_distance = payload.getSINGLE();

			obj.flow_x = payload.getINT16();

			obj.flow_y = payload.getINT16();

			obj.sensor_id = payload.getUINT8();

			obj.quality = payload.getUINT8();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | optical_flow.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.flow_comp_m_x(obj,value)
            obj.flow_comp_m_x = single(value);
        end
                                
        function set.flow_comp_m_y(obj,value)
            obj.flow_comp_m_y = single(value);
        end
                                
        function set.ground_distance(obj,value)
            obj.ground_distance = single(value);
        end
                                    
        function set.flow_x(obj,value)
            if value == int16(value)
                obj.flow_x = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | optical_flow.set.flow_x()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.flow_y(obj,value)
            if value == int16(value)
                obj.flow_y = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | optical_flow.set.flow_y()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.sensor_id(obj,value)
            if value == uint8(value)
                obj.sensor_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | optical_flow.set.sensor_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.quality(obj,value)
            if value == uint8(value)
                obj.quality = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | optical_flow.set.quality()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end