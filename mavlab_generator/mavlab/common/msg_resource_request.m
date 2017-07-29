classdef msg_resource_request < mavlink_handle
	%MSG_RESOURCE_REQUEST(packet,request_id,uri_type,uri,transfer_type,storage): MAVLINK Message ID = 142
    %Description:
    %    The autopilot is requesting a resource (file, binary, other type of data)
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

    methods

        %Constructor: msg_resource_request
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_resource_request(packet,request_id,uri_type,uri,transfer_type,storage)
        
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
            
            elseif nargin-1 == 5
                obj.request_id = request_id;
                obj.uri_type = uri_type;
                obj.uri = uri;
                obj.transfer_type = transfer_type;
                obj.storage = storage;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_resource_request.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
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
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

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
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.uri_type(obj,value)
            if value == uint8(value)
                obj.uri_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.uri(obj,value)
            if value == uint8(value)
                obj.uri = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.transfer_type(obj,value)
            if value == uint8(value)
                obj.transfer_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.storage(obj,value)
            if value == uint8(value)
                obj.storage = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end