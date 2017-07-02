classdef msg_follow_target < mavlink_message
    %MAVLINK Message Class
    %Name: follow_target	ID: 144
    %Description: current motion information from a designated system
            
    properties(Constant)
        ID = 144
        LEN = 93
    end
    
    properties        
		timestamp	%Timestamp in milliseconds since system boot (uint64[1])
		custom_state	%button states or switches of a tracker device (uint64[1])
		lat	%Latitude (WGS84), in degrees * 1E7 (int32[1])
		lon	%Longitude (WGS84), in degrees * 1E7 (int32[1])
		alt	%AMSL, in meters (single[1])
		vel	%target velocity (0,0,0) for unknown (single[3])
		acc	%linear target acceleration (0,0,0) for unknown (single[3])
		attitude_q	%(1 0 0 0 for unknown) (single[4])
		rates	%(0 0 0 for unknown) (single[3])
		position_cov	%eph epv (single[3])
		est_capabilities	%bit positions for tracker reporting capabilities (POS = 0, VEL = 1, ACCEL = 2, ATT + RATES = 3) (uint8[1])
	end

    
    methods
        
        %Constructor: msg_follow_target
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_follow_target(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_follow_target.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_follow_target.ID;
                
			packet.payload.putUINT64(obj.timestamp);

			packet.payload.putUINT64(obj.custom_state);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putSINGLE(obj.alt);
            
            for i = 1:3
                packet.payload.putSINGLE(obj.vel(i));
            end
                                        
            for i = 1:3
                packet.payload.putSINGLE(obj.acc(i));
            end
                                        
            for i = 1:4
                packet.payload.putSINGLE(obj.attitude_q(i));
            end
                                        
            for i = 1:3
                packet.payload.putSINGLE(obj.rates(i));
            end
                                        
            for i = 1:3
                packet.payload.putSINGLE(obj.position_cov(i));
            end
                            
			packet.payload.putUINT8(obj.est_capabilities);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.timestamp = payload.getUINT64();

			obj.custom_state = payload.getUINT64();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getSINGLE();
            
            for i = 1:3
                obj.vel(i) = payload.getSINGLE();
            end
                                        
            for i = 1:3
                obj.acc(i) = payload.getSINGLE();
            end
                                        
            for i = 1:4
                obj.attitude_q(i) = payload.getSINGLE();
            end
                                        
            for i = 1:3
                obj.rates(i) = payload.getSINGLE();
            end
                                        
            for i = 1:3
                obj.position_cov(i) = payload.getSINGLE();
            end
                            
			obj.est_capabilities = payload.getUINT8();

		end
            
        function set.timestamp(obj,value)
            if value == uint64(value)
                obj.timestamp = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | follow_target.set.timestamp()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.custom_state(obj,value)
            if value == uint64(value)
                obj.custom_state = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | follow_target.set.custom_state()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | follow_target.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | follow_target.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.alt(obj,value)
            obj.alt = single(value);
        end
                                
        function set.vel(obj,value)
            obj.vel = single(value);
        end
                                
        function set.acc(obj,value)
            obj.acc = single(value);
        end
                                
        function set.attitude_q(obj,value)
            obj.attitude_q = single(value);
        end
                                
        function set.rates(obj,value)
            obj.rates = single(value);
        end
                                
        function set.position_cov(obj,value)
            obj.position_cov = single(value);
        end
                                    
        function set.est_capabilities(obj,value)
            if value == uint8(value)
                obj.est_capabilities = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | follow_target.set.est_capabilities()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end