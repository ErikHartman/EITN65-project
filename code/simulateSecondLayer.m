function [spike_trains, f_secondary] = simulateSecondLayer(Stim)

f_secondary = zeros(size(Stim));

for i=1:25
    [spike_trains(:,i),f_secondary(i)] = simulateSecondaryNeuron(Stim(i),0);
end

