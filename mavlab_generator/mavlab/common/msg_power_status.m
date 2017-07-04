classdef msg_power_status < mavlink_message
    %MAVLINK Message Class
    %Name: power_status	ID: 125
    %Description: Power supply status
            
    properties(Constant)
        ID = 125
        LEN = 6
    end
    
    properties        
		vcc	%5V rail voltage in millivolts (uint16)
		vservo	%servo rail voltage in millivolts (uint16)
		flags	%power supply status flags (see MAV_POWER_STATUS enum) (uint16)
	end
    
    methods
        
        %Constructor: msg_power_status
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_power_status(packet,vcc,vservo,flags)
        
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
                
				obj.vcc = vcc;
				obj.vservo = vservo;
				obj.flags = flags;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_power_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_power_status.ID;
                
				packet.payload.putUINT16(obj.vcc);

				packet.payload.putUINT16(obj.vservo);

				packet.payload.putUINT16(obj.flags);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.vcc = payload.getUINT16();

			obj.vservo = payload.getUINT16();

			obj.flags = payload.getUINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.vcc,2) ~= 1
                result = 'vcc';                                        
            elseif size(obj.vservo,2) ~= 1
                result = 'vservo';                                        
            elseif size(obj.flags,2) ~= 1
                result = 'flags';                            
            else
                result = 0;
            end
            
        end
                                
        function set.vcc(obj,value)
            if value == uint16(value)
                obj.vcc = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.vservo(obj,value)
            if value == uint16(value)
                obj.vservo = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                        
	end
end