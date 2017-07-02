classdef msg_set_gps_global_origin < mavlink_message
    %MAVLINK Message Class
    %Name: set_gps_global_origin	ID: 48
    %Description: As local waypoints exist, the global MISSION reference allows to transform between the local coordinate frame and the global (GPS) coordinate frame. This can be necessary when e.g. in- and outdoor settings are connected and the MAV should move from in- to outdoor.
            
    properties(Constant)
        ID = 48
        LEN = 13
    end
    
    properties        
		latitude	%Latitude (WGS84), in degrees * 1E7 (int32[1])
		longitude	%Longitude (WGS84, in degrees * 1E7 (int32[1])
		altitude	%Altitude (AMSL), in meters * 1000 (positive for up) (int32[1])
		target_system	%System ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_set_gps_global_origin
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_gps_global_origin(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_set_gps_global_origin.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_set_gps_global_origin.ID;
                
			packet.payload.putINT32(obj.latitude);

			packet.payload.putINT32(obj.longitude);

			packet.payload.putINT32(obj.altitude);

			packet.payload.putUINT8(obj.target_system);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.latitude = payload.getINT32();

			obj.longitude = payload.getINT32();

			obj.altitude = payload.getINT32();

			obj.target_system = payload.getUINT8();

		end
            
        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_gps_global_origin.set.latitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_gps_global_origin.set.longitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.altitude(obj,value)
            if value == int32(value)
                obj.altitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_gps_global_origin.set.altitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_gps_global_origin.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end