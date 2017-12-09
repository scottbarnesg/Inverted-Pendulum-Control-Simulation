%% Sim_Inv_Pend
%   Adapts inverted pendulum to add noise. We 
% Authorship:
%   Scott Barnes
%   The George Washington University
%   MAE 6246: Electromechanical Control Systems
%   Final Project: Inverted Pendulum

function clSysN = op2cl_noise(Ac, B, C, D, F1, F2)
    F_1 = [F1; F1; F1; F1];
    F_2 = [F2; F2; F2; F2];
    clSysN = ss(Ac, F_1, C, F_2);
end