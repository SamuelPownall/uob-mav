classdef msg_timesync < MAVLinkMessage
	%MSG_TIMESYNC: MAVLink Message ID = 111
    %Description:
    %    Time synchronization message.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    tc1(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,tc1,ts1,varargin)

            if nargin == 2 + 1
                msg = msg_timesync(tc1,ts1,varargin);
            elseif nargin == 2
                msg = msg_timesync(tc1);
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

        function obj = msg_timesync(tc1,ts1,varargin)
        %MSG_TIMESYNC: Create a new timesync message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(tc1,'MAVLinkPacket')
                    packet = tc1;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('tc1','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.tc1 = tc1;
                obj.ts1 = ts1;
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

                packet = MAVLinkPacket(msg_timesync.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_timesync.ID;
                
                packet.payload.putINT64(obj.tc1);
                packet.payload.putINT64(obj.ts1);

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
                MAVLink.throwTypeError('value','int64');
            end
        end
        
        function set.ts1(obj,value)
            if value == int64(value)
                obj.ts1 = int64(value);
            else
                MAVLink.throwTypeError('value','int64');
            end
        end
        
    end

end