classdef msg_mission_item_reached < mavlink_message
	%MSG_MISSION_ITEM_REACHED(packet,seq): MAVLINK Message ID = 46
    %Description:
    %    A certain mission item has been reached. The system will either hold this position (or circle on the orbit) or (if the autocontinue on the WP was set) continue to the next MISSION.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    seq(uint16): Sequence
	
	properties(Constant)
		ID = 46
		LEN = 2
	end
	
	properties
        seq	%Sequence	|	(uint16)
    end

    methods

        %Constructor: msg_mission_item_reached
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_item_reached(packet,seq)
        
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

                packet = mavlink_packet(msg_mission_item_reached.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_item_reached.ID;
                
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