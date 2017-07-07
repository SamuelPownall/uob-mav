classdef msg_pid_tuning < mavlink_message
    %MAVLINK Message Class
    %Name: pid_tuning	ID: 194
    %Description: PID tuning information
            
    properties(Constant)
        ID = 194
        LEN = 25
    end
    
    properties        
		desired	%desired rate (degrees/s) (single)
		achieved	%achieved rate (degrees/s) (single)
		ff	%FF component (single)
		p	%P component (single)
		i	%I component (single)
		d	%D component (single)
		axis	%axis (uint8)
	end
    
    methods
        
        %Constructor: msg_pid_tuning
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_pid_tuning(packet,desired,achieved,ff,p,i,d,axis)
        
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
                
            elseif nargin == 8
                
				obj.desired = desired;
				obj.achieved = achieved;
				obj.ff = ff;
				obj.p = p;
				obj.i = i;
				obj.d = d;
				obj.axis = axis;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_pid_tuning.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_pid_tuning.ID;
                
				packet.payload.putSINGLE(obj.desired);

				packet.payload.putSINGLE(obj.achieved);

				packet.payload.putSINGLE(obj.ff);

				packet.payload.putSINGLE(obj.p);

				packet.payload.putSINGLE(obj.i);

				packet.payload.putSINGLE(obj.d);

				packet.payload.putUINT8(obj.axis);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.desired = payload.getSINGLE();

			obj.achieved = payload.getSINGLE();

			obj.ff = payload.getSINGLE();

			obj.p = payload.getSINGLE();

			obj.i = payload.getSINGLE();

			obj.d = payload.getSINGLE();

			obj.axis = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.desired,2) ~= 1
                result = 'desired';                                        
            elseif size(obj.achieved,2) ~= 1
                result = 'achieved';                                        
            elseif size(obj.ff,2) ~= 1
                result = 'ff';                                        
            elseif size(obj.p,2) ~= 1
                result = 'p';                                        
            elseif size(obj.i,2) ~= 1
                result = 'i';                                        
            elseif size(obj.d,2) ~= 1
                result = 'd';                                        
            elseif size(obj.axis,2) ~= 1
                result = 'axis';                            
            else
                result = 0;
            end
            
        end
                            
        function set.desired(obj,value)
            obj.desired = single(value);
        end
                                
        function set.achieved(obj,value)
            obj.achieved = single(value);
        end
                                
        function set.ff(obj,value)
            obj.ff = single(value);
        end
                                
        function set.p(obj,value)
            obj.p = single(value);
        end
                                
        function set.i(obj,value)
            obj.i = single(value);
        end
                                
        function set.d(obj,value)
            obj.d = single(value);
        end
                                    
        function set.axis(obj,value)
            if value == uint8(value)
                obj.axis = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end