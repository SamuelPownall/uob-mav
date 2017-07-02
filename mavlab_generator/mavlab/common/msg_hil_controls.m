classdef msg_hil_controls < mavlink_message
    %MAVLINK Message Class
    %Name: hil_controls	ID: 91
    %Description: Sent from autopilot to simulation. Hardware in the loop control outputs
            
    properties(Constant)
        ID = 91
        LEN = 42
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64[1])
		roll_ailerons	%Control output -1 .. 1 (single[1])
		pitch_elevator	%Control output -1 .. 1 (single[1])
		yaw_rudder	%Control output -1 .. 1 (single[1])
		throttle	%Throttle 0 .. 1 (single[1])
		aux1	%Aux 1, -1 .. 1 (single[1])
		aux2	%Aux 2, -1 .. 1 (single[1])
		aux3	%Aux 3, -1 .. 1 (single[1])
		aux4	%Aux 4, -1 .. 1 (single[1])
		mode	%System mode (MAV_MODE) (uint8[1])
		nav_mode	%Navigation mode (MAV_NAV_MODE) (uint8[1])
	end

    
    methods
        
        %Constructor: msg_hil_controls
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_controls(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_controls.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
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
                fprintf(2,'MAVLAB-ERROR | hil_controls.set.mode()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.nav_mode(obj,value)
            if value == uint8(value)
                obj.nav_mode = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_controls.set.nav_mode()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end