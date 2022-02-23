E_syn  = nan(25,1);
E_syn(13)  = 0;
E_syn([7 8 9 12 14 17 18 19]) = -75;

I_const_weak = 1;
I_const_strong = 15;
A_pp_I = 3;

Stim = zeros(25,1);
Stim(1)  = I_const_weak;
spike_trains = simulateSecondLayer(Stim,0);
f=zeros(20,5);
for i=1:20
    f(i,1) = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn);
end
%  Strong touch in center
Stim = zeros(25,1);
Stim(13)  =I_const_strong;
spike_trains = simulateSecondLayer(Stim,0);
for i=1:20
    f(i,2) = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn);
end
%  Weak touch in center
Stim = zeros(25,1);
Stim(13)  =I_const_weak;
spike_trains = simulateSecondLayer(Stim,0);
for i=1:20
    f(i,3) = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn);
end
%  Strong touch in surround
Stim = zeros(25,1);
Stim(14)  =I_const_strong;
spike_trains = simulateSecondLayer(Stim,0);
for i=1:20
    f(i,4) = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn);
end
%  Weak touch in surround
Stim = zeros(25,1);
Stim(14)  =I_const_weak;
spike_trains = simulateSecondLayer(Stim,0);
for i=1:20
    f(i,5) = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn);
end


figure;
boxplot(f)
xticks([1:5])
xticklabels({'S(1)', 'S(13)', 'W(13)', 'S(14)', 'W(14)'})
ylabel('Frequency')