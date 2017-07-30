function [outString, exitChar] = mavstring(inString,schema,startIndex,endIndex)
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

    %States used by the parsing engine
    SEARCHING = 0; VARIABLE = 1; REPETITION = 2; CONDITIONAL = 3;
    CONDITIONTRUE = 4; CONDITIONFALSE = 5;

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
    
    %Initialise the parser loop
    i = startIndex;
    state = SEARCHING;
    %Pad the input string so that certain operations will not go out of bounds
    inString = [inString '    '];
    
    %Parse until the end index is reached or there is a break condition
    while i <= endIndex
        
        %Update the exit character index
        exitChar = i;
        %Read a new character from the string
        c = inString(i);
        
        switch(state)
            
            %Adds each new character to the output string unless a template tag is found
            case SEARCHING     
                      
                %If the conditional delimiter is found update the exit character index and break
                if strcmp(inString(i:i+2),'<?>')
                    exitChar = exitChar + 2;
                    break;
                end     
                
                %Update the state of the parser if a template tag is found
                switch(inString(i:i+1))
                    %Variable start tag
                    case '${'
                        varName = [];
                        i=i+1;
                        state = VARIABLE;
                    %Repetition start tag
                    case '#{'
                        varName = [];
                        i=i+1;
                        state = REPETITION;
                    %Conditional start tag
                    case '?{'
                        condition = [];
                        conditionStart = i+2;
                        i=i+1;
                        state = CONDITIONAL;
                    %Repetition end tag
                    case '}#'
                        exitChar = exitChar + 1;
                        break;
                    %Conditional end tag
                    case '}?'
                        exitChar = exitChar + 1;
                        break;
                    %Otherwise add character to output string
                    otherwise
                        outString = [outString c];
                end
                
            %Replaces the variable tag with the associated field data in the schema
            case VARIABLE
                
                %If the variable end tag is found handle data injection
                if strcmp(inString(i:i+1),'}$')
                    
                    %If no associated field exists display an error and break
                    if ~isfield(schema,varName)
                        disp('ERROR: Field does not exist!');
                        break;
                    %otherwise inject the data into the output string
                    elseif isnumeric(schema.(varName))
                        outString = [outString num2str(schema.(varName))];
                    else
                        outString = [outString schema.(varName)];
                    end
                    
                    %Update the state of the parser
                    i=i+1;
                    state = SEARCHING;
                
                %otherwise if the character is alphanumeric update the variable name
                elseif isstrprop(c,'alphanum')
                    varName = [varName c];
                %otherwise display an error and break
                else
                    disp('ERROR: VARIABLE NAME CONTAINS SPECIAL CHAR');
                    break;
                end
                
            %Adds text to the output string for each element in an array
            case REPETITION
                
                %If the repetition delimiter is found handle data injection
                if strcmp(inString(i:i+2),'<#>')
                    
                    %If no associated field exists display an error and break
                    if ~isfield(schema,varName)
                        disp('ERROR: Field does not exist!');
                        break;
                    %Otherwise process the repetition text and inject it into the output string for each array element
                    else
                        newSchema = schema.(varName);
                        for j=1:1:size(newSchema,2)
                            [returnedString,exitChar] = mavstring(inString,newSchema(j),i+3);
                            outString = [outString returnedString];
                        end
                    end
                    
                    %Update the state of the parser
                    i = exitChar;
                    state = SEARCHING;
                    
                %Otherwise if the character is alphanumeric update the variable name
                elseif isstrprop(c,'alphanum')
                    varName = [varName c];
                %Otherwise display an error and break
                else
                    disp('ERROR: REPETITION VARIABLE CONTAINS SPECIAL CHAR')
                    break;
                end
                
            %Adds the text of expression 1 if the condition is true of expression 2 if false
            case CONDITIONAL
                
                %If the conditional delimiter is found handle condition evaluation
                if strcmp(inString(i:i+2),'<?>')
                    
                    condition = mavstring(inString,schema,conditionStart,i-1);
                    %Try to evaluate the condition using code injection (WARNING: Only use trusted templates)
                    try
                        eval(sprintf('if %s,state=CONDITIONTRUE;,else,state=CONDITIONFALSE;,end',condition));
                        i=i+2;
                    %Otherwise display an error and break
                    catch
                        disp('ERROR: Condition is not valid!');
                        break;
                    end
                    
                %Otherwise if the conditional end tag is found throw an error and break
                elseif strcmp(inString(i:i+1),'}?')
                    disp('ERROR: Conditional tag is incorrectly formatted');
                    break;
                %Otherwise update the condition text
                else
                    condition = [condition c];
                end
                
            %If the evaluated condition is true
            case CONDITIONTRUE
                
                %Inject the text from expression 1
                [returnedString, i] = mavstring(inString, schema, i);
                outString = [outString returnedString];
                [~, i] = mavstring(inString, schema, i);
                %Update the state of the parser
                state = SEARCHING;
                
            %If the evaluated condition is false
            case CONDITIONFALSE
                
                %Inject the text from expression 2
                [~, i] = mavstring(inString, schema, i);
                [returnedString, i] = mavstring(inString, schema, i+1);
                outString = [outString returnedString];
                %Update the state of the parser
                state = SEARCHING;
                
        end
        
        %Increment the character counter
        i=i+1;
        
    end

end

