classdef msg_fence_fetch_point < mavlink_message
	%MSG_FENCE_FETCH_POINT: MAVLINK Message ID = 161
    %Description:
    %    Request a current fence point from MAV
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    target_system(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    idx(uint8): point index (first point is 1, 0 is for return point)
	
	properties(Constant)
		ID = 161
		LEN = 3
	end
	
	properties
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        idx	%point index (first point is 1, 0 is for return point)	|	(uint8)
    end

    methods

        function obj = msg_fence_fetch_point(target_system,target_component,idx,varargin)
        %MSG_FENCE_FETCH_POINT: Create a new fence_fetch_point message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(target_system,'mavlink_packet')
                    packet = target_system;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('target_system','mavlink_packet');
                end
            elseif nargin == 3
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.idx = idx;
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

                packet = mavlink_packet(msg_fence_fetch_point.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_fence_fetch_point.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.idx);

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
            
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.idx = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.idx,2) ~= 1
                result = 'idx';

            else
                result = 0;
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
        
        function set.idx(obj,value)
            if value == uint8(value)
                obj.idx = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end