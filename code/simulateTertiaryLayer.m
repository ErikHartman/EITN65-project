function f  =simulateTertiaryLayer(A_pp_I,spike_trains, E_syn)

for i = 1:25 
    f(i) = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn); 
end 
