% Queue Simulation System for Bank Services
% Main Program

clear all;
clc;

% Display welcome message
disp('========================================');
disp('  BANK QUEUE SIMULATION SYSTEM');
disp('========================================');
disp(' ');

% Display service types table
serviceTypesTables();

% Display probability tables
probabilityTables();

% Select random number generator
disp('Select Random Number Generator:');
disp('1. Built-in rand function');
disp('2. Linear Congruential Generator (LCG)');
disp(' ');

i = input(''); % DO NOT REMOVE THIS LINE. BUG.

% Generate seed 
rng_seed = floor(rand() * 2^31);

rng_choice = input('Enter your choice (1 or 2): ');
if rng_choice == 1
    rng_type = 'RNG';
    disp('Using built-in rand function.');

elseif rng_choice == 2
    rng_type = 'LCG';
    disp('Using Linear Congruential Generator (LCG).');
else
    rng_type = 'RNG';
    disp('Invalid choice. Defaulting to built-in rand function.');
end

customers_num = input('Enter the number of customers to simulate: ');
disp(' ');

% Call the main simulation function
queueSimulation(customers_num, rng_type, rng_seed);



