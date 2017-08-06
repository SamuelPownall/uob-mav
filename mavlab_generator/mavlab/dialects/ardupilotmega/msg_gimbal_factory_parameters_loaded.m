classdef msg_gimbal_factory_parameters_loaded < MAVLinkMessage
	%MSG_GIMBAL_FACTORY_PARAMETERS_LOADED: MAVLink Message ID = 207
    %Description:
    %    Sent by the gimbal after the factory parameters are successfully loaded, to inform the factory software that the load is complete
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    dummy(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    dummy(uint8): Dummy field because mavgen doesn't allow messages with no fields
	
	properties(Constant)
		ID = 207
		LEN = 1
	end
	
	properties
        dummy	%Dummy field because mavgen doesn't allow messages with no fields	|	(uint8)
    end

    methods(Static)

        function send(out,dummy,varargin)

            if nargin == 1 + 1
                msg = msg_gimbal_factory_parameters_loaded(dummy,varargin);
            elseif nargin == 2
                msg = msg_gimbal_factory_parameters_loaded(dummy);
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

        function obj = msg_gimbal_factory_parameters_loaded(dummy,varargin)
        %MSG_GIMBAL_FACTORY_PARAMETERS_LOADED: Create a new gimbal_factory_parameters_loaded message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(dummy,'MAVLinkPacket')
                    packet = dummy;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    obj.dummy = dummy;
                end
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

                packet = MAVLinkPacket(msg_gimbal_factory_parameters_loaded.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gimbal_factory_parameters_loaded.ID;
                
                packet.payload.putUINT8(obj.dummy);

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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end