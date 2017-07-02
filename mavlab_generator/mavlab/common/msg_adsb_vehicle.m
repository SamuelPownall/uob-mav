classdef msg_adsb_vehicle < mavlink_message
    %MAVLINK Message Class
    %Name: adsb_vehicle	ID: 246
    %Description: The location and information of an ADSB vehicle
            
    properties(Constant)
        ID = 246
        LEN = 38
    end
    
    properties        
		icao_address	%ICAO address (uint32[1])
		lat	%Latitude, expressed as degrees * 1E7 (int32[1])
		lon	%Longitude, expressed as degrees * 1E7 (int32[1])
		altitude	%Altitude(ASL) in millimeters (int32[1])
		heading	%Course over ground in centidegrees (uint16[1])
		hor_velocity	%The horizontal velocity in centimeters/second (uint16[1])
		ver_velocity	%The vertical velocity in centimeters/second, positive is up (int16[1])
		flags	%Flags to indicate various statuses including valid data fields (uint16[1])
		squawk	%Squawk code (uint16[1])
		altitude_type	%Type from ADSB_ALTITUDE_TYPE enum (uint8[1])
		callsign	%The callsign, 8+null (uint8[9])
		emitter_type	%Type from ADSB_EMITTER_TYPE enum (uint8[1])
		tslc	%Time since last communication in seconds (uint8[1])
	end

    
    methods
        
        %Constructor: msg_adsb_vehicle
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_adsb_vehicle(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_adsb_vehicle.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_adsb_vehicle.ID;
                
			packet.payload.putUINT32(obj.icao_address);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putINT32(obj.altitude);

			packet.payload.putUINT16(obj.heading);

			packet.payload.putUINT16(obj.hor_velocity);

			packet.payload.putINT16(obj.ver_velocity);

			packet.payload.putUINT16(obj.flags);

			packet.payload.putUINT16(obj.squawk);

			packet.payload.putUINT8(obj.altitude_type);
            
            for i = 1:9
                packet.payload.putUINT8(obj.callsign(i));
            end
                            
			packet.payload.putUINT8(obj.emitter_type);

			packet.payload.putUINT8(obj.tslc);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.icao_address = payload.getUINT32();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.altitude = payload.getINT32();

			obj.heading = payload.getUINT16();

			obj.hor_velocity = payload.getUINT16();

			obj.ver_velocity = payload.getINT16();

			obj.flags = payload.getUINT16();

			obj.squawk = payload.getUINT16();

			obj.altitude_type = payload.getUINT8();
            
            for i = 1:9
                obj.callsign(i) = payload.getUINT8();
            end
                            
			obj.emitter_type = payload.getUINT8();

			obj.tslc = payload.getUINT8();

		end
            
        function set.icao_address(obj,value)
            if value == uint32(value)
                obj.icao_address = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.icao_address()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.altitude(obj,value)
            if value == int32(value)
                obj.altitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.altitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.heading(obj,value)
            if value == uint16(value)
                obj.heading = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.heading()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.hor_velocity(obj,value)
            if value == uint16(value)
                obj.hor_velocity = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.hor_velocity()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.ver_velocity(obj,value)
            if value == int16(value)
                obj.ver_velocity = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.ver_velocity()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.flags()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.squawk(obj,value)
            if value == uint16(value)
                obj.squawk = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.squawk()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.altitude_type(obj,value)
            if value == uint8(value)
                obj.altitude_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.altitude_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.callsign(obj,value)
            if value == uint8(value)
                obj.callsign = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.callsign()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.emitter_type(obj,value)
            if value == uint8(value)
                obj.emitter_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.emitter_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.tslc(obj,value)
            if value == uint8(value)
                obj.tslc = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | adsb_vehicle.set.tslc()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end