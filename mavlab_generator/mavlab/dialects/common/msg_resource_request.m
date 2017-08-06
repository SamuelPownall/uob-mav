classdef msg_resource_request < MAVLinkMessage
	%MSG_RESOURCE_REQUEST: MAVLink Message ID = 142
    %Description:
    %    The autopilot is requesting a resource (file, binary, other type of data)
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    request_id(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    request_id(uint8): Request ID. This ID should be re-used when sending back URI contents
    %    uri_type(uint8): The type of requested URI. 0 = a file via URL. 1 = a UAVCAN binary
    %    uri(uint8[120]): The requested unique resource identifier (URI). It is not necessarily a straight domain name (depends on the URI type enum)
    %    transfer_type(uint8): The way the autopilot wants to receive the URI. 0 = MAVLink FTP. 1 = binary stream.
    %    storage(uint8[120]): The storage path the autopilot wants the URI to be stored in. Will only be valid if the transfer_type has a storage associated (e.g. MAVLink FTP).
	
	properties(Constant)
		ID = 142
		LEN = 127
	end
	
	properties
        request_id	%Request ID. This ID should be re-used when sending back URI contents	|	(uint8)
        uri_type	%The type of requested URI. 0 = a file via URL. 1 = a UAVCAN binary	|	(uint8)
        uri	%The requested unique resource identifier (URI). It is not necessarily a straight domain name (depends on the URI type enum)	|	(uint8[120])
        transfer_type	%The way the autopilot wants to receive the URI. 0 = MAVLink FTP. 1 = binary stream.	|	(uint8)
        storage	%The storage path the autopilot wants the URI to be stored in. Will only be valid if the transfer_type has a storage associated (e.g. MAVLink FTP).	|	(uint8[120])
    end

    methods(Static)

        function send(out,request_id,uri_type,uri,transfer_type,storage,varargin)

            if nargin == 5 + 1
                msg = msg_resource_request(request_id,uri_type,uri,transfer_type,storage,varargin);
            elseif nargin == 2
                msg = msg_resource_request(request_id);
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

        function obj = msg_resource_request(request_id,uri_type,uri,transfer_type,storage,varargin)
        %MSG_RESOURCE_REQUEST: Create a new resource_request message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(request_id,'MAVLinkPacket')
                    packet = request_id;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('request_id','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.request_id = request_id;
                obj.uri_type = uri_type;
                obj.uri = uri;
                obj.transfer_type = transfer_type;
                obj.storage = storage;
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

                packet = MAVLinkPacket(msg_resource_request.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_resource_request.ID;
                
                packet.payload.putUINT8(obj.request_id);
                packet.payload.putUINT8(obj.uri_type);
                for i=1:1:120
                    packet.payload.putUINT8(obj.uri(i));
                end
                packet.payload.putUINT8(obj.transfer_type);
                for i=1:1:120
                    packet.payload.putUINT8(obj.storage(i));
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
            
            obj.request_id = payload.getUINT8();
            obj.uri_type = payload.getUINT8();
            for i=1:1:120
                obj.uri(i) = payload.getUINT8();
            end
            obj.transfer_type = payload.getUINT8();
            for i=1:1:120
                obj.storage(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.request_id,2) ~= 1
                result = 'request_id';
            elseif size(obj.uri_type,2) ~= 1
                result = 'uri_type';
            elseif size(obj.uri,2) ~= 120
                result = 'uri';
            elseif size(obj.transfer_type,2) ~= 1
                result = 'transfer_type';
            elseif size(obj.storage,2) ~= 120
                result = 'storage';

            else
                result = 0;
            end
        end

        function set.request_id(obj,value)
            if value == uint8(value)
                obj.request_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.uri_type(obj,value)
            if value == uint8(value)
                obj.uri_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.uri(obj,value)
            if value == uint8(value)
                obj.uri = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.transfer_type(obj,value)
            if value == uint8(value)
                obj.transfer_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.storage(obj,value)
            if value == uint8(value)
                obj.storage = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end