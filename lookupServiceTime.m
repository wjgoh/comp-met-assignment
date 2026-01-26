function serviceTime = lookupServiceTime(rn, serviceType)
    % Maps RN to Service Time based on Service Type tables
    
    if serviceType == 1
        % Service Type 1 Distribution
        if rn <= 0.20
            serviceTime = 2;
        elseif rn <= 0.50
            serviceTime = 3;
        elseif rn <= 0.85
            serviceTime = 4;
        else
            serviceTime = 5;
        end
        
    elseif serviceType == 2
        % Service Type 2 Distribution
        if rn <= 0.15
            serviceTime = 3;
        elseif rn <= 0.40
            serviceTime = 4;
        elseif rn <= 0.80
            serviceTime = 5;
        else
            serviceTime = 6;
        end
        
    elseif serviceType == 3
        % Service Type 3 Distribution
        if rn <= 0.10
            serviceTime = 5;
        elseif rn <= 0.30
            serviceTime = 6;
        elseif rn <= 0.65
            serviceTime = 7;
        elseif rn <= 0.90
            serviceTime = 8;
        else
            serviceTime = 9;
        end
    else
        serviceTime = 0; % Error case
    end
end