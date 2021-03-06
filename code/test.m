
%% simulating secondary neuron
simulateSecondaryNeuron(1, 1)

%% simulating secondary layer
Stim = zeros(5*7,1)';
I=10;
Stim(7) = I;
Stim(19) = I;
[spike_trains, f_secondary] = simulateSecondLayer(Stim);
f_secondary = reshape(f_secondary, 5,7)';
figure;
imagesc(f_secondary);
title('Secondary layer frequency (E)')
colorbar;
axis square;

%% simulating tertiary neuron
A_pp_I = 10;
E_syn = nan(35,1);
E_syn(7) = 0;
f_tertiary = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn);
%% simulating tertiary layer (takes spike_trains from above)
A_pp_I = 3;

f_tertiary_weak = simulateBraille(1,0, 0, 1);
f_tertiary_weak = reshape(f_tertiary_weak, 5,7)';
f_tertiary = simulateBraille(1,0, 0, 10);
f_tertiary = reshape(f_tertiary, 5,7)';
f_tertiary_li = simulateBraille(1,1, 0, 10);
f_tertiary_li = reshape(f_tertiary_li, 5,7)';
f_tertiary_noise = simulateBraille(1,0,1,10);
f_tertiary_noise = reshape(f_tertiary_noise, 5,7)';
figure;
subplot(2,2,1);
imagesc(f_tertiary_weak);
title('Weak current')
colorbar;
axis square;
subplot(2,2,2);
imagesc(f_tertiary);
title('Strong current')
colorbar;
axis square;
subplot(2,2,3);
imagesc(f_tertiary_noise);
title('Strong current with noise')
colorbar;
axis square;
subplot(2,2,4);
imagesc(f_tertiary_li);
title('Strong current with noise and LI')
colorbar;
axis square;
%% plotting character third layer

upper_color_lim = 58;
lower_color_lim = 45;

f_E = simulateBraille(1, 0, 1, 10); 
f_J = simulateBraille(2, 0, 1,10); 
f_R = simulateBraille(3, 0, 1, 10); 
f_U = simulateBraille(4, 0, 1, 10); 

f_E_li = simulateBraille(1, 1, 1, 10); 
f_J_li = simulateBraille(2, 1, 1, 10); 
f_R_li = simulateBraille(3, 1, 1, 10); 
f_U_li = simulateBraille(4, 1, 1, 10); 

f_E = reshape(f_E, 5,7)';
f_J = reshape(f_J, 5,7)';
f_U = reshape(f_U, 5,7)';
f_R = reshape(f_R, 5,7)';

f_E_li = reshape(f_E_li, 5,7)';
f_J_li = reshape(f_J_li, 5,7)';
f_U_li = reshape(f_U_li, 5,7)';
f_R_li = reshape(f_R_li, 5,7)';

fig_handle = figure;
caxis([lower_color_lim,upper_color_lim])
subplot(4,2,1)

imagesc(f_E);
% title('E')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

subplot(4,2,2)

imagesc(f_J);
title('J')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

subplot(4,2,3)

imagesc(f_R);
title('R')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

subplot(4,2,4)

imagesc(f_U);
title('U')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

subplot(4,2,5)

imagesc(f_E_li);
title('E li')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

subplot(4,2,6)

imagesc(f_J_li);
title('J li')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

subplot(4,2,7)

imagesc(f_R_li);
title('R li')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

subplot(4,2,8)

imagesc(f_U_li);
title('U li')
colorbar;
caxis([lower_color_lim,upper_color_lim])
axis square;

