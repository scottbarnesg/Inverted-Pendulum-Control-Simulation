%% Sim_Inv_Pend
%   Simulates an inverted pendulum.
% Authorship:
%   Scott Barnes
%   The George Washington University
%   MAE 6246: Electromechanical Control Systems
%   Final Project: Inverted Pendulum
% Input Parameters
%   tf: Simulation Termination Time
%   F1: Plant Noise Magnitude
%   F2: Measurement Noise Magnitude
%   y_0: Initial Position
%   dy_0: Initial Velocity
%   theta_0: Initial Angle
%   dtheta_0: Initial Angular Velocity
%   clSys: Closed Loop System
%   l: Pendulum Length
% Return Values
%   y: System Output (Position & Angle)
%   t: Time Vector
%   x: Input

function [y, t, x] = sim_inv_pend(tf, dt, F1, F2, y_0, dy_0, theta_0, dtheta_0, clSys, live, l)
    % Simulate
    t = 0:dt:tf;
    u = wgn(1, size(t, 2), 1);
    x0 = [y_0; dy_0; theta_0; dtheta_0];
    [y, t, x] = lsim(clSys, u, t, x0);
    % Real Time Plot of Simulation
    z1 = zeros(1, size(y, 1));
    y1 = y(:, 1);
    y2 = y1+l*sin(y(:, 2));
    z2 = l*cos(y(:, 2));
    f = figure;
    if live == 't'
        for i = 1:size(y, 1)
            plot([y1(i) y2(i)], [z1(i) z2(i)], '-o');
            hold on;
            rectangle('Position', [y1(i)-0.2*l, z1(i)-0.1*l, 0.4*l, 0.2*l], 'EdgeColor', 'b');
            hold off;
            axis([-2 2 -2 2].*l);
            xlabel('y');
            ylabel('z');
            grid on;
            title('Inverted Pendulum: Real-Time Simulation');
            out1 = ['Theta = ', num2str(y(i, 2)), ' radians'];
            text(-1.9*l, 1.5*l, out1);
            out2 = ['y2 = ', num2str(y2(i)), ' meters'];
            text(-1.9*l, 1.7*l, out2);
            out3 = ['y1 = ', num2str(y1(i)), ' meters'];
            text(-1.9*l, 1.9*l, out3);
            out4 = ['t = ', num2str(t(i)), ' seconds'];
            text(-1.9*l, 1.3*l, out4);
            drawnow;
            sim2gif(f, i, 'Demo.gif');
            % pause(0.0001);
        end
    end
    % Calculate Error
    e_ang = abs(y(:, 2));
    e_pos = abs(y(:, 1));
    
    % Plot Results
    fig1 = figure;
    subplot(2, 1, 1);
    plot(t, y(:, 1));
    axis tight;
    xlabel('Time');
    ylabel('Position');
    title('Cart Position');
    subplot(2, 1, 2);
    plot(t, y(:, 2));
    axis tight;
    xlabel('Time');
    ylabel('Angle');
    title('Pendulum Angle (Radians)');
    fig2 = figure;
    subplot(2, 1, 1);
    plot(t, abs(e_pos));
    axis tight;
    xlabel('Time');
    ylabel('Error');
    title('Magnitude of  Positional Error');
    subplot(2, 1, 2);
    plot(t, abs(e_ang));
    axis tight;
    xlabel('Time');
    ylabel('Error');
    title('Magnitude of  Angular Error');
end