classdef msg_extended_sys_state < mavlink_message
	%MSG_EXTENDED_SYS_STATE: MAVLINK Message ID = 245
    %Description:
    %    Provides state for additional features
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

    methods

        function obj = msg_extended_sys_state(packet,vtol_state,landed_state)
        %Create a new extended_sys_state message
        
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
            
            elseif nargin-1 == 2
                obj.vtol_state = vtol_state;
                obj.landed_state = landed_state;
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

                packet = mavlink_packet(msg_extended_sys_state.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_extended_sys_state.ID;
                
                packet.payload.putUINT8(obj.vtol_state);
                packet.payload.putUINT8(obj.landed_state);

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
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.landed_state(obj,value)
            if value == uint8(value)
                obj.landed_state = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end