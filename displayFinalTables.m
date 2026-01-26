function displayFinalTables(results, customers_num)
    % Column mapping from the 'results' matrix:
    % 1:CustNo, 2:QNum, 3:ArrTime, 4:Type, 5:Counter, 6:RN_Svc, 7:SvcTime, 
    % 8:Start, 9:End, 10:Wait, 11:SystemTime

    % 1. General Simulation Table [cite: 44]
    disp(' ');
    disp('========================================================================');
    disp('                      GENERAL SIMULATION TABLE');
    disp('========================================================================');
    fprintf('%-8s | %-12s | %-12s | %-12s | %-8s\n', 'Cust #', 'Arrival T', 'Type', 'Queue Num', 'Counter');
    for i = 1:size(results, 1)
        fprintf('%-8d | %-12d | %-12d | %-12d | %-8d\n', results(i,1), results(i,3), results(i,4), results(i,2), results(i,5));
    end

    % 2. Service Type Specific Tables 
    for t = 1:3
        fprintf('\n========================================================================\n');
        fprintf('                       SERVICE TYPE %d TABLE\n', t);
        fprintf('========================================================================\n');
        fprintf('%-6s | %-6s | %-6s | %-6s | %-6s | %-6s | %-6s | %-6s\n', ...
            'Q Num', 'Arr T', 'Cntr', 'Svc T', 'Start', 'End', 'Wait', 'Sys T');
        
        type_data = results(results(:,4) == t, :);
        if isempty(type_data)
            disp('No customers for this service type.');
        else
            for j = 1:size(type_data, 1)
                fprintf('%-6d | %-6d | %-6d | %-6d | %-6d | %-6d | %-6d | %-6d\n', ...
                    type_data(j,2), type_data(j,3), type_data(j,5), type_data(j,7), ...
                    type_data(j,8), type_data(j,9), type_data(j,10), type_data(j,11));
            end
        end
    end

    % 3. Evaluation Results 
    disp(' ');
    disp('========================================');
    disp('          EVALUATION RESULTS');
    disp('========================================');
    fprintf('Average Waiting Time: %.2f mins\n', mean(results(:,10)));
    fprintf('Average Service Time: %.2f mins\n', mean(results(:,7)));
    fprintf('Average Time in System: %.2f mins\n', mean(results(:,11)));
    
    num_waited = sum(results(:,10) > 0);
    fprintf('Probability that customer has to wait: %.2f\n', num_waited / customers_num);
end