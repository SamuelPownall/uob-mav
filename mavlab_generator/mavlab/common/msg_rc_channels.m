classdef msg_rc_channels < mavlink_message
    %MAVLINK Message Class
    %Name: rc_channels	ID: 65
    %Description: The PPM values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters might violate this specification.
            
    properties(Constant)
        ID = 65
        LEN = 42
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		chan1_raw	%RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan2_raw	%RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan3_raw	%RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan4_raw	%RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan5_raw	%RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan6_raw	%RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan7_raw	%RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan8_raw	%RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan9_raw	%RC channel 9 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan10_raw	%RC channel 10 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan11_raw	%RC channel 11 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan12_raw	%RC channel 12 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan13_raw	%RC channel 13 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan14_raw	%RC channel 14 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan15_raw	%RC channel 15 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan16_raw	%RC channel 16 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan17_raw	%RC channel 17 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chan18_raw	%RC channel 18 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16)
		chancount	%Total number of RC channels being received. This can be larger than 18, indicating that more channels are available but not given in this message. This value should be 0 when no RC channels are available. (uint8)
		rssi	%Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown. (uint8)
	end
    
    methods
        
        %Constructor: msg_rc_channels
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_rc_channels(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_rc_channels.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_rc_channels.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putUINT16(obj.chan1_raw);

				packet.payload.putUINT16(obj.chan2_raw);

				packet.payload.putUINT16(obj.chan3_raw);

				packet.payload.putUINT16(obj.chan4_raw);

				packet.payload.putUINT16(obj.chan5_raw);

				packet.payload.putUINT16(obj.chan6_raw);

				packet.payload.putUINT16(obj.chan7_raw);

				packet.payload.putUINT16(obj.chan8_raw);

				packet.payload.putUINT16(obj.chan9_raw);

				packet.payload.putUINT16(obj.chan10_raw);

				packet.payload.putUINT16(obj.chan11_raw);

				packet.payload.putUINT16(obj.chan12_raw);

				packet.payload.putUINT16(obj.chan13_raw);

				packet.payload.putUINT16(obj.chan14_raw);

				packet.payload.putUINT16(obj.chan15_raw);

				packet.payload.putUINT16(obj.chan16_raw);

				packet.payload.putUINT16(obj.chan17_raw);

				packet.payload.putUINT16(obj.chan18_raw);

				packet.payload.putUINT8(obj.chancount);

				packet.payload.putUINT8(obj.rssi);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.chan1_raw = payload.getUINT16();

			obj.chan2_raw = payload.getUINT16();

			obj.chan3_raw = payload.getUINT16();

			obj.chan4_raw = payload.getUINT16();

			obj.chan5_raw = payload.getUINT16();

			obj.chan6_raw = payload.getUINT16();

			obj.chan7_raw = payload.getUINT16();

			obj.chan8_raw = payload.getUINT16();

			obj.chan9_raw = payload.getUINT16();

			obj.chan10_raw = payload.getUINT16();

			obj.chan11_raw = payload.getUINT16();

			obj.chan12_raw = payload.getUINT16();

			obj.chan13_raw = payload.getUINT16();

			obj.chan14_raw = payload.getUINT16();

			obj.chan15_raw = payload.getUINT16();

			obj.chan16_raw = payload.getUINT16();

			obj.chan17_raw = payload.getUINT16();

			obj.chan18_raw = payload.getUINT16();

			obj.chancount = payload.getUINT8();

			obj.rssi = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.chan1_raw,2) ~= 1
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
            elseif size(obj.chan9_raw,2) ~= 1
                result = 'chan9_raw';                                        
            elseif size(obj.chan10_raw,2) ~= 1
                result = 'chan10_raw';                                        
            elseif size(obj.chan11_raw,2) ~= 1
                result = 'chan11_raw';                                        
            elseif size(obj.chan12_raw,2) ~= 1
                result = 'chan12_raw';                                        
            elseif size(obj.chan13_raw,2) ~= 1
                result = 'chan13_raw';                                        
            elseif size(obj.chan14_raw,2) ~= 1
                result = 'chan14_raw';                                        
            elseif size(obj.chan15_raw,2) ~= 1
                result = 'chan15_raw';                                        
            elseif size(obj.chan16_raw,2) ~= 1
                result = 'chan16_raw';                                        
            elseif size(obj.chan17_raw,2) ~= 1
                result = 'chan17_raw';                                        
            elseif size(obj.chan18_raw,2) ~= 1
                result = 'chan18_raw';                                        
            elseif size(obj.chancount,2) ~= 1
                result = 'chancount';                                        
            elseif size(obj.rssi,2) ~= 1
                result = 'rssi';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
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
                                    
        function set.chan9_raw(obj,value)
            if value == uint16(value)
                obj.chan9_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan10_raw(obj,value)
            if value == uint16(value)
                obj.chan10_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan11_raw(obj,value)
            if value == uint16(value)
                obj.chan11_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan12_raw(obj,value)
            if value == uint16(value)
                obj.chan12_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan13_raw(obj,value)
            if value == uint16(value)
                obj.chan13_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan14_raw(obj,value)
            if value == uint16(value)
                obj.chan14_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan15_raw(obj,value)
            if value == uint16(value)
                obj.chan15_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan16_raw(obj,value)
            if value == uint16(value)
                obj.chan16_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan17_raw(obj,value)
            if value == uint16(value)
                obj.chan17_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan18_raw(obj,value)
            if value == uint16(value)
                obj.chan18_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chancount(obj,value)
            if value == uint8(value)
                obj.chancount = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.rssi(obj,value)
            if value == uint8(value)
                obj.rssi = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end