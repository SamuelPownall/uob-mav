classdef msg_gps_global_origin < mavlink_message
    %MAVLINK Message Class
    %Name: gps_global_origin	ID: 49
    %Description: Once the MAV sets a new GPS-Local correspondence, this message announces the origin (0,0,0) position
            
    properties(Constant)
        ID = 49
        LEN = 12
    end
    
    properties        
		latitude	%Latitude (WGS84), in degrees * 1E7 (int32[1])
		longitude	%Longitude (WGS84), in degrees * 1E7 (int32[1])
		altitude	%Altitude (AMSL), in meters * 1000 (positive for up) (int32[1])
	end

    
    methods
        
        %Constructor: msg_gps_global_origin
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gps_global_origin(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_gps_global_origin.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_gps_global_origin.ID;
                
			packet.payload.putINT32(obj.latitude);

			packet.payload.putINT32(obj.longitude);

			packet.payload.putINT32(obj.altitude);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.latitude = payload.getINT32();

			obj.longitude = payload.getINT32();

			obj.altitude = payload.getINT32();

		end
            
        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_global_origin.set.latitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_global_origin.set.longitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.altitude(obj,value)
            if value == int32(value)
                obj.altitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_global_origin.set.altitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                        
	end
end