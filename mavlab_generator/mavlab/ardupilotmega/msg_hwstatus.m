classdef msg_hwstatus < mavlink_message
    %MAVLINK Message Class
    %Name: hwstatus	ID: 165
    %Description: Status of key hardware
            
    properties(Constant)
        ID = 165
        LEN = 3
    end
    
    properties        
		vcc	%board voltage (mV) (uint16)
		i2cerr	%I2C error count (uint8)
	end
    
    methods
        
        %Constructor: msg_hwstatus
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_hwstatus(packet,vcc,i2cerr)
        
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
                
            elseif nargin == 3
                
				obj.vcc = vcc;
				obj.i2cerr = i2cerr;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_hwstatus.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hwstatus.ID;
                
				packet.payload.putUINT16(obj.vcc);

				packet.payload.putUINT8(obj.i2cerr);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.vcc = payload.getUINT16();

			obj.i2cerr = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.vcc,2) ~= 1
                result = 'vcc';                                        
            elseif size(obj.i2cerr,2) ~= 1
                result = 'i2cerr';                            
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
                                    
        function set.i2cerr(obj,value)
            if value == uint8(value)
                obj.i2cerr = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end