function outString = mavstring(inString, schemaMap)
%MAVSTRING Summary of this function goes here
%   Detailed explanation goes here

    SEARCHING = 0; GOTDOLLAR = 1; GOTOPENBRACE = 2;
     GOTCOLON = 3; GOTCLOSEBRACEVAR = 4; GOTCLOSEBRACEREP = 5;
    state = SEARCHING;
    
    varName = []; mapName = [];
    stackLevel = 0;

    for i = 1:1:size(inString,2)
        
        c = inString(i);
        
        switch(state)
            
            case SEARCHING
                if c == '$'
                    state = GOTDOLLAR;
                end
            
            case GOTDOLLAR
                if c == '{'
                    state = GOTOPENBRACE;
                    stackLevel = stackLevel + 1;
                    varName = [];
                else
                    state = SEARCHING;
                end
            
            case GOTOPENBRACE
                if c == '}'
                    state = GOTCLOSEBRACEVAR;
                elseif c == ':'
                    state = GOTCOLON;
                    mapName = varName;
                elseif isstrprop(c,'alphanum')
                    varName = [varName c];
                else
                    state = SEARCHING;
                    stackLevel = stackLevel - 1;
                    disp('WARNING');
                end
                
            case GOTCOLON
                
            case GOTCLOSEBRACEVAR
                if c == '$'
                    stackLevel = stackLevel - 1;
                end    
                
            case GOTCLOSEBRACEREP
                

                
        end
        
    end

end

