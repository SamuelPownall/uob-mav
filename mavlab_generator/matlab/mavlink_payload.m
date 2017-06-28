classdef mavlink_payload < handle
    %MAVLINK_PAYLOAD Class
    %Used to construct a message payload
    
    %Private constants for use by the class
    properties(Constant, Access = private)
        MIN_VALUE_UNSIGNED = 0;           %Minimum value of unsigned variables
        MAX_VALUE_UINT8 = 255;            %Maximum value of uint8
        MAX_VALUE_UINT16 = 65535;         %Maximum value of uint16
        MAX_VALUE_UINT32 = 4294967295;    %Maximum value of uint32
        MAX_PAYLOAD_SIZE = 255;           %Maximum length of payload in bytes
    end
    
    %Private variables
    properties(Access = private)
        index = 1;
        isFull = 0;
        byteBuffer;
        length;
    end
    
    %Private object methods
    methods(Access = private)
        
        %Function: Add byte to payload and increase index
        %byte must be of type uint8
        function add(obj, byte)
            %Check that the index is within bounds
            if obj.index <= obj.length
                %Check that byte is of type uint8
                if isa(byte,'uint8')
                    obj.byteBuffer(obj.index) = byte;
                    if obj.index == obj.length
                        obj.isFull = 1;
                        obj.setIndex(obj.length)
                    else
                        obj.incrementIndex(1);
                    end
                else
                    disp('ERROR(mavlink_payload.add): Input "byte" is not of type "uint8"')
                end
            else
                disp('ERROR(mavlink_payload.add): Current index is out of bounds')
            end
        end
        
    end
    
    %Public object methods
    methods
        
        %Constructor: mavlink_payload
        %bufferSize should be an integer between 0 and MAX_PAYLOAD_SIZE
        function obj = mavlink_payload(payloadLength)
            if payloadLength > obj.MAX_PAYLOAD_SIZE
                disp('ERROR(mavlink_payload): Specified payload size is greater than the maximum');
                obj.byteBuffer = zeros(obj.MAX_PAYLOAD_SIZE, 'uint8');
                obj.length = obj.MAX_PAYLOAD_SIZE;
            else
                obj.byteBuffer = zeros(payloadLength,1, 'uint8');
                obj.length = payloadLength;
            end
        end
        
        %Function: Reset the index to 0
        function resetIndex(obj)
            obj.index = 1;
        end
        
        %Function: Increment the index by incr
        function incrementIndex(obj, incr)
            obj.index = obj.index + incr;
        end
        
        %Getter: byteBuffer
        function byteBuffer = getByteBuffer(obj)
            byteBuffer = obj.byteBuffer;
        end
        
        %Getter: length
        function length = getLength(obj)
            length = obj.length;
        end
        
        %Getter: isPayloadFull
        function fillState = isPayloadFull(obj)
            fillState = obj.isFull;
        end
        
        %Getter: index
        function index = getIndex(obj)
            index = obj.index;
        end
        
        %Getter: Next byte as type int8
        function value = getINT8(obj)
            if obj.index <= obj.length
                value = typecast(obj.byteBuffer(obj.index),'int8');
                obj.incrementIndex(1);
            else
                disp('ERROR(mavlink_payload.getINT8): Current index will lead to overflow')
            end
        end
        
        %Getter: Next byte as type uint8
        function value = getUINT8(obj)
            if obj.index <= obj.length
                value = typecast(obj.byteBuffer(obj.index),'uint8');
                obj.incrementIndex(1);
            else
                disp('ERROR(mavlink_payload.getUINT8): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 2 bytes as type int16
        function value = getINT16(obj)
            if obj.index + 1 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+1),'int16');
                obj.incrementIndex(2);
            else
                disp('ERROR(mavlink_payload.getINT16): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 2 bytes as type uint16
        function value = getUINT16(obj)
            if obj.index + 1 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+1),'uint16');
                obj.incrementIndex(2);
            else
                disp('ERROR(mavlink_payload.getUINT16): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 4 bytes as type int32
        function value = getINT32(obj)
            if obj.index + 3 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+3),'int32');
                obj.incrementIndex(4);
            else
                disp('ERROR(mavlink_payload.getINT32): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 4 bytes as type uint32
        function value = getUINT32(obj)
            if obj.index + 3 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+3),'uint32');
                obj.incrementIndex(4);
            else
                disp('ERROR(mavlink_payload.getUINT32): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 8 bytes as type int64
        function value = getINT64(obj)
            if obj.index + 7 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+7),'int64');
                obj.incrementIndex(8);
            else
                disp('ERROR(mavlink_payload.getINT64): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 8 bytes as type uint64
        function value = getUINT64(obj)
            if obj.index + 7 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+7),'uint64');
                obj.incrementIndex(8);
            else
                disp('ERROR(mavlink_payload.getUINT64): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 4 bytes as type float
        function value = getFloat(obj)
            if obj.index + 3 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+3),'single');
                obj.incrementIndex(4);
            else
                disp('ERROR(mavlink_payload.getFloat): Current index will lead to overflow')
            end
        end
        
        %Getter: Next 8 bytes as type double
        function value = getDouble(obj)
            if obj.index + 7 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+7),'double');
                obj.incrementIndex(8);
            else
                disp('ERROR(mavlink_payload.getDouble): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a int8 in the next byte
        function putINT8(obj, value)
            if obj.index <= obj.length
                if isa(value,'int8')
                    obj.add(typecast(value,'uint8'));
                else
                    disp('ERROR(mavlink_payload.putINT8): Input "value" is not of type "int8"')
                end
            else
                disp('ERROR(mavlink_payload.putINT8): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a uint8 in the next byte
        function putUINT8(obj, value)
            if obj.index <= obj.length
                if isa(value,'uint8')
                    obj.add(value);
                else
                    disp('ERROR(mavlink_payload.putUINT8): Input "value" is not of type "uint8"')
                end
            else
                disp('ERROR(mavlink_payload.putUINT8): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a int16 in the next 2 bytes
        function putINT16(obj, value)
            if obj.index + 1 <= obj.length
                if isa(value,'int16')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                else
                    disp('ERROR(mavlink_payload.putINT16): Input "value" is not of type "int16"')
                end
            else
                disp('ERROR(mavlink_payload.putINT16): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a uint16 in the next 2 bytes
        function putUINT16(obj, value)
            if obj.index + 1 <= obj.length
                if isa(value,'uint16')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                else
                    disp('ERROR(mavlink_payload.putUINT16): Input "value" is not of type "uint16"')
                end
            else
                disp('ERROR(mavlink_payload.putUINT16): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a int32 in the next 4 bytes
        function putINT32(obj, value)
            if obj.index + 3 <= obj.length
                if isa(value,'int32')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                else
                    disp('ERROR(mavlink_payload.putINT32): Input "value" is not of type "int32"')
                end
            else
                disp('ERROR(mavlink_payload.putINT32): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a uint32 in the next 4 bytes
        function putUINT32(obj, value)
            if obj.index + 3 <= obj.length
                if isa(value,'uint32')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                else
                    disp('ERROR(mavlink_payload.putUINT32): Input "value" is not of type "uint32"')
                end
            else
                disp('ERROR(mavlink_payload.putUINT32): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a int64 in the next 8 bytes
        function putINT64(obj, value)
            if obj.index + 7 <= obj.length
                if isa(value,'int64')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                    obj.add(data(5));
                    obj.add(data(6));
                    obj.add(data(7));
                    obj.add(data(8));
                else
                    disp('ERROR(mavlink_payload.putINT64): Input "value" is not of type "int64"')
                end
            else
                disp('ERROR(mavlink_payload.putINT64): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a uint64 in the next 8 bytes
        function putUINT64(obj, value)
            if obj.index + 7 <= obj.length
                if isa(value,'uint64')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                    obj.add(data(5));
                    obj.add(data(6));
                    obj.add(data(7));
                    obj.add(data(8));
                else
                    disp('ERROR(mavlink_payload.putUINT64): Input "value" is not of type "uint64"')
                end
            else
                disp('ERROR(mavlink_payload.putUINT64): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a float in the next 4 bytes
        function putFloat(obj, value)
            if obj.index + 3 <= obj.length
                if isa(value,'single')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                else
                    disp('ERROR(mavlink_payload.putFloat): Input "value" is not of type "float"')
                end
            else
                disp('ERROR(mavlink_payload.putFloat): Current index will lead to overflow')
            end
        end
        
        %Putter: Place a double in the next 8 bytes
        function putDouble(obj, value)
            if obj.index + 7 <= obj.length
                if isa(value,'double')
                    data = typecast(value, 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                    obj.add(data(5));
                    obj.add(data(6));
                    obj.add(data(7));
                    obj.add(data(8));
                else
                    disp('ERROR(mavlink_payload.putDouble): Input "value" is not of type "double"')
                end
            else
                disp('ERROR(mavlink_payload.putDouble): Current index will lead to overflow')
            end
        end
        
        %Setter: index
        function setIndex(obj, index)
            if index >= 1 && index <= obj.length
                obj.index = index;
            else
                disp('ERROR(mavlink_payload.setIndex): Specified index is out of bounds')
            end
        end
        
    end
    
end

