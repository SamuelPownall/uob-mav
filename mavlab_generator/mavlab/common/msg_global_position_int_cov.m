classdef msg_global_position_int_cov < mavlink_message
    %MAVLINK Message Class
    %Name: global_position_int_cov	ID: 63
    %Description: The filtered global position (e.g. fused GPS and accelerometers). The position is in GPS-frame (right-handed, Z-up). It  is designed as scaled integer message since the resolution of float is not sufficient. NOTE: This message is intended for onboard networks / companion computers and higher-bandwidth links and optimized for accuracy and completeness. Please use the GLOBAL_POSITION_INT message for a minimal subset.
            
    properties(Constant)
        ID = 63
        LEN = 181
    end
    
    properties        
		time_usec	%Timestamp (microseconds since system boot or since UNIX epoch) (uint64[1])
		lat	%Latitude, expressed as degrees * 1E7 (int32[1])
		lon	%Longitude, expressed as degrees * 1E7 (int32[1])
		alt	%Altitude in meters, expressed as * 1000 (millimeters), above MSL (int32[1])
		relative_alt	%Altitude above ground in meters, expressed as * 1000 (millimeters) (int32[1])
		vx	%Ground X Speed (Latitude), expressed as m/s (single[1])
		vy	%Ground Y Speed (Longitude), expressed as m/s (single[1])
		vz	%Ground Z Speed (Altitude), expressed as m/s (single[1])
		covariance	%Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.) (single[36])
		estimator_type	%Class id of the estimator this estimate originated from. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_global_position_int_cov
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_global_position_int_cov(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_global_position_int_cov.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_global_position_int_cov.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putINT32(obj.alt);

			packet.payload.putINT32(obj.relative_alt);

			packet.payload.putSINGLE(obj.vx);

			packet.payload.putSINGLE(obj.vy);

			packet.payload.putSINGLE(obj.vz);
            
            for i = 1:36
                packet.payload.putSINGLE(obj.covariance(i));
            end
                            
			packet.payload.putUINT8(obj.estimator_type);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getINT32();

			obj.relative_alt = payload.getINT32();

			obj.vx = payload.getSINGLE();

			obj.vy = payload.getSINGLE();

			obj.vz = payload.getSINGLE();
            
            for i = 1:36
                obj.covariance(i) = payload.getSINGLE();
            end
                            
			obj.estimator_type = payload.getUINT8();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int_cov.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int_cov.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int_cov.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int_cov.set.alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.relative_alt(obj,value)
            if value == int32(value)
                obj.relative_alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int_cov.set.relative_alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.vx(obj,value)
            obj.vx = single(value);
        end
                                
        function set.vy(obj,value)
            obj.vy = single(value);
        end
                                
        function set.vz(obj,value)
            obj.vz = single(value);
        end
                                
        function set.covariance(obj,value)
            obj.covariance = single(value);
        end
                                    
        function set.estimator_type(obj,value)
            if value == uint8(value)
                obj.estimator_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int_cov.set.estimator_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end