function [outString,exitChar] = mavstring(inString,schema,startIndex,endIndex)
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

    %Handle varying numbers of arguments to allow for recursive functionality
    if nargin < 4
        endIndex = size(inString,2);
    end
    if nargin < 3
        startIndex = 1;
    end
    
    tags = sort([strfind(inString,'${') strfind(inString,'#{') strfind(inString,'?{') strfind(inString,'}#') ...
        strfind(inString,'}?') strfind(inString,'<?>')]);
    
    %Initialise the parser loop
    i = startIndex;
    
    %Parse until no more special tags are found
    for tagIndex=1:1:size(tags,2)
        
        if tags(tagIndex) >= i;
                
            outString = [outString inString(i:tags(tagIndex)-1)];
            
            switch(inString(tags(tagIndex):tags(tagIndex)+1))
                %Variable start tag
                case '${'
                    [returnedString,exitChar] = variable(inString(tags(tagIndex)+2:end),schema);
                    outString = [outString, returnedString];
                    i = tags(tagIndex) + exitChar + 1;
                %Repetition start tag
                case '#{'
                    [returnedString,exitChar] = repetition(inString(tags(tagIndex)+2:end),schema);
                    outString = [outString, returnedString];
                    i = tags(tagIndex) + exitChar + 1;
                %Conditional start tag
                case '?{'
                    [returnedString,exitChar] = conditional(inString(tags(tagIndex)+2:end),schema);
                    outString = [outString, returnedString];
                    i = tags(tagIndex) + exitChar + 1;
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
    outString = [outString inString(i:end)];
end

function [outString,exitChar] = variable(inString,schema)
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

