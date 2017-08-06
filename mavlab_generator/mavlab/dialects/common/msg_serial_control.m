classdef msg_serial_control < MAVLinkMessage
	%MSG_SERIAL_CONTROL: MAVLink Message ID = 126
    %Description:
    %    Control a serial port. This can be used for raw access to an onboard serial peripheral such as a GPS or telemetry radio. It is designed to make it possible to update the devices firmware via MAVLink messages or change the devices settings. A message with zero bytes can be used to change just the baudrate.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    baudrate(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,baudrate,timeout,device,flags,count,data,varargin)

            if nargin == 6 + 1
                msg = msg_serial_control(baudrate,timeout,device,flags,count,data,varargin);
            elseif nargin == 2
                msg = msg_serial_control(baudrate);
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

        function obj = msg_serial_control(baudrate,timeout,device,flags,count,data,varargin)
        %MSG_SERIAL_CONTROL: Create a new serial_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(baudrate,'MAVLinkPacket')
                    packet = baudrate;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('baudrate','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.baudrate = baudrate;
                obj.timeout = timeout;
                obj.device = device;
                obj.flags = flags;
                obj.count = count;
                obj.data = data;
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

                packet = MAVLinkPacket(msg_serial_control.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.timeout(obj,value)
            if value == uint16(value)
                obj.timeout = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.device(obj,value)
            if value == uint8(value)
                obj.device = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.flags(obj,value)
            if value == uint8(value)
                obj.flags = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end