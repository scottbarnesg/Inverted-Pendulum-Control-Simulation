%% is_observable
%   Determines if a linear system is observable
% Authorship:
%   Scott Barnes
%   The George Washington University
%   MAE 6246: Electromechanical Control Systems
%   Final Project: Inverted Pendulum
% Inputs:
%   A: A Matrix of Linear System
%   C: C Matrix of Linear System
% Output:
%   obsrvbl: Boolean value, identifies observabilitys

function obsrvbl = is_observable(A, C)
    Ob = [C' A'*C' (A')^2*C' (A')^3*C'];
    o = rank(Ob);
    if o == size(A, 1)
        obsrvbl = 'true';
        disp('System is observable');
    else
        obsrvbl = 'false';
        disp('System is not observable');
    end
end