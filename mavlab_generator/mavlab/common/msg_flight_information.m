classdef msg_flight_information < mavlink_message
	%MSG_FLIGHT_INFORMATION: MAVLINK Message ID = 264
    %Description:
    %    WIP: Information about flight since last arming
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    arming_time_utc(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    arming_time_utc(uint64): Timestamp at arming (microseconds since UNIX epoch) in UTC, 0 for unknown
    %    takeoff_time_utc(uint64): Timestamp at takeoff (microseconds since UNIX epoch) in UTC, 0 for unknown
    %    flight_uuid(uint64): Universally unique identifier (UUID) of flight, should correspond to name of logfiles
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
	
	properties(Constant)
		ID = 264
		LEN = 28
	end
	
	properties
        arming_time_utc	%Timestamp at arming (microseconds since UNIX epoch) in UTC, 0 for unknown	|	(uint64)
        takeoff_time_utc	%Timestamp at takeoff (microseconds since UNIX epoch) in UTC, 0 for unknown	|	(uint64)
        flight_uuid	%Universally unique identifier (UUID) of flight, should correspond to name of logfiles	|	(uint64)
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
    end

    methods

        function obj = msg_flight_information(arming_time_utc,takeoff_time_utc,flight_uuid,time_boot_ms,varargin)
        %Create a new flight_information message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(arming_time_utc,'mavlink_packet')
                    packet = arming_time_utc;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('arming_time_utc','mavlink_packet');
                end
            
            elseif nargin == 4
                obj.arming_time_utc = arming_time_utc;
                obj.takeoff_time_utc = takeoff_time_utc;
                obj.flight_uuid = flight_uuid;
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

                packet = mavlink_packet(msg_flight_information.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_flight_information.ID;
                
                packet.payload.putUINT64(obj.arming_time_utc);
                packet.payload.putUINT64(obj.takeoff_time_utc);
                packet.payload.putUINT64(obj.flight_uuid);
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
            
            obj.arming_time_utc = payload.getUINT64();
            obj.takeoff_time_utc = payload.getUINT64();
            obj.flight_uuid = payload.getUINT64();
            obj.time_boot_ms = payload.getUINT32();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.arming_time_utc,2) ~= 1
                result = 'arming_time_utc';
            elseif size(obj.takeoff_time_utc,2) ~= 1
                result = 'takeoff_time_utc';
            elseif size(obj.flight_uuid,2) ~= 1
                result = 'flight_uuid';
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';

            else
                result = 0;
            end
        end

        function set.arming_time_utc(obj,value)
            if value == uint64(value)
                obj.arming_time_utc = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.takeoff_time_utc(obj,value)
            if value == uint64(value)
                obj.takeoff_time_utc = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.flight_uuid(obj,value)
            if value == uint64(value)
                obj.flight_uuid = uint64(value);
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