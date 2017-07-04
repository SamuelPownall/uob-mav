classdef msg_rc_channels_override < mavlink_message
    %MAVLINK Message Class
    %Name: rc_channels_override	ID: 70
    %Description: The RAW values of the RC channels sent to the MAV to override info received from the RC radio. A value of UINT16_MAX means no change to that channel. A value of 0 means control of that channel should be released back to the RC radio. The standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters might violate this specification.
            
    properties(Constant)
        ID = 70
        LEN = 18
    end
    
    properties        
		chan1_raw	%RC channel 1 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		chan2_raw	%RC channel 2 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		chan3_raw	%RC channel 3 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		chan4_raw	%RC channel 4 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		chan5_raw	%RC channel 5 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		chan6_raw	%RC channel 6 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		chan7_raw	%RC channel 7 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		chan8_raw	%RC channel 8 value, in microseconds. A value of UINT16_MAX means to ignore this field. (uint16)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
	end
    
    methods
        
        %Constructor: msg_rc_channels_override
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_rc_channels_override(packet,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,target_system,target_component)
        
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
                
            elseif nargin == 11
                
				obj.chan1_raw = chan1_raw;
				obj.chan2_raw = chan2_raw;
				obj.chan3_raw = chan3_raw;
				obj.chan4_raw = chan4_raw;
				obj.chan5_raw = chan5_raw;
				obj.chan6_raw = chan6_raw;
				obj.chan7_raw = chan7_raw;
				obj.chan8_raw = chan8_raw;
				obj.target_system = target_system;
				obj.target_component = target_component;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_rc_channels_override.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_rc_channels_override.ID;
                
				packet.payload.putUINT16(obj.chan1_raw);

				packet.payload.putUINT16(obj.chan2_raw);

				packet.payload.putUINT16(obj.chan3_raw);

				packet.payload.putUINT16(obj.chan4_raw);

				packet.payload.putUINT16(obj.chan5_raw);

				packet.payload.putUINT16(obj.chan6_raw);

				packet.payload.putUINT16(obj.chan7_raw);

				packet.payload.putUINT16(obj.chan8_raw);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.chan1_raw = payload.getUINT16();

			obj.chan2_raw = payload.getUINT16();

			obj.chan3_raw = payload.getUINT16();

			obj.chan4_raw = payload.getUINT16();

			obj.chan5_raw = payload.getUINT16();

			obj.chan6_raw = payload.getUINT16();

			obj.chan7_raw = payload.getUINT16();

			obj.chan8_raw = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.chan1_raw,2) ~= 1
                result = 'chan1_raw';                                        
            elseif size(obj.chan2_raw,2) ~= 1
                result = 'chan2_raw';                                        
            elseif size(obj.chan3_raw,2) ~= 1
                result = 'chan3_raw';                                        
            elseif size(obj.chan4_raw,2) ~= 1
                result = 'chan4_raw';                                        
            elseif size(obj.chan5_raw,2) ~= 1
                result = 'chan5_raw';                                        
            elseif size(obj.chan6_raw,2) ~= 1
                result = 'chan6_raw';                                        
            elseif size(obj.chan7_raw,2) ~= 1
                result = 'chan7_raw';                                        
            elseif size(obj.chan8_raw,2) ~= 1
                result = 'chan8_raw';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                            
            else
                result = 0;
            end
            
        end
                                
        function set.chan1_raw(obj,value)
            if value == uint16(value)
                obj.chan1_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan2_raw(obj,value)
            if value == uint16(value)
                obj.chan2_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan3_raw(obj,value)
            if value == uint16(value)
                obj.chan3_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan4_raw(obj,value)
            if value == uint16(value)
                obj.chan4_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan5_raw(obj,value)
            if value == uint16(value)
                obj.chan5_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan6_raw(obj,value)
            if value == uint16(value)
                obj.chan6_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan7_raw(obj,value)
            if value == uint16(value)
                obj.chan7_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan8_raw(obj,value)
            if value == uint16(value)
                obj.chan8_raw = uint16(value);
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