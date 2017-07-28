classdef msg_camera_status < mavlink_message
	%MSG_CAMERA_STATUS(packet,time_usec,p1,p2,p3,p4,img_idx,target_system,cam_idx,event_id): MAVLINK Message ID = 179
    %Description:
    %    Camera Event
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Image timestamp (microseconds since UNIX epoch, according to camera clock)
    %    p1(single): Parameter 1 (meaning depends on event, see CAMERA_STATUS_TYPES enum)
    %    p2(single): Parameter 2 (meaning depends on event, see CAMERA_STATUS_TYPES enum)
    %    p3(single): Parameter 3 (meaning depends on event, see CAMERA_STATUS_TYPES enum)
    %    p4(single): Parameter 4 (meaning depends on event, see CAMERA_STATUS_TYPES enum)
    %    img_idx(uint16): Image index
    %    target_system(uint8): System ID
    %    cam_idx(uint8): Camera ID
    %    event_id(uint8): See CAMERA_STATUS_TYPES enum for definition of the bitmask
	
	properties(Constant)
		ID = 179
		LEN = 29
	end
	
	properties
        time_usec	%Image timestamp (microseconds since UNIX epoch, according to camera clock)	|	(uint64)
        p1	%Parameter 1 (meaning depends on event, see CAMERA_STATUS_TYPES enum)	|	(single)
        p2	%Parameter 2 (meaning depends on event, see CAMERA_STATUS_TYPES enum)	|	(single)
        p3	%Parameter 3 (meaning depends on event, see CAMERA_STATUS_TYPES enum)	|	(single)
        p4	%Parameter 4 (meaning depends on event, see CAMERA_STATUS_TYPES enum)	|	(single)
        img_idx	%Image index	|	(uint16)
        target_system	%System ID	|	(uint8)
        cam_idx	%Camera ID	|	(uint8)
        event_id	%See CAMERA_STATUS_TYPES enum for definition of the bitmask	|	(uint8)
    end

    methods

        %Constructor: msg_camera_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_status(packet,time_usec,p1,p2,p3,p4,img_idx,target_system,cam_idx,event_id)
        
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
            
            elseif nargin-1 == 9
                obj.time_usec = time_usec;
                obj.p1 = p1;
                obj.p2 = p2;
                obj.p3 = p3;
                obj.p4 = p4;
                obj.img_idx = img_idx;
                obj.target_system = target_system;
                obj.cam_idx = cam_idx;
                obj.event_id = event_id;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_camera_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_camera_status.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.p1);
                packet.payload.putSINGLE(obj.p2);
                packet.payload.putSINGLE(obj.p3);
                packet.payload.putSINGLE(obj.p4);
                packet.payload.putUINT16(obj.img_idx);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.cam_idx);
                packet.payload.putUINT8(obj.event_id);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.p1 = payload.getSINGLE();
            obj.p2 = payload.getSINGLE();
            obj.p3 = payload.getSINGLE();
            obj.p4 = payload.getSINGLE();
            obj.img_idx = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.cam_idx = payload.getUINT8();
            obj.event_id = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.p1,2) ~= 1
                result = 'p1';
            elseif size(obj.p2,2) ~= 1
                result = 'p2';
            elseif size(obj.p3,2) ~= 1
                result = 'p3';
            elseif size(obj.p4,2) ~= 1
                result = 'p4';
            elseif size(obj.img_idx,2) ~= 1
                result = 'img_idx';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.cam_idx,2) ~= 1
                result = 'cam_idx';
            elseif size(obj.event_id,2) ~= 1
                result = 'event_id';

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
        
        function set.p1(obj,value)
            obj.p1 = single(value);
        end
        
        function set.p2(obj,value)
            obj.p2 = single(value);
        end
        
        function set.p3(obj,value)
            obj.p3 = single(value);
        end
        
        function set.p4(obj,value)
            obj.p4 = single(value);
        end
        
        function set.img_idx(obj,value)
            if value == uint16(value)
                obj.img_idx = uint16(value);
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
        
        function set.cam_idx(obj,value)
            if value == uint8(value)
                obj.cam_idx = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.event_id(obj,value)
            if value == uint8(value)
                obj.event_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end