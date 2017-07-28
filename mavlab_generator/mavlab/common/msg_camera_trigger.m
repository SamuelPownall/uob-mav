classdef msg_camera_trigger < mavlink_message
	%MSG_CAMERA_TRIGGER(packet,time_usec,seq): MAVLINK Message ID = 112
    %Description:
    %    Camera-IMU triggering and synchronisation message.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Timestamp for the image frame in microseconds
    %    seq(uint32): Image frame sequence
	
	properties(Constant)
		ID = 112
		LEN = 12
	end
	
	properties
        time_usec	%Timestamp for the image frame in microseconds	|	(uint64)
        seq	%Image frame sequence	|	(uint32)
    end

    methods

        %Constructor: msg_camera_trigger
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_trigger(packet,time_usec,seq)
        
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
            
            elseif nargin-1 == 2
                obj.time_usec = time_usec;
                obj.seq = seq;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_camera_trigger.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_camera_trigger.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putUINT32(obj.seq);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.seq = payload.getUINT32();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.seq,2) ~= 1
                result = 'seq';

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
        
        function set.seq(obj,value)
            if value == uint32(value)
                obj.seq = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
    end

end