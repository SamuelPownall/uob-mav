classdef msg_set_mag_offsets < mavlink_message
	%MSG_SET_MAG_OFFSETS: MAVLINK Message ID = 151
    %Description:
    %    Deprecated. Use MAV_CMD_PREFLIGHT_SET_SENSOR_OFFSETS instead. Set the magnetometer offsets
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    mag_ofs_x(int16): magnetometer X offset
    %    mag_ofs_y(int16): magnetometer Y offset
    %    mag_ofs_z(int16): magnetometer Z offset
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 151
		LEN = 8
	end
	
	properties
        mag_ofs_x	%magnetometer X offset	|	(int16)
        mag_ofs_y	%magnetometer Y offset	|	(int16)
        mag_ofs_z	%magnetometer Z offset	|	(int16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods

        function obj = msg_set_mag_offsets(packet,mag_ofs_x,mag_ofs_y,mag_ofs_z,target_system,target_component)
        %Create a new set_mag_offsets message
        
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
            
            elseif nargin-1 == 5
                obj.mag_ofs_x = mag_ofs_x;
                obj.mag_ofs_y = mag_ofs_y;
                obj.mag_ofs_z = mag_ofs_z;
                obj.target_system = target_system;
                obj.target_component = target_component;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_set_mag_offsets.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_set_mag_offsets.ID;
                
                packet.payload.putINT16(obj.mag_ofs_x);
                packet.payload.putINT16(obj.mag_ofs_y);
                packet.payload.putINT16(obj.mag_ofs_z);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.mag_ofs_x = payload.getINT16();
            obj.mag_ofs_y = payload.getINT16();
            obj.mag_ofs_z = payload.getINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.mag_ofs_x,2) ~= 1
                result = 'mag_ofs_x';
            elseif size(obj.mag_ofs_y,2) ~= 1
                result = 'mag_ofs_y';
            elseif size(obj.mag_ofs_z,2) ~= 1
                result = 'mag_ofs_z';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.mag_ofs_x(obj,value)
            if value == int16(value)
                obj.mag_ofs_x = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.mag_ofs_y(obj,value)
            if value == int16(value)
                obj.mag_ofs_y = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.mag_ofs_z(obj,value)
            if value == int16(value)
                obj.mag_ofs_z = int16(value);
            else
                mavlink.throwTypeError('value','int16');
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
        
    end

end