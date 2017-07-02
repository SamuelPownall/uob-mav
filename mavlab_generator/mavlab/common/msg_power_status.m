classdef msg_power_status < mavlink_message
    %MAVLINK Message Class
    %Name: power_status	ID: 125
    %Description: Power supply status
            
    properties(Constant)
        ID = 125
        LEN = 6
    end
    
    properties        
		vcc	%5V rail voltage in millivolts (uint16[1])
		vservo	%servo rail voltage in millivolts (uint16[1])
		flags	%power supply status flags (see MAV_POWER_STATUS enum) (uint16[1])
	end

    
    methods
        
        %Constructor: msg_power_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_power_status(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_power_status.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_power_status.ID;
                
			packet.payload.putUINT16(obj.vcc);

			packet.payload.putUINT16(obj.vservo);

			packet.payload.putUINT16(obj.flags);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.vcc = payload.getUINT16();

			obj.vservo = payload.getUINT16();

			obj.flags = payload.getUINT16();

		end
            
        function set.vcc(obj,value)
            if value == uint16(value)
                obj.vcc = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | power_status.set.vcc()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.vservo(obj,value)
            if value == uint16(value)
                obj.vservo = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | power_status.set.vservo()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | power_status.set.flags()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end