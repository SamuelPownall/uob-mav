classdef msg_digicam_configure < mavlink_message
	%MSG_DIGICAM_CONFIGURE: MAVLINK Message ID = 154
    %Description:
    %    Configure on-board Camera Control System.
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    extra_value(single): Correspondent value to given extra_param
    %    shutter_speed(uint16): Divisor number //e.g. 1000 means 1/1000 (0 means ignore)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    mode(uint8): Mode enumeration from 1 to N //P, TV, AV, M, Etc (0 means ignore)
    %    aperture(uint8): F stop number x 10 //e.g. 28 means 2.8 (0 means ignore)
    %    iso(uint8): ISO enumeration from 1 to N //e.g. 80, 100, 200, Etc (0 means ignore)
    %    exposure_type(uint8): Exposure type enumeration from 1 to N (0 means ignore)
    %    command_id(uint8): Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
    %    engine_cut_off(uint8): Main engine cut-off time before camera trigger in seconds/10 (0 means no cut-off)
    %    extra_param(uint8): Extra parameters enumeration (0 means ignore)
	
	properties(Constant)
		ID = 154
		LEN = 15
	end
	
	properties
        extra_value	%Correspondent value to given extra_param	|	(single)
        shutter_speed	%Divisor number //e.g. 1000 means 1/1000 (0 means ignore)	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        mode	%Mode enumeration from 1 to N //P, TV, AV, M, Etc (0 means ignore)	|	(uint8)
        aperture	%F stop number x 10 //e.g. 28 means 2.8 (0 means ignore)	|	(uint8)
        iso	%ISO enumeration from 1 to N //e.g. 80, 100, 200, Etc (0 means ignore)	|	(uint8)
        exposure_type	%Exposure type enumeration from 1 to N (0 means ignore)	|	(uint8)
        command_id	%Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once	|	(uint8)
        engine_cut_off	%Main engine cut-off time before camera trigger in seconds/10 (0 means no cut-off)	|	(uint8)
        extra_param	%Extra parameters enumeration (0 means ignore)	|	(uint8)
    end

    methods

        function obj = msg_digicam_configure(packet,extra_value,shutter_speed,target_system,target_component,mode,aperture,iso,exposure_type,command_id,engine_cut_off,extra_param)
        %Create a new digicam_configure message
        
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
            
            elseif nargin-1 == 11
                obj.extra_value = extra_value;
                obj.shutter_speed = shutter_speed;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.mode = mode;
                obj.aperture = aperture;
                obj.iso = iso;
                obj.exposure_type = exposure_type;
                obj.command_id = command_id;
                obj.engine_cut_off = engine_cut_off;
                obj.extra_param = extra_param;
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

                packet = mavlink_packet(msg_digicam_configure.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_digicam_configure.ID;
                
                packet.payload.putSINGLE(obj.extra_value);
                packet.payload.putUINT16(obj.shutter_speed);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.mode);
                packet.payload.putUINT8(obj.aperture);
                packet.payload.putUINT8(obj.iso);
                packet.payload.putUINT8(obj.exposure_type);
                packet.payload.putUINT8(obj.command_id);
                packet.payload.putUINT8(obj.engine_cut_off);
                packet.payload.putUINT8(obj.extra_param);

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
            
            obj.extra_value = payload.getSINGLE();
            obj.shutter_speed = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.mode = payload.getUINT8();
            obj.aperture = payload.getUINT8();
            obj.iso = payload.getUINT8();
            obj.exposure_type = payload.getUINT8();
            obj.command_id = payload.getUINT8();
            obj.engine_cut_off = payload.getUINT8();
            obj.extra_param = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.extra_value,2) ~= 1
                result = 'extra_value';
            elseif size(obj.shutter_speed,2) ~= 1
                result = 'shutter_speed';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.mode,2) ~= 1
                result = 'mode';
            elseif size(obj.aperture,2) ~= 1
                result = 'aperture';
            elseif size(obj.iso,2) ~= 1
                result = 'iso';
            elseif size(obj.exposure_type,2) ~= 1
                result = 'exposure_type';
            elseif size(obj.command_id,2) ~= 1
                result = 'command_id';
            elseif size(obj.engine_cut_off,2) ~= 1
                result = 'engine_cut_off';
            elseif size(obj.extra_param,2) ~= 1
                result = 'extra_param';

            else
                result = 0;
            end
        end

        function set.extra_value(obj,value)
            obj.extra_value = single(value);
        end
        
        function set.shutter_speed(obj,value)
            if value == uint16(value)
                obj.shutter_speed = uint16(value);
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
        
        function set.mode(obj,value)
            if value == uint8(value)
                obj.mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.aperture(obj,value)
            if value == uint8(value)
                obj.aperture = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.iso(obj,value)
            if value == uint8(value)
                obj.iso = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.exposure_type(obj,value)
            if value == uint8(value)
                obj.exposure_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.command_id(obj,value)
            if value == uint8(value)
                obj.command_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.engine_cut_off(obj,value)
            if value == uint8(value)
                obj.engine_cut_off = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.extra_param(obj,value)
            if value == uint8(value)
                obj.extra_param = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end