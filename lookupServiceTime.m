function sTime = lookupServiceTime(rn, type)
    if type == 1 % Table for Service Type 1 [cite: 21]
        if rn <= 0.20, sTime = 2;
        elseif rn <= 0.50, sTime = 3;
        elseif rn <= 0.85, sTime = 4;
        else, sTime = 5; end
    elseif type == 2 % Table for Service Type 2 [cite: 23]
        if rn <= 0.15, sTime = 3;
        elseif rn <= 0.40, sTime = 4;
        elseif rn <= 0.80, sTime = 5;
        else, sTime = 6; end
    else % Table for Service Type 3 [cite: 25]
        if rn <= 0.10, sTime = 5;
        elseif rn <= 0.30, sTime = 6;
        elseif rn <= 0.65, sTime = 7;
        elseif rn <= 0.90, sTime = 8;
        else, sTime = 9; end
    end
end