clear all, close all, clc

TNS = importdata('SL-TH_101_400_t2t.txt');

x = TNS(:,1);
y = TNS(:,2);

figure('Units', 'centimeters', 'Position', [5 2 20 18]);
    subplot(2,2,1)
        [gauss_fit, gof_gauss, output_gauss]       = TNS_gauss(x,y);
        res_gauss = 0;
        for i = 1:length(output_gauss.residuals)
            res_gauss = res_gauss + (output_gauss.residuals(i))^2;
        end
        res_gauss = sqrt(res_gauss);

    subplot(2,2,2)
        [lorentz_fit, gof_lorentz, output_lorentz] = TNS_Lorentz(x,y);
        res_lorentz = 0;
        for i = 1:length(output_lorentz.residuals)
            res_lorentz = res_lorentz + (output_lorentz.residuals(i))^2;
        end
        res_lorentz = sqrt(res_lorentz);

    subplot(2,2,3)
        [voight_fit, gof_voight, output_voight]    = TNS_Voight(x,y);
        res_voight = 0;
        for i = 1:length(output_voight.residuals)
            res_voight = res_voight + (output_voight.residuals(i))^2;
        end
        res_voight = sqrt(res_voight);

    subplot(2,2,4)
        [pearson_fit, gof_pearson, output_pearson] = TNS_PearsonVII(x,y);
        res_pearson = 0;
        for i = 1:length(output_pearson.residuals)
            res_pearson = res_pearson + (output_pearson.residuals(i))^2;
        end
        res_pearson = sqrt(res_pearson);

    
% figure('Units', 'centimeters', 'Position', [5 2 30 22]);
%     subplot(2,2,1)
%         plot(gauss_fit, x, y, '.k', 'residuals');
%         ylim([-2E4 2E4]);
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'Intensity (a. u.)', 'FontSize', 15);
%         set(gca, 'fontsize', 13);
%         grid on
%         legend('Gaussian fit - residuals', 'Zero Line');
%         text(42.6, -0.9E6, sprintf('Residual sum of squares = %0.4e', res_gauss), 'fontsize', 13);
%     subplot(2,2,2)
%         plot(lorentz_fit, x, y, '.k', 'residuals');
%         ylim([-2E4 2E4]);
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'Intensity (a. u.)', 'FontSize', 15  );
%         set(gca, 'fontsize', 13);
%         grid on
%         legend('Lorentzian fit - residuals', 'Zero Line');
%         text(42.6, -0.9E6, sprintf('Residual sum of squares = %0.4e', res_lorentz), 'fontsize', 13);
%     subplot(2,2,3)
%         plot(voight_fit, x, y, '.k', 'residuals');
%         ylim([-2E4 2E4]);
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'Intensity (a. u.)', 'FontSize', 15  );
%         set(gca, 'fontsize', 13);
%         grid on
%         legend('Pseudo Voight fit - residuals', 'Zero Line');
%         text(42.6, -0.9E6, sprintf('Residual sum of squares = %0.4e', res_voight), 'fontsize', 13);
%     subplot(2,2,4)
%         plot(pearson_fit, x, y, '.k', 'residuals');
%         ylim([-2E4 2E4]);
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         ylabel( 'Intensity (a. u.)', 'FontSize', 15  );
%         set(gca, 'fontsize', 13);
%         grid on
%         legend('Gaussian fit - residuals', 'Zero Line');
%         text(42.6, -0.9E6, sprintf('Residual sum of squares = %0.4e', res_pearson), 'fontsize', 13);