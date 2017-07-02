classdef msg_data_transmission_handshake < mavlink_message
    %MAVLINK Message Class
    %Name: data_transmission_handshake	ID: 130
    %Description: None
            
    properties(Constant)
        ID = 130
        LEN = 13
    end
    
    properties        
		size	%total data size in bytes (set on ACK only) (uint32[1])
		width	%Width of a matrix or image (uint16[1])
		height	%Height of a matrix or image (uint16[1])
		packets	%number of packets beeing sent (set on ACK only) (uint16[1])
		type	%type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h) (uint8[1])
		payload	%payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only) (uint8[1])
		jpg_quality	%JPEG quality out of [1,100] (uint8[1])
	end

    
    methods
        
        %Constructor: msg_data_transmission_handshake
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_data_transmission_handshake(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_data_transmission_handshake.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_data_transmission_handshake.ID;
                
			packet.payload.putUINT32(obj.size);

			packet.payload.putUINT16(obj.width);

			packet.payload.putUINT16(obj.height);

			packet.payload.putUINT16(obj.packets);

			packet.payload.putUINT8(obj.type);

			packet.payload.putUINT8(obj.payload);

			packet.payload.putUINT8(obj.jpg_quality);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.size = payload.getUINT32();

			obj.width = payload.getUINT16();

			obj.height = payload.getUINT16();

			obj.packets = payload.getUINT16();

			obj.type = payload.getUINT8();

			obj.payload = payload.getUINT8();

			obj.jpg_quality = payload.getUINT8();

		end
            
        function set.size(obj,value)
            if value == uint32(value)
                obj.size = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_transmission_handshake.set.size()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.width(obj,value)
            if value == uint16(value)
                obj.width = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_transmission_handshake.set.width()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.height(obj,value)
            if value == uint16(value)
                obj.height = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_transmission_handshake.set.height()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.packets(obj,value)
            if value == uint16(value)
                obj.packets = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_transmission_handshake.set.packets()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_transmission_handshake.set.type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.payload(obj,value)
            if value == uint8(value)
                obj.payload = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_transmission_handshake.set.payload()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.jpg_quality(obj,value)
            if value == uint8(value)
                obj.jpg_quality = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_transmission_handshake.set.jpg_quality()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end