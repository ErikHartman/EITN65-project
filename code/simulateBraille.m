function f_tertiary = simulateBraille(input_char)

% Parameters
E_syn = zeros(5*7,1);
E_syn([1 2 3 4 5 6 8 10 11 12 13 14 15 16 18 20 21 22 23 24 25 26 28 30 31 32 33 34 35]) = 0;
I_weak = 1;
I_strong = 15;
A_pp_I = 3;
Stim = zeros(5*7,1)';
% Stimulate Braille character
if input_char == 1
    Stim = simulate_E(Stim, I_strong,I_weak);
end
if input_char == 2
     Stim =  simulate_J(Stim, I_strong,I_weak);
end
if input_char == 3
    Stim = simulate_R(Stim, I_strong,I_weak);
end
if input_char == 4
     Stim =  simulate_U(Stim, I_strong,I_weak);
end

% Stimulate second layer
spike_trains = simulateSecondLayer(Stim); 
% Stimulate third layer
f_tertiary = simulateTertiaryLayer(A_pp_I, spike_trains, E_syn);

    function Stim = simulate_E(Stim, I_strong,I_weak)
        Stim(7) = I_strong;
        Stim(19) = I_strong;
    end
    function Stim = simulate_J(Stim,I_strong,I_weak)
        Stim(9) = I_strong;
        Stim(19) = I_strong;
        Stim(17) = I_strong;
    end

    function Stim = simulate_R(Stim,I_strong,I_weak)
        Stim(7) = I_strong;
        Stim(17) = I_strong;
        Stim(27) = I_strong;
        Stim(19) = I_strong;
    end

    function Stim = simulate_U(Stim, I_strong,I_weak)
        Stim(7) = I_strong;
        Stim(27) = I_strong;
        Stim(29) = I_strong;
    end

end