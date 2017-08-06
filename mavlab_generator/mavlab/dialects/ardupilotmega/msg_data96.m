classdef msg_data96 < MAVLinkMessage
	%MSG_DATA96: MAVLink Message ID = 172
    %Description:
    %    Data packet, size 96
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    type(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    type(uint8): data type
    %    len(uint8): data length
    %    data(uint8[96]): raw data
	
	properties(Constant)
		ID = 172
		LEN = 98
	end
	
	properties
        type	%data type	|	(uint8)
        len	%data length	|	(uint8)
        data	%raw data	|	(uint8[96])
    end

    methods(Static)

        function send(out,type,len,data,varargin)

            if nargin == 3 + 1
                msg = msg_data96(type,len,data,varargin);
            elseif nargin == 2
                msg = msg_data96(type);
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

        function obj = msg_data96(type,len,data,varargin)
        %MSG_DATA96: Create a new data96 message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(type,'MAVLinkPacket')
                    packet = type;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('type','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.type = type;
                obj.len = len;
                obj.data = data;
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

                packet = MAVLinkPacket(msg_data96.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_data96.ID;
                
                packet.payload.putUINT8(obj.type);
                packet.payload.putUINT8(obj.len);
                for i=1:1:96
                    packet.payload.putUINT8(obj.data(i));
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
            
            obj.type = payload.getUINT8();
            obj.len = payload.getUINT8();
            for i=1:1:96
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.type,2) ~= 1
                result = 'type';
            elseif size(obj.len,2) ~= 1
                result = 'len';
            elseif size(obj.data,2) ~= 96
                result = 'data';

            else
                result = 0;
            end
        end

        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.len(obj,value)
            if value == uint8(value)
                obj.len = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end