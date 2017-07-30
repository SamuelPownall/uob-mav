classdef mavstruct
%MAVSTRUCT: The MAVLAB XML toolbox
%Description:
%    Reads XML files and parses the nodes into a structure. Includes convenience functions that
%    allow searching for fields of a specified name.
    
    properties
        name;           %Name of this node
        text;           %Text field of the node
        children;       %Array of child mavstructs
        attributes;             %Attributes of this node
        hasChildren = 0;        %Does the children field exist
        hasText = 0;            %Does the text field exist
        hasAttributes = 0;      %Does the attributes field exist
    end
    
    methods
        
        function obj = mavstruct(filename,name,text,children,attributes, hasText, hasChildren, hasAttributes)
        %MAVSTRUCT: Generates a searchable structure from XML
        %Description:
        %    The constructor for creating a new mavstruct object from an XML file.
        %Arguments:
        %    filename(string): Path to the XML file to be parsed
        %    name(string): Name of this mavstruct
        %    text(text): Text content of this mavstruct
        %    children(mavstruct): Array of child mavstructs
        %    attributes(struct): Array of attribute structs
            
            %If there is 1 input argument create a mavstruct from an XML file
            if nargin == 1
                
                %Display console message and start timer
                disp(['Parsing XML file: ' filename]);
                timer = tic();
                %Read the DOM tree for this XML file
                try
                   tree = xmlread(filename);
                catch
                   error('Failed to read XML file %s.',filename);
                end
                %Create a structure by parsing the DOM tree
                [children,~,~,~] = mavstruct.parseChildNodes(tree);
                obj = mavstruct([],'root','This is the root of the XML file',children,[],1,1,0);
                %Display time taken to parse
                disp(['Parsing completed in: ' num2str(toc(timer)) ' seconds']);
                
            %Otherwise if there are 8 arguments create a new mavstruct using fields
            elseif nargin == 8
                obj.name = name;
                obj.text = text;
                obj.children = children;
                obj.attributes = attributes;
                obj.hasText = hasText;
                obj.hasChildren = hasChildren;
                obj.hasAttributes = hasAttributes;
            end
            
        end
        
        function result = find(obj,query)
        %FIND: Finds the first child with the requested name
        %Description:
        %    Searches the current nodes children array and attempts to find the first child with the name
        %    requested.
        %Arguments:
        %    query(string): The name of the child being requested
            
            result = {};
            if ~isempty(obj.children)
                for i = 1:1:size(obj.children,2)
                    if strcmp(obj.children{i}.name,query)
                        result = obj.children{i};
                        break;
                    end
                end
            end
            
        end
        
        function result = findAll(obj,query)
        %FINDALL: Finds all children with the requested name
        %Description:
        %    Searches the current nodes children array and attemts to find all of the children with the name
        %    requested.
        %Arguments:
        %    query(string): The name of the children being requested
            
            result = {};
            if ~isempty(obj.children)
                for i = 1:1:size(obj.children,2)
                    if strcmp(obj.children{i}.name,query)
                        result = [result obj.children{i}];
                    end
                end
            end
            
        end
        
        function result = findAllUntil(obj,query,until)
            %FINDALLUNTIL: Finds all children with the requested name until a given other child is found
            %Description:
            %    Searches the current nodes children array and attemts to find all of the children with the name
            %    requested until a given field is found.
            %Arguments:
            %    query(string): The name of the children being requested
            %    until(string): The name of the cut-off child
            
            result = {};
            if ~isempty(obj.children)
                
                for i = 1:1:size(obj.children,2)
                    if strcmp(obj.children{i}.name,query)
                        result = [result obj.children{i}];
                    elseif strcmp(obj.children{i}.name,until)
                        break;
                    end
                end
                
            end
            
        end
        
    end
    
    methods(Static, Access = private)
        
        function [children, text,hasText,hasChildren] = parseChildNodes(theNode)
        %PARSECHILDNODES: Parses the children of the current node
        %Description:
        %    Recursively finds the children of each node in a DOM tree starting from the specified node.
        %Arguments:
        %    theNode(DOM): The XML tree obtained from xmlread() which needs to be parsed

            children = {};
            text = [];
            hasText = 0;
            hasChildren = 0;
            
            %If the current node has children process them and add to the child array
            if hasChildNodes(theNode)
                childNodes = getChildNodes(theNode);
                numChildNodes = getLength(childNodes);

                %Iterate and parse each child node
                count = 1; i = 1;
                while i <= numChildNodes
                    theChild = childNodes.item(i-1);
                    %If the child node name is '#text' and not whitespace, found text field of the parent node
                    newChild = mavstruct.makeStructFromNode(theChild);
                    if strcmp(newChild.name, '#text')
                        newText = strtrim(char(getTextContent(theChild)));
                        if newChild.hasChildren == 0 && ~strcmp(newText,'')
                            text = newText;
                            hasText = 1;
                        end 
                    %Otherwise, create a mavstruct from the child and add to the child array.
                    else
                        hasChildren = 1;
                        children{count} = newChild;
                        count = count + 1;
                    end
                    i = i + 1;
                end
            end
        end
        
        function newStruct = makeStructFromNode(theNode)
        %MAKESTRUCTFROMNODE: Generates a structure from the current node
        %Description:
        %    Reads all of the data from the current node and returns it as a new mavstruct
        %Arguments:
        %    theNode(DOM): The XML node to be parsed into a structure
            
            %Obtain children and attributes of this node
            [children, text, hasText, hasChildren] = mavstruct.parseChildNodes(theNode);
            [attributes, hasAttributes] = mavstruct.parseAttributes(theNode);
            %Set the name of this node
            name = char(getNodeName(theNode));
            
            newStruct = mavstruct([],name,text,children,attributes,hasText,hasChildren,hasAttributes);

        end

        function [attributes, hasAttribs] = parseAttributes(theNode)
        %PARSEATTRIBUTES: Creates a structure array from the attributes of the specified node
        %Description:
        %    Finds all of the attributes of the current node and stores each as a structure in an array.
        %Arguments:
        %    theNode(DOM): The XML node from which to extract attributes

            attribFields = {};
            attribValues = {};

            %If the node has attributes, add each to the attribute array
            if hasAttributes(theNode)
               hasAttribs = 1;
               theAttributes = getAttributes(theNode);
               numAttributes = getLength(theAttributes);

               %Aquire the name and value of the current attribute
               for i = 1:1:numAttributes
                   attrib = theAttributes.item(i-1);
                   attribFields = [attribFields {char(getName(attrib))}];
                   attribValues = [attribValues {char(getValue(attrib))}];
               end
            else
                hasAttribs = 0;
            end

            %Convert the attributes cell array to a struct array
            attributes = cell2struct(attribValues,attribFields,2);
        end
        
    end
    
end

