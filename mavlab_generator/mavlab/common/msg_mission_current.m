classdef msg_mission_current < mavlink_message
	%MSG_MISSION_CURRENT: MAVLINK Message ID = 42
    %Description:
    %    Message that announces the sequence number of the current active mission item. The MAV will fly towards this mission item.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    seq(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    seq(uint16): Sequence
	
	properties(Constant)
		ID = 42
		LEN = 2
	end
	
	properties
        seq	%Sequence	|	(uint16)
    end

    methods

        function obj = msg_mission_current(seq,varargin)
        %Create a new mission_current message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(seq,'mavlink_packet')
                    packet = seq;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    obj.seq = seq;
                end
            
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

                packet = mavlink_packet(msg_mission_current.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_current.ID;
                
                packet.payload.putUINT16(obj.seq);

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
            
            obj.seq = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.seq,2) ~= 1
                result = 'seq';

            else
                result = 0;
            end
        end

        function set.seq(obj,value)
            if value == uint16(value)
                obj.seq = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end