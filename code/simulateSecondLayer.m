function [spike_trains, f_secondary] = simulateSecondLayer(Stim,plotFlag)

f_secondary = zeros(25,1);
for i=1:25
    [spike_trains(:,i),f_secondary(i)] = simulateSecondaryNeuron(Stim(i),0);
end

StimMatrix = reshape(Stim,5,5);
fMatrix = reshape(f_secondary,5,5);

%% plot
if plotFlag == 1
    figure;
    imagesc(StimMatrix);
    colorbar;
    title('Secondary Neuron Layer Spike Trains')
    axis square
    figure;
    imagesc(fMatrix);
    colorbar;
    title('Secondary Neuron Layer Frequency')
    axis square
end
