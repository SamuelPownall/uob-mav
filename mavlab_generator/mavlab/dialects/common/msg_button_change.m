classdef msg_button_change < MAVLinkMessage
	%MSG_BUTTON_CHANGE: MAVLink Message ID = 257
    %Description:
    %    Report button state change
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    last_change_ms(uint32): Time of last change of button state
    %    state(uint8): Bitmap state of buttons
	
	properties(Constant)
		ID = 257
		LEN = 9
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        last_change_ms	%Time of last change of button state	|	(uint32)
        state	%Bitmap state of buttons	|	(uint8)
    end

    methods(Static)

        function send(out,time_boot_ms,last_change_ms,state,varargin)

            if nargin == 3 + 1
                msg = msg_button_change(time_boot_ms,last_change_ms,state,varargin);
            elseif nargin == 2
                msg = msg_button_change(time_boot_ms);
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

        function obj = msg_button_change(time_boot_ms,last_change_ms,state,varargin)
        %MSG_BUTTON_CHANGE: Create a new button_change message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_boot_ms,'MAVLinkPacket')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_boot_ms','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.last_change_ms = last_change_ms;
                obj.state = state;
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

                packet = MAVLinkPacket(msg_button_change.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_button_change.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putUINT32(obj.last_change_ms);
                packet.payload.putUINT8(obj.state);

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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.last_change_ms = payload.getUINT32();
            obj.state = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.last_change_ms,2) ~= 1
                result = 'last_change_ms';
            elseif size(obj.state,2) ~= 1
                result = 'state';

            else
                result = 0;
            end
        end

        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.last_change_ms(obj,value)
            if value == uint32(value)
                obj.last_change_ms = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.state(obj,value)
            if value == uint8(value)
                obj.state = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end