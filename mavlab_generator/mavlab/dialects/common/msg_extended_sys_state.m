classdef msg_extended_sys_state < MAVLinkMessage
	%MSG_EXTENDED_SYS_STATE: MAVLink Message ID = 245
    %Description:
    %    Provides state for additional features
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    vtol_state(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    vtol_state(uint8): The VTOL state if applicable. Is set to MAV_VTOL_STATE_UNDEFINED if UAV is not in VTOL configuration.
    %    landed_state(uint8): The landed state. Is set to MAV_LANDED_STATE_UNDEFINED if landed state is unknown.
	
	properties(Constant)
		ID = 245
		LEN = 2
	end
	
	properties
        vtol_state	%The VTOL state if applicable. Is set to MAV_VTOL_STATE_UNDEFINED if UAV is not in VTOL configuration.	|	(uint8)
        landed_state	%The landed state. Is set to MAV_LANDED_STATE_UNDEFINED if landed state is unknown.	|	(uint8)
    end

    methods(Static)

        function send(out,vtol_state,landed_state,varargin)

            if nargin == 2 + 1
                msg = msg_extended_sys_state(vtol_state,landed_state,varargin);
            elseif nargin == 2
                msg = msg_extended_sys_state(vtol_state);
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

        function obj = msg_extended_sys_state(vtol_state,landed_state,varargin)
        %MSG_EXTENDED_SYS_STATE: Create a new extended_sys_state message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(vtol_state,'MAVLinkPacket')
                    packet = vtol_state;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('vtol_state','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.vtol_state = vtol_state;
                obj.landed_state = landed_state;
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

                packet = MAVLinkPacket(msg_extended_sys_state.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_extended_sys_state.ID;
                
                packet.payload.putUINT8(obj.vtol_state);
                packet.payload.putUINT8(obj.landed_state);

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
            
            obj.vtol_state = payload.getUINT8();
            obj.landed_state = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.vtol_state,2) ~= 1
                result = 'vtol_state';
            elseif size(obj.landed_state,2) ~= 1
                result = 'landed_state';

            else
                result = 0;
            end
        end

        function set.vtol_state(obj,value)
            if value == uint8(value)
                obj.vtol_state = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.landed_state(obj,value)
            if value == uint8(value)
                obj.landed_state = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end