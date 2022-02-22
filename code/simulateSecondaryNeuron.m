% Basic integrate-and-fire neuron 
function [spike_train, f_secondary] = simulateSecondaryNeuron(I_const, plotFlag)

%% Section 1: Settings
% Time step delta [ms] with which the differential equation
%                    dV/dt = - (V-E_L)/RC + I/C
% is evaluated
delta = 0.02;
% Run calculations from t = 0 ms up to t = tstop [ms]
tstop = 1000;
% Time axis
t = 0:delta:tstop;
% Number of time steps
Nt = numel(t);

% Capacitance [nF] (default: 0.5 nF) and 
% leak resistance [M ohms] (default: 40 M ohms)
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

%% Section 2: Define the input current with which the neuron is stimulated
%       If you want to use a constant input current, put flag = 1. 
%       If you want to use a sinusoidal input current, put flag = 2.
%       If you want to use a random input current, put flag = 3.
flag = 1;
if flag == 1
    % Define constant input current [nA] (default: 10 nA)
    I = I_const*ones(Nt,1);
elseif flag == 2
    % Frequency of the sinusoidal input current [Hz] (default: 2 Hz)
    f_I = 2;
    % Amplitude of the sinusoidal input current [nA] (default: 1.25 nA)
    A_I = 1.25;
    % Sinusoidal input current (factor 1000 to compensate for t being in ms)
    I = A_I*sin(2*pi*t/1000*f_I);
elseif flag == 3
    % Peak-to-peak variation of input current [nA] (default: 50 nA)
    A_pp_I = 50;
    % Ratio between positive and negative current injection (default: 1)
    Pos_to_neg_ratio = 1;
    % Random input current [nA]
    I = A_pp_I*( rand(Nt,1) - 1/(Pos_to_neg_ratio+1));
end

%% Section 3: Compute changes in membrane potential due to input current
% Allocate a vector for the membrane potential (V = 0 mV)
V = zeros(Nt,1);
% Put inial value of the membrane potential to E_L
V(1) = E_L;
% Initialize a vector for the spike train of the simulated neuron
% (false, or 0, when there is no spike, true, or 1, when there is a spike)
spike_train = false(1,Nt);

% Evaluate dV/dt = - (V-E_L)/RC + I/C
for i = 2:Nt
    % If we are not in the refractory period:
    if refcount == 0
        % Euler method: V(t+delta) = V(t) + delta*dV/dt
        V(i) = V(i-1) + delta*(-(V(i-1)-E_L)/(R*C) + I(i-1)/C);
    % Else if we are in the refractory period:
    else
        % Countdown of how many time steps that are left of the refractory
        % period
        refcount = refcount - 1;
        % Keep membrane voltage at its reset value during refractory period
        V(i) = V_reset;
    end
    
    % Check whether threshold for action potential generation is crossed:
    if V(i) > V_th
        % Reset membrane voltage
        V(i) = V_reset;
        % Set refractory counter to the number of time steps corresponding
        % to the refractory period
        refcount = round(abs_ref/delta);
        % Save time point of action potential firing for plotting
        spike_train(i) = true;
    end
end

N_spikes = sum(spike_train);
f_secondary = (tstop*10^-3)/N_spikes;

%% Section 4: Plot results
if plotFlag == 1
    figure('Name','The integrate-and-fire neuron');
    % Plot input current over time
    subplot(411);
    plot(t,I);
    ylabel('Input current (nA)');
    axis([0 tstop min(0,1.1*min(I)) 1.1*max(I)])
    % Plot membrane potential over time
    subplot(4,1,2:4);
    hold on;
    % Plot membrane potential
    plot(t,V);
    % Indicate time points of action potential firing
    line([t(spike_train);t(spike_train)],...
         [V_th*ones(1,sum(spike_train));V_spike*ones(1,sum(spike_train))],...
         'Color','c');
    xlabel('Time (ms)');
    ylabel('Membrane potential (mV)');
    if any(spike_train)
        legend('Membrane potential','Action potential firing');
    end

end
