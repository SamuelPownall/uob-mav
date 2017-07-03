classdef msg_rc_channels_scaled < mavlink_message
    %MAVLINK Message Class
    %Name: rc_channels_scaled	ID: 34
    %Description: The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 10000. Channels that are inactive should be set to UINT16_MAX.
            
    properties(Constant)
        ID = 34
        LEN = 22
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		chan1_scaled	%RC channel 1 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		chan2_scaled	%RC channel 2 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		chan3_scaled	%RC channel 3 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		chan4_scaled	%RC channel 4 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		chan5_scaled	%RC channel 5 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		chan6_scaled	%RC channel 6 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		chan7_scaled	%RC channel 7 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		chan8_scaled	%RC channel 8 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX. (int16)
		port	%Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos. (uint8)
		rssi	%Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown. (uint8)
	end
    
    methods
        
        %Constructor: msg_rc_channels_scaled
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_rc_channels_scaled(packet)
        
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
        
                packet = mavlink_packet(msg_rc_channels_scaled.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_rc_channels_scaled.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putINT16(obj.chan1_scaled);

				packet.payload.putINT16(obj.chan2_scaled);

				packet.payload.putINT16(obj.chan3_scaled);

				packet.payload.putINT16(obj.chan4_scaled);

				packet.payload.putINT16(obj.chan5_scaled);

				packet.payload.putINT16(obj.chan6_scaled);

				packet.payload.putINT16(obj.chan7_scaled);

				packet.payload.putINT16(obj.chan8_scaled);

				packet.payload.putUINT8(obj.port);

				packet.payload.putUINT8(obj.rssi);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_rc_channels_scaled.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.chan1_scaled = payload.getINT16();

			obj.chan2_scaled = payload.getINT16();

			obj.chan3_scaled = payload.getINT16();

			obj.chan4_scaled = payload.getINT16();

			obj.chan5_scaled = payload.getINT16();

			obj.chan6_scaled = payload.getINT16();

			obj.chan7_scaled = payload.getINT16();

			obj.chan8_scaled = payload.getINT16();

			obj.port = payload.getUINT8();

			obj.rssi = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.chan1_scaled,2) ~= 1
                result = 'chan1_scaled';                                        
            elseif size(obj.chan2_scaled,2) ~= 1
                result = 'chan2_scaled';                                        
            elseif size(obj.chan3_scaled,2) ~= 1
                result = 'chan3_scaled';                                        
            elseif size(obj.chan4_scaled,2) ~= 1
                result = 'chan4_scaled';                                        
            elseif size(obj.chan5_scaled,2) ~= 1
                result = 'chan5_scaled';                                        
            elseif size(obj.chan6_scaled,2) ~= 1
                result = 'chan6_scaled';                                        
            elseif size(obj.chan7_scaled,2) ~= 1
                result = 'chan7_scaled';                                        
            elseif size(obj.chan8_scaled,2) ~= 1
                result = 'chan8_scaled';                                        
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
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.chan1_scaled(obj,value)
            if value == int16(value)
                obj.chan1_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan1_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.chan2_scaled(obj,value)
            if value == int16(value)
                obj.chan2_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan2_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.chan3_scaled(obj,value)
            if value == int16(value)
                obj.chan3_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan3_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.chan4_scaled(obj,value)
            if value == int16(value)
                obj.chan4_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan4_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.chan5_scaled(obj,value)
            if value == int16(value)
                obj.chan5_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan5_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.chan6_scaled(obj,value)
            if value == int16(value)
                obj.chan6_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan6_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.chan7_scaled(obj,value)
            if value == int16(value)
                obj.chan7_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan7_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.chan8_scaled(obj,value)
            if value == int16(value)
                obj.chan8_scaled = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.chan8_scaled()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.port(obj,value)
            if value == uint8(value)
                obj.port = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.port()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.rssi(obj,value)
            if value == uint8(value)
                obj.rssi = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels_scaled.set.rssi()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end