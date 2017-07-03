classdef msg_gps_input < mavlink_message
    %MAVLINK Message Class
    %Name: gps_input	ID: 232
    %Description: GPS sensor input message.  This is a raw sensor value sent by the GPS. This is NOT the global position estimate of the sytem.
            
    properties(Constant)
        ID = 232
        LEN = 63
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64)
		time_week_ms	%GPS time (milliseconds from start of GPS week) (uint32)
		lat	%Latitude (WGS84), in degrees * 1E7 (int32)
		lon	%Longitude (WGS84), in degrees * 1E7 (int32)
		alt	%Altitude (AMSL, not WGS84), in m (positive for up) (single)
		hdop	%GPS HDOP horizontal dilution of position in m (single)
		vdop	%GPS VDOP vertical dilution of position in m (single)
		vn	%GPS velocity in m/s in NORTH direction in earth-fixed NED frame (single)
		ve	%GPS velocity in m/s in EAST direction in earth-fixed NED frame (single)
		vd	%GPS velocity in m/s in DOWN direction in earth-fixed NED frame (single)
		speed_accuracy	%GPS speed accuracy in m/s (single)
		horiz_accuracy	%GPS horizontal accuracy in m (single)
		vert_accuracy	%GPS vertical accuracy in m (single)
		ignore_flags	%Flags indicating which fields to ignore (see GPS_INPUT_IGNORE_FLAGS enum).  All other fields must be provided. (uint16)
		time_week	%GPS week number (uint16)
		gps_id	%ID of the GPS for multiple GPS inputs (uint8)
		fix_type	%0-1: no fix, 2: 2D fix, 3: 3D fix. 4: 3D with DGPS. 5: 3D with RTK (uint8)
		satellites_visible	%Number of satellites visible. (uint8)
	end
    
    methods
        
        %Constructor: msg_gps_input
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gps_input(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_gps_input.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gps_input.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putUINT32(obj.time_week_ms);

				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lon);

				packet.payload.putSINGLE(obj.alt);

				packet.payload.putSINGLE(obj.hdop);

				packet.payload.putSINGLE(obj.vdop);

				packet.payload.putSINGLE(obj.vn);

				packet.payload.putSINGLE(obj.ve);

				packet.payload.putSINGLE(obj.vd);

				packet.payload.putSINGLE(obj.speed_accuracy);

				packet.payload.putSINGLE(obj.horiz_accuracy);

				packet.payload.putSINGLE(obj.vert_accuracy);

				packet.payload.putUINT16(obj.ignore_flags);

				packet.payload.putUINT16(obj.time_week);

				packet.payload.putUINT8(obj.gps_id);

				packet.payload.putUINT8(obj.fix_type);

				packet.payload.putUINT8(obj.satellites_visible);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_gps_input.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.time_week_ms = payload.getUINT32();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getSINGLE();

			obj.hdop = payload.getSINGLE();

			obj.vdop = payload.getSINGLE();

			obj.vn = payload.getSINGLE();

			obj.ve = payload.getSINGLE();

			obj.vd = payload.getSINGLE();

			obj.speed_accuracy = payload.getSINGLE();

			obj.horiz_accuracy = payload.getSINGLE();

			obj.vert_accuracy = payload.getSINGLE();

			obj.ignore_flags = payload.getUINT16();

			obj.time_week = payload.getUINT16();

			obj.gps_id = payload.getUINT8();

			obj.fix_type = payload.getUINT8();

			obj.satellites_visible = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.time_week_ms,2) ~= 1
                result = 'time_week_ms';                                        
            elseif size(obj.lat,2) ~= 1
                result = 'lat';                                        
            elseif size(obj.lon,2) ~= 1
                result = 'lon';                                        
            elseif size(obj.alt,2) ~= 1
                result = 'alt';                                        
            elseif size(obj.hdop,2) ~= 1
                result = 'hdop';                                        
            elseif size(obj.vdop,2) ~= 1
                result = 'vdop';                                        
            elseif size(obj.vn,2) ~= 1
                result = 'vn';                                        
            elseif size(obj.ve,2) ~= 1
                result = 've';                                        
            elseif size(obj.vd,2) ~= 1
                result = 'vd';                                        
            elseif size(obj.speed_accuracy,2) ~= 1
                result = 'speed_accuracy';                                        
            elseif size(obj.horiz_accuracy,2) ~= 1
                result = 'horiz_accuracy';                                        
            elseif size(obj.vert_accuracy,2) ~= 1
                result = 'vert_accuracy';                                        
            elseif size(obj.ignore_flags,2) ~= 1
                result = 'ignore_flags';                                        
            elseif size(obj.time_week,2) ~= 1
                result = 'time_week';                                        
            elseif size(obj.gps_id,2) ~= 1
                result = 'gps_id';                                        
            elseif size(obj.fix_type,2) ~= 1
                result = 'fix_type';                                        
            elseif size(obj.satellites_visible,2) ~= 1
                result = 'satellites_visible';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.time_week_ms(obj,value)
            if value == uint32(value)
                obj.time_week_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.time_week_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.alt(obj,value)
            obj.alt = single(value);
        end
                                
        function set.hdop(obj,value)
            obj.hdop = single(value);
        end
                                
        function set.vdop(obj,value)
            obj.vdop = single(value);
        end
                                
        function set.vn(obj,value)
            obj.vn = single(value);
        end
                                
        function set.ve(obj,value)
            obj.ve = single(value);
        end
                                
        function set.vd(obj,value)
            obj.vd = single(value);
        end
                                
        function set.speed_accuracy(obj,value)
            obj.speed_accuracy = single(value);
        end
                                
        function set.horiz_accuracy(obj,value)
            obj.horiz_accuracy = single(value);
        end
                                
        function set.vert_accuracy(obj,value)
            obj.vert_accuracy = single(value);
        end
                                    
        function set.ignore_flags(obj,value)
            if value == uint16(value)
                obj.ignore_flags = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.ignore_flags()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.time_week(obj,value)
            if value == uint16(value)
                obj.time_week = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.time_week()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.gps_id(obj,value)
            if value == uint8(value)
                obj.gps_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.gps_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.fix_type(obj,value)
            if value == uint8(value)
                obj.fix_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.fix_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellites_visible(obj,value)
            if value == uint8(value)
                obj.satellites_visible = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_input.set.satellites_visible()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end