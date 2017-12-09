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

function [y, t, x] = sim_inv_pend(tf, dt, F1, F2, y_0, dy_0, theta_0, dtheta_0, clSys, live, l, G, B)
    % Simulate
    t = 0:dt:tf;
    u = wgn(2, size(t, 2), 1);
    x0 = [y_0; dy_0; theta_0; dtheta_0];
    [y, t, x] = lsim(clSys, u(1, :), t, x0);
    % Real Time Plot of Simulation
    z1 = zeros(1, size(y, 1));
    y1 = y(:, 1);
    y2 = y1+l*sin(y(:, 3));
    z2 = l*cos(y(:, 3));
    % Calculate Input
    inpt = G*x';
    % "Live" Simulation
    if live == 't'
        f = figure;
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
            out5 = ['-Gx = ', num2str(inpt(i)), ' Newtons'];
            text(-1.9*l, 1.1*l, out5);
            drawnow;
%             if (mod(t(i), 0.5) == 0)
%                filename = ['Sim1-', num2str(t(i)), '.fig']; 
%                savefig(f, filename);
%                figure;
%                openfig(filename);
%             end
            sim2gif(f, i, 'SwingUp1.gif');
            % pause(0.001);
        end
    end
    % Calculate Error
    e_ang = abs(y(:, 3));
    e_pos = abs(y(:, 1));
    % Plot Results
    fig1 = figure;
    yyaxis left;
    h1(1:3) = plot(t, y(:, 1), '-', t, y(:, 3), '.-r', [0, tf], [0, 0], '--');
    xlabel('Time (s)');
    ylabel('Magnitude (m, rad)');
    title('Simulation Results');
    yyaxis right;
    h1(4:5) = plot(t, inpt, '-', [0, tf], [0, 0], '--');
    ylabel('Controller Input (N)');
    axis tight;
    legend(h1([1, 2, 4]),'Cart Position (m)', 'Pendulum Angle (rad)', 'Controller Input (N)');
    fig2 = figure;
    yyaxis left;
    h2(1:2) = plot(t, y(:, 2), '-', [0, tf], [0, 0], '--');
    xlabel('Time (s)');
    ylabel('Cart Velocity (m/s)');
    yyaxis right;
    h2(3:4) = plot(t, y(:, 4), '-', [0, tf], [0, 0], '--');
    ylabel('Pendulum Angular Velocity (rad/s)');
    legend(h2([1, 3]), 'Cart Velocity (m/s)', 'Pendulum Angular Velocity (rad/s)');
    fig3 = figure;
    plot(t, F1*u(1, :), t, F2*u(2, :));
    title('Noise');
    xlabel('Time (s)');
    ylabel('Noise Magnitude');
    legend('Plant Noise', 'Measurement Noise');
end