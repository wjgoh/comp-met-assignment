% RNG.m
function random_numbers = RNG(n_samples)
    if nargin < 1
        n_samples = 1;
    end
    
    % Generate random numbers
    random_numbers = rand(1, n_samples);
end