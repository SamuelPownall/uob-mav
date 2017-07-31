classdef msg_mission_set_current < mavlink_message
	%MSG_MISSION_SET_CURRENT: MAVLINK Message ID = 41
    %Description:
    %    Set the mission item with sequence number seq as current item. This means that the MAV will continue to this mission item on the shortest path (not following the mission items in-between).
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    seq(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    seq(uint16): Sequence
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 41
		LEN = 4
	end
	
	properties
        seq	%Sequence	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods

        function obj = msg_mission_set_current(seq,target_system,target_component,varargin)
        %Create a new mission_set_current message
        
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
                    mavlink.throwTypeError('seq','mavlink_packet');
                end
            
            elseif nargin == 3
                obj.seq = seq;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = mavlink_packet(msg_mission_set_current.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_set_current.ID;
                
                packet.payload.putUINT16(obj.seq);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.seq,2) ~= 1
                result = 'seq';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

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
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end