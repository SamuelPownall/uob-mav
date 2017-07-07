classdef msg_data32 < mavlink_message
    %MAVLINK Message Class
    %Name: data32	ID: 170
    %Description: Data packet, size 32
            
    properties(Constant)
        ID = 170
        LEN = 34
    end
    
    properties        
		type	%data type (uint8)
		len	%data length (uint8)
		data	%raw data (uint8[32])
	end
    
    methods
        
        %Constructor: msg_data32
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_data32(packet,type,len,data)
        
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
                
            elseif nargin == 4
                
				obj.type = type;
				obj.len = len;
				obj.data = data;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_data32.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_data32.ID;
                
				packet.payload.putUINT8(obj.type);

				packet.payload.putUINT8(obj.len);
            
                for i = 1:32
                    packet.payload.putUINT8(obj.data(i));
                end
                                        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.type = payload.getUINT8();

			obj.len = payload.getUINT8();
            
            for i = 1:32
                obj.data(i) = payload.getUINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.type,2) ~= 1
                result = 'type';                                        
            elseif size(obj.len,2) ~= 1
                result = 'len';                                        
            elseif size(obj.data,2) ~= 32
                result = 'data';                            
            else
                result = 0;
            end
            
        end
                                
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.len(obj,value)
            if value == uint8(value)
                obj.len = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end