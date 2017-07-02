classdef msg_rc_channels < mavlink_message
    %MAVLINK Message Class
    %Name: rc_channels	ID: 65
    %Description: The PPM values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters might violate this specification.
            
    properties(Constant)
        ID = 65
        LEN = 42
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		chan1_raw	%RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan2_raw	%RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan3_raw	%RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan4_raw	%RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan5_raw	%RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan6_raw	%RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan7_raw	%RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan8_raw	%RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan9_raw	%RC channel 9 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan10_raw	%RC channel 10 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan11_raw	%RC channel 11 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan12_raw	%RC channel 12 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan13_raw	%RC channel 13 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan14_raw	%RC channel 14 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan15_raw	%RC channel 15 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan16_raw	%RC channel 16 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan17_raw	%RC channel 17 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chan18_raw	%RC channel 18 value, in microseconds. A value of UINT16_MAX implies the channel is unused. (uint16[1])
		chancount	%Total number of RC channels being received. This can be larger than 18, indicating that more channels are available but not given in this message. This value should be 0 when no RC channels are available. (uint8[1])
		rssi	%Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown. (uint8[1])
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.chan1_raw(obj,value)
            if value == uint16(value)
                obj.chan1_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan1_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan2_raw(obj,value)
            if value == uint16(value)
                obj.chan2_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan2_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan3_raw(obj,value)
            if value == uint16(value)
                obj.chan3_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan3_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan4_raw(obj,value)
            if value == uint16(value)
                obj.chan4_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan4_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan5_raw(obj,value)
            if value == uint16(value)
                obj.chan5_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan5_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan6_raw(obj,value)
            if value == uint16(value)
                obj.chan6_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan6_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan7_raw(obj,value)
            if value == uint16(value)
                obj.chan7_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan7_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan8_raw(obj,value)
            if value == uint16(value)
                obj.chan8_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan8_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan9_raw(obj,value)
            if value == uint16(value)
                obj.chan9_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan9_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan10_raw(obj,value)
            if value == uint16(value)
                obj.chan10_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan10_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan11_raw(obj,value)
            if value == uint16(value)
                obj.chan11_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan11_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan12_raw(obj,value)
            if value == uint16(value)
                obj.chan12_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan12_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan13_raw(obj,value)
            if value == uint16(value)
                obj.chan13_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan13_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan14_raw(obj,value)
            if value == uint16(value)
                obj.chan14_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan14_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan15_raw(obj,value)
            if value == uint16(value)
                obj.chan15_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan15_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan16_raw(obj,value)
            if value == uint16(value)
                obj.chan16_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan16_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan17_raw(obj,value)
            if value == uint16(value)
                obj.chan17_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan17_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan18_raw(obj,value)
            if value == uint16(value)
                obj.chan18_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chan18_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chancount(obj,value)
            if value == uint8(value)
                obj.chancount = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.chancount()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.rssi(obj,value)
            if value == uint8(value)
                obj.rssi = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | rc_channels.set.rssi()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end