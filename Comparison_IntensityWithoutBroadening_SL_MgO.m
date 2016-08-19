clear all, close all, clc

MgO_0p001 = importdata('MgO_intensityWithoutBroadening_0.001.txt');
MgO_0p01  = importdata('MgO_intensityWithoutBroadening_0.01.txt');
SL_0p001  = importdata('SL_IntensityWithoutBroadening_0.001.txt');
    SL_0p001_200(:,1) = SL_0p001(1:find(SL_0p001(:,1) == 33),1);
    SL_0p001_200(:,2) = SL_0p001(1:find(SL_0p001(:,1) == 33),2);
    SL_0p001_400(:,1) = SL_0p001(find(SL_0p001(:,1) == 33)+1:end,1);
    SL_0p001_400(:,2) = SL_0p001(find(SL_0p001(:,1) == 33)+1:end,2);
SL_0p01   = importdata('SL_IntensityWithoutBroadening_0.01.txt');
    SL_0p01_200(:,1) = SL_0p01(1:find(SL_0p01(:,1) == 33),1);
    SL_0p01_200(:,2) = SL_0p01(1:find(SL_0p01(:,1) == 33),2);
    SL_0p01_400(:,1) = SL_0p01(find(SL_0p01(:,1) == 33)+1:end,1);
    SL_0p01_400(:,2) = SL_0p01(find(SL_0p01(:,1) == 33)+1:end,2);




%% plots
figure('Units', 'centimeters', 'Position', [5 2 30 22]);
subplot(2,2,1)
    semilogy(MgO_0p001(:,1), MgO_0p001(:,2)/max(MgO_0p001(:,2)), 'r', 'Linewidth', 1.5);
        text(43.15, 0.15, sprintf('MgO (200) peak\ncalculation\nstep = 0.001°'), 'fontsize', 13);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    
subplot(2,2,2)
    semilogy(MgO_0p01(:,1), MgO_0p01(:,2)/max(MgO_0p01(:,2)), 'r', 'Linewidth', 1.5);
        text(43.15, 0.15, sprintf('MgO (200) peak\ncalculation\nstep = 0.01°'), 'fontsize', 13);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
            
subplot(2,2,3)
    semilogy(SL_0p001_200(:,1), SL_0p001_200(:,2)/max(SL_0p001_200(:,2)), 'r', 'Linewidth', 1.5); hold on;
    semilogy(SL_0p001_400(:,1), SL_0p001_400(:,2)/max(SL_0p001_400(:,2)), 'r', 'Linewidth', 1.5);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        set(gca, 'XTick', 24:2:66);
        xlim([25 66]);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
        h1 = text(26, 1E-7, sprintf('SL calculation\nstep = 0.001°'), 'fontsize', 13);
        uistack(h1, 'top');
%         uistack(h2, 'bottom');
        breakxaxis([33 56], 0.005);
    
subplot(2,2,4)
    semilogy(SL_0p01_200(:,1), SL_0p01_200(:,2)/max(SL_0p01_200(:,2)), 'r', 'Linewidth', 1.5); hold on;
    semilogy(SL_0p01_400(:,1), SL_0p01_400(:,2)/max(SL_0p01_400(:,2)), 'r', 'Linewidth', 1.5);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        set(gca, 'XTick', 24:2:66);
        xlim([25 66]);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
        h2 = text(26, 1E-7, sprintf('SL calculation\nstep = 0.01°'), 'fontsize', 13);
        uistack(h2, 'top');
        breakxaxis([33 56], 0.005);
