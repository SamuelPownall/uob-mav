classdef msg_system_time < MAVLinkMessage
	%MSG_SYSTEM_TIME: MAVLink Message ID = 2
    %Description:
    %    The system time is the time of the master clock, typically the computer clock of the main onboard computer.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_unix_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_unix_usec(uint64): Timestamp of the master clock in microseconds since UNIX epoch.
    %    time_boot_ms(uint32): Timestamp of the component clock since boot time in milliseconds.
	
	properties(Constant)
		ID = 2
		LEN = 12
	end
	
	properties
        time_unix_usec	%Timestamp of the master clock in microseconds since UNIX epoch.	|	(uint64)
        time_boot_ms	%Timestamp of the component clock since boot time in milliseconds.	|	(uint32)
    end

    methods(Static)

        function send(out,time_unix_usec,time_boot_ms,varargin)

            if nargin == 2 + 1
                msg = msg_system_time(time_unix_usec,time_boot_ms,varargin);
            elseif nargin == 2
                msg = msg_system_time(time_unix_usec);
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

        function obj = msg_system_time(time_unix_usec,time_boot_ms,varargin)
        %MSG_SYSTEM_TIME: Create a new system_time message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_unix_usec,'MAVLinkPacket')
                    packet = time_unix_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_unix_usec','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.time_unix_usec = time_unix_usec;
                obj.time_boot_ms = time_boot_ms;
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

                packet = MAVLinkPacket(msg_system_time.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_system_time.ID;
                
                packet.payload.putUINT64(obj.time_unix_usec);
                packet.payload.putUINT32(obj.time_boot_ms);

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
            
            obj.time_unix_usec = payload.getUINT64();
            obj.time_boot_ms = payload.getUINT32();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_unix_usec,2) ~= 1
                result = 'time_unix_usec';
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';

            else
                result = 0;
            end
        end

        function set.time_unix_usec(obj,value)
            if value == uint64(value)
                obj.time_unix_usec = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
    end

end