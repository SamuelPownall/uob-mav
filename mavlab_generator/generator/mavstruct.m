classdef mavstruct
    %MAVSTRUCT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name;
        text;
        children;
        attributes;
        hasChildren = 0;
        hasText = 0;
        hasAttributes = 0;
    end
    
    methods
        
        function obj = mavstruct(filename)
            
            if nargin == 1
                try
                   tree = xmlread(filename);
                catch
                   error('Failed to read XML file %s.',filename);
                end

                [root,~] = mavstruct.parseChildNodes(tree);
                obj = root{1};
            end
            
        end
        
        function result = find(obj,query)
            
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
        
        function [children, text] = parseChildNodes(theNode)

            children = {};
            text = [];
            if theNode.hasChildNodes
               childNodes = theNode.getChildNodes;
               numChildNodes = childNodes.getLength;

                count = 1; i = 1;
                while i <= numChildNodes
                    theChild = childNodes.item(i-1);
                    if strcmp(theChild.getNodeName,'#text')
                        if any(strcmp(methods(theChild), 'getData')) && ~strcmp(strtrim(char(theChild.getData)),'')
                            text = char(theChild.getData);
                        end
                    else
                        children{count} = mavstruct.makeStructFromNode(theChild);
                        count = count + 1;
                    end
                    i = i + 1;
                end
            end
        end
        
        function newStruct = makeStructFromNode(theNode)
            
            [children, text] = mavstruct.parseChildNodes(theNode);
            attributes = mavstruct.parseAttributes(theNode);
            
            newStruct = mavstruct();
            newStruct.name = char(theNode.getNodeName);
            
            if ~isempty(text)
                newStruct.text = text;
                newStruct.hasText = 1;
            end

            if ~isempty(children)
                newStruct.children = children;
                newStruct.hasChildren = 1;
            end
            
            if ~isempty(attributes)
                newStruct.attributes = attributes;
                newStruct.hasAttributes = 1;
            end

        end

        function attributes = parseAttributes(theNode)

            attribFields = {};
            attribValues = {};

            if theNode.hasAttributes
               theAttributes = theNode.getAttributes;
               numAttributes = theAttributes.getLength;

               for i = 1:1:numAttributes
                   attrib = theAttributes.item(i-1);
                   attribFields = [attribFields {char(attrib.getName)}];
                   attribValues = [attribValues {char(attrib.getValue)}];
               end

            end

            attributes = cell2struct(attribValues,attribFields,2);
        end
        
    end
    
end

