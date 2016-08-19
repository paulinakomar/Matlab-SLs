clear all, close all, clc

SL_200 = importdata('SL_Voight200.txt');
SL_400 = importdata('SL_Voight400.txt');

x200 = SL_200(:,1);
y200 = SL_200(:,2);

x400 = SL_400(:,1);
y400 = SL_400(:,2);

%% 200 peak => 30degrees
[SL200_fit, gof_SL200, output_SL200] = Fit200Peak_fromSimulation(x200,y200);
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
%        xc =        28.8  (28.8, 28.8)
%        xc2 =       28.87  (28.87, 28.87)
%        y0 =      0.0001  (fixed at bound)


%% 200 peak => 62degrees
[SL400_fit, gof_SL400, output_SL400] = Fit400Peak_fromSimulation(x400,y400);
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
%        xc =       60.04  (60.04, 60.04)
%        xc2 =       60.21  (60.21, 60.21)
%        y0 =   6.878e-06  (-0.3898, 0.3898)

%% calculate peak separation
% twotheta = [30 43 62.4];
% width    = [0.06 0.11 0.18];
% p = polyfit(twotheta, width, 1);
% 
% figure('Units', 'centimeters', 'Position', [5 2 20 15]);
%     plot(twotheta, width, 'ko', 'MarkerFaceColor', [0 0 0]); hold on;
%     plot(twotheta, twotheta*p(1)+p(2), 'r', 'linewidth', 1);
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         xlim([25 65]);
%         ylabel( 'K_{\alpha}_1 - K_{\alpha}_2 peaks separation (°)', 'FontSize', 15);
%         ylim([0 0.2]);
%         set(gca, 'fontsize', 13);
%         grid on; box on;
%     text(45, 0.09, 'y = 0.0037\cdotx - 0.0502', 'FontSize', 15);
