classdef msg_extended_sys_state < mavlink_message
    %MAVLINK Message Class
    %Name: extended_sys_state	ID: 245
    %Description: Provides state for additional features
            
    properties(Constant)
        ID = 245
        LEN = 2
    end
    
    properties        
		vtol_state	%The VTOL state if applicable. Is set to MAV_VTOL_STATE_UNDEFINED if UAV is not in VTOL configuration. (uint8)
		landed_state	%The landed state. Is set to MAV_LANDED_STATE_UNDEFINED if landed state is unknown. (uint8)
	end
    
    methods
        
        %Constructor: msg_extended_sys_state
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_extended_sys_state(packet)
        
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
        
                packet = mavlink_packet(msg_extended_sys_state.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_extended_sys_state.ID;
                
				packet.payload.putUINT8(obj.vtol_state);

				packet.payload.putUINT8(obj.landed_state);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.vtol_state = payload.getUINT8();

			obj.landed_state = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.vtol_state,2) ~= 1
                result = 'vtol_state';                                        
            elseif size(obj.landed_state,2) ~= 1
                result = 'landed_state';                            
            else
                result = 0;
            end
            
        end
                                
        function set.vtol_state(obj,value)
            if value == uint8(value)
                obj.vtol_state = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.landed_state(obj,value)
            if value == uint8(value)
                obj.landed_state = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end