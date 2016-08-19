clear all, close all, clc

TNS_200 = importdata('SL-TH_63_200.txt');
TNS_400 = importdata('SL-TH_63_400.txt');

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
%        AG =       1e+04  (6543, 1.346e+04)
%        AG2 =        9370  (6139, 1.26e+04)
%        AL =        9387  (6268, 1.251e+04)
%        AL2 =        4299  (975.7, 7622)
%        wG =     0.08302  (0.08123, 0.08481)
%        wG2 =      0.0702  (0.06764, 0.07275)
%        wL =     0.08597  (0.07733, 0.0946)
%        wL2 =     0.06258  (0.04722, 0.07793)
%        xc =       30.06  (30.04, 30.07)
%        xc2 =          30  (29.99, 30)
%        y0 =   1.171e-07  (-111.5, 111.5)


%% 200 peak => 62degrees
[TNS400_fit, gof_TNS400, output_TNS400] = Fit400Peak(x400,y400);
%      General model:
%      TNS400_fit(x) = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) 
%                     + (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)
%                     ))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-
%                     xc2)^2 + wL2^2))
%      Coefficients (with 95% confidence bounds):
%        AG =        1904  (1731, 2077)
%        AG2 =        4817  (4622, 5013)
%        AL =        5178  (4922, 5435)
%        AL2 =        3970  (3782, 4158)
%        wG =      0.1218  (0.1178, 0.1257)
%        wG2 =     0.08885  (0.08758, 0.09012)
%        wL =      0.1115  (0.1082, 0.1148)
%        wL2 =       0.125  (0.1167, 0.1333)
%        xc =       62.51  (62.5, 62.51)
%        xc2 =       62.33  (62.33, 62.33)
%        y0 =   3.601e-05  (-13.48, 13.48)

%% plot fits
f1 = figure('Units', 'centimeters', 'Position', [5 2 30 22]);
subplot(2,1,1)
    plot(TNS200_fit, x200, y200);
subplot(2,1,2)
    plot(TNS400_fit, x400, y400);

%% calculate peak separation
twotheta = [30 43 62.4];
width    = [0.06 0.11 0.18];
p = polyfit(twotheta, width, 1);

f2 = figure('Units', 'centimeters', 'Position', [5 2 20 15]);
    plot(twotheta, width, 'ko', 'MarkerFaceColor', [0 0 0]); hold on;
    plot(twotheta, twotheta*p(1)+p(2), 'r', 'linewidth', 1);
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        xlim([25 65]);
        ylabel( 'K_{\alpha}_1 - K_{\alpha}_2 peaks separation (°)', 'FontSize', 15);
        ylim([0 0.2]);
        set(gca, 'fontsize', 13);
        grid on; box on;
    text(45, 0.09, 'y = 0.0037\cdotx - 0.0502', 'FontSize', 15);
