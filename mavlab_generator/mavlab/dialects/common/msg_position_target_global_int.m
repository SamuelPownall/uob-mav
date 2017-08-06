classdef msg_position_target_global_int < MAVLinkMessage
	%MSG_POSITION_TARGET_GLOBAL_INT: MAVLink Message ID = 87
    %Description:
    %    Reports the current commanded vehicle position, velocity, and acceleration as specified by the autopilot. This should match the commands sent in SET_POSITION_TARGET_GLOBAL_INT if the vehicle is being controlled this way.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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
    %    coordinate_frame(uint8): Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11
	
	properties(Constant)
		ID = 87
		LEN = 51
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
        coordinate_frame	%Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11	|	(uint8)
    end

    methods(Static)

        function send(out,time_boot_ms,lat_int,lon_int,alt,vx,vy,vz,afx,afy,afz,yaw,yaw_rate,type_mask,coordinate_frame,varargin)

            if nargin == 14 + 1
                msg = msg_position_target_global_int(time_boot_ms,lat_int,lon_int,alt,vx,vy,vz,afx,afy,afz,yaw,yaw_rate,type_mask,coordinate_frame,varargin);
            elseif nargin == 2
                msg = msg_position_target_global_int(time_boot_ms);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_position_target_global_int(time_boot_ms,lat_int,lon_int,alt,vx,vy,vz,afx,afy,afz,yaw,yaw_rate,type_mask,coordinate_frame,varargin)
        %MSG_POSITION_TARGET_GLOBAL_INT: Create a new position_target_global_int message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_boot_ms,'MAVLinkPacket')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_boot_ms','MAVLinkPacket');
                end
            elseif nargin >= 14 && isempty(varargin{1})
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
                obj.coordinate_frame = coordinate_frame;
            elseif nargin ~= 0
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_position_target_global_int.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_position_target_global_int.ID;
                
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
                packet.payload.putUINT8(obj.coordinate_frame);

            else
                packet = [];
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

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
            obj.coordinate_frame = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.lat_int(obj,value)
            if value == int32(value)
                obj.lat_int = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.lon_int(obj,value)
            if value == int32(value)
                obj.lon_int = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
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
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.coordinate_frame(obj,value)
            if value == uint8(value)
                obj.coordinate_frame = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end