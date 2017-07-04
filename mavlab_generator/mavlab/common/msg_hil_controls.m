classdef msg_hil_controls < mavlink_message
    %MAVLINK Message Class
    %Name: hil_controls	ID: 91
    %Description: Sent from autopilot to simulation. Hardware in the loop control outputs
            
    properties(Constant)
        ID = 91
        LEN = 42
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64)
		roll_ailerons	%Control output -1 .. 1 (single)
		pitch_elevator	%Control output -1 .. 1 (single)
		yaw_rudder	%Control output -1 .. 1 (single)
		throttle	%Throttle 0 .. 1 (single)
		aux1	%Aux 1, -1 .. 1 (single)
		aux2	%Aux 2, -1 .. 1 (single)
		aux3	%Aux 3, -1 .. 1 (single)
		aux4	%Aux 4, -1 .. 1 (single)
		mode	%System mode (MAV_MODE) (uint8)
		nav_mode	%Navigation mode (MAV_NAV_MODE) (uint8)
	end
    
    methods
        
        %Constructor: msg_hil_controls
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_hil_controls(packet,time_usec,roll_ailerons,pitch_elevator,yaw_rudder,throttle,aux1,aux2,aux3,aux4,mode,nav_mode)
        
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
                
            elseif nargin == 12
                
				obj.time_usec = time_usec;
				obj.roll_ailerons = roll_ailerons;
				obj.pitch_elevator = pitch_elevator;
				obj.yaw_rudder = yaw_rudder;
				obj.throttle = throttle;
				obj.aux1 = aux1;
				obj.aux2 = aux2;
				obj.aux3 = aux3;
				obj.aux4 = aux4;
				obj.mode = mode;
				obj.nav_mode = nav_mode;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_hil_controls.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_controls.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putSINGLE(obj.roll_ailerons);

				packet.payload.putSINGLE(obj.pitch_elevator);

				packet.payload.putSINGLE(obj.yaw_rudder);

				packet.payload.putSINGLE(obj.throttle);

				packet.payload.putSINGLE(obj.aux1);

				packet.payload.putSINGLE(obj.aux2);

				packet.payload.putSINGLE(obj.aux3);

				packet.payload.putSINGLE(obj.aux4);

				packet.payload.putUINT8(obj.mode);

				packet.payload.putUINT8(obj.nav_mode);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.roll_ailerons = payload.getSINGLE();

			obj.pitch_elevator = payload.getSINGLE();

			obj.yaw_rudder = payload.getSINGLE();

			obj.throttle = payload.getSINGLE();

			obj.aux1 = payload.getSINGLE();

			obj.aux2 = payload.getSINGLE();

			obj.aux3 = payload.getSINGLE();

			obj.aux4 = payload.getSINGLE();

			obj.mode = payload.getUINT8();

			obj.nav_mode = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.roll_ailerons,2) ~= 1
                result = 'roll_ailerons';                                        
            elseif size(obj.pitch_elevator,2) ~= 1
                result = 'pitch_elevator';                                        
            elseif size(obj.yaw_rudder,2) ~= 1
                result = 'yaw_rudder';                                        
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';                                        
            elseif size(obj.aux1,2) ~= 1
                result = 'aux1';                                        
            elseif size(obj.aux2,2) ~= 1
                result = 'aux2';                                        
            elseif size(obj.aux3,2) ~= 1
                result = 'aux3';                                        
            elseif size(obj.aux4,2) ~= 1
                result = 'aux4';                                        
            elseif size(obj.mode,2) ~= 1
                result = 'mode';                                        
            elseif size(obj.nav_mode,2) ~= 1
                result = 'nav_mode';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                
        function set.roll_ailerons(obj,value)
            obj.roll_ailerons = single(value);
        end
                                
        function set.pitch_elevator(obj,value)
            obj.pitch_elevator = single(value);
        end
                                
        function set.yaw_rudder(obj,value)
            obj.yaw_rudder = single(value);
        end
                                
        function set.throttle(obj,value)
            obj.throttle = single(value);
        end
                                
        function set.aux1(obj,value)
            obj.aux1 = single(value);
        end
                                
        function set.aux2(obj,value)
            obj.aux2 = single(value);
        end
                                
        function set.aux3(obj,value)
            obj.aux3 = single(value);
        end
                                
        function set.aux4(obj,value)
            obj.aux4 = single(value);
        end
                                    
        function set.mode(obj,value)
            if value == uint8(value)
                obj.mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.nav_mode(obj,value)
            if value == uint8(value)
                obj.nav_mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end