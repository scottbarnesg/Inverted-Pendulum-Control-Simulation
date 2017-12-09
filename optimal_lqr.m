%% Optimal_LQR
%   Generates Optimal LQR Controller. This was designed for an inverted
%   pendulum, but is applicable to all LQR Controllers.
% Authorship:
%   Scott Barnes
%   The George Washington University
%   MAE 6246: Electromechanical Control Systems
%   Final Project: Inverted Pendulum
% Inputs
%   A: A matrix of Open Loop System
%   B: B matrix of Open Loop System
%   C: C matrix of Open Loop System
%   D: D matrix of Open Loop System
% Outputs
%   G: Optimal LQR Controller

function G = optimal_lqr(A, B, C, D)
    format long g
    Q = C'*C; % Equally Weighs Angle and Position
    % Q = [100 0 0 0; 1 0 0 0; 0 0 0 0; 0 0 0 0]; % Emphasives Cart Position
    % Q(3,3) = 100;
    R = 1;
    H = [A -B*inv(R)*B'; -Q -A'];
    [V, E] = eig(H);
    ind = 0;
    for i = 1:size(E, 1)
        if real(E(i, i)) < 0
            ind = ind + 1;
            T(:, ind) = V(:, i);
        end
    end
    T1 = T(1:4, :);
    T2 = T(5:8, :);
    M = T2*inv(T1);
    G = real(inv(R)*B'*M)
    % K = lqr(A, B, Q, R) Uncomment to verify with MATLAB's LQR optimizer
    disp('The optimal control law was found to be:');
    disp(G);
end