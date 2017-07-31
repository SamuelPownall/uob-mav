classdef msg_system_time < mavlink_message
	%MSG_SYSTEM_TIME: MAVLINK Message ID = 2
    %Description:
    %    The system time is the time of the master clock, typically the computer clock of the main onboard computer.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_unix_usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_system_time(time_unix_usec,time_boot_ms,varargin)
        %Create a new system_time message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(time_unix_usec,'mavlink_packet')
                    packet = time_unix_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_unix_usec','mavlink_packet');
                end
            
            elseif nargin == 2
                obj.time_unix_usec = time_unix_usec;
                obj.time_boot_ms = time_boot_ms;
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

                packet = mavlink_packet(msg_system_time.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_system_time.ID;
                
                packet.payload.putUINT64(obj.time_unix_usec);
                packet.payload.putUINT32(obj.time_boot_ms);

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
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
    end

end