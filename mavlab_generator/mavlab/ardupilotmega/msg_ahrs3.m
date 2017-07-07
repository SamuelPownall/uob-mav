classdef msg_ahrs3 < mavlink_message
    %MAVLINK Message Class
    %Name: ahrs3	ID: 182
    %Description: Status of third AHRS filter if available. This is for ANU research group (Ali and Sean)
            
    properties(Constant)
        ID = 182
        LEN = 40
    end
    
    properties        
		roll	%Roll angle (rad) (single)
		pitch	%Pitch angle (rad) (single)
		yaw	%Yaw angle (rad) (single)
		altitude	%Altitude (MSL) (single)
		lat	%Latitude in degrees * 1E7 (int32)
		lng	%Longitude in degrees * 1E7 (int32)
		v1	%test variable1 (single)
		v2	%test variable2 (single)
		v3	%test variable3 (single)
		v4	%test variable4 (single)
	end
    
    methods
        
        %Constructor: msg_ahrs3
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_ahrs3(packet,roll,pitch,yaw,altitude,lat,lng,v1,v2,v3,v4)
        
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
                
            elseif nargin == 11
                
				obj.roll = roll;
				obj.pitch = pitch;
				obj.yaw = yaw;
				obj.altitude = altitude;
				obj.lat = lat;
				obj.lng = lng;
				obj.v1 = v1;
				obj.v2 = v2;
				obj.v3 = v3;
				obj.v4 = v4;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_ahrs3.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_ahrs3.ID;
                
				packet.payload.putSINGLE(obj.roll);

				packet.payload.putSINGLE(obj.pitch);

				packet.payload.putSINGLE(obj.yaw);

				packet.payload.putSINGLE(obj.altitude);

				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lng);

				packet.payload.putSINGLE(obj.v1);

				packet.payload.putSINGLE(obj.v2);

				packet.payload.putSINGLE(obj.v3);

				packet.payload.putSINGLE(obj.v4);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.altitude = payload.getSINGLE();

			obj.lat = payload.getINT32();

			obj.lng = payload.getINT32();

			obj.v1 = payload.getSINGLE();

			obj.v2 = payload.getSINGLE();

			obj.v3 = payload.getSINGLE();

			obj.v4 = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.roll,2) ~= 1
                result = 'roll';                                        
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';                                        
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';                                        
            elseif size(obj.altitude,2) ~= 1
                result = 'altitude';                                        
            elseif size(obj.lat,2) ~= 1
                result = 'lat';                                        
            elseif size(obj.lng,2) ~= 1
                result = 'lng';                                        
            elseif size(obj.v1,2) ~= 1
                result = 'v1';                                        
            elseif size(obj.v2,2) ~= 1
                result = 'v2';                                        
            elseif size(obj.v3,2) ~= 1
                result = 'v3';                                        
            elseif size(obj.v4,2) ~= 1
                result = 'v4';                            
            else
                result = 0;
            end
            
        end
                            
        function set.roll(obj,value)
            obj.roll = single(value);
        end
                                
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
                                
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
                                
        function set.altitude(obj,value)
            obj.altitude = single(value);
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.lng(obj,value)
            if value == int32(value)
                obj.lng = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                
        function set.v1(obj,value)
            obj.v1 = single(value);
        end
                                
        function set.v2(obj,value)
            obj.v2 = single(value);
        end
                                
        function set.v3(obj,value)
            obj.v3 = single(value);
        end
                                
        function set.v4(obj,value)
            obj.v4 = single(value);
        end
                        
	end
end