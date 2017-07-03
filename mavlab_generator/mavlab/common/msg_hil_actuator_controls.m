classdef msg_hil_actuator_controls < mavlink_message
    %MAVLINK Message Class
    %Name: hil_actuator_controls	ID: 93
    %Description: Sent from autopilot to simulation. Hardware in the loop control outputs (replacement for HIL_CONTROLS)
            
    properties(Constant)
        ID = 93
        LEN = 81
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64)
		flags	%Flags as bitfield, reserved for future use. (uint64)
		controls	%Control outputs -1 .. 1. Channel assignment depends on the simulated hardware. (single[16])
		mode	%System mode (MAV_MODE), includes arming state. (uint8)
	end
    
    methods
        
        %Constructor: msg_hil_actuator_controls
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_actuator_controls(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_hil_actuator_controls.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_actuator_controls.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putUINT64(obj.flags);
            
                for i = 1:16
                    packet.payload.putSINGLE(obj.controls(i));
                end
                                
				packet.payload.putUINT8(obj.mode);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_hil_actuator_controls.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.flags = payload.getUINT64();
            
            for i = 1:16
                obj.controls(i) = payload.getSINGLE();
            end
                            
			obj.mode = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.flags,2) ~= 1
                result = 'flags';                                        
            elseif size(obj.controls,2) ~= 16
                result = 'controls';                                        
            elseif size(obj.mode,2) ~= 1
                result = 'mode';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_actuator_controls.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.flags(obj,value)
            if value == uint64(value)
                obj.flags = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_actuator_controls.set.flags()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.controls(obj,value)
            obj.controls = single(value);
        end
                                    
        function set.mode(obj,value)
            if value == uint8(value)
                obj.mode = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_actuator_controls.set.mode()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end