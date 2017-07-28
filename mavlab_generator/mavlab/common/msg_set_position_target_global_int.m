classdef msg_set_position_target_global_int < mavlink_message
	%MSG_SET_POSITION_TARGET_GLOBAL_INT(packet,time_boot_ms,lat_int,lon_int,alt,vx,vy,vz,afx,afy,afz,yaw,yaw_rate,type_mask,target_system,target_component,coordinate_frame): MAVLINK Message ID = 86
    %Description:
    %    Sets a desired vehicle position, velocity, and/or acceleration in a global coordinate system (WGS84). Used by an external controller to command the vehicle (manual controller or other system).
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp in milliseconds since system boot. The rationale for the timestamp in the setpoint is to allow the system to compensate for the transport delay of the setpoint. This allows the system to compensate processing latency.
    %    lat_int(int32): X Position in WGS84 frame in 1e7 * meters
    %    lon_int(int32): Y Position in WGS84 frame in 1e7 * meters
    %    alt(single): Altitude in meters in AMSL altitude, not WGS84 if absolute or relative, above terrain if GLOBAL_TERRAIN_ALT_INT
    %    vx(single): X velocity in NED frame in meter / s
    %    vy(single): Y velocity in NED frame in meter / s
    %    vz(single): Z velocity in NED frame in meter / s
    %    afx(single): X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
    %    afy(single): Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
    %    afz(single): Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
    %    yaw(single): yaw setpoint in rad
    %    yaw_rate(single): yaw rate setpoint in rad/s
    %    type_mask(uint16): Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    coordinate_frame(uint8): Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11
	
	properties(Constant)
		ID = 86
		LEN = 53
	end
	
	properties
        time_boot_ms	%Timestamp in milliseconds since system boot. The rationale for the timestamp in the setpoint is to allow the system to compensate for the transport delay of the setpoint. This allows the system to compensate processing latency.	|	(uint32)
        lat_int	%X Position in WGS84 frame in 1e7 * meters	|	(int32)
        lon_int	%Y Position in WGS84 frame in 1e7 * meters	|	(int32)
        alt	%Altitude in meters in AMSL altitude, not WGS84 if absolute or relative, above terrain if GLOBAL_TERRAIN_ALT_INT	|	(single)
        vx	%X velocity in NED frame in meter / s	|	(single)
        vy	%Y velocity in NED frame in meter / s	|	(single)
        vz	%Z velocity in NED frame in meter / s	|	(single)
        afx	%X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N	|	(single)
        afy	%Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N	|	(single)
        afz	%Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N	|	(single)
        yaw	%yaw setpoint in rad	|	(single)
        yaw_rate	%yaw rate setpoint in rad/s	|	(single)
        type_mask	%Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        coordinate_frame	%Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11	|	(uint8)
    end

    methods

        %Constructor: msg_set_position_target_global_int
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_position_target_global_int(packet,time_boot_ms,lat_int,lon_int,alt,vx,vy,vz,afx,afy,afz,yaw,yaw_rate,type_mask,target_system,target_component,coordinate_frame)
        
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
            
            elseif nargin-1 == 16
                obj.time_boot_ms = time_boot_ms;
                obj.lat_int = lat_int;
                obj.lon_int = lon_int;
                obj.alt = alt;
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.afx = afx;
                obj.afy = afy;
                obj.afz = afz;
                obj.yaw = yaw;
                obj.yaw_rate = yaw_rate;
                obj.type_mask = type_mask;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.coordinate_frame = coordinate_frame;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_set_position_target_global_int.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_set_position_target_global_int.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putINT32(obj.lat_int);
                packet.payload.putINT32(obj.lon_int);
                packet.payload.putSINGLE(obj.alt);
                packet.payload.putSINGLE(obj.vx);
                packet.payload.putSINGLE(obj.vy);
                packet.payload.putSINGLE(obj.vz);
                packet.payload.putSINGLE(obj.afx);
                packet.payload.putSINGLE(obj.afy);
                packet.payload.putSINGLE(obj.afz);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.yaw_rate);
                packet.payload.putUINT16(obj.type_mask);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.coordinate_frame);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.lat_int = payload.getINT32();
            obj.lon_int = payload.getINT32();
            obj.alt = payload.getSINGLE();
            obj.vx = payload.getSINGLE();
            obj.vy = payload.getSINGLE();
            obj.vz = payload.getSINGLE();
            obj.afx = payload.getSINGLE();
            obj.afy = payload.getSINGLE();
            obj.afz = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.yaw_rate = payload.getSINGLE();
            obj.type_mask = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.coordinate_frame = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.lat_int,2) ~= 1
                result = 'lat_int';
            elseif size(obj.lon_int,2) ~= 1
                result = 'lon_int';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';
            elseif size(obj.afx,2) ~= 1
                result = 'afx';
            elseif size(obj.afy,2) ~= 1
                result = 'afy';
            elseif size(obj.afz,2) ~= 1
                result = 'afz';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';
            elseif size(obj.yaw_rate,2) ~= 1
                result = 'yaw_rate';
            elseif size(obj.type_mask,2) ~= 1
                result = 'type_mask';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.coordinate_frame,2) ~= 1
                result = 'coordinate_frame';

            else
                result = 0;
            end
        end

        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.lat_int(obj,value)
            if value == int32(value)
                obj.lat_int = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.lon_int(obj,value)
            if value == int32(value)
                obj.lon_int = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.alt(obj,value)
            obj.alt = single(value);
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
        
        function set.afx(obj,value)
            obj.afx = single(value);
        end
        
        function set.afy(obj,value)
            obj.afy = single(value);
        end
        
        function set.afz(obj,value)
            obj.afz = single(value);
        end
        
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
        
        function set.yaw_rate(obj,value)
            obj.yaw_rate = single(value);
        end
        
        function set.type_mask(obj,value)
            if value == uint16(value)
                obj.type_mask = uint16(value);
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
        
        function set.coordinate_frame(obj,value)
            if value == uint8(value)
                obj.coordinate_frame = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end