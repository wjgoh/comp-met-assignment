function random_numbers = LCG(seed, n_samples)
    % LCG - Linear Congruential Generator
    a = 1664525;
    c = 1013904223;
    m = 2^32;
    
    % Initialize array to store random numbers
    random_numbers = zeros(1, n_samples);
    
    % Generate random numbers using LCG formula
    x = seed;
    for i = 1:n_samples
        x = mod(a * x + c, m);
        random_numbers(i) = x / m;  % Normalize to [0, 1)
    end
end