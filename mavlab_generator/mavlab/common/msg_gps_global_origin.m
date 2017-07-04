classdef msg_gps_global_origin < mavlink_message
    %MAVLINK Message Class
    %Name: gps_global_origin	ID: 49
    %Description: Once the MAV sets a new GPS-Local correspondence, this message announces the origin (0,0,0) position
            
    properties(Constant)
        ID = 49
        LEN = 12
    end
    
    properties        
		latitude	%Latitude (WGS84), in degrees * 1E7 (int32)
		longitude	%Longitude (WGS84), in degrees * 1E7 (int32)
		altitude	%Altitude (AMSL), in meters * 1000 (positive for up) (int32)
	end
    
    methods
        
        %Constructor: msg_gps_global_origin
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_gps_global_origin(packet,latitude,longitude,altitude)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
                
            elseif nargin == 4
                
				obj.latitude = latitude;
				obj.longitude = longitude;
				obj.altitude = altitude;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_gps_global_origin.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gps_global_origin.ID;
                
				packet.payload.putINT32(obj.latitude);

				packet.payload.putINT32(obj.longitude);

				packet.payload.putINT32(obj.altitude);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.latitude = payload.getINT32();

			obj.longitude = payload.getINT32();

			obj.altitude = payload.getINT32();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.latitude,2) ~= 1
                result = 'latitude';                                        
            elseif size(obj.longitude,2) ~= 1
                result = 'longitude';                                        
            elseif size(obj.altitude,2) ~= 1
                result = 'altitude';                            
            else
                result = 0;
            end
            
        end
                                
        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.altitude(obj,value)
            if value == int32(value)
                obj.altitude = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                        
	end
end