clear all, close all, clc

MgO_meas    = importdata('MgO_t2t.txt');
step_0p005  = importdata('step_0.005.txt');
step_0p0025 = importdata('step_0.0025.txt');
step_0p001  = importdata('step_0.001.txt');
step_0p0005 = importdata('step_0.0005.txt');

figure('Units', 'centimeters', 'Position', [5 2 30 22]);
subplot(2,2,1)
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), ':.k'); hold on;
    plot(step_0p0005(:,1), step_0p0005(:,2)/max(step_0p0005(:,2)), 'r', 'Linewidth', 1.5);
        text(43.01, 0.92, sprintf('calculation\nstep = 0.0005°'), 'fontsize', 13);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    
subplot(2,2,2)
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), ':.k'); hold on;
    plot(step_0p001(:,1), step_0p001(:,2)/max(step_0p001(:,2)), 'r', 'Linewidth', 1.5);
        text(43.01, 0.92, sprintf('calculation\nstep = 0.001°'), 'fontsize', 13);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    
subplot(2,2,3)
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), ':.k'); hold on;
    plot(step_0p0025(:,1), step_0p0025(:,2)/max(step_0p0025(:,2)), 'r', 'Linewidth', 1.5);
        text(43.01, 0.92, sprintf('calculation\nstep = 0.0025°'), 'fontsize', 13);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    
subplot(2,2,4)
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), ':.k'); hold on;
    plot(step_0p005(:,1), step_0p005(:,2)/max(step_0p005(:,2)), 'r', 'Linewidth', 1.5);
        text(43.01, 0.92, sprintf('calculation\nstep = 0.005°'), 'fontsize', 13);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;