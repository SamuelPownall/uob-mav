classdef msg_mission_request_partial_list < MAVLinkMessage
	%MSG_MISSION_REQUEST_PARTIAL_LIST: MAVLink Message ID = 37
    %Description:
    %    Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. If start and end index are the same, just send one waypoint.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    start_index(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,start_index,end_index,target_system,target_component,varargin)

            if nargin == 4 + 1
                msg = msg_mission_request_partial_list(start_index,end_index,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_mission_request_partial_list(start_index);
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

        function obj = msg_mission_request_partial_list(start_index,end_index,target_system,target_component,varargin)
        %MSG_MISSION_REQUEST_PARTIAL_LIST: Create a new mission_request_partial_list message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(start_index,'MAVLinkPacket')
                    packet = start_index;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('start_index','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.start_index = start_index;
                obj.end_index = end_index;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = MAVLinkPacket(msg_mission_request_partial_list.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_mission_request_partial_list.ID;
                
                packet.payload.putINT16(obj.start_index);
                packet.payload.putINT16(obj.end_index);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.end_index(obj,value)
            if value == int16(value)
                obj.end_index = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end