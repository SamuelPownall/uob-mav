classdef msg_set_mag_offsets < mavlink_handle
	%MSG_SET_MAG_OFFSETS(packet,mag_ofs_x,mag_ofs_y,mag_ofs_z,target_system,target_component): MAVLINK Message ID = 151
    %Description:
    %    Deprecated. Use MAV_CMD_PREFLIGHT_SET_SENSOR_OFFSETS instead. Set the magnetometer offsets
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_set_mag_offsets
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_mag_offsets(packet,mag_ofs_x,mag_ofs_y,mag_ofs_z,target_system,target_component)
        
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.mag_ofs_x = payload.getINT16();
            obj.mag_ofs_y = payload.getINT16();
            obj.mag_ofs_z = payload.getINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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