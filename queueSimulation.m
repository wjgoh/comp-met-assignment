function queueSimulation(num_customers, rng_type, seed)
    % Core logic for the Discrete Event Simulation
    
    %% PHASE 1: GENERATE CUSTOMER DATA
    % We pre-calculate all customer attributes before the time loop starts
    
    % Generate RNs based on selection
    if strcmp(rng_type, 'LCG')
        rn_arrival = LCG(seed, num_customers);
        rn_type    = LCG(seed + 12345, num_customers); % Different seed
        rn_service = LCG(seed + 67890, num_customers); % Different seed
    else
        rn_arrival = rand(1, num_customers);
        rn_type    = rand(1, num_customers);
        rn_service = rand(1, num_customers);
    end
    
    % Initialize Data Structures
    customers = []; 
    current_arrival_time = 0;
    
    for i = 1:num_customers
        % 1. Determine Inter-arrival and Arrival Time
        inter_t = lookupInterArrival(rn_arrival(i));
        current_arrival_time = current_arrival_time + inter_t;
        
        % 2. Determine Service Type
        s_type = lookupServiceType(rn_type(i));
        
        % 3. Determine Service Duration
        s_time = lookupServiceTime(rn_service(i), s_type);
        
        % 4. Assign Queue Number (e.g., Type 1 -> 1001)
        if s_type == 1
            q_prefix = 1000;
        elseif s_type == 2
            q_prefix = 2000;
        else
            q_prefix = 3000;
        end
        
        % Store in Struct
        customers(i).id = i;
        customers(i).rn_arrival = rn_arrival(i);
        customers(i).inter_arrival = inter_t;
        customers(i).arrival_time = current_arrival_time;
        customers(i).rn_type = rn_type(i);
        customers(i).service_type = s_type;
        customers(i).queue_num = q_prefix + i;
        customers(i).rn_service = rn_service(i);
        customers(i).service_duration = s_time;
        
        % Result Placeholders
        customers(i).counter_id = 0;
        customers(i).start_time = -1;
        customers(i).end_time = -1;
        customers(i).wait_time = 0;
        customers(i).time_in_system = 0;
        customers(i).status = 'pending'; % pending, queue, service, done
    end

    %% PHASE 2: SIMULATION ENGINE (TIME LOOP)
    
    disp(' ');
    disp('--- SIMULATION LOG ---');
    
    clock_time = 0;
    completed_count = 0;
    
    % Queues for each service type
    queue_1 = [];
    queue_2 = [];
    queue_3 = [];
    
    % Counter Status (Value = Time the counter becomes free. 0 = Free now)
    % Type 1: Counters 1, 2, 3
    % Type 2: Counters 4, 5
    % Type 3: Counters 6, 7
    counters = zeros(1, 7); 
    
    while completed_count < num_customers
        
        % 1. CHECK ARRIVALS
        for i = 1:num_customers
            if customers(i).arrival_time == clock_time
                % Add to appropriate queue
                if customers(i).service_type == 1
                    queue_1 = [queue_1, i];
                elseif customers(i).service_type == 2
                    queue_2 = [queue_2, i];
                else
                    queue_3 = [queue_3, i];
                end
                customers(i).status = 'queue';
                fprintf('Time %d: Customer %d arrived (Queue %d)\n', ...
                    clock_time, i, customers(i).queue_num);
            end
        end
        
        % 2. CHECK DEPARTURES (Counter frees up)
        % We check if any busy counter finishes exactly at this minute
        for c = 1:7
            if counters(c) == clock_time && counters(c) > 0
                % Find who was at this counter? 
                % (We just know the counter is free now, logging is handled at start)
                % Reset counter to 0 (free) is not strictly needed if we check <= clock
            end
        end
        
        % 3. ASSIGN SERVICE (If Counter is Free AND Queue has people)
        
        % -- Service Type 1 (Counters 1, 2, 3) --
        for c = 1:3
            if counters(c) <= clock_time && ~isempty(queue_1)
                % Pop first customer
                cust_idx = queue_1(1);
                queue_1(1) = []; 
                
                % Assign Logic
                customers(cust_idx).counter_id = c;
                customers(cust_idx).start_time = clock_time;
                customers(cust_idx).end_time = clock_time + customers(cust_idx).service_duration;
                customers(cust_idx).wait_time = customers(cust_idx).start_time - customers(cust_idx).arrival_time;
                customers(cust_idx).time_in_system = customers(cust_idx).end_time - customers(cust_idx).arrival_time;
                customers(cust_idx).status = 'done';
                
                % Update Counter Busy Time
                counters(c) = customers(cust_idx).end_time;
                
                fprintf('Time %d: Counter %d started serving Queue %d\n', ...
                    clock_time, c, customers(cust_idx).queue_num);
                
                % Log Departure immediately for future reference
                fprintf('        (Will depart at Time %d)\n', customers(cust_idx).end_time);
                
                completed_count = completed_count + 1;
            end
        end
        
        % -- Service Type 2 (Counters 4, 5) --
        for c = 4:5
            if counters(c) <= clock_time && ~isempty(queue_2)
                cust_idx = queue_2(1);
                queue_2(1) = []; 
                
                customers(cust_idx).counter_id = c;
                customers(cust_idx).start_time = clock_time;
                customers(cust_idx).end_time = clock_time + customers(cust_idx).service_duration;
                customers(cust_idx).wait_time = customers(cust_idx).start_time - customers(cust_idx).arrival_time;
                customers(cust_idx).time_in_system = customers(cust_idx).end_time - customers(cust_idx).arrival_time;
                customers(cust_idx).status = 'done';
                
                counters(c) = customers(cust_idx).end_time;
                fprintf('Time %d: Counter %d started serving Queue %d\n', ...
                    clock_time, c, customers(cust_idx).queue_num);
                fprintf('        (Will depart at Time %d)\n', customers(cust_idx).end_time);
                
                completed_count = completed_count + 1;
            end
        end
        
        % -- Service Type 3 (Counters 6, 7) --
        for c = 6:7
             if counters(c) <= clock_time && ~isempty(queue_3)
                cust_idx = queue_3(1);
                queue_3(1) = []; 
                
                customers(cust_idx).counter_id = c;
                customers(cust_idx).start_time = clock_time;
                customers(cust_idx).end_time = clock_time + customers(cust_idx).service_duration;
                customers(cust_idx).wait_time = customers(cust_idx).start_time - customers(cust_idx).arrival_time;
                customers(cust_idx).time_in_system = customers(cust_idx).end_time - customers(cust_idx).arrival_time;
                customers(cust_idx).status = 'done';
                
                counters(c) = customers(cust_idx).end_time;
                fprintf('Time %d: Counter %d started serving Queue %d\n', ...
                    clock_time, c, customers(cust_idx).queue_num);
                fprintf('        (Will depart at Time %d)\n', customers(cust_idx).end_time);
                
                completed_count = completed_count + 1;
            end
        end
        
        clock_time = clock_time + 1;
    end
    
    %% PHASE 3: REPORTING AND TABLES
    
    % 1. Master Simulation Table
    disp(' ');
    disp('================================================================================');
    disp('                              SIMULATION TABLE                                  ');
    disp('================================================================================');
    disp('Cust  | RN Arr | Inter | Arr Time | RN Type | Type | Q Num | RN Svc | Duration');
    disp('--------------------------------------------------------------------------------');
    for i = 1:num_customers
        fprintf('%-5d | %.4f | %-5d | %-8d | %.4f  | %-4d | %-5d | %.4f | %-8d\n', ...
            customers(i).id, ...
            customers(i).rn_arrival, ...
            customers(i).inter_arrival, ...
            customers(i).arrival_time, ...
            customers(i).rn_type, ...
            customers(i).service_type, ...
            customers(i).queue_num, ...
            customers(i).rn_service, ...
            customers(i).service_duration);
    end
    
    % 2. Detailed Service Tables (As requested per type)
    printServiceTable(customers, 1);
    printServiceTable(customers, 2);
    printServiceTable(customers, 3);
    
    % 3. Final Evaluation Metrics
    avg_wait = mean([customers.wait_time]);
    avg_sys = mean([customers.time_in_system]);
    
    disp(' ');
    disp('========================================');
    disp('  PERFORMANCE EVALUATION');
    disp('========================================');
    fprintf('Average Waiting Time:       %.2f mins\n', avg_wait);
    fprintf('Average Time in System:     %.2f mins\n', avg_sys);
    fprintf('Total Simulation Time:      %d mins\n', max([customers.end_time]));
    disp('========================================');
    
end

function printServiceTable(all_cust, type_id)
    disp(' ');
    fprintf('================ DETAILED LOG: SERVICE TYPE %d ================\n', type_id);
    disp('Cust | Queue | Arr | Counter | Svc Time | Begin | End | Wait | SysTime');
    disp('-----------------------------------------------------------------------');
    
    % Filter customers by type
    count = 0;
    total_wait = 0;
    
    for i = 1:length(all_cust)
        if all_cust(i).service_type == type_id
            c = all_cust(i);
            fprintf('%-4d | %-5d | %-3d | %-7d | %-8d | %-5d | %-3d | %-4d | %-7d\n', ...
                c.id, c.queue_num, c.arrival_time, c.counter_id, ...
                c.service_duration, c.start_time, c.end_time, ...
                c.wait_time, c.time_in_system);
            
            count = count + 1;
            total_wait = total_wait + c.wait_time;
        end
    end
    
    if count > 0
        fprintf('-----------------------------------------------------------------------\n');
        fprintf('Average Wait for Type %d: %.2f mins\n', type_id, total_wait/count);
    else
        disp('No customers for this service type.');
    end
end