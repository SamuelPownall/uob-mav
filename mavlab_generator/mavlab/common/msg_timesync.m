classdef msg_timesync < mavlink_message
	%MSG_TIMESYNC: MAVLINK Message ID = 111
    %Description:
    %    Time synchronization message.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    tc1(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    tc1(int64): Time sync timestamp 1
    %    ts1(int64): Time sync timestamp 2
	
	properties(Constant)
		ID = 111
		LEN = 16
	end
	
	properties
        tc1	%Time sync timestamp 1	|	(int64)
        ts1	%Time sync timestamp 2	|	(int64)
    end

    methods

        function obj = msg_timesync(tc1,ts1,varargin)
        %Create a new timesync message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(tc1,'mavlink_packet')
                    packet = tc1;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('tc1','mavlink_packet');
                end
            
            elseif nargin == 2
                obj.tc1 = tc1;
                obj.ts1 = ts1;
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

                packet = mavlink_packet(msg_timesync.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_timesync.ID;
                
                packet.payload.putINT64(obj.tc1);
                packet.payload.putINT64(obj.ts1);

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
            
            obj.tc1 = payload.getINT64();
            obj.ts1 = payload.getINT64();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.tc1,2) ~= 1
                result = 'tc1';
            elseif size(obj.ts1,2) ~= 1
                result = 'ts1';

            else
                result = 0;
            end
        end

        function set.tc1(obj,value)
            if value == int64(value)
                obj.tc1 = int64(value);
            else
                mavlink.throwTypeError('value','int64');
            end
        end
        
        function set.ts1(obj,value)
            if value == int64(value)
                obj.ts1 = int64(value);
            else
                mavlink.throwTypeError('value','int64');
            end
        end
        
    end

end