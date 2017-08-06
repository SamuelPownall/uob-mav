classdef msg_storage_information < MAVLinkMessage
	%MSG_STORAGE_INFORMATION: MAVLink Message ID = 261
    %Description:
    %    WIP: Information about a storage medium
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,time_boot_ms,total_capacity,used_capacity,available_capacity,read_speed,write_speed,storage_id,status,varargin)

            if nargin == 8 + 1
                msg = msg_storage_information(time_boot_ms,total_capacity,used_capacity,available_capacity,read_speed,write_speed,storage_id,status,varargin);
            elseif nargin == 2
                msg = msg_storage_information(time_boot_ms);
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

        function obj = msg_storage_information(time_boot_ms,total_capacity,used_capacity,available_capacity,read_speed,write_speed,storage_id,status,varargin)
        %MSG_STORAGE_INFORMATION: Create a new storage_information message object
        
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
            elseif nargin >= 8 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.total_capacity = total_capacity;
                obj.used_capacity = used_capacity;
                obj.available_capacity = available_capacity;
                obj.read_speed = read_speed;
                obj.write_speed = write_speed;
                obj.storage_id = storage_id;
                obj.status = status;
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

                packet = MAVLinkPacket(msg_storage_information.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwTypeError('value','uint32');
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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.status(obj,value)
            if value == uint8(value)
                obj.status = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end