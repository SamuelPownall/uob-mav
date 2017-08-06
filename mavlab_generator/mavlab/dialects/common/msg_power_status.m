classdef msg_power_status < MAVLinkMessage
	%MSG_POWER_STATUS: MAVLink Message ID = 125
    %Description:
    %    Power supply status
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    Vcc(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    Vcc(uint16): 5V rail voltage in millivolts
    %    Vservo(uint16): servo rail voltage in millivolts
    %    flags(uint16): power supply status flags (see MAV_POWER_STATUS enum)
	
	properties(Constant)
		ID = 125
		LEN = 6
	end
	
	properties
        Vcc	%5V rail voltage in millivolts	|	(uint16)
        Vservo	%servo rail voltage in millivolts	|	(uint16)
        flags	%power supply status flags (see MAV_POWER_STATUS enum)	|	(uint16)
    end

    methods(Static)

        function send(out,Vcc,Vservo,flags,varargin)

            if nargin == 3 + 1
                msg = msg_power_status(Vcc,Vservo,flags,varargin);
            elseif nargin == 2
                msg = msg_power_status(Vcc);
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

        function obj = msg_power_status(Vcc,Vservo,flags,varargin)
        %MSG_POWER_STATUS: Create a new power_status message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(Vcc,'MAVLinkPacket')
                    packet = Vcc;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('Vcc','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.Vcc = Vcc;
                obj.Vservo = Vservo;
                obj.flags = flags;
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

                packet = MAVLinkPacket(msg_power_status.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_power_status.ID;
                
                packet.payload.putUINT16(obj.Vcc);
                packet.payload.putUINT16(obj.Vservo);
                packet.payload.putUINT16(obj.flags);

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
            
            obj.Vcc = payload.getUINT16();
            obj.Vservo = payload.getUINT16();
            obj.flags = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.Vcc,2) ~= 1
                result = 'Vcc';
            elseif size(obj.Vservo,2) ~= 1
                result = 'Vservo';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';

            else
                result = 0;
            end
        end

        function set.Vcc(obj,value)
            if value == uint16(value)
                obj.Vcc = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.Vservo(obj,value)
            if value == uint16(value)
                obj.Vservo = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end