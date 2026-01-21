function probabilityTables()
    % Display Probability Distribution Tables for Queue Simulation
    
    disp(' ');
    disp('========================================');
    disp('  PROBABILITY DISTRIBUTION TABLES');
    disp('========================================');
    disp(' ');
    
    % Service Type Probabilities
    disp('SERVICE TYPE PROBABILITIES:');
    disp('+---------------+------------+------------+----------+');
    disp('| Service Type  |     1      |     2      |     3    |');
    disp('| Probability   |    0.50    |    0.30    |    0.20  |');
    disp('| CDF           |    0.50    |    0.80    |    1.00  |');
    disp('| Range         | 0.00-0.50  | 0.50-0.80  | 0.80-1.00|');
    disp('+---------------+------------+------------+----------+');
    disp(' ');
    
    % Service Type 1 Service Times
    
    disp('SERVICE TYPE 1 - SERVICE TIME DISTRIBUTION:');
    disp('+----------------------+------------+------------+------------+----------+')
    disp('| Service Time (Mins)  |     2      |     3      |     4      |     5    |');
    disp('| Probability          |    0.20    |    0.30    |    0.35    |    0.15  |');
    disp('| CDF                  |    0.20    |    0.50    |    0.85    |    1.00  |');
    disp('| Range                | 0.00-0.20  | 0.20-0.50  | 0.50-0.85  | 0.85-1.00|');
    disp('+----------------------+------------+------------+------------+----------+');
    disp(' ');
    
    % Service Type 2 Service Times
    disp('SERVICE TYPE 2 - SERVICE TIME DISTRIBUTION:');
    disp('+----------------------+------------+------------+------------+----------+')
    disp('| Service Time (Mins)  |     3      |     4      |     5      |     6    |');
    disp('| Probability          |    0.15    |    0.25    |    0.40    |    0.20  |');
    disp('| CDF                  |    0.15    |    0.40    |    0.80    |    1.00  |');
    disp('| Range                | 0.00-0.15  | 0.15-0.40  | 0.40-0.80  | 0.80-1.00|');
    disp('+----------------------+------------+------------+------------+----------+');
    disp(' ');
    
    % Service Type 3 Service Times
    disp('SERVICE TYPE 3 - SERVICE TIME DISTRIBUTION:');
    disp('+----------------------+------------+------------+------------+------------+----------+')
    disp('| Service Time (Mins)  |     5      |     6      |     7      |     8      |     9    |');
    disp('| Probability          |    0.10    |    0.20    |    0.35    |    0.25    |    0.10  |');
    disp('| CDF                  |    0.10    |    0.30    |    0.65    |    0.90    |    1.00  |');
    disp('| Range                | 0.00-0.10  | 0.10-0.30  | 0.30-0.65  | 0.65-0.90  | 0.90-1.00|');
    disp('+----------------------+------------+------------+------------+------------+----------+');
    disp(' ');
    
    % Inter-arrival Times
    disp('INTER-ARRIVAL TIME DISTRIBUTION:');
    disp('+---------------+------------+------------+------------+----------+')
    disp('| Inter-arrival |     1      |     2      |     3      |     4    |');
    disp('| Probability   |    0.20    |    0.30    |    0.35    |    0.15  |');
    disp('| CDF           |    0.20    |    0.50    |    0.85    |    1.00  |');
    disp('| Range         | 0.00-0.20  | 0.20-0.50  | 0.50-0.85  | 0.85-1.00|');
    disp('+---------------+------------+------------+------------+----------+');
    disp(' ');
    
end
