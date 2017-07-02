classdef msg_resource_request < mavlink_message
    %MAVLINK Message Class
    %Name: resource_request	ID: 142
    %Description: The autopilot is requesting a resource (file, binary, other type of data)
            
    properties(Constant)
        ID = 142
        LEN = 243
    end
    
    properties        
		request_id	%Request ID. This ID should be re-used when sending back URI contents (uint8[1])
		uri_type	%The type of requested URI. 0 = a file via URL. 1 = a UAVCAN binary (uint8[1])
		uri	%The requested unique resource identifier (URI). It is not necessarily a straight domain name (depends on the URI type enum) (uint8[120])
		transfer_type	%The way the autopilot wants to receive the URI. 0 = MAVLink FTP. 1 = binary stream. (uint8[1])
		storage	%The storage path the autopilot wants the URI to be stored in. Will only be valid if the transfer_type has a storage associated (e.g. MAVLink FTP). (uint8[120])
	end

    
    methods
        
        %Constructor: msg_resource_request
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_resource_request(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_resource_request.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_resource_request.ID;
                
			packet.payload.putUINT8(obj.request_id);

			packet.payload.putUINT8(obj.uri_type);
            
            for i = 1:120
                packet.payload.putUINT8(obj.uri(i));
            end
                            
			packet.payload.putUINT8(obj.transfer_type);
            
            for i = 1:120
                packet.payload.putUINT8(obj.storage(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.request_id = payload.getUINT8();

			obj.uri_type = payload.getUINT8();
            
            for i = 1:120
                obj.uri(i) = payload.getUINT8();
            end
                            
			obj.transfer_type = payload.getUINT8();
            
            for i = 1:120
                obj.storage(i) = payload.getUINT8();
            end
                            
		end
            
        function set.request_id(obj,value)
            if value == uint8(value)
                obj.request_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | resource_request.set.request_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.uri_type(obj,value)
            if value == uint8(value)
                obj.uri_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | resource_request.set.uri_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.uri(obj,value)
            if value == uint8(value)
                obj.uri = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | resource_request.set.uri()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.transfer_type(obj,value)
            if value == uint8(value)
                obj.transfer_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | resource_request.set.transfer_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.storage(obj,value)
            if value == uint8(value)
                obj.storage = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | resource_request.set.storage()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end