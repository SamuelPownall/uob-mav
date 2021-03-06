classdef msg_param_request_read < MAVLinkMessage
	%MSG_PARAM_REQUEST_READ: MAVLink Message ID = 20
    %Description:
    %    Request to read the onboard parameter with the param_id string id. Onboard parameters are stored as key[const char*] -> value[float]. This allows to send a parameter to any other component (such as the GCS) without the need of previous knowledge of possible parameter names. Thus the same GCS can store different parameters for different autopilots. See also http://qgroundcontrol.org/parameter_interface for a full documentation of QGroundControl and IMU code.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    param_index(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    param_index(int16): Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    param_id(uint8[16]): Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
	
	properties(Constant)
		ID = 20
		LEN = 20
	end
	
	properties
        param_index	%Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored)	|	(int16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string	|	(uint8[16])
    end

    methods(Static)

        function send(out,param_index,target_system,target_component,param_id,varargin)

            if nargin == 4 + 1
                msg = msg_param_request_read(param_index,target_system,target_component,param_id,varargin);
            elseif nargin == 2
                msg = msg_param_request_read(param_index);
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

        function obj = msg_param_request_read(param_index,target_system,target_component,param_id,varargin)
        %MSG_PARAM_REQUEST_READ: Create a new param_request_read message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(param_index,'MAVLinkPacket')
                    packet = param_index;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('param_index','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.param_index = param_index;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.param_id = param_id;
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

                packet = MAVLinkPacket(msg_param_request_read.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_param_request_read.ID;
                
                packet.payload.putINT16(obj.param_index);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:16
                    packet.payload.putUINT8(obj.param_id(i));
                end

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
            
            obj.param_index = payload.getINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            for i=1:1:16
                obj.param_id(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.param_index,2) ~= 1
                result = 'param_index';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.param_id,2) ~= 16
                result = 'param_id';

            else
                result = 0;
            end
        end

        function set.param_index(obj,value)
            if value == int16(value)
                obj.param_index = int16(value);
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
        
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end