classdef mavlab
%MAVLAB: MATLAB implementation of the MAVLINK 1.0 message marshalling library
%Description:
%    This library is used for communicating between MATLAB and a MAVLINK enabled autopilot. It
%    allows for the use of MATLAB functions and Simulink in MAV applications. 
    
    methods(Static, Access=public)
        
        function generate(xmlPath, outputPath)
        %GENERATE: Generates a MATLAB implementation of the MAVLINK 1.0 library
        %Description:
        %    Generates a MATLAB implemenation of the MAVLINK 1.0 library from a set of XML dialect
        %    files. The MAVLAB library allows communication between MATLAB and MAVLINK enabled
        %    autopilots.
        %Arguments:
        %    xmlPath(string): Path to the folder containing XML dialect files
        %    outputPath(string): Path to where the mavlab folder will be generated (default = '.')

            %Start timer
            timer = tic();
        
            %Handle varying numbers of input arguments
            if nargin == 1
                outputPath = '.';
            elseif nargin > 2
                disp('ERROR: Too many input arguments!');
                return;
            elseif nargin == 0
                disp('ERROR: Path to XML files must be specified!');
                return;
            end

            fullParsedMsgList = [];

            %Create the folder system at the output path
            mavlabPath = [outputPath '/mavlab'];
            if ~exist(mavlabPath,'dir')
                mkdir(mavlabPath);
            end

            mainPath = [mavlabPath '/main'];
            if ~exist(mainPath,'dir')
                mkdir(mainPath);
            end

            %Find all XML files within the specified folder
            xmlList = dir([xmlPath '/*.xml']);

            %Perform the following actions for each dialect
            for i = 1:1:size(xmlList)
                fullname = [xmlPath '/' xmlList(i).name];
                f = fopen(fullname,'r');

                %Load the MAVLINK message definition XML document as a mavstruct
                root = mavstruct(fullname);
                xmlName = strrep(xmlList(i).name, '.xml', '');

                %Create a folder for this dialect
                messagePath = [mavlabPath '/' xmlName];
                if ~exist(messagePath,'dir')
                    mkdir(messagePath);
                end

                %Find the message definitions and generate a MATLINK class for each
                msgList = root.find('mavlink').find('messages').findAll('message');
                parsedMsgList = mavlab.generateMessageClasses(messagePath, msgList);

                %Generate the enumeration class for this dialect
                enumList = root.find('mavlink').find('enums').findAll('enum');
                mavlab.generateEnumClass(messagePath, xmlName, enumList);

                %Combine message lists from each dialect
                fullParsedMsgList = [fullParsedMsgList parsedMsgList];

                fclose(f);
            end

            %Reformat the parsed message list to support the template engine
            parsedMsgList = struct('message',fullParsedMsgList);
            %Generate the MAVLINK packet class
            mavlab.generatePacketClass(mainPath, parsedMsgList);
            %Generate the MAVLINK CRC class
            mavlab.generateCRCClass(mainPath, parsedMsgList);
            %Copy fixed classes into the main folder
            mavlab.copyFixedClasses(mainPath);
            
            disp(['MAVLAB Implementation generated successfully! (' num2str(toc(timer)) ' seconds)']);

        end
        
    end
    
    methods(Static,Access=private)
        
        function parsedMsgList = generateMessageClasses(msgPath, msgList)
            %GENERATEMESSAGECLASSES: Generates a MAVLINK message class per message in msgList
            %Description:
            %    Generates a class file per message in msgList in the folder specified by messagePath.
            %Arguments:
            %    msgPath(string): Path to the folder where message files will be generated
            %    msgList(mavstruct): Array of messages to generate classes from


            %Create an empty cell array for parsed messages
            parsedMsgList = [];

            %Load the template for MAVLINK message classes
            templateFile = fopen('message_template.txt','r');
            template = char(fread(templateFile,[1 inf]));
            fclose(templateFile);

            %Generate a MAVLINK class file for each message in the XML file
            for i = 1:1:size(msgList,2)
                parsedMsg = mavlab.generateClassFromMsg(msgPath, msgList(i), template);
                parsedMsgList = cat(2,parsedMsgList,parsedMsg);
            end

        end
        
        function parsedMsg = generateClassFromMsg(msgPath, msg, template)
            %GENERATECLASSFROMMSG: Generates a MAVLINK message class
            %Description:
            %    Generates a class file by injecting the data stored in msg into a template.
            %Arguments:
            %    msgPath(string): Path to the folder where the message file will be generated
            %    msg(mavstruct): Message to generate the class file from
            %    template(string): Template used with mavstring to produce a message class

            parsedMsg = [];

            %Look-up structure of data sizes
            typeSize = struct('double',8,'int64_t',8,'uint64_t',8,'int32_t',4,...
                'uint32_t',4,'float',4,'int16_t',2,'uint16_t',2,'char',1,'int8_t',1,'uint8_t',1);

            %Get top level message attributes
            parsedMsg.msgid = msg.attributes.id;
            parsedMsg.name = lower(msg.attributes.name);
            parsedMsg.nameUpper = upper(parsedMsg.name);

            %Get description if available, otherwise set to 'No description available'
            if ~isempty(msg.find('description'))
                parsedMsg.desc = strrep(msg.find('description').text,'\n','');
            else
                parsedMsg.desc = 'No description available';
            end

            %Find all fields until the extension tag
            fields = msg.findAllUntil('field','extensions');
            %Define struct for parsed fields
            parsedFields = struct('type',{},'name',{},'desc',{},'size',{});

            %Parse all fields in the message and add to parsedFields
            parsedMsg.msglen = 0;
            for i=1:1:size(fields,2)

                %Get name of field
                fieldName = fields(i).attributes.name;

                %Get description if available, otherwise set to 'No description available'
                if fields(i).hasText
                    fieldDesc = fields(i).text;
                else
                    fieldDesc = 'No description available';
                end

                %Get the array size of the field
                fieldType = strsplit(fields(i).attributes.type,'[');
                if size(fieldType,2) > 1
                    arraySize = strsplit(fieldType{2},']');
                    arraySize = int8(str2double(arraySize{1}));
                else
                    arraySize = 1;
                end

                %Handle special mavlink_version case
                fieldType = strrep(fieldType{1},'_mavlink_version','');
                %Add this field to parsedFields
                parsedFields(i) = struct('type',fieldType,'name',fieldName,'desc',fieldDesc,'size',arraySize);
                parsedMsg.msglen = parsedMsg.msglen + typeSize.(fieldType)*arraySize;

            end

            %Sort the fields of this message into data type order and store the name of the first
            parsedMsg.orderedFields = mavlab.fieldSort(parsedFields, typeSize);
            parsedMsg.firstFieldName = parsedMsg.orderedFields(1).name;
            %Find the number of fields in this message
            parsedMsg.numFields = size(parsedMsg.orderedFields,2);

            %Calculate the checksum for this message
            crc = uint16(hex2dec('ffff'));
            crc = mavlab.accumulate(crc,[upper(parsedMsg.name) ' ']);
            for i = 1:1:size(parsedMsg.orderedFields,2)
                crc = mavlab.accumulate(crc,[parsedMsg.orderedFields(i).type ' ']);
                crc = mavlab.accumulate(crc,[parsedMsg.orderedFields(i).name ' ']);
                if parsedMsg.orderedFields(i).size > 1
                    crc = mavlab.accumulate(crc,char(parsedMsg.orderedFields(i).size));
                end
            end
            bytes = typecast(crc,'uint8');
            parsedMsg.crc = bitxor(bytes(1),bytes(2));

            %Re-format field types to conform to MATLAB standards
            for i = 1:1:size(parsedMsg.orderedFields,2)
                %Remove trailing '_t' from the field type
                newType = strsplit(parsedMsg.orderedFields(i).type,'_');
                %Replace 'char' type with 'uint8'
                if strcmp(newType,'char')
                    parsedMsg.orderedFields(i).type = 'uint8';
                %replace 'float' type with 'single'
                elseif strcmp(newType,'float')
                    parsedMsg.orderedFields(i).type = 'single';
                else
                    parsedMsg.orderedFields(i).type = newType{1};
                end
                %Add uppercase form of type to message structure
                parsedMsg.orderedFields(i).typeUpper = upper(parsedMsg.orderedFields(i).type);
            end

            %Write the class file for this MAVLINK message
            messageFilename = [msgPath '/msg_' parsedMsg.name '.m'];
            disp(['Generating: ' messageFilename]);
            messageFile = fopen(messageFilename,'w');
            fprintf(messageFile,mavstring(template,parsedMsg));
            fclose(messageFile); 

        end
        
        function generateEnumClass(msgPath, xmlName, enumList)
            %GENERATEENUMCLASS: Generates a MAVLINK enum class
            %Description:
            %    Generates a class file by injecting the data stored in enumList into a template.
            %Arguments:
            %    msgPath(string): Path to the folder where the enum file will be generated
            %    xmlName(string): Name of the source XML dialect for this enum list 
            %    enumList(mavstruct): List of enums to generate the enum class from

            %Load the template for MAVLINK enum classes
            templateFile = fopen('enum_template.txt','r');
            template = char(fread(templateFile,[1 inf]));
            fclose(templateFile);

            %Define the struct for parsed enums
            parsedEnumList = struct('xmlName',xmlName,'xmlNameUpper',upper(xmlName),'enum', struct('name',{}...
                ,'value',{},'desc',{}));

            %Parse all enums and add to parsedEnumList
            for i=1:1:size(enumList,2)
                %Find all entries in the current enum
                entryList = enumList(i).findAll('entry');
                value = 0;
                %Add each entry as an independent enum to parsedEnumList
                for j=1:1:size(entryList,2)
                    %Get the name of this enum
                    entry.name = entryList(j).attributes.name;
                    %Get the enum value if available, otherwise use incrementing values from 0
                    if isfield(entryList(j).attributes,'value')
                        entry.value = entryList(j).attributes.value;
                    else
                        entry.value = value;
                        value = value + 1;
                    end
                    %Get description if available, otherwise set to 'No description available'
                    if ~isempty(entryList(j).find('description'))
                        entry.desc = entryList(j).find('description').text;
                    else
                        entry.desc = 'No description available';
                    end
                    %Add this enum to parsedEnumList
                    parsedEnumList.enum(end+1) = entry;
                end
            end

            %Write the enum class file
            enumFilename = [msgPath '/' xmlName '.m'];
            disp(['Generating: ' enumFilename]);
            enumFile = fopen(enumFilename,'w');
            fprintf(enumFile,mavstring(template,parsedEnumList));
            fclose(enumFile); 

        end
        
        function generatePacketClass(mainPath, parsedMsgList)
            %GENERATEPACKETCLASS: Generates the MAVLINK packet class
            %Description: 
            %    Uses a list of parsed messages and a template to generate the complete packet class for this
            %    MAVLINK implementation.
            %Arguments:
            %    mainPath(string): Path to the folder where the packet class will be generated
            %    parsedMsgList(struct): List of message structures compatible with the class template

            %Load the template for the MAVLINK packet class
            templateFile = fopen('mavlink_packet_template.txt','r');
            template = char(fread(templateFile,[1 inf]));
            fclose(templateFile);

            %Write the MAVLINK packet class file
            mavlinkPacketFilename = [mainPath '/mavlink_packet.m'];
            disp(['Generating: ' mavlinkPacketFilename]);
            mavlinkPacketFile = fopen(mavlinkPacketFilename,'w');
            fprintf(mavlinkPacketFile,mavstring(template,parsedMsgList));
            fclose(mavlinkPacketFile); 

        end
        
        function generateCRCClass(mainPath, parsedMsgList)
            %GENERATECRCCLASS: Generates the MAVLINK CRC class
            %Description: 
            %    Uses a list of parsed messages and a template to generate the complete CRC class for this
            %    MAVLINK implementation.
            %Arguments:
            %    mainPath(string): Path to the folder where the CRC class will be generated
            %    parsedMsgList(struct): List of message structures compatible with the class template

            %Load the template for the MAVLINK CRC class
            templateFile = fopen('mavlink_crc_template.txt','r');
            template = char(fread(templateFile,[1 inf]));
            fclose(templateFile);

            %Define the struct for CRCs
            crcList = struct('crc',struct('value',{}));

            %Initialise all CRCs to 0
            for i=1:1:255
                crcList.crc(i).value = 0;
            end

            %Place the CRC for each message into crcList in the correct position
            for i=1:1:size(parsedMsgList.message,2)
                crc.value = parsedMsgList.message(i).crc;
                msgid = int64(str2double(parsedMsgList.message(i).msgid));
                if msgid <= 255
                    crcList.crc(msgid+1) = crc;
                end
            end

            %Write the MAVLINK CRC class file
            mavlinkCRCFilename = [mainPath '/mavlink_crc.m'];
            disp(['Generating: ' mavlinkCRCFilename]);
            mavlinkCRCFile = fopen(mavlinkCRCFilename,'w');
            fprintf(mavlinkCRCFile,mavstring(template,crcList));
            fclose(mavlinkCRCFile);

        end
        
        function copyFixedClasses(mainPath)
            %COPYFIXEDCLASSES: Copy master files into the MAVLAB implementation
            %Description: 
            %    Copies one of each master file into the MAVLAB implementation. These files do not need to be
            %    generated and are the same for any set of XML files.
            %Arguments:
            %    mainPath(string): Path to the folder that the master classes will be copied to

            copyfile('master/mavlink_handle_master.m',[mainPath '/mavlink_handle.m']);
            copyfile('master/mavlink_message_master.m',[mainPath '/mavlink_message.m']);
            copyfile('master/mavlink_payload_master.m',[mainPath '/mavlink_payload.m']);
            copyfile('master/mavlink_parser_master.m',[mainPath '/mavlink_parser.m']);
            copyfile('master/mavlink_stats_master.m',[mainPath '/mavlink_stats.m']);
            copyfile('master/mavlink_master.m',[mainPath '/mavlink.m']);

        end
        
        function orderedFields = fieldSort(parsedFields, typeSize)
            %FIELDSORT: Sorts a list of fields by type
            %Description:
            %    Uses the type of each field to sort in descending order of data size.
            %Arguments:
            %    parsedFields(struct): Array of parsed fields to be sorted
            %    typeSize(struct): Structure used to map between type name and data size.

            mat = zeros(1,size(parsedFields,2));

            %Get the data size of each field using type
            for i = 1:1:size(parsedFields,2)
                mat(i) = typeSize.(parsedFields(i).type);
            end

            %Sort the fields
            [~,ix] = sort(mat,'descend');
            orderedFields = parsedFields(ix);

        end
        
        function crcOut = accumulate(crcIn, buf)
            %ACCUMULATE: Accumulate a buffer of bytes into a checksum
            %Description:
            %    Accumulates each byte in buf into crcIn using the X.25 checksum standard.
            %Arguments:
            %    crcIn(uint16): The checksum to be updated using buf
            %    buf(char): Array of bytes to accumulate into the checksum

            crc = crcIn;
            %Loop through each char in buf and add to the checksum
            for i = 1:1:size(buf,2)
                char = buf(i);
                %Check that the input is a char
                if char == uint8(char)
                    %Accumulate the char into the checksum
                    char = uint8(char);
                    crcBytes = typecast(uint16(crc),'uint8');
                    temp = bitxor(char,crcBytes(1));
                    temp = bitxor(temp,bitshift(temp,4));
                    crcAccum = bitxor(uint16(crcBytes(2)),bitshift(uint16(temp),8));
                    crcAccum = bitxor(crcAccum,bitshift(uint16(temp),3));
                    crcAccum = bitxor(crcAccum,bitshift(uint16(temp),-4));
                    crc = crcAccum;   
                end
            end
            %Return the modified CRC
            crcOut = crc;

        end

    end
    
end

