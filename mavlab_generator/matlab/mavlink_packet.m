classdef mavlink_packet < handle
    %MAVLINK_PACKET Class
    %Used to encode and decode MAVLINK packets
    
    %Constant public variables
    properties(Constant)
        STX = 254;  %The 'magic' byte
    end
    
    %Private variables
    properties
        len;        %Length of the packet payload
        seq;        %Sequence number of the current packet
        sysid;      %ID of the sending system
        compid;     %ID of the sending component
        msgid;      %ID of the message type contained in the payload
        payload;    %The packet payload
        crc;        %The crc object for this packet
    end
    
    %Publically accessible object variables
    methods
        
        %Constructor: mavlink_packet
        %payloadLength should be an integer between 0 and MAX_PAYLOAD_SIZE
        function obj = mavlink_packet(payloadLength)
            obj.len = payloadLength;
            obj.payload = mavlink_payload(payloadLength);
        end
        
        %Generate the CRC checksum for the packet
        function generateCRC(obj)   
            if isempty(obj.crc)
                obj.crc = mavlink_crc();
            else
                obj.crc.start_checksum();
            end
            
            obj.crc.updateChecksum(uint8(obj.len));
            obj.crc.updateChecksum(uint8(obj.seq));
            obj.crc.updateChecksum(uint8(obj.sysid));
            obj.crc.updateChecksum(uint8(obj.compid));
            obj.crc.updateChecksum(uint8(obj.msgid));
            
            obj.payload.resetIndex();
            for i = 1:1:obj.payload.getLength()
                obj.crc.updateChecksum(obj.payload.getUINT8())
            end
            obj.crc.finishChecksum(uint8(obj.msgid))
        end
        
        %Encode the packet into a byte buffer for transmission
        function byteBuffer = encodePacket(obj)
            obj.generateCRC();
            byteBuffer = cat(1,uint8(obj.STX),uint8(obj.len),uint8(obj.seq),uint8(obj.sysid),...
                uint8(obj.compid),uint8(obj.msgid),obj.payload.getByteBuffer(),obj.crc.getLSB(), obj.crc.getLSB());
        end
        
        %Getter: isPayloadFull
        function fillStatus = isPayloadFull(obj)
            fillStatus = obj.payload.isPayloadFull();
        end     
   
    end
    
end

