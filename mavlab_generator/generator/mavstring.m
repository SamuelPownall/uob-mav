function [outString,exitChar] = mavstring(inString,schema)
%MAVSTRING: The MAVLAB templating engine
%Description:
%    Parses a string and injects data from a schema into it using a simple templating system. Error
%    checking is minimal so use with caution.
%Arguments:
%    inString: The string to be used as the template
%    schema: The structure from which data will be injected into the template
%    startIndex: Index at which to start parsing the template string
%    endIndex: Index at which to stop parsing the template string
%Usage:
%    Variable: ${var}$
%    Repetition: #{array<#>text}#
%    Conditional: ?{condition<?>expression1<?>expression2}?

    %Initialise some variables
    varName = []; condition = []; outString = []; exitChar = 0;
    conditionStart = 0;
    
    %Find all tags in the file and sort them in character index order
    tags = sort([strfind(inString,'${') strfind(inString,'#{') strfind(inString,'?{') strfind(inString,'}#') ...
        strfind(inString,'}?') strfind(inString,'<?>')]);
    
    %Initialise the parser loop
    stringIndex = 1;
    
    %Parse until no more special tags are found
    for tagIndex=1:1:size(tags,2)
        %Ignore any tags that occur before the current string index
        if tags(tagIndex) >= stringIndex;
            %Add text between the current string index and next tag to the output string
            outString = [outString inString(stringIndex:tags(tagIndex)-1)];
            %Determine the tag type and handle appropriately
            switch(inString(tags(tagIndex):tags(tagIndex)+1))
                %Variable start tag
                case '${'
                    [returnedString,exitChar] = variable(inString(tags(tagIndex)+2:end),schema);
                    outString = [outString, returnedString];
                    stringIndex = tags(tagIndex) + exitChar + 1;
                %Repetition start tag
                case '#{'
                    [returnedString,exitChar] = repetition(inString(tags(tagIndex)+2:end),schema);
                    outString = [outString, returnedString];
                    stringIndex = tags(tagIndex) + exitChar + 1;
                %Conditional start tag
                case '?{'
                    [returnedString,exitChar] = conditional(inString(tags(tagIndex)+2:end),schema);
                    outString = [outString, returnedString];
                    stringIndex = tags(tagIndex) + exitChar + 1;
                %Repetition end tag
                case '}#'
                    exitChar = tags(tagIndex) + 1;
                    return;
                %Conditional end tag
                case '}?'
                    exitChar = tags(tagIndex) + 1;
                    return;
                %Handles the 3 character conditional delimiter
                otherwise
                    exitChar = tags(tagIndex) + 2;
                    return;
            end
            
        end
        
    end
    %Add remaining text after the last found tag to the output string
    outString = [outString inString(stringIndex:end)];
end

function [outString,exitChar] = variable(inString,schema)
%VARIABLE: Handles replacement of ${var}$ tags
%Description:
%    Replaces a variable tag with data found in the supplied schema. Throws an error if the input
%    string is not formatted correctly.
%Arguments:
%    inString(string): String to be parsed for a variable name
%    schema(struct): Source of the data used to replace the ${var}$ tag
    outString = [];
    tagStart = strfind(inString,'}$');
    varName = inString(1:tagStart(1)-1);
    exitChar = tagStart(1)+2;
    if ~isfield(schema,varName)
        disp('ERROR: Field does not exist!');
    elseif isnumeric(schema.(varName))
        outString = num2str(schema.(varName));
    else
        outString = schema.(varName);
    end
end

function [outString,exitChar] = repetition(inString,schema)
%VARIABLE: Handles replacement of #{array<#>text}# tags
%Description:
%    Replaces a repetition tag with data found in the supplied schema. Throws an error if the input
%    string is not formatted correctly. Supports nesting.
%Arguments:
%    inString(string): String to be parsed for an array name and replacement text
%    schema(struct): Source of the array data
    outString = [];
    tagStart = strfind(inString,'<#>');
    varName = inString(1:tagStart(1)-1);
    if ~isfield(schema,varName)
        disp('ERROR: Field does not exist!');
        outString = [];
        exitChar = [];
        return;
    else
        newSchema = schema.(varName);
        for j=1:1:size(newSchema,2)
            [returnedString,exitChar] = mavstring(inString(tagStart(1)+3:end),newSchema(j));
            outString = [outString returnedString];
            exitChar = exitChar + tagStart(1) + 3;
        end
    end
end

function [outString,exitChar] = conditional(inString,schema)
%VARIABLE: Handles replacement of ?{condition<?>expression1<?>expression2}? tags
%Description:
%    Replaces a conditional tag with data found in the supplied schema. Throws an error if the input
%    string is not formatted correctly. Does not support nesting.
%Arguments:
%    inString(string): String to be parsed for a condition and expressions
%    schema(struct): Source of the data used by any nested tags
    outString = []; evaluation = -1;
    tagStart = strfind(inString,'<?>');
    [condition,~] = mavstring(inString(1:tagStart(1)-1),schema);
    try
        eval(sprintf('if %s,evaluation=1;,else,evaluation=0;,end',condition));
    catch
        disp('ERROR: Condition is not valid!');
    end
    if evaluation == 1
        [outString,~] = mavstring(inString(tagStart(1)+3:end),schema);
    elseif evaluation == 0
        [outString,~] = mavstring(inString(tagStart(2)+3:end),schema);
    end
    tagStart = strfind(inString,'}?');
    exitChar = tagStart(1) + 2;
end

