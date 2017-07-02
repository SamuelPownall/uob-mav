classdef msg_camera_trigger < mavlink_message
    %MAVLINK Message Class
    %Name: camera_trigger	ID: 112
    %Description: Camera-IMU triggering and synchronisation message.
            
    properties(Constant)
        ID = 112
        LEN = 12
    end
    
    properties        
		time_usec	%Timestamp for the image frame in microseconds (uint64[1])
		seq	%Image frame sequence (uint32[1])
	end

    
    methods
        
        %Constructor: msg_camera_trigger
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_trigger(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_camera_trigger.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_camera_trigger.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putUINT32(obj.seq);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.seq = payload.getUINT32();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_trigger.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.seq(obj,value)
            if value == uint32(value)
                obj.seq = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_trigger.set.seq()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                        
	end
end