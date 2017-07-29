classdef msg_storage_information < mavlink_message
	%MSG_STORAGE_INFORMATION: MAVLINK Message ID = 261
    %Description:
    %    WIP: Information about a storage medium
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    total_capacity(single): Total capacity in MiB
    %    used_capacity(single): Used capacity in MiB
    %    available_capacity(single): Available capacity in MiB
    %    read_speed(single): Read speed in MiB/s
    %    write_speed(single): Write speed in MiB/s
    %    storage_id(uint8): Storage ID if there are multiple
    %    status(uint8): Status of storage (0 not available, 1 unformatted, 2 formatted)
	
	properties(Constant)
		ID = 261
		LEN = 26
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        total_capacity	%Total capacity in MiB	|	(single)
        used_capacity	%Used capacity in MiB	|	(single)
        available_capacity	%Available capacity in MiB	|	(single)
        read_speed	%Read speed in MiB/s	|	(single)
        write_speed	%Write speed in MiB/s	|	(single)
        storage_id	%Storage ID if there are multiple	|	(uint8)
        status	%Status of storage (0 not available, 1 unformatted, 2 formatted)	|	(uint8)
    end

    methods

        function obj = msg_storage_information(packet,time_boot_ms,total_capacity,used_capacity,available_capacity,read_speed,write_speed,storage_id,status)
        %Create a new storage_information message
        
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
            
            elseif nargin-1 == 8
                obj.time_boot_ms = time_boot_ms;
                obj.total_capacity = total_capacity;
                obj.used_capacity = used_capacity;
                obj.available_capacity = available_capacity;
                obj.read_speed = read_speed;
                obj.write_speed = write_speed;
                obj.storage_id = storage_id;
                obj.status = status;
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

                packet = mavlink_packet(msg_storage_information.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_storage_information.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.total_capacity);
                packet.payload.putSINGLE(obj.used_capacity);
                packet.payload.putSINGLE(obj.available_capacity);
                packet.payload.putSINGLE(obj.read_speed);
                packet.payload.putSINGLE(obj.write_speed);
                packet.payload.putUINT8(obj.storage_id);
                packet.payload.putUINT8(obj.status);

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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.total_capacity = payload.getSINGLE();
            obj.used_capacity = payload.getSINGLE();
            obj.available_capacity = payload.getSINGLE();
            obj.read_speed = payload.getSINGLE();
            obj.write_speed = payload.getSINGLE();
            obj.storage_id = payload.getUINT8();
            obj.status = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.total_capacity,2) ~= 1
                result = 'total_capacity';
            elseif size(obj.used_capacity,2) ~= 1
                result = 'used_capacity';
            elseif size(obj.available_capacity,2) ~= 1
                result = 'available_capacity';
            elseif size(obj.read_speed,2) ~= 1
                result = 'read_speed';
            elseif size(obj.write_speed,2) ~= 1
                result = 'write_speed';
            elseif size(obj.storage_id,2) ~= 1
                result = 'storage_id';
            elseif size(obj.status,2) ~= 1
                result = 'status';

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
        
        function set.total_capacity(obj,value)
            obj.total_capacity = single(value);
        end
        
        function set.used_capacity(obj,value)
            obj.used_capacity = single(value);
        end
        
        function set.available_capacity(obj,value)
            obj.available_capacity = single(value);
        end
        
        function set.read_speed(obj,value)
            obj.read_speed = single(value);
        end
        
        function set.write_speed(obj,value)
            obj.write_speed = single(value);
        end
        
        function set.storage_id(obj,value)
            if value == uint8(value)
                obj.storage_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.status(obj,value)
            if value == uint8(value)
                obj.status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end