function interArrival = lookupInterArrival(rn)
    % Use the probability ranges from ProbabilityTables
    if rn <= 0.20
        interArrival = 1;
    elseif rn <= 0.50
        interArrival = 2;
    elseif rn <= 0.85
        interArrival = 3;
    else
        interArrival = 4;
    end
end
