classdef msg_gimbal_factory_parameters_loaded < mavlink_message
    %MAVLINK Message Class
    %Name: gimbal_factory_parameters_loaded	ID: 207
    %Description:              Sent by the gimbal after the factory parameters are successfully loaded, to inform the factory software that the load is complete         
            
    properties(Constant)
        ID = 207
        LEN = 1
    end
    
    properties        
		dummy	%Dummy field because mavgen doesn't allow messages with no fields (uint8)
	end
    
    methods
        
        %Constructor: msg_gimbal_factory_parameters_loaded
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_gimbal_factory_parameters_loaded(packet,dummy)
        
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
                
            elseif nargin == 2
                
				obj.dummy = dummy;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_gimbal_factory_parameters_loaded.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_factory_parameters_loaded.ID;
                
				packet.payload.putUINT8(obj.dummy);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.dummy = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.dummy,2) ~= 1
                result = 'dummy';                            
            else
                result = 0;
            end
            
        end
                                
        function set.dummy(obj,value)
            if value == uint8(value)
                obj.dummy = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end