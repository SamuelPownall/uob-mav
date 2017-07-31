classdef msg_mission_request_partial_list < mavlink_message
	%MSG_MISSION_REQUEST_PARTIAL_LIST: MAVLINK Message ID = 37
    %Description:
    %    Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. If start and end index are the same, just send one waypoint.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    start_index(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    start_index(int16): Start index, 0 by default
    %    end_index(int16): End index, -1 by default (-1: send list to end). Else a valid index of the list
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 37
		LEN = 6
	end
	
	properties
        start_index	%Start index, 0 by default	|	(int16)
        end_index	%End index, -1 by default (-1: send list to end). Else a valid index of the list	|	(int16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods

        function obj = msg_mission_request_partial_list(start_index,end_index,target_system,target_component,varargin)
        %Create a new mission_request_partial_list message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(start_index,'mavlink_packet')
                    packet = start_index;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('start_index','mavlink_packet');
                end
            
            elseif nargin == 4
                obj.start_index = start_index;
                obj.end_index = end_index;
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

                packet = mavlink_packet(msg_mission_request_partial_list.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_request_partial_list.ID;
                
                packet.payload.putINT16(obj.start_index);
                packet.payload.putINT16(obj.end_index);
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
            
            obj.start_index = payload.getINT16();
            obj.end_index = payload.getINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.start_index,2) ~= 1
                result = 'start_index';
            elseif size(obj.end_index,2) ~= 1
                result = 'end_index';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.start_index(obj,value)
            if value == int16(value)
                obj.start_index = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.end_index(obj,value)
            if value == int16(value)
                obj.end_index = int16(value);
            else
                mavlink.throwTypeError('value','int16');
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