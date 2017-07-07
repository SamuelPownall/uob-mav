classdef msg_rally_point < mavlink_message
    %MAVLINK Message Class
    %Name: rally_point	ID: 175
    %Description: A rally point. Used to set a point when from GCS -> MAV. Also used to return a point from MAV -> GCS
            
    properties(Constant)
        ID = 175
        LEN = 19
    end
    
    properties        
		lat	%Latitude of point in degrees * 1E7 (int32)
		lng	%Longitude of point in degrees * 1E7 (int32)
		alt	%Transit / loiter altitude in meters relative to home (int16)
		break_alt	%Break altitude in meters relative to home (int16)
		land_dir	%Heading to aim for when landing. In centi-degrees. (uint16)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
		idx	%point index (first point is 0) (uint8)
		count	%total number of points (for sanity checking) (uint8)
		flags	%See RALLY_FLAGS enum for definition of the bitmask. (uint8)
	end
    
    methods
        
        %Constructor: msg_rally_point
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_rally_point(packet,lat,lng,alt,break_alt,land_dir,target_system,target_component,idx,count,flags)
        
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
                
				obj.lat = lat;
				obj.lng = lng;
				obj.alt = alt;
				obj.break_alt = break_alt;
				obj.land_dir = land_dir;
				obj.target_system = target_system;
				obj.target_component = target_component;
				obj.idx = idx;
				obj.count = count;
				obj.flags = flags;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_rally_point.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_rally_point.ID;
                
				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lng);

				packet.payload.putINT16(obj.alt);

				packet.payload.putINT16(obj.break_alt);

				packet.payload.putUINT16(obj.land_dir);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);

				packet.payload.putUINT8(obj.idx);

				packet.payload.putUINT8(obj.count);

				packet.payload.putUINT8(obj.flags);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.lat = payload.getINT32();

			obj.lng = payload.getINT32();

			obj.alt = payload.getINT16();

			obj.break_alt = payload.getINT16();

			obj.land_dir = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.idx = payload.getUINT8();

			obj.count = payload.getUINT8();

			obj.flags = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.lat,2) ~= 1
                result = 'lat';                                        
            elseif size(obj.lng,2) ~= 1
                result = 'lng';                                        
            elseif size(obj.alt,2) ~= 1
                result = 'alt';                                        
            elseif size(obj.break_alt,2) ~= 1
                result = 'break_alt';                                        
            elseif size(obj.land_dir,2) ~= 1
                result = 'land_dir';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                                        
            elseif size(obj.idx,2) ~= 1
                result = 'idx';                                        
            elseif size(obj.count,2) ~= 1
                result = 'count';                                        
            elseif size(obj.flags,2) ~= 1
                result = 'flags';                            
            else
                result = 0;
            end
            
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
                                    
        function set.alt(obj,value)
            if value == int16(value)
                obj.alt = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                                    
        function set.break_alt(obj,value)
            if value == int16(value)
                obj.break_alt = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                                    
        function set.land_dir(obj,value)
            if value == uint16(value)
                obj.land_dir = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.idx(obj,value)
            if value == uint8(value)
                obj.idx = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.flags(obj,value)
            if value == uint8(value)
                obj.flags = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end