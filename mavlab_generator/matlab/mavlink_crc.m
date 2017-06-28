classdef mavlink_crc < handle
    %CRC Class
    %Handles the crc x.25 checksum system used by MAVLINK
    
    properties(Constant)
        MAVLINK_MESSAGE_CRCS = uint8([50, 124, 137, 0, 237, 217, 104, 119, 0, 0, 0, 89, 0, 0, 0, 0, 0,...
            0, 0, 0, 214, 159, 220, 168, 24, 23, 170, 144, 67, 115, 39, 246, 185, 104, 237, 244,...
            222, 212, 9, 254, 230, 28, 28, 132, 221, 232, 11, 153, 41, 39, 78, 196, 0, 0, 15, 3,...
            0, 0, 0, 0, 0, 167, 183, 119, 191, 118, 148, 21, 0, 243, 124, 0, 0, 38, 20, 158, 152,...
            143, 0, 0, 0, 106, 49, 22, 143, 140, 5, 150, 0, 231, 183, 63, 54, 47, 0, 0, 0, 0, 0,...
            0, 175, 102, 158, 208, 56, 93, 138, 108, 32, 185, 84, 34, 174, 124, 237, 4, 76, 128,...
            56, 116, 134, 237, 203, 250, 87, 203, 220, 25, 226, 46, 29, 223, 85, 6, 229, 203, 1,...
            195, 109, 168, 181, 47, 72, 131, 127, 0, 103, 154, 178, 200, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 232, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 163, 105, 151, 35, 150, 0, 0, 0, 0, 0, 0,...
            90, 104, 85, 95, 130, 184, 81, 8, 204, 49, 170, 44, 83, 46, 0]);
        CRC_INIT_VALUE = uint16(hex2dec('ffff'));
    end
    
    properties
        crcValue;
    end
    
    methods
        
        %Constructor: mavlink_crc
        function obj = mavlink_crc()
            obj.startChecksum();
        end
        
        function updateChecksum(obj, char)
            if isa(char,'uint8')
                crcBytes = typecast(uint16(obj.crcValue),'uint8');
                temp = bitxor(char,crcBytes(1));
                temp = bitxor(temp,bitshift(temp,4));
                crcAccum = bitxor(uint16(crcBytes(2)),bitshift(uint16(temp),8));
                crcAccum = bitxor(crcAccum,bitshift(uint16(temp),3));
                crcAccum = bitxor(crcAccum,bitshift(uint16(temp),-4));
                obj.crcValue = crcAccum;
            else
                disp('ERROR(mavlink_crc.updateChecksum): Input "char" is not of type "uint8"');
            end
        end
        
        %Function: Initialises the checksum value
        function startChecksum(obj)
            obj.crcValue = obj.CRC_INIT_VALUE;
        end
        
        %Function: Hash the checksum with the mavlink message CRC
        function finishChecksum(obj, msgid)
           obj.updateChecksum(obj.MAVLINK_MESSAGE_CRCS(msgid + 1)) 
        end
        
        %Getter: MSB
        function msb = getMSB(obj)
            crcBytes = typecast(uint16(obj.crcValue),'uint8');
            msb = crcBytes(2);
        end
        
        %Getter: LSB
        function lsb = getLSB(obj)
            crcBytes = typecast(uint16(obj.crcValue),'uint8');
            lsb = crcBytes(1);
        end
        
    end
    
end

