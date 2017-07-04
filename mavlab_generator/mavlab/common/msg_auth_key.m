classdef msg_auth_key < mavlink_message
    %MAVLINK Message Class
    %Name: auth_key	ID: 7
    %Description: Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol has been kept simple, so transmitting the key requires an encrypted channel for true safety.
            
    properties(Constant)
        ID = 7
        LEN = 32
    end
    
    properties        
		key	%key (uint8[32])
	end
    
    methods
        
        %Constructor: msg_auth_key
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_auth_key(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_auth_key.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_auth_key.ID;
                            
                for i = 1:32
                    packet.payload.putUINT8(obj.key(i));
                end
                                        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
                    
            for i = 1:32
                obj.key(i) = payload.getUINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.key,2) ~= 32
                result = 'key';                            
            else
                result = 0;
            end
            
        end
                                
        function set.key(obj,value)
            if value == uint8(value)
                obj.key = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end