classdef msg_timesync < mavlink_message
    %MAVLINK Message Class
    %Name: timesync	ID: 111
    %Description: Time synchronization message.
            
    properties(Constant)
        ID = 111
        LEN = 16
    end
    
    properties        
		tc1	%Time sync timestamp 1 (int64[1])
		ts1	%Time sync timestamp 2 (int64[1])
	end

    
    methods
        
        %Constructor: msg_timesync
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_timesync(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_timesync.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_timesync.ID;
                
			packet.payload.putINT64(obj.tc1);

			packet.payload.putINT64(obj.ts1);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.tc1 = payload.getINT64();

			obj.ts1 = payload.getINT64();

		end
            
        function set.tc1(obj,value)
            if value == int64(value)
                obj.tc1 = int64(value);
            else
                fprintf(2,'MAVLAB-ERROR | timesync.set.tc1()\n\t Input "value" is not of type "int64"\n');
            end
        end
                                    
        function set.ts1(obj,value)
            if value == int64(value)
                obj.ts1 = int64(value);
            else
                fprintf(2,'MAVLAB-ERROR | timesync.set.ts1()\n\t Input "value" is not of type "int64"\n');
            end
        end
                        
	end
end