clear all, close all, clc

step_0p01  = importdata('SL_sim_0.01step.txt');
step_0p02  = importdata('SL_sim_0.02step.txt');
step_0p001 = importdata('SL_sim_0.001step.txt');
step_0p002 = importdata('SL_sim_0.002step.txt');

k = 0;
kolory = importdata('\\fs01\holuj$\Dokumente\MATLAB\Functions\kolory.txt');
a = round(256/4)-1;

ColorSet = kolory(1,:);
for i=1:3
    ColorSet = [ColorSet; kolory(a*i,:)];
end

figure('Units', 'centimeters', 'Position', [5 2 24 17]);

    semilogy(step_0p02(:,1), step_0p02(:,2)/max(step_0p02(:,2)), 'Color', ColorSet(1,:), 'Linewidth', 2);    hold on;
    semilogy(step_0p01(:,1), 10*step_0p01(:,2)/max(step_0p01(:,2)), 'Color', ColorSet(2,:), 'Linewidth', 2);
    semilogy(step_0p001(:,1), 100*step_0p001(:,2)/max(step_0p001(:,2)), 'Color', ColorSet(3,:), 'Linewidth', 2);
    semilogy(step_0p002(:,1), 1000*step_0p002(:,2)/max(step_0p002(:,2)), 'Color', ColorSet(4,:), 'Linewidth', 2);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 15);
        grid on; box on;
    set(gca, 'XTick', 25:2:66);
    xlim([25 66]);
    breakxaxis([33 56], 0.005);
        legend(sprintf('calculation step:\n0.02°'), '0.01°', '0.001°', '0.002°');
        