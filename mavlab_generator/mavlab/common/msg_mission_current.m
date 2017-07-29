classdef msg_mission_current < mavlink_handle
	%MSG_MISSION_CURRENT(packet,seq): MAVLINK Message ID = 42
    %Description:
    %    Message that announces the sequence number of the current active mission item. The MAV will fly towards this mission item.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    seq(uint16): Sequence
	
	properties(Constant)
		ID = 42
		LEN = 2
	end
	
	properties
        seq	%Sequence	|	(uint16)
    end

    methods

        %Constructor: msg_mission_current
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_current(packet,seq)
        
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
            
            elseif nargin-1 == 1
                obj.seq = seq;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.seq = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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