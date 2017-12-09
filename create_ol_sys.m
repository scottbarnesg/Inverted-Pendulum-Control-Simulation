%% create_ol_sys
%   Creates open loop system for inverted pendulum
% Authorship:
%   Scott Barnes
%   The George Washington University
%   MAE 6246: Electromechanical Control Systems
%   Final Project: Inverted Pendulum
% Inputs
%   m: Pendulum Mass
%   M: Cart Mass
%   l: Pendulum Length
%   g: Gravity
%   F: Noise Magnitude
% Outputs
%   A: A matrix of Open Loop System
%   B: B matrix of Open Loop System
%   C: C matrix of Open Loop System
%   D: D matrix of Open Loop System
%   F1: Magnitude of Plant Noise
%   F2: Magnitude of Measurement Noise

function [A, B, C, D, F1, F2] = create_ol_sys(m, M, l, g)
    % Plant
    A = [0 0 1 0; 0 -m*g/M 0 0; 0 0 0 1; 0 g*(M+m)/(m*l) 0 0];
    B = [0; 1/M; 0; -1/(M*l)];
    % Measurement
    C = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    D = [0; 0; 0; 0];
end