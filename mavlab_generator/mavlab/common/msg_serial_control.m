classdef msg_serial_control < mavlink_handle
	%MSG_SERIAL_CONTROL(packet,baudrate,timeout,device,flags,count,data): MAVLINK Message ID = 126
    %Description:
    %    Control a serial port. This can be used for raw access to an onboard serial peripheral such as a GPS or telemetry radio. It is designed to make it possible to update the devices firmware via MAVLink messages or change the devices settings. A message with zero bytes can be used to change just the baudrate.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_serial_control
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_serial_control(packet,baudrate,timeout,device,flags,count,data)
        
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
            
            elseif nargin-1 == 6
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

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
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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