function theStruct = xml2struct(filename)
    % PARSEXML Convert XML file to a MATLAB structure.
    try
       tree = xmlread(filename);
    catch
       error('Failed to read XML file %s.',filename);
    end

    % Recurse over child nodes. This could run into problems 
    % with very deeply nested trees.

    [theStruct, text] = parseChildNodes(tree);
end


% ----- Local function PARSECHILDNODES -----
function [children, text] = parseChildNodes(theNode)
    % Recurse over node children.
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
                [structFields, structValues] = makeStructFromNode(theChild);
                children{count} = cell2struct(structValues,structFields,2);
                count = count + 1;
            end
            i = i + 1;
        end
    end
end

% ----- Local function MAKESTRUCTFROMNODE -----
function [structFields, structValues] = makeStructFromNode(theNode)
    % Create structure of node info.

    structFields = {'name'};
    structValues = {char(theNode.getNodeName)};
    [children, text] = parseChildNodes(theNode);
    attributes = parseAttributes(theNode);

    if ~isempty(text)
        structFields = [structFields {'Text','hasText'}];
        structValues = [structValues {text,1}];
    else
        structFields = [structFields {'hasText'}];
        structValues = [structValues {0}];
    end

    if ~isempty(children)
        structFields = [structFields {'children','numChildren'}];
        structValues = [structValues {children,size(children,2)}];
    else
        structFields = [structFields {'numChildren'}];
        structValues = [structValues {0}];
    end

    if ~isempty(attributes)
        structFields = [structFields {'attributes','hasAttributes'}];
        structValues = [structValues {attributes,1}];
    else
        structFields = [structFields {'hasAttributes'}];
        structValues = [structValues {0}];
    end
end


% ----- Local function PARSEATTRIBUTES -----
function attributes = parseAttributes(theNode)
    % Create attributes structure.
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