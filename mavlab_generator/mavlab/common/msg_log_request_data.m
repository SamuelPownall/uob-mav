classdef msg_log_request_data < mavlink_message
	%MSG_LOG_REQUEST_DATA: MAVLINK Message ID = 119
    %Description:
    %    Request a chunk of a log
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    ofs(uint32): Offset into the log
    %    count(uint32): Number of bytes
    %    id(uint16): Log id (from LOG_ENTRY reply)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 119
		LEN = 12
	end
	
	properties
        ofs	%Offset into the log	|	(uint32)
        count	%Number of bytes	|	(uint32)
        id	%Log id (from LOG_ENTRY reply)	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods

        function obj = msg_log_request_data(packet,ofs,count,id,target_system,target_component)
        %Create a new log_request_data message
        
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
            
            elseif nargin-1 == 5
                obj.ofs = ofs;
                obj.count = count;
                obj.id = id;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = mavlink_packet(msg_log_request_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_log_request_data.ID;
                
                packet.payload.putUINT32(obj.ofs);
                packet.payload.putUINT32(obj.count);
                packet.payload.putUINT16(obj.id);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
            
            obj.ofs = payload.getUINT32();
            obj.count = payload.getUINT32();
            obj.id = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.ofs,2) ~= 1
                result = 'ofs';
            elseif size(obj.count,2) ~= 1
                result = 'count';
            elseif size(obj.id,2) ~= 1
                result = 'id';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.ofs(obj,value)
            if value == uint32(value)
                obj.ofs = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.count(obj,value)
            if value == uint32(value)
                obj.count = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.id(obj,value)
            if value == uint16(value)
                obj.id = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end