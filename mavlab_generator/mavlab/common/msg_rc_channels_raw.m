classdef msg_rc_channels_raw < mavlink_message
    %MAVLINK Message Class
    %Name: rc_channels_raw	ID: 35
    %Description: The RAW values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters might violate this specification.
            
    properties(Constant)
        ID = 35
        LEN = 22
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
		port	%Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos. (uint8)
		rssi	%Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown. (uint8)
	end
    
    methods
        
        %Constructor: msg_rc_channels_raw
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_rc_channels_raw(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_rc_channels_raw.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_rc_channels_raw.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putUINT16(obj.chan1_raw);

				packet.payload.putUINT16(obj.chan2_raw);

				packet.payload.putUINT16(obj.chan3_raw);

				packet.payload.putUINT16(obj.chan4_raw);

				packet.payload.putUINT16(obj.chan5_raw);

				packet.payload.putUINT16(obj.chan6_raw);

				packet.payload.putUINT16(obj.chan7_raw);

				packet.payload.putUINT16(obj.chan8_raw);

				packet.payload.putUINT8(obj.port);

				packet.payload.putUINT8(obj.rssi);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_rc_channels_raw.pack()\n\t Message data in "%s" is not valid\n',emptyField);
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

			obj.port = payload.getUINT8();

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
            elseif size(obj.port,2) ~= 1
                result = 'port';                                        
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
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.chan1_raw(obj,value)
            if value == uint16(value)
                obj.chan1_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan1_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan2_raw(obj,value)
            if value == uint16(value)
                obj.chan2_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan2_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan3_raw(obj,value)
            if value == uint16(value)
                obj.chan3_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan3_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan4_raw(obj,value)
            if value == uint16(value)
                obj.chan4_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan4_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan5_raw(obj,value)
            if value == uint16(value)
                obj.chan5_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan5_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan6_raw(obj,value)
            if value == uint16(value)
                obj.chan6_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan6_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan7_raw(obj,value)
            if value == uint16(value)
                obj.chan7_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan7_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan8_raw(obj,value)
            if value == uint16(value)
                obj.chan8_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.chan8_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.port(obj,value)
            if value == uint8(value)
                obj.port = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.port()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.rssi(obj,value)
            if value == uint8(value)
                obj.rssi = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_raw.set.rssi()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end