clear all, close all, clc

%% measured data
meas_200 = importdata('SL-TH_101_200_t2t.txt');
meas_400 = importdata('SL-TH_101_400_t2t.txt');

%% TiNiSn film
    TNS_200 = importdata('TNS_200_1u_sim_TNSPeakWidth.txt');
    TNS_400 = importdata('TNS_400_1u_sim_TNSPeakWidth.txt');
    
    x200 = TNS_200(:,1);
    y200 = TNS_200(:,2);

    x400 = TNS_400(:,1);
    y400 = TNS_400(:,2);

    %% 200 peak => 30degrees
    [TNS200_fit, gof_TNS200, output_TNS200] = Fit200Peak(x200,y200);
        %      General model:
        %      TNS200_fit(x) = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) 
        %                     + (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)
        %                     ))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-
        %                     xc2)^2 + wL2^2))
        %      Coefficients (with 95% confidence bounds):
        %        AG =    1.62e+05  (5.944e+04, 2.646e+05)
        %        AG2 =   3.954e+04  (-4.276e+04, 1.218e+05)
        %        AL =   4.523e+04  (4597, 8.587e+04)
        %        AL2 =        9194  (-2.12e+04, 3.959e+04)
        %        wG =     0.06369  (0.05516, 0.07223)
        %        wG2 =     0.04053  (0.0205, 0.06056)
        %        wL =     0.05701  (0.03864, 0.07539)
        %        wL2 =      0.1533  (-1.189, 1.496)
        %        xc =       30.1152  (30.09, 30.14)
        %        xc2 =       30.0581  (30.04, 30.08)
        %        y0 =   0.0009166  (-2.248e+04, 2.248e+04)


    %% 400 peak => 62degrees
    [TNS400_fit, gof_TNS400, output_TNS400] = Fit400Peak(x400,y400);
        %      General model:
        %      TNS400_fit(x) = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) 
        %                     + (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)
        %                     ))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-
        %                     xc2)^2 + wL2^2))
        %      Coefficients (with 95% confidence bounds):
        %        AG =   2.646e+04  (2.46e+04, 2.832e+04)
        %        AG2 =   5.214e+04  (4.793e+04, 5.635e+04)
        %        AL =   1.437e+04  (1.163e+04, 1.71e+04)
        %        AL2 =   3.013e+04  (2.685e+04, 3.341e+04)
        %        wG =     0.07409  (0.07151, 0.07667)
        %        wG2 =     0.06688  (0.06594, 0.06782)
        %        wL =     0.08299  (0.07258, 0.09341)
        %        wL2 =      0.1215  (0.09047, 0.1526)
        %        xc =       62.7163  (62.71, 62.72)
        %        xc2 =       62.5432  (62.54, 62.54)
        %        y0 =   0.0003979  (-1195, 1195)


    %% calculate peak separation
    twotheta = [30 43 62.4];
    width    = [0.0571 0.1114 0.1730];
    MgObased = [0.0731 NaN    0.1648];
    TNSbased = [0.0734 NaN    0.1714];
    
    p = polyfit(twotheta, width, 1);

    f2 = figure('Units', 'centimeters', 'Position', [5 2 20 15]);
        plot(twotheta, width, 'ko', 'MarkerFaceColor', [0 0 0]); hold on;
        plot(twotheta, MgObased, 'bo', 'MarkerFaceColor', [0 0 1]);
        plot(twotheta, TNSbased, 'ro', 'MarkerFaceColor', [1 0 0]);
        plot(twotheta, twotheta*p(1)+p(2), 'r', 'linewidth', 1);
            xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
            xlim([25 65]);
            ylabel( 'K_{\alpha}_1 - K_{\alpha}_2 peaks separation (°)', 'FontSize', 15);
            ylim([0 0.2]);
            set(gca, 'fontsize', 13);
            grid on; box on;
        text(45, 0.09, 'y = 0.0037\cdotx - 0.0502', 'FontSize', 15);

    
%% TNS simulation with MgO peak widths

    TNS_MgO_200 = importdata('TNS_200_1u_sim_MgOPeakWidth.txt');
    TNS_MgO_400 = importdata('TNS_400_1u_sim_MgOPeakWidth.txt');

    TNS_MgO_x200 = TNS_MgO_200(:,1);
    TNS_MgO_y200 = TNS_MgO_200(:,2);

    TNS_MgO_x400 = TNS_MgO_400(:,1);
    TNS_MgO_y400 = TNS_MgO_400(:,2);

    %% 200 peak => 30degrees
    [TNS_MgO_200_fit, gof_TNS_MgO_200, output_TNS_MgO_200] = Fit200Peak_fromSimulation(TNS_MgO_x200,TNS_MgO_y200);
        %      General model:
        %      SL200_fit(x) = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) +
        %                      (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)
        %                     ))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-
        %                     xc2)^2 + wL2^2))
        %      Coefficients (with 95% confidence bounds):
        %        AG =     0.04037  (0.04018, 0.04056)
        %        AG2 =     0.01982  (0.01973, 0.01991)
        %        AL =     0.00567  (0.005284, 0.006057)
        %        AL2 =     0.01486  (0.01437, 0.01534)
        %        wG =     0.02949  (0.02943, 0.02956)
        %        wG2 =     0.02902  (0.02893, 0.02911)
        %        wL =      0.1234  (0.1104, 0.1364)
        %        wL2 =         0.2  (fixed at bound)
        %        xc =        28.7996  (28.8, 28.8)
        %        xc2 =       28.8727  (28.87, 28.87)
        %        y0 =      0.0001  (fixed at bound)


    %% 400 peak => 62degrees
    [TNS_MgO_400_fit, gof_TNS_MgO_400, output_TNS_MgO_400] = Fit400Peak_fromSimulation(TNS_MgO_x400,TNS_MgO_y400);
        %      General model:
        %      SL400_fit(x) = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) +
        %                      (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)
        %                     ))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-
        %                     xc2)^2 + wL2^2))
        %      Coefficients (with 95% confidence bounds):
        %        AG =     0.06961  (0.06948, 0.06975)
        %        AG2 =       0.035  (0.03489, 0.0351)
        %        AL =     0.03881  (0.007511, 0.0701)
        %        AL2 =    0.003714  (-0.9426, 0.9501)
        %        wG =     0.02945  (0.02943, 0.02948)
        %        wG2 =     0.02948  (0.02943, 0.02953)
        %        wL =      0.2258  (0.1167, 0.3349)
        %        wL2 =         0.5  (-49.35, 50.35)
        %        xc =       60.0414  (60.04, 60.04)
        %        xc2 =       60.2062  (60.21, 60.21)
        %        y0 =   6.878e-06  (-0.3898, 0.3898)

        
%% TNS Gauss peak widths
    TNS_Gauss_200 = importdata('TNS_200_1u_sim_GaussBroadening.txt');
    TNS_Gauss_400 = importdata('TNS_400_1u_sim_GaussBroadening.txt');

    TNS_Gauss_x200 = TNS_Gauss_200(:,1);
    TNS_Gauss_y200 = TNS_Gauss_200(:,2);

    TNS_Gauss_x400 = TNS_Gauss_400(:,1);
    TNS_Gauss_y400 = TNS_Gauss_400(:,2);
        
%% plot fits
    f1 = figure('Units', 'centimeters', 'Position', [5 2 16 16]);
    subplot(2,2,1)
        plot(TNS_Gauss_x200, TNS_Gauss_y200, 'r', 'Linewidth', 2); hold on;
        plot(meas_200(:,1), meas_200(:,2)/max(meas_200(:,2)), '.k');
        xlim([29.6 30.6]);
        set(gca,'xtick',29.6:0.5:30.6);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'I/I_{max}', 'FontSize', 15);
        ylim([0 1]);
        set(gca, 'fontsize', 13);
        grid on; box on;
%         legend(sprintf('Gauss broadening'), 'measured data');
        annotation('textbox',[0.30 0.83 0.1 0.1], 'string', sprintf('(002)\nTiNiSn'),...
            'linestyle', 'none', 'fontsize', 13);
    subplot(2,2,2)
        plot(TNS_Gauss_x400, TNS_Gauss_y400, 'r', 'Linewidth', 2); hold on;
        plot(meas_400(:,1), meas_400(:,2)/max(meas_400(:,2)), '.k');
        xlim([61.8 63]);
        set(gca,'xtick',61.8:0.4:63, 'yticklabel',{''});
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'I/I_{max}', 'FontSize', 15);
        ylim([0 1]);
        set(gca, 'fontsize', 13);
        grid on; box on;
        legend(sprintf('Gauss broadening\n\\sigma=0.2°'), 'measured data');
        annotation('textbox',[0.58 0.83 0.1 0.1], 'string', sprintf('(004)\nTiNiSn'),...
            'linestyle', 'none', 'fontsize', 13);
    
%     subplot(3,2,3)
%         plot(TNS_MgO_x200, TNS_MgO_y200, 'r', 'Linewidth', 2); hold on;
%         plot(meas_200(:,1), meas_200(:,2)/max(meas_200(:,2)), '.k');
%         xlim([29.6 30.6]);
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'Intensity (a. u)', 'FontSize', 15);
%         ylim([0 1]);
%         set(gca, 'fontsize', 13);
%         grid on; box on;
%         legend(sprintf('peak broadened by\nMgO (200) peak width'), 'measured data');
%     subplot(3,2,4)
%         plot(TNS_MgO_x400, TNS_MgO_y400, 'r', 'Linewidth', 2); hold on;
%         plot(meas_400(:,1), meas_400(:,2)/max(meas_400(:,2)), '.k');
%         xlim([61.8 63]);
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'Intensity (a. u)', 'FontSize', 15);
%         ylim([0 1]);
%         set(gca, 'fontsize', 13);
%         grid on; box on;
%         legend(sprintf('peak broadened by\nMgO (200) peak width'), 'measured data');

        
    subplot(2,2,3)
        plot(x200, y200, 'r', 'Linewidth', 2); hold on;
        plot(meas_200(:,1), meas_200(:,2)/max(meas_200(:,2)), '.k');
        xlim([29.6 30.6]);
        set(gca,'xtick',29.6:0.5:30.6);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'I/I_{max}', 'FontSize', 15);
        ylim([0 1]);
        set(gca, 'fontsize', 13);
        grid on; box on;
%         legend(sprintf('two pseudo Voigt curves\nfitted to (200) TiNiSn peak'), 'measured data');
        annotation('textbox',[0.30 0.36 0.1 0.1], 'string', sprintf('(002)\nTiNiSn'),...
            'linestyle', 'none', 'fontsize', 13);
    subplot(2,2,4)
        plot(x400, y400, 'r', 'Linewidth', 2); hold on;
        plot(meas_400(:,1), meas_400(:,2)/max(meas_400(:,2)), '.k');
        xlim([61.8 63]);
        set(gca,'xtick',61.8:0.4:63, 'yticklabel',{''});
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'I/I_{max}', 'FontSize', 15);
        ylim([0 1]);
        set(gca, 'fontsize', 13);
        grid on; box on;
        legend(sprintf('pseudo Voigt\nbroadening'), 'measured data');
        annotation('textbox',[0.58 0.36 0.1 0.1], 'string', sprintf('(004)\nTiNiSn'),...
            'linestyle', 'none', 'fontsize', 13);

