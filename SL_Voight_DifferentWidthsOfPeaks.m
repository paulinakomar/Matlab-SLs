clear all, close all, clc

SL_meas_200 = importdata('SL-TH_55_200-2T.txt');
SL_meas_400 = importdata('SL-TH_55_400-2T.txt');
Gauss = importdata('SL_sim_GaussBroadening.txt');
    Gauss_200(:,1) = Gauss(1:find(Gauss(:,1) == 33),1);
    Gauss_200(:,2) = Gauss(1:find(Gauss(:,1) == 33),2);
    Gauss_400(:,1) = Gauss(find(Gauss(:,1) == 33)+1:end,1);
    Gauss_400(:,2) = Gauss(find(Gauss(:,1) == 33)+1:end,2);
% Voight_both200 = importdata('SL_Voight_both200Width.txt');
%     Voight_both200_200(:,1) = Voight_both200(1:find(Voight_both200(:,1) == 33),1);
%     Voight_both200_200(:,2) = Voight_both200(1:find(Voight_both200(:,1) == 33),2);
%     Voight_both200_400(:,1) = Voight_both200(find(Voight_both200(:,1) == 33)+1:end,1);
%     Voight_both200_400(:,2) = Voight_both200(find(Voight_both200(:,1) == 33)+1:end,2);
% Voight_both400 = importdata('SL_Voight_both400Width.txt');
%     Voight_both400_200(:,1) = Voight_both400(1:find(Voight_both400(:,1) == 33),1);
%     Voight_both400_200(:,2) = Voight_both400(1:find(Voight_both400(:,1) == 33),2);
%     Voight_both400_400(:,1) = Voight_both400(find(Voight_both400(:,1) == 33)+1:end,1);
%     Voight_both400_400(:,2) = Voight_both400(find(Voight_both400(:,1) == 33)+1:end,2);
% Voight_MgOWidth = importdata('SL_Voight_bothMgOWidth.txt');
%     Voight_MgOWidth_200(:,1) = Voight_MgOWidth(1:find(Voight_MgOWidth(:,1) == 33),1);
%     Voight_MgOWidth_200(:,2) = Voight_MgOWidth(1:find(Voight_MgOWidth(:,1) == 33),2);
%     Voight_MgOWidth_400(:,1) = Voight_MgOWidth(find(Voight_MgOWidth(:,1) == 33)+1:end,1);
%     Voight_MgOWidth_400(:,2) = Voight_MgOWidth(find(Voight_MgOWidth(:,1) == 33)+1:end,2);
Voight_200_400 = importdata('SL_Voight_200&400Width.txt');
    Voight_200_400_200(:,1) = Voight_200_400(1:find(Voight_200_400(:,1) == 33),1);
    Voight_200_400_200(:,2) = Voight_200_400(1:find(Voight_200_400(:,1) == 33),2);
    Voight_200_400_400(:,1) = Voight_200_400(find(Voight_200_400(:,1) == 33)+1:end,1);
    Voight_200_400_400(:,2) = Voight_200_400(find(Voight_200_400(:,1) == 33)+1:end,2);

% -------------------------------------------------------------------------------
%% plots for SL
%--------------------------------------------------------------------------------


figure('Units', 'centimeters', 'Position', [5 2 18 16]);
subplot(2,1,1) % 
    h1 = semilogy(Gauss_200(:,1), Gauss_200(:,2)/max(Gauss_200(:,2)), 'r', 'Linewidth', 1.5); hold on;
    h2 = semilogy(Gauss_400(:,1), Gauss_400(:,2)/max(Gauss_400(:,2)), 'r', 'Linewidth', 1.5);
    h3 = semilogy(SL_meas_200(:,1), SL_meas_200(:,2)/max(SL_meas_200(:,2)), '.k');
    h4 = semilogy(SL_meas_400(:,1), SL_meas_400(:,2)/max(SL_meas_400(:,2)), '.k');
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        set(gca, 'XTick', 25:2:66);
        xlim([25 66]);
        ylabel( sprintf('Normalized\nintensity (a. u.)'), 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    breakxaxis([33 56], 0.005);
    legend([h1 h3],{sprintf('Gauss broadening'), 'Measured data'}, 'location', 'east');%, 'Measured data');
    
    
    
subplot(2,1,2) % 
%     h1 = semilogy(Voight_MgOWidth_200(:,1), Voight_MgOWidth_200(:,2)/max(Voight_MgOWidth_200(:,2)), 'r', 'Linewidth', 1.5); hold on;
%     h2 = semilogy(Voight_MgOWidth_400(:,1), Voight_MgOWidth_400(:,2)/max(Voight_MgOWidth_400(:,2)), 'r', 'Linewidth', 1.5);
%     h3 = semilogy(SL_meas_200(:,1), SL_meas_200(:,2)/max(SL_meas_200(:,2)), '.k');
%     h4 = semilogy(SL_meas_400(:,1), SL_meas_400(:,2)/max(SL_meas_400(:,2)), '.k');
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         set(gca, 'XTick', 25:2:66);
%         xlim([25 66]);
%         ylabel( sprintf('Normalized\nintensity (a. u.)'), 'FontSize', 15);
%         set(gca, 'fontsize', 13);
%         grid on; box on;
%     legend([h1 h3],{sprintf('Peak width taken from\nMgO (200) peak'), 'Measured data'}, 'location', 'south');%, 'Measured data');
%     breakxaxis([33 56], 0.005);
    
% figure('Units', 'centimeters', 'Position', [5 2 25 30]);       
% subplot(3,1,1) %
%     h1 = semilogy(Voight_both200_200(:,1), Voight_both200_200(:,2)/max(Voight_both200_200(:,2)), 'r', 'Linewidth', 1.5); hold on;
%     h2 = semilogy(Voight_both200_400(:,1), Voight_both200_400(:,2)/max(Voight_both200_400(:,2)), 'r', 'Linewidth', 1.5);
%     h3 = semilogy(SL_meas_200(:,1), SL_meas_200(:,2)/max(SL_meas_200(:,2)), '.k');
%     h4 = semilogy(SL_meas_400(:,1), SL_meas_400(:,2)/max(SL_meas_400(:,2)), '.k');
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         set(gca, 'XTick', 25:2:66);
%         xlim([25 66]);
%         ylabel( sprintf('Normalized\nintensity (a. u.)'), 'FontSize', 15);
%         set(gca, 'fontsize', 13);
%         grid on; box on;
%     legend([h1 h3],{sprintf('Peak width taken from\nTiNiSn (200) peak'), 'Measured data'}, 'location', 'south');%, 'Measured data');
%     breakxaxis([33 56], 0.005);
%     
% 
% subplot(3,1,2) %
%     h1 = semilogy(Voight_both400_200(:,1), Voight_both400_200(:,2)/max(Voight_both400_200(:,2)), 'r', 'Linewidth', 1.5); hold on;
%     h2 = semilogy(Voight_both400_400(:,1), Voight_both400_400(:,2)/max(Voight_both400_400(:,2)), 'r', 'Linewidth', 1.5);
%     h3 = semilogy(SL_meas_200(:,1), SL_meas_200(:,2)/max(SL_meas_200(:,2)), '.k');
%     h4 = semilogy(SL_meas_400(:,1), SL_meas_400(:,2)/max(SL_meas_400(:,2)), '.k');
%         xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
%         set(gca, 'XTick', 25:2:66);
%         xlim([25 66]);
%         ylabel( sprintf('Normalized\nintensity (a. u.)'), 'FontSize', 15);
%         set(gca, 'fontsize', 13);
%         grid on; box on;
%     legend([h1 h3],{sprintf('Peak width taken from\nTiNiSn (400) peak'), 'Measured data'}, 'location', 'south');%, 'Measured data');
%     breakxaxis([33 56], 0.005);
%     
% subplot(3,1,3) %
    h1 = semilogy(Voight_200_400_200(:,1), Voight_200_400_200(:,2)/max(Voight_200_400_200(:,2)), 'r', 'Linewidth', 1.5); hold on;
    h2 = semilogy(Voight_200_400_400(:,1), Voight_200_400_400(:,2)/max(Voight_200_400_400(:,2)), 'r', 'Linewidth', 1.5);
    h3 = semilogy(SL_meas_200(:,1), SL_meas_200(:,2)/max(SL_meas_200(:,2)), '.k');
    h4 = semilogy(SL_meas_400(:,1), SL_meas_400(:,2)/max(SL_meas_400(:,2)), '.k');
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        set(gca, 'XTick', 25:2:66);
        xlim([25 66]);
        ylabel( sprintf('Normalized\nintensity (a. u.)'), 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    breakxaxis([33 56], 0.005);
    legend([h1 h3],{sprintf('Peak widths taken from the\ncorresponding TiNiSn peaks'), 'Measured data'}, 'location', 'east');%, 'Measured data');
    

