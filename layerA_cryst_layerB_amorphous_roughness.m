% function [twotheta_200, twotheta_400, IntVoight_200, IntVoight_400,...
%     d_buffer, d_a, d_b, f] = SL_buffer_input(buffer_YN, buffer_material, N_uc_buffer,...
%     range, system, N_bilayer, N_uc_a, N_uc_b, d_buffer_new, d_a_new, d_b_new, Nrelaxation,...
%     intermixing, Nuc_intermixing_a, Nuc_intermixing_b)
close all, clear all, clc
% Simulation der Satellitenpeaks um 200 und 400 peak
% beide Strukturfaktoren im jeweiligen Winkelbereich
% Ni=28;Ti=22;Zr=40;Hf=72;Sn=50;
% f1_V=18.05;   f1_Ni=23.3; f1_TiSn=17.05+42.2; f1_ZrHfSn=0.5*32.84+0.5*63.04+42.2; % für 30° in Twotheta
% f2_V=13.3597; f2_Ni=17.9; f2_TiSn=12.57+33.55; f2_ZrHfSn=0.5*26.17+0.5*52.47+33.55; % für 60° Strukturfaktoren für 1. und 2. Streubereich



% clear f;
%% Parameters needed for the simulation of satellite peaks of 200 and 400 peaks
    % structure factors (from PowderCell) and lattice constants
    % all structure factors are real
lambda=1.541;
% Ni
a_Ni=[12.838 7.292 4.444 2.380];
b_Ni=[3.878  0.257 12.176 66.342];
c_Ni=[1.034  0     0      0];

% Ti
a_Ti=[9.759 7.356 1.699 1.902];
b_Ti=[7.851 0.500 35.634 116.105];
c_Ti=[1.281  0     0      0];

% Sn
a_Sn=[19.189 19.101 4.458 2.466];
b_Sn=[5.830 0.503 26.891 83.957];
c_Sn=[4.782  0     0      0];



    lambda1 = 1.54056;     

    % two theta range
    twotheta = 25:0.01:35; %range(1,1):range(1,2):range(1,3); % in degrees


    twotheta_rad_200 = twotheta/180*pi/2; % in radians
%     twotheta_rad_400 = twotheta_400/180*pi/2; % in radians
        thetar = twotheta/180*pi/2; % 200 and 400 range in radians

    % momentum transfer
    q1_lambda1 = 4*pi/lambda1*sin(twotheta_rad_200);

    f_Ti=0;    f_Ni=0;    f_Sn=0;

for k=1:4
   f_Ti = f_Ti + a_Ti(k)*exp(-b_Ti(k)*q1_lambda1/(4*pi))+c_Ti(k);
   f_Ni = f_Ni + a_Ni(k)*exp(-b_Ni(k)*q1_lambda1/(4*pi))+c_Ni(k);
   f_Sn = f_Sn + a_Sn(k)*exp(-b_Sn(k)*q1_lambda1/(4*pi))+c_Sn(k);
end

f_TiSn = f_Ti + f_Sn;

    a.TNS = 5.94;
    a.HNS = 6.08;

    d_a = a.TNS;             
    d_b = a.HNS;

   
N_a = 33.5; % number of layers
N_b = 26;
M = 5;
s = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
L = d_a*N_a + d_b*N_b + 0.5;

for j = 1:length(s)
    for i = 1:length(q1_lambda1)
        Int_tog(i,j) = (f_TiSn(i)+f_Ni(i)).^2*(sin(N_a*d_a*q1_lambda1(i)/2)/sin(d_a*q1_lambda1(i)/2))^2;

        for r = 1: M-1
        roughness(i,j) = (M-r)*cos(q1_lambda1(i) * r * L) * exp(-r*q1_lambda1(i).^2*s(j)^2);
        end
        roughness(i,j) = roughness(i,j)*2+M;
    end

    for i =1:length(roughness)
        result(i,j) = Int_tog(i,j) * roughness(i,j);
    end
end

figure('units', 'centimeters','Position', [5, 5, 26, 18]);
for i = 1:6
    subplot(2,3,i)
    plot(twotheta, result(:,i), 'k', 'linewidth', 1);
        xlim([28 32]);
        ylim([0 3E7]);
        box on, grid on;
        title(sprintf('s = %0.1f A', s(i)), 'Fontsize', 15);
        xlabel('2\it{}\theta (°)', 'Fontsize', 15);
        ylabel('Intensity (a.u)', 'Fontsize', 15);
        set(gca, 'Fontsize', 15);
end


