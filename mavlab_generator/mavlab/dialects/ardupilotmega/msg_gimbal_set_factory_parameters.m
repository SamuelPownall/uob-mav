classdef msg_gimbal_set_factory_parameters < MAVLinkMessage
	%MSG_GIMBAL_SET_FACTORY_PARAMETERS: MAVLink Message ID = 206
    %Description:
    %    Set factory configuration parameters (such as assembly date and time, and serial number).  This is only intended to be used
            during manufacture, not by end users, so it is protected by a simple checksum of sorts (this won't stop anybody determined,
            it's mostly just to keep the average user from trying to modify these values.  This will need to be revisited if that isn't
            adequate.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    magic_1(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    magic_1(uint32): Magic number 1 for validation
    %    magic_2(uint32): Magic number 2 for validation
    %    magic_3(uint32): Magic number 3 for validation
    %    serial_number_pt_1(uint32): Unit Serial Number Part 1 (part code, design, language/country)
    %    serial_number_pt_2(uint32): Unit Serial Number Part 2 (option, year, month)
    %    serial_number_pt_3(uint32): Unit Serial Number Part 3 (incrementing serial number per month)
    %    assembly_year(uint16): Assembly Date Year
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    assembly_month(uint8): Assembly Date Month
    %    assembly_day(uint8): Assembly Date Day
    %    assembly_hour(uint8): Assembly Time Hour
    %    assembly_minute(uint8): Assembly Time Minute
    %    assembly_second(uint8): Assembly Time Second
	
	properties(Constant)
		ID = 206
		LEN = 33
	end
	
	properties
        magic_1	%Magic number 1 for validation	|	(uint32)
        magic_2	%Magic number 2 for validation	|	(uint32)
        magic_3	%Magic number 3 for validation	|	(uint32)
        serial_number_pt_1	%Unit Serial Number Part 1 (part code, design, language/country)	|	(uint32)
        serial_number_pt_2	%Unit Serial Number Part 2 (option, year, month)	|	(uint32)
        serial_number_pt_3	%Unit Serial Number Part 3 (incrementing serial number per month)	|	(uint32)
        assembly_year	%Assembly Date Year	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        assembly_month	%Assembly Date Month	|	(uint8)
        assembly_day	%Assembly Date Day	|	(uint8)
        assembly_hour	%Assembly Time Hour	|	(uint8)
        assembly_minute	%Assembly Time Minute	|	(uint8)
        assembly_second	%Assembly Time Second	|	(uint8)
    end

    methods(Static)

        function send(out,magic_1,magic_2,magic_3,serial_number_pt_1,serial_number_pt_2,serial_number_pt_3,assembly_year,target_system,target_component,assembly_month,assembly_day,assembly_hour,assembly_minute,assembly_second,varargin)

            if nargin == 14 + 1
                msg = msg_gimbal_set_factory_parameters(magic_1,magic_2,magic_3,serial_number_pt_1,serial_number_pt_2,serial_number_pt_3,assembly_year,target_system,target_component,assembly_month,assembly_day,assembly_hour,assembly_minute,assembly_second,varargin);
            elseif nargin == 2
                msg = msg_gimbal_set_factory_parameters(magic_1);
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

        function obj = msg_gimbal_set_factory_parameters(magic_1,magic_2,magic_3,serial_number_pt_1,serial_number_pt_2,serial_number_pt_3,assembly_year,target_system,target_component,assembly_month,assembly_day,assembly_hour,assembly_minute,assembly_second,varargin)
        %MSG_GIMBAL_SET_FACTORY_PARAMETERS: Create a new gimbal_set_factory_parameters message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(magic_1,'MAVLinkPacket')
                    packet = magic_1;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('magic_1','MAVLinkPacket');
                end
            elseif nargin >= 14 && isempty(varargin{1})
                obj.magic_1 = magic_1;
                obj.magic_2 = magic_2;
                obj.magic_3 = magic_3;
                obj.serial_number_pt_1 = serial_number_pt_1;
                obj.serial_number_pt_2 = serial_number_pt_2;
                obj.serial_number_pt_3 = serial_number_pt_3;
                obj.assembly_year = assembly_year;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.assembly_month = assembly_month;
                obj.assembly_day = assembly_day;
                obj.assembly_hour = assembly_hour;
                obj.assembly_minute = assembly_minute;
                obj.assembly_second = assembly_second;
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

                packet = MAVLinkPacket(msg_gimbal_set_factory_parameters.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gimbal_set_factory_parameters.ID;
                
                packet.payload.putUINT32(obj.magic_1);
                packet.payload.putUINT32(obj.magic_2);
                packet.payload.putUINT32(obj.magic_3);
                packet.payload.putUINT32(obj.serial_number_pt_1);
                packet.payload.putUINT32(obj.serial_number_pt_2);
                packet.payload.putUINT32(obj.serial_number_pt_3);
                packet.payload.putUINT16(obj.assembly_year);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.assembly_month);
                packet.payload.putUINT8(obj.assembly_day);
                packet.payload.putUINT8(obj.assembly_hour);
                packet.payload.putUINT8(obj.assembly_minute);
                packet.payload.putUINT8(obj.assembly_second);

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
            
            obj.magic_1 = payload.getUINT32();
            obj.magic_2 = payload.getUINT32();
            obj.magic_3 = payload.getUINT32();
            obj.serial_number_pt_1 = payload.getUINT32();
            obj.serial_number_pt_2 = payload.getUINT32();
            obj.serial_number_pt_3 = payload.getUINT32();
            obj.assembly_year = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.assembly_month = payload.getUINT8();
            obj.assembly_day = payload.getUINT8();
            obj.assembly_hour = payload.getUINT8();
            obj.assembly_minute = payload.getUINT8();
            obj.assembly_second = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.magic_1,2) ~= 1
                result = 'magic_1';
            elseif size(obj.magic_2,2) ~= 1
                result = 'magic_2';
            elseif size(obj.magic_3,2) ~= 1
                result = 'magic_3';
            elseif size(obj.serial_number_pt_1,2) ~= 1
                result = 'serial_number_pt_1';
            elseif size(obj.serial_number_pt_2,2) ~= 1
                result = 'serial_number_pt_2';
            elseif size(obj.serial_number_pt_3,2) ~= 1
                result = 'serial_number_pt_3';
            elseif size(obj.assembly_year,2) ~= 1
                result = 'assembly_year';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.assembly_month,2) ~= 1
                result = 'assembly_month';
            elseif size(obj.assembly_day,2) ~= 1
                result = 'assembly_day';
            elseif size(obj.assembly_hour,2) ~= 1
                result = 'assembly_hour';
            elseif size(obj.assembly_minute,2) ~= 1
                result = 'assembly_minute';
            elseif size(obj.assembly_second,2) ~= 1
                result = 'assembly_second';

            else
                result = 0;
            end
        end

        function set.magic_1(obj,value)
            if value == uint32(value)
                obj.magic_1 = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.magic_2(obj,value)
            if value == uint32(value)
                obj.magic_2 = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.magic_3(obj,value)
            if value == uint32(value)
                obj.magic_3 = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.serial_number_pt_1(obj,value)
            if value == uint32(value)
                obj.serial_number_pt_1 = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.serial_number_pt_2(obj,value)
            if value == uint32(value)
                obj.serial_number_pt_2 = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.serial_number_pt_3(obj,value)
            if value == uint32(value)
                obj.serial_number_pt_3 = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.assembly_year(obj,value)
            if value == uint16(value)
                obj.assembly_year = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
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
        
        function set.assembly_month(obj,value)
            if value == uint8(value)
                obj.assembly_month = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_day(obj,value)
            if value == uint8(value)
                obj.assembly_day = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_hour(obj,value)
            if value == uint8(value)
                obj.assembly_hour = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_minute(obj,value)
            if value == uint8(value)
                obj.assembly_minute = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_second(obj,value)
            if value == uint8(value)
                obj.assembly_second = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end