classdef msg_gimbal_set_factory_parameters < mavlink_message
	%MSG_GIMBAL_SET_FACTORY_PARAMETERS: MAVLINK Message ID = 206
    %Description:
    %    Set factory configuration parameters (such as assembly date and time, and serial number).  This is only intended to be used
            during manufacture, not by end users, so it is protected by a simple checksum of sorts (this won't stop anybody determined,
            it's mostly just to keep the average user from trying to modify these values.  This will need to be revisited if that isn't
            adequate.
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

    methods

        function obj = msg_gimbal_set_factory_parameters(packet,magic_1,magic_2,magic_3,serial_number_pt_1,serial_number_pt_2,serial_number_pt_3,assembly_year,target_system,target_component,assembly_month,assembly_day,assembly_hour,assembly_minute,assembly_second)
        %Create a new gimbal_set_factory_parameters message
        
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
            
            elseif nargin-1 == 14
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

                packet = mavlink_packet(msg_gimbal_set_factory_parameters.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
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
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.magic_2(obj,value)
            if value == uint32(value)
                obj.magic_2 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.magic_3(obj,value)
            if value == uint32(value)
                obj.magic_3 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.serial_number_pt_1(obj,value)
            if value == uint32(value)
                obj.serial_number_pt_1 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.serial_number_pt_2(obj,value)
            if value == uint32(value)
                obj.serial_number_pt_2 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.serial_number_pt_3(obj,value)
            if value == uint32(value)
                obj.serial_number_pt_3 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.assembly_year(obj,value)
            if value == uint16(value)
                obj.assembly_year = uint16(value);
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
        
        function set.assembly_month(obj,value)
            if value == uint8(value)
                obj.assembly_month = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_day(obj,value)
            if value == uint8(value)
                obj.assembly_day = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_hour(obj,value)
            if value == uint8(value)
                obj.assembly_hour = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_minute(obj,value)
            if value == uint8(value)
                obj.assembly_minute = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.assembly_second(obj,value)
            if value == uint8(value)
                obj.assembly_second = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end