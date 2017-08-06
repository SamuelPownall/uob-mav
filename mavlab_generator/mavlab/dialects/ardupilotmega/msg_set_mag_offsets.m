classdef msg_set_mag_offsets < MAVLinkMessage
	%MSG_SET_MAG_OFFSETS: MAVLink Message ID = 151
    %Description:
    %    Deprecated. Use MAV_CMD_PREFLIGHT_SET_SENSOR_OFFSETS instead. Set the magnetometer offsets
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    mag_ofs_x(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,mag_ofs_x,mag_ofs_y,mag_ofs_z,target_system,target_component,varargin)

            if nargin == 5 + 1
                msg = msg_set_mag_offsets(mag_ofs_x,mag_ofs_y,mag_ofs_z,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_set_mag_offsets(mag_ofs_x);
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

        function obj = msg_set_mag_offsets(mag_ofs_x,mag_ofs_y,mag_ofs_z,target_system,target_component,varargin)
        %MSG_SET_MAG_OFFSETS: Create a new set_mag_offsets message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(mag_ofs_x,'MAVLinkPacket')
                    packet = mag_ofs_x;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('mag_ofs_x','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.mag_ofs_x = mag_ofs_x;
                obj.mag_ofs_y = mag_ofs_y;
                obj.mag_ofs_z = mag_ofs_z;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = MAVLinkPacket(msg_set_mag_offsets.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_set_mag_offsets.ID;
                
                packet.payload.putINT16(obj.mag_ofs_x);
                packet.payload.putINT16(obj.mag_ofs_y);
                packet.payload.putINT16(obj.mag_ofs_z);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.mag_ofs_y(obj,value)
            if value == int16(value)
                obj.mag_ofs_y = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.mag_ofs_z(obj,value)
            if value == int16(value)
                obj.mag_ofs_z = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end