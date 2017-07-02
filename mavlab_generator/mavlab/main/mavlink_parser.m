classdef mavlink_parser < handle
    %MAVLINK_PARSER Class
    %Parses streams of chars for MAVLINK messages
    
    %Private constant properties
    properties(Constant, Access = private)
        STATE_UNINIT = 0;
        STATE_IDLE = 1;
        STATE_GOT_STX = 2;
        STATE_GOT_LEN = 3;
        STATE_GOT_SEQ = 4;
        STATE_GOT_SYSID = 5;
        STATE_GOT_COMPID = 6;
        STATE_GOT_MSGID = 7;
        STATE_GOT_PAYLOAD = 8;
        STATE_GOT_CRC1 = 9;
    end
    
    %Private properties
    properties(Access = private)
        msg_received;
        packet;
        state;
    end
    
    %Public object methods
    methods
        
        %Constructor: mavlink_parser
        function obj = mavlink_parser()
            obj.state = obj.STATE_UNINIT;
        end
        
        %Function: Parse the next char and add to packet
        %char must be of type uint8
        function packet = parseChar(obj,char)
            
            %Check that the input if of type uint8
            if isa(char,'uint8')
                obj.msg_received = 0;
                switch (obj.state)

                    %Wait until the start byte is received
                    case {obj.STATE_UNINIT, obj.STATE_IDLE}
                        if char == mavlink_packet.STX
                            obj.state = obj.STATE_GOT_STX;
                        end

                    %Get the payload length
                    case obj.STATE_GOT_STX
                        obj.packet = mavlink_packet(char);
                        obj.state = obj.STATE_GOT_LEN;

                    %Get the packet sequence
                    case obj.STATE_GOT_LEN
                        obj.packet.seq = char;
                        obj.state = obj.STATE_GOT_SEQ;

                    %Get the sending system ID
                    case obj.STATE_GOT_SEQ
                        obj.packet.sysid = char;
                        obj.state = obj.STATE_GOT_SYSID;

                    %Get the sending component ID
                    case obj.STATE_GOT_SYSID
                        obj.packet.compid = char;
                        obj.state = obj.STATE_GOT_COMPID;

                    %Get the message ID 
                    case obj.STATE_GOT_COMPID
                        obj.packet.msgid = char;
                        if obj.packet.msgid == 0
                            obj.state = obj.STATE_GOT_PAYLOAD;
                        else
                            obj.state = obj.STATE_GOT_MSGID;
                        end

                    %Get the payload bytes 
                    case obj.STATE_GOT_MSGID
                        obj.packet.payload.putUINT8(char);
                        if obj.packet.isPayloadFull()
                            obj.state = obj.STATE_GOT_PAYLOAD;
                        end

                    %Get and check the first CRC checksum byte
                    case obj.STATE_GOT_PAYLOAD
                        obj.packet.generateCRC();
                        if char ~= obj.packet.crc.getLSB()
                            obj.state = obj.STATE_IDLE;
                            if char == mavlink_packet.STX
                                obj.state = obj.STATE_GOT_STX;
                            end
                        else
                            obj.state = obj.STATE_GOT_CRC1;
                        end

                    %Get and check the second CRC checksum byte
                    case obj.STATE_GOT_CRC1
                        if char ~= obj.packet.crc.getMSB()
                            obj.state = obj.STATE_IDLE;
                            if char == mavlink_packet.STX
                                obj.state = obj.STATE_GOT_STX;
                            end
                        else
                            obj.msg_received = true;
                            obj.state = obj.STATE_IDLE;
                        end
                end

                %If the packet is complete return it
                if obj.msg_received
                    packet = obj.packet;
                else
                    packet = [];
                end
                
            else
                fprintf(2,'MAVLAB-ERROR | mavlink_parser.parse_char()\n\t Input "char" is not of type "uint8"\n');
                packet = [];
            end
        end
    end
end

