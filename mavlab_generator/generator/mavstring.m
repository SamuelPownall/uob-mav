function [outString, exitChar] = mavstring(inString,schema,startIndex,endIndex)
%MAVSTRING2 Summary of this function goes here
%   Detailed explanation goes here

    SEARCHING = 0; VARIABLE = 1; REPETITION = 2; CONDITIONAL = 3;
    CONDITIONTRUE = 4; CONDITIONFALSE = 5;

    varName = []; condition = []; outString = []; exitChar = 0;
    conditionStart = 0;

    if nargin < 4
        endIndex = size(inString,2);
    end
    if nargin < 3
        startIndex = 1;
    end
    
    i = startIndex;
    inString = [inString '    '];
    state = SEARCHING;
    
    while i <= endIndex
        
        exitChar = i;
        c = inString(i);
        
        switch(state)
            
            case SEARCHING
                
                if strcmp(inString(i:i+2),'<?>')
                    exitChar = exitChar + 2;
                    break;
                end     
                
                switch(inString(i:i+1))
                    case '${'
                        varName = [];
                        i=i+1;
                        state = VARIABLE;
                    case '#{'
                        varName = [];
                        i=i+1;
                        state = REPETITION;
                    case '?{'
                        condition = [];
                        conditionStart = i+2;
                        i=i+1;
                        state = CONDITIONAL;
                    case '}#'
                        exitChar = exitChar + 1;
                        break;
                    case '}?'
                        exitChar = exitChar + 1;
                        break;
                    otherwise
                        outString = [outString c];
                end
                
            case VARIABLE
                
                if strcmp(inString(i:i+1),'}$')
                    
                    if ~isfield(schema,varName)
                        disp('ERROR: Field does not exist!');
                        break;
                    elseif isnumeric(schema.(varName))
                        outString = [outString num2str(schema.(varName))];
                    else
                        outString = [outString schema.(varName)];
                    end
                    i=i+1;
                    state = SEARCHING;
                    
                elseif isstrprop(c,'alphanum')
                    varName = [varName c];
                else
                    disp('ERROR: VARIABLE NAME CONTAINS SPECIAL CHAR');
                    break;
                end
                
            case REPETITION
                
                if strcmp(inString(i:i+2),'<#>')
                    
                    if ~isfield(schema,varName)
                        disp('ERROR: Field does not exist!');
                        break;
                    else
                        newSchema = schema.(varName);
                        for j=1:1:size(newSchema,2)
                            [returnedString,exitChar] = mavstring(inString,newSchema(j),i+3);
                            outString = [outString returnedString];
                        end
                    end
                    i = exitChar;
                    state = SEARCHING;
                    
                elseif isstrprop(c,'alphanum')
                    varName = [varName c];
                else
                    disp('ERROR: REPETITION VARIABLE CONTAINS SPECIAL CHAR')
                    break;
                end
                
            case CONDITIONAL
                
                if strcmp(inString(i:i+2),'<?>')
                    
                    condition = mavstring(inString,schema,conditionStart,i-1);
                    try
                        eval(sprintf('if %s,state=CONDITIONTRUE;,else,state=CONDITIONFALSE;,end',condition));
                        i=i+2;
                    catch
                        disp('ERROR: Condition is not valid!');
                        break;
                    end
                    
                elseif strcmp(inString(i:i+1),'}?')
                    disp('ERROR: Conditional tag is incorrectly formatted');
                    break;
                else
                    condition = [condition c];
                end
                
            case CONDITIONTRUE
                
                [returnedString, i] = mavstring(inString, schema, i);
                outString = [outString returnedString];
                [~, i] = mavstring(inString, schema, i);
                state = SEARCHING;
                
            case CONDITIONFALSE
                
                [~, i] = mavstring(inString, schema, i);
                [returnedString, i] = mavstring(inString, schema, i+1);
                outString = [outString returnedString];
                state = SEARCHING;
                
        end
        
        i=i+1;
        
    end

end

