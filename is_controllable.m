%% is_controllable
%   Determines if a linear system is controllable. 
% Authorship:
%   Scott Barnes
%   The George Washington University
%   MAE 6246: Electromechanical Control Systems
%   Final Project: Inverted Pendulum
% Inputs:
%   A: A Matrix of Linear System
%   B: B Matrix of Linear System
% Output:
%   cntrble: Boolean value, identifies controllability

function cntrble = is_controllable(A, B)
    Cr = [B A*B A^2*B A^3*B];
    c = rank(Cr);
    if c == size(A, 1)
        cntrble = 'true';
        disp('System is controllable');
    else
        cntrble = 'false';
        disp('System is not controllable');
    end
end