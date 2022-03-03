function f_tertiary = simulateBraille(input_char, lateral_inhibition_flag, I)
    % Parameters
    A_pp_I = 3;
    Stim = zeros(35,1);
    f_tertiary = zeros(35,1);
    % Stimulate Braille character
    pos = simulate_char(input_char);
    for l = 1:length(pos)
        Stim(pos) = I;
    end
    [spike_trains, ~] = simulateSecondLayer(Stim); 
    for i = 1:35
        E_syn = nan(35,1);
        E_syn(i) = 0;
        if lateral_inhibition_flag == 1
%            lateral inhibition on --> add neighbouring elements
             E_syn = add_lateral_inhibition(i);
        end
        f_tertiary(i) = simulateTertiaryNeuron(A_pp_I, spike_trains, E_syn); 
    end
    
    
end

%% functions
function pos = simulate_char(input_char)
    switch input_char
        case 1
            pos = [7,19];
        case 2
            pos = [7, 17, 19];
        case 3
            pos = [7, 17, 19, 27];
        case 4
            pos = [7, 27, 29];
        case 5
            pos = [7,9]; 
        case 6
            pos = [7,9,19];
        case 7
            pos = [9, 17, 19];
        case 8
            pos = [7, 17, 27, 9];
        case 9
            pos = [27,17,9];
        case 10
            pos = [7, 27, 29];
        case 11
            pos = [9, 19, 29, 27, 7];
            
    end
end

function E_syn = add_lateral_inhibition(i)
            E_syn = nan(35,1);
            E_syn(i) = 0;
% funktionen från helvetet
            if mod(i,5) ~= 1
%                 not left edge --> add left
                  E_syn(i-1) = -75;
            end
            if mod(i,5) ~= 0
%                 not right edge --> add left
                E_syn(i+1) = -75;
            end
            if i >= 6
%                 not top --> add top
                E_syn(i-5) = -75;
            end
            if i <= 30
%                 not bottom --> add bottom
                  E_syn(i+5) = -75;
            end
            if i <= 29 && mod(i,5) ~= 1
%                 not bottom left --> add diagonal down right
                    E_syn(i+6) = -75;
            end
            if i <= 30 && mod(i,5) ~= 0
%                 not bottom right --> add diagonal down left
                    E_syn(i+4) = - 75;
            end
            if i >=6 && mod(i,5) ~= 1
%                 not top left --> add diagonal up right
                    E_syn(i-4) = -75;
            end
            if i >= 7 && mod(i,5) ~= 0
%                 not top right --> add diagonal up left
                    E_syn(i-6) = -75;
            end
end