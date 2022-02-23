
%% milestone 1
simulateSecondaryNeuron(10,1)
simulateSecondaryNeuron(1,1)

%% milestone 2
stim = [ 1 1 1 1 1 1 1 1 2 2 2 2 1 1 1 3 3 3 4 4 4 10 1 1 1]';
[spike_trains, f] = simulateSecondLayer(stim);
stim_mat = reshape(stim,5,5);
f = reshape(f,5,5);
figure;
imagesc(f);
title('Frequency')
axis square;
colorbar;
figure;
imagesc(stim_mat);
colorbar;
title('Stimuli')
axis square;

%% milestone 3
E_syn  =nan(25,1);
E_syn(13)  = 0;
f = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn);

%% milestone 4
E_syn  =nan(25,1);
E_syn(13)  = 0;
E_syn([7 8 9 12 14 17 18 19]) = -70;
