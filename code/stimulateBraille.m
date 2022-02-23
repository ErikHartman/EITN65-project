

%% Demo
E_syn = zeros(25,1);
E_syn([7 8 9 12 14 17 18 19]) = -75;
I_weak = 1;
I_strong = 15;
A_pp_I = 3;

Stim = zeros(25,1); 
Stim(13) =  I_strong;
Stim(15) = I_weak;
Stim(20) = I_strong;
spike_trains = simulateSecondLayer(Stim,0); 
f_tertiary= simulateTertiaryLayer(A_pp_I, spike_trains, E_syn);

f_tertiary = reshape(f_tertiary,5,5);

imagesc(f_tertiary);
yticks((1:5))
colorbar;
title('Tirtiary Neuron Layer Frequency')
axis square

%% Simulate Braille
% start with 4x7 for braille
% generate characters
% generate f_tertiary
    % 10^3 for each character in training
    % 10^2 for testing
% train SVM on f_tertiary
square = 1:5*7;
square = reshape(square,5,7)';

E_syn = zeros(5*7,1);
E_syn([1 2 3 4 5 6 8 10 11 12 13 14 15 16 18 20 21 22 23 24 25 26 28 30 31 32 33 34 35]) = 0;
I_weak = 1;
I_strong = 15;
A_pp_I = 3;


Stim = simulate_e(I_strong,I_weak);
spike_trains = simulateSecondLayer(Stim); 
f_tertiary= simulateTertiaryLayer(A_pp_I, spike_trains, E_syn);

f_tertiary = reshape(f_tertiary,5,7)';

imagesc(f_tertiary);
yticks((1:5))
colorbar;
title('Tirtiary Neuron Layer Frequency')
axis square

function Stim = simulate_e(I_strong,I_weak)
    Stim = zeros(5*7,1);
    Stim(7) = I_strong;
    Stim(19) = I_strong;
end