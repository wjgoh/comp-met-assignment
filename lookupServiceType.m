function serviceType = lookupServiceType(rn)
    % Use Service Type Probability ranges
    if rn <= 0.50
        serviceType = 1;
    elseif rn <= 0.80
        serviceType = 2;
    else
        serviceType = 3;
    end
end