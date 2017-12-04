% Scott Barnes
% The George Washington University
% MAE 6246: Electromechanical Control Systems
% Final Project: Inverted Pendulum

clc; clear; close all;
%% Define System Paramaters:

m = 3; % Pendulum Mass
g = 9.81; % Gravity
M = 10; % Cart Mass
l = 1.5; % Pendulum Length
F1 = 0.001; % Magnitude of Plant White Noise
F2 = 0.001; % Magnitude of Measurement White Noise

%% Create Open Loop Model
[A, B, C, D] = create_ol_sys(m, M, l, g)

%% Observability & Controllability Matricies
c = is_controllable(A, B);
o = is_observable(A, C);

%% LQR Controller
G = optimal_lqr(A, B, C, D);

%% Create Closed Loop Model
% Noiseless Model
Ac = A-B*G;
clSys = ss(Ac, B, C, D)
% Noisy Model
clSysN = op2cl(A, B, C, D, G, F1, F2);
%% Simulate

% Set Initial Conditions
y_0 = -1.9; % Initial Position
dy_0 = 0; % Intial Velocity
theta_0 = pi/3; % Initial Angle
dtheta_0 = 0; % Initial Angular Velocity

% Select Simulation Parameters
tf = 5+abs(5*cos(theta_0))+M/m % Termination Time
dt = 0.1; % Change in Time (Decreasing dt increases processing time)
% dt = tf/750; % Change in Time (750 Data Points)
live = 't'; % Set Real Time Simulation to 't' (true) or 'f' (false).
% Note: real time simulation is computationally demanding

% Run Simulation
[y, t, x] = sim_inv_pend(tf, dt, F1, F2, y_0, dy_0, theta_0, dtheta_0, clSysN, live, l);