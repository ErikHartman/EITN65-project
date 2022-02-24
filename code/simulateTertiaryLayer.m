function f  =simulateTertiaryLayer(A_pp_I,spike_trains, E_syn)
f = zeros(35,1);
for i = 1:35 
    f(i) = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn); 
end 
