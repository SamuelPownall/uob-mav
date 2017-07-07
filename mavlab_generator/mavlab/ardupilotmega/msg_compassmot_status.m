classdef msg_compassmot_status < mavlink_message
    %MAVLINK Message Class
    %Name: compassmot_status	ID: 177
    %Description: Status of compassmot calibration
            
    properties(Constant)
        ID = 177
        LEN = 20
    end
    
    properties        
		current	%current (amps) (single)
		compensationx	%Motor Compensation X (single)
		compensationy	%Motor Compensation Y (single)
		compensationz	%Motor Compensation Z (single)
		throttle	%throttle (percent*10) (uint16)
		interference	%interference (percent) (uint16)
	end
    
    methods
        
        %Constructor: msg_compassmot_status
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_compassmot_status(packet,current,compensationx,compensationy,compensationz,throttle,interference)
        
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
                
            elseif nargin == 7
                
				obj.current = current;
				obj.compensationx = compensationx;
				obj.compensationy = compensationy;
				obj.compensationz = compensationz;
				obj.throttle = throttle;
				obj.interference = interference;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_compassmot_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_compassmot_status.ID;
                
				packet.payload.putSINGLE(obj.current);

				packet.payload.putSINGLE(obj.compensationx);

				packet.payload.putSINGLE(obj.compensationy);

				packet.payload.putSINGLE(obj.compensationz);

				packet.payload.putUINT16(obj.throttle);

				packet.payload.putUINT16(obj.interference);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.current = payload.getSINGLE();

			obj.compensationx = payload.getSINGLE();

			obj.compensationy = payload.getSINGLE();

			obj.compensationz = payload.getSINGLE();

			obj.throttle = payload.getUINT16();

			obj.interference = payload.getUINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.current,2) ~= 1
                result = 'current';                                        
            elseif size(obj.compensationx,2) ~= 1
                result = 'compensationx';                                        
            elseif size(obj.compensationy,2) ~= 1
                result = 'compensationy';                                        
            elseif size(obj.compensationz,2) ~= 1
                result = 'compensationz';                                        
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';                                        
            elseif size(obj.interference,2) ~= 1
                result = 'interference';                            
            else
                result = 0;
            end
            
        end
                            
        function set.current(obj,value)
            obj.current = single(value);
        end
                                
        function set.compensationx(obj,value)
            obj.compensationx = single(value);
        end
                                
        function set.compensationy(obj,value)
            obj.compensationy = single(value);
        end
                                
        function set.compensationz(obj,value)
            obj.compensationz = single(value);
        end
                                    
        function set.throttle(obj,value)
            if value == uint16(value)
                obj.throttle = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.interference(obj,value)
            if value == uint16(value)
                obj.interference = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                        
	end
end