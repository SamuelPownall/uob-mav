classdef msg_serial_control < mavlink_message
	%MSG_SERIAL_CONTROL: MAVLINK Message ID = 126
    %Description:
    %    Control a serial port. This can be used for raw access to an onboard serial peripheral such as a GPS or telemetry radio. It is designed to make it possible to update the devices firmware via MAVLink messages or change the devices settings. A message with zero bytes can be used to change just the baudrate.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    baudrate(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    baudrate(uint32): Baudrate of transfer. Zero means no change.
    %    timeout(uint16): Timeout for reply data in milliseconds
    %    device(uint8): See SERIAL_CONTROL_DEV enum
    %    flags(uint8): See SERIAL_CONTROL_FLAG enum
    %    count(uint8): how many bytes in this transfer
    %    data(uint8[70]): serial data
	
	properties(Constant)
		ID = 126
		LEN = 79
	end
	
	properties
        baudrate	%Baudrate of transfer. Zero means no change.	|	(uint32)
        timeout	%Timeout for reply data in milliseconds	|	(uint16)
        device	%See SERIAL_CONTROL_DEV enum	|	(uint8)
        flags	%See SERIAL_CONTROL_FLAG enum	|	(uint8)
        count	%how many bytes in this transfer	|	(uint8)
        data	%serial data	|	(uint8[70])
    end

    methods

        function obj = msg_serial_control(baudrate,timeout,device,flags,count,data,varargin)
        %MSG_SERIAL_CONTROL: Create a new serial_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(baudrate,'mavlink_packet')
                    packet = baudrate;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('baudrate','mavlink_packet');
                end
            elseif nargin == 6
                obj.baudrate = baudrate;
                obj.timeout = timeout;
                obj.device = device;
                obj.flags = flags;
                obj.count = count;
                obj.data = data;
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

                packet = mavlink_packet(msg_serial_control.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_serial_control.ID;
                
                packet.payload.putUINT32(obj.baudrate);
                packet.payload.putUINT16(obj.timeout);
                packet.payload.putUINT8(obj.device);
                packet.payload.putUINT8(obj.flags);
                packet.payload.putUINT8(obj.count);
                for i=1:1:70
                    packet.payload.putUINT8(obj.data(i));
                end

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
            
            obj.baudrate = payload.getUINT32();
            obj.timeout = payload.getUINT16();
            obj.device = payload.getUINT8();
            obj.flags = payload.getUINT8();
            obj.count = payload.getUINT8();
            for i=1:1:70
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.baudrate,2) ~= 1
                result = 'baudrate';
            elseif size(obj.timeout,2) ~= 1
                result = 'timeout';
            elseif size(obj.device,2) ~= 1
                result = 'device';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';
            elseif size(obj.count,2) ~= 1
                result = 'count';
            elseif size(obj.data,2) ~= 70
                result = 'data';

            else
                result = 0;
            end
        end

        function set.baudrate(obj,value)
            if value == uint32(value)
                obj.baudrate = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.timeout(obj,value)
            if value == uint16(value)
                obj.timeout = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.device(obj,value)
            if value == uint8(value)
                obj.device = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.flags(obj,value)
            if value == uint8(value)
                obj.flags = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end