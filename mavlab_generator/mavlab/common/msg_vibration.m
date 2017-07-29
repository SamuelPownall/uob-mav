classdef msg_vibration < mavlink_message
	%MSG_VIBRATION: MAVLINK Message ID = 241
    %Description:
    %    Vibration levels and accelerometer clipping
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    vibration_x(single): Vibration levels on X-axis
    %    vibration_y(single): Vibration levels on Y-axis
    %    vibration_z(single): Vibration levels on Z-axis
    %    clipping_0(uint32): first accelerometer clipping count
    %    clipping_1(uint32): second accelerometer clipping count
    %    clipping_2(uint32): third accelerometer clipping count
	
	properties(Constant)
		ID = 241
		LEN = 32
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        vibration_x	%Vibration levels on X-axis	|	(single)
        vibration_y	%Vibration levels on Y-axis	|	(single)
        vibration_z	%Vibration levels on Z-axis	|	(single)
        clipping_0	%first accelerometer clipping count	|	(uint32)
        clipping_1	%second accelerometer clipping count	|	(uint32)
        clipping_2	%third accelerometer clipping count	|	(uint32)
    end

    methods

        function obj = msg_vibration(packet,time_usec,vibration_x,vibration_y,vibration_z,clipping_0,clipping_1,clipping_2)
        %Create a new vibration message
        
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
            
            elseif nargin-1 == 7
                obj.time_usec = time_usec;
                obj.vibration_x = vibration_x;
                obj.vibration_y = vibration_y;
                obj.vibration_z = vibration_z;
                obj.clipping_0 = clipping_0;
                obj.clipping_1 = clipping_1;
                obj.clipping_2 = clipping_2;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_vibration.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_vibration.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.vibration_x);
                packet.payload.putSINGLE(obj.vibration_y);
                packet.payload.putSINGLE(obj.vibration_z);
                packet.payload.putUINT32(obj.clipping_0);
                packet.payload.putUINT32(obj.clipping_1);
                packet.payload.putUINT32(obj.clipping_2);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.vibration_x = payload.getSINGLE();
            obj.vibration_y = payload.getSINGLE();
            obj.vibration_z = payload.getSINGLE();
            obj.clipping_0 = payload.getUINT32();
            obj.clipping_1 = payload.getUINT32();
            obj.clipping_2 = payload.getUINT32();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.vibration_x,2) ~= 1
                result = 'vibration_x';
            elseif size(obj.vibration_y,2) ~= 1
                result = 'vibration_y';
            elseif size(obj.vibration_z,2) ~= 1
                result = 'vibration_z';
            elseif size(obj.clipping_0,2) ~= 1
                result = 'clipping_0';
            elseif size(obj.clipping_1,2) ~= 1
                result = 'clipping_1';
            elseif size(obj.clipping_2,2) ~= 1
                result = 'clipping_2';

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
        
        function set.vibration_x(obj,value)
            obj.vibration_x = single(value);
        end
        
        function set.vibration_y(obj,value)
            obj.vibration_y = single(value);
        end
        
        function set.vibration_z(obj,value)
            obj.vibration_z = single(value);
        end
        
        function set.clipping_0(obj,value)
            if value == uint32(value)
                obj.clipping_0 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.clipping_1(obj,value)
            if value == uint32(value)
                obj.clipping_1 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.clipping_2(obj,value)
            if value == uint32(value)
                obj.clipping_2 = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
    end

end