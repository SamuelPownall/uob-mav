classdef msg_gimbal_factory_parameters_loaded < mavlink_message
	%MSG_GIMBAL_FACTORY_PARAMETERS_LOADED: MAVLINK Message ID = 207
    %Description:
    %    Sent by the gimbal after the factory parameters are successfully loaded, to inform the factory software that the load is complete
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    dummy(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    dummy(uint8): Dummy field because mavgen doesn't allow messages with no fields
	
	properties(Constant)
		ID = 207
		LEN = 1
	end
	
	properties
        dummy	%Dummy field because mavgen doesn't allow messages with no fields	|	(uint8)
    end

    methods

        function obj = msg_gimbal_factory_parameters_loaded(dummy,varargin)
        %Create a new gimbal_factory_parameters_loaded message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(dummy,'mavlink_packet')
                    packet = dummy;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    obj.dummy = dummy;
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

                packet = mavlink_packet(msg_gimbal_factory_parameters_loaded.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_factory_parameters_loaded.ID;
                
                packet.payload.putUINT8(obj.dummy);

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
            
            obj.dummy = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.dummy,2) ~= 1
                result = 'dummy';

            else
                result = 0;
            end
        end

        function set.dummy(obj,value)
            if value == uint8(value)
                obj.dummy = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end