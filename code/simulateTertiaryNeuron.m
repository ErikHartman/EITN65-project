% Fire a neuron via alpha function synapse and random input spike train

% Clean up workspace
function f_tertiary = simulateTertiaryNeuron(A_pp_I,spike_trains,E_syn)
% Comment this line if you want to have a different random presynptic spike
% train every time you run the script.
% rand('state',0)

%% Section 1a: Settings for the integrate-and-fire model
% Time step delta [ms] with which the differential equation
%                    dV/dt = - (V-E_L)/RC + I/C
% is evaluated
delta = 0.2;
% Run calculations from t = 0 ms up to t = tstop [ms]
tstop = 1000;
% Time axis
t = 0:delta:tstop;
% Number of time steps
Nt = numel(t);
% Capacitance [nF] and leak resistance [M ohms]
C = 0.5;
R = 40;
% Reversal potential for leak current (i.e., equilibrium potential) [mV]
E_L = -60;
% Threshold for action potential generation [mV]
V_th = -40;
% Peak action potential value [mV] (only used for plotting)
V_spike = 50;
% Reset potential after an action potential [mV]
V_reset = E_L;
% Absolute refractory period [ms]
abs_ref = 5;
% Initialize counter keeping track of the refractory period
refcount = 0;

%% Section 1b: Settings for the synapse(s)
% Reversal potential for synaptic current
% Time constant for alpha function [ms]
tau_alpha1 = 1;
% Maximal conductance [nS]
g_syn_bar1 = 0.05; 
% Alpha function
alpha_func = g_syn_bar1*t/tau_alpha1.*(exp(1-t/tau_alpha1));


%% Section 2: Define the input current with which the neuron is stimulated
% Define constant input current [nA]
Pos_to_neg_ratio = 1;
I = A_pp_I*rand(Nt,1)-1/(Pos_to_neg_ratio+1);

%% Section 4: Compute changes in synaptic conductance due to input spikes
% (a simple convolution as we know the arrival of all input spikes in advance)

for i = 1:size(spike_trains,2)  
    g_syn(:,i) = conv(alpha_func,spike_trains(:,i)); 
end
g_syn = g_syn(1:Nt,:);
%% Section 5: Compute changes in membrane potential due to synaptic current
% Allocate a vector for the membrane potential (V = 0 mV)
V = zeros(Nt,1);
% Put inial value of the membrane potential to E_L
V(1) = E_L;
% Initialize synaptic current
I_syn = zeros(Nt,1);
% Initialize a vector for the spike train of the simulated neuron
% (false, or 0, when there is no spike, true, or 1, when there is a spike)
spike_train_out = false(1,Nt);

% Evaluate dV/dt = - (V-E_L)/RC + - I_syn/C + I/C
for i = 2:Nt
    % If we are not in the refractory period:
    if ~refcount
        % Euler method: V(t+delta) = V(t) + delta*dV/dt
        V(i) = V(i-1) + delta*(-(V(i-1)-E_L)/(R*C) - I_syn(i-1)/C + I(i)/C);
    else
        % Update the counter keeping track of the refractory period
        refcount = refcount - 1;
        % Keep membrane voltage at its reset value during refractory period
        V(i) = V_reset;
    end
    % Compute synaptic current due to the new membrane potential
    for j = 1:25
        if isnan(E_syn(j))
            continue
        end
        I_syn(i) = I_syn(i)+g_syn(i,j)*(V(i)-E_syn(j));
    end
    
    % Generate spike
    if V(i) > V_th
        % Reset membrane potential
        V(i) = V_reset;
        % Set refractory counter
        refcount = round(abs_ref/delta);
        % Save time point of action potential firing for plotting
        spike_train_out(i) = true;
    end
end

N_spikes = sum(spike_train_out);
f_tertiary = N_spikes;
