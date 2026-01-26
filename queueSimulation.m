function queueSimulation(customers_num, rng_type, rng_seed)
    % Initialize Counter Free Times (7 counters total)
    % Counters 1-3 (Type 1), 4-5 (Type 2), 6-7 (Type 3)
    counter_free_until = zeros(1, 7);
    
    % Storage for results
    results = []; 
    current_time = 0;
    last_arrival_time = 0;

    % 1. Generate all Random Numbers upfront based on user choice
    if strcmp(rng_type, 'LCG')
        rn_inter = LCG(rng_seed, customers_num);
        rn_type = LCG(rng_seed + 1, customers_num);
        rn_service = LCG(rng_seed + 2, customers_num);
    else
        rn_inter = rand(1, customers_num);
        rn_type = rand(1, customers_num);
        rn_service = rand(1, customers_num);
    end

    fprintf('\n--- STARTING SIMULATION ---\n');

    for i = 1:customers_num
        % A. Determine Arrival
        inter_arrival = lookupInterArrival(rn_inter(i));
        arrival_time = last_arrival_time + inter_arrival;
        last_arrival_time = arrival_time;
        
        % B. Determine Service Type
        sType = lookupServiceType(rn_type(i));
        qNumber = (sType * 1000) + i; % e.g., 1001, 2001
        
        % C. Select Counter based on Service Type
        if sType == 1
            relevant_counters = [1, 2, 3];
        elseif sType == 2
            relevant_counters = [4, 5];
        else
            relevant_counters = [6, 7];
        end
        
        % Find the counter that finishes the soonest
        [free_time, idx] = min(counter_free_until(relevant_counters));
        chosen_counter = relevant_counters(idx);
        
        % D. Calculate Service Timing
        serviceTime = lookupServiceTime(rn_service(i), sType);
        service_start = max(arrival_time, free_time);
        waiting_time = service_start - arrival_time;
        service_end = service_start + serviceTime;
        time_in_system = service_end - arrival_time;
        
        % Update counter status
        counter_free_until(chosen_counter) = service_end;
        
        % E. Display real-time messages
        fprintf('Arrival of customer %d at minute %d (Queue: %d)\n', i, arrival_time, qNumber);
        if service_start > arrival_time
            fprintf('Customer %d waited until minute %d.\n', qNumber, service_start);
        end
        fprintf('Service for %d started at minute %d at Counter %d.\n', qNumber, service_start, chosen_counter);
        fprintf('Departure of customer %d at minute %d.\n', i, service_end);
        disp('------------------------------------');

        % Store data for final tables
        results = [results; i, qNumber, arrival_time, sType, chosen_counter, rn_service(i), serviceTime, service_start, service_end, waiting_time, time_in_system];
    end

    % 2. After loop, display the final evaluation
    displayFinalTables(results, customers_num);
end