function [twotheta_200, twotheta_400, IntVoight_200, IntVoight_400,...
    d_buffer, d_a, d_b, F, thickness_perm_a, thickness_perm_b, d_perm_a, d_perm_b] = SL_buffer_input(buffer_YN,...
    buffer_material, N_uc_buffer, range, system, N_bilayer, N_uc_a, N_uc_b, d_buffer_new,...
    d_a_new, d_b_new, Nrelaxation, intermixing, Nuc_intermixing_a, Nuc_intermixing_b,...
    range_Numberuc_a, range_Numberuc_b, std_dev_normal_thickness_a, std_dev_normal_thickness_b,...
    range_UCSize_a, range_UCSize_b, std_dev_normal_ucSize_a, std_dev_normal_ucSize_b)
% close all, clear all, clc
% Simulation der Satellitenpeaks um 200 und 400 peak
% beide Strukturfaktoren im jeweiligen Winkelbereich
% Ni=28;Ti=22;Zr=40;Hf=72;Sn=50;
% f1_V=18.05;   f1_Ni=23.3; f1_TiSn=17.05+42.2; f1_ZrHfSn=0.5*32.84+0.5*63.04+42.2; % für 30° in Twotheta
% f2_V=13.3597; f2_Ni=17.9; f2_TiSn=12.57+33.55; f2_ZrHfSn=0.5*26.17+0.5*52.47+33.55; % für 60° Strukturfaktoren für 1. und 2. Streubereich

clear F;
%% Parameters needed for the simulation of satellite peaks of 200 and 400 peaks
    % structure factors from http://lamp.tu-graz.ac.at/~hadley/ss1/crystaldiffraction/atomicformfactors/formfactors.php
    % all structure factors are real
divide_uc = 4;

% Cu radiation wavelength (A)
lambda1 = 1.54056;
lambda2 = 1.54439;

% two theta range
twotheta_200 = range(1,1):range(1,2):range(1,3); % in degrees
twotheta_400 = range(2,1):range(2,2):range(2,3); % in degrees

theta_rad_200 = twotheta_200/180*pi/2; % in radians
theta_rad_400 = twotheta_400/180*pi/2; % in radians
    thetar = [theta_rad_200 theta_rad_400];

% momentum transfer
dq1_lambda1 = 4*pi/lambda1*sin(theta_rad_200);
dq2_lambda1 = 4*pi/lambda1*sin(theta_rad_400);
    dq_lambda1 = [dq1_lambda1 dq2_lambda1];

dq1_lambda2 = 4*pi/lambda2*sin(theta_rad_200);
dq2_lambda2 = 4*pi/lambda2*sin(theta_rad_400);
    dq_lambda2 = [dq1_lambda2 dq2_lambda2];

%% Atomic form factors from:
% http://lamp.tu-graz.ac.at/~hadley/ss1/crystaldiffraction/atomicformfactors/formfactors.php
[a, B, disp_corr_1, disp_corr_2, f, density, MassAttenuation, mass] = material_parameters(dq_lambda1, dq_lambda2);

       
%% choose material system
[f.a.mat, f.b.mat, d_a, d_b, mu] = choose_system(system, d_a_new, d_b_new, f, a, divide_uc, mass, MassAttenuation, density);

t = 1e-6;
Int_correction = ((1 + (cos(2*thetar)).^2)./sin(2*thetar)) .* (1 - exp(-2*mu*t./sin(thetar)));


%% buffer layer
[f.buffer_1layer, f.buffer_2layer, d_buffer] = buffer_layer(buffer_material, d_buffer_new, a, divide_uc, f);

    

%% Construction of the superlattice 
d_mean = (d_a + d_b)/2; 
if buffer_YN
    N_planes_buffer = N_uc_buffer*divide_uc;
else
    N_planes_buffer = 0;
end

% dev_uc = 1;
% std_dev_normal = 0.25;

thickness_perm_a = GaussDistributionOfThicknessesInUC(N_uc_a, range_Numberuc_a, std_dev_normal_thickness_a, double(N_bilayer));
thickness_perm_b = GaussDistributionOfThicknessesInUC(N_uc_b, range_Numberuc_b, std_dev_normal_thickness_b, double(N_bilayer));

% figure()
% steps = N_uc_a-range_Numberuc_a:0.25:N_uc_a+range_Numberuc_a
% hist(thickness_perm_a, steps)

N_planes_a = thickness_perm_a*divide_uc; % Number of planes
N_planes_b = thickness_perm_b*divide_uc; % Anzahl Netzebenen Achtung > Anzahl EZ
N_planes   = (sum(N_planes_a) + sum(N_planes_b)) + N_planes_buffer; % total number of planes

d_perm_a = GaussDistributionOfUCSize(divide_uc*d_a, range_UCSize_a+0.2, std_dev_normal_ucSize_a, max(N_planes_a))/divide_uc;
d_perm_b = GaussDistributionOfUCSize(divide_uc*d_b, range_UCSize_b+0.2, std_dev_normal_ucSize_b, max(N_planes_b))/divide_uc;

% absolute value of the strain = (unit cell of buffer layer / unit cell of substrate -1)
strain = d_buffer*divide_uc/5.95-1;

zposition = zeros(1,N_planes+1);  % Ort der Netzebenen
F = zposition; % Scattering factor der Netzebenen;
% zposition is the total thickness of film in A;
% f gives information whether a given layer belongs to material a or b
currentN = 1;
currentposition = 0;
F_a = 1;
F_b = 0; % f_a als logische Variable: Netzebene gehoert zu Typ a, f_a=1 oder Typ b f_b=0
% ermoeglicht spaeter Interpretation als interdiffusion und Prozentwerte 0<=f_a<=1
                 
 if buffer_YN
     for b = 1:N_planes_buffer
         F(currentN) = F_a;
         if isnan(Nrelaxation)
             zposition(currentN) = currentposition + d_buffer;
         else
             zposition(currentN) = currentposition + d_buffer + strain*exp(-currentN/Nrelaxation);
         end
         currentposition = zposition(currentN);  % aktuelle z-Koordinate
         currentN = currentN + 1;
     end
 end

%%
if ~N_bilayer == 0 && (~N_uc_a == 0 || ~N_uc_b == 0)
    for b = 1:N_bilayer
%         F(currentN) = F_a;   % Strukturfaktor der n-ten Netzebene starte mit a
%         zposition(currentN) = currentposition + d_mean;  % z-Koordinate der n-ten Netzebene am Interface
%         currentposition = zposition(currentN);  % aktuelle z-Koordinate
%         currentN = currentN + 1;
        
        if N_planes_a > 0
            for s = 1:N_planes_a(b)
                F(currentN) = F_a;   % Strukturfaktor der n-ten Netzebene
                zposition(currentN) = currentposition + d_perm_a(s);  % z-Koordinate der n-ten Netzebene
                currentposition = zposition(currentN);  % aktuelle z-Koordinate
                currentN = currentN + 1;
            end % s
        end % if
        
%         F(currentN) = F_b;   % Strukturfaktor der n-ten Netzebene jetzt cfs
%         zposition(currentN) = currentposition + d_mean;  % z-Koordinate der n-ten Netzebene am Interface
%         currentposition = zposition(currentN);  % aktuelle z-Koordinate
%         currentN = currentN + 1;
        
        if N_planes_b > 0
            for c = 1:N_planes_b(b)  % war hier falsch
                F(currentN) = F_b;   % Strukturfaktor der n-ten Netzebene
                zposition(currentN) = currentposition + d_perm_b(c);  % z-Koordinate der n-ten Netzebene
                currentposition = zposition(currentN);  % aktuelle z-Koordinate
                currentN = currentN + 1;
            end % c
        end % if
        
        perm = randperm(length(d_perm_a));
        for i = 1:length(perm)
            p = perm(i);
            d_perm_perm_a(i) = d_perm_a(p);
        end
            d_perm_a = d_perm_perm_a;

            clear i perm;
        perm = randperm(length(d_perm_b));
        for i = 1:length(perm)
            p = perm(i);
            d_perm_perm_b(i) = d_perm_b(p);
        end
            d_perm_b = d_perm_perm_b;
        
    end % b
end

%% interdiffusion
F = interdiffusion(intermixing, divide_uc, N_planes_buffer, N_planes_a, N_planes_b, Nuc_intermixing_a, Nuc_intermixing_b, N_bilayer, F);

% Bis hier Aufbau des Übergitters // till here the creation of a grid for the SL 

%%
Ftot_lambda1 = 0; % Ftot = Vektor mit Streukraeften als Fkt des Impulsuebertrages=Winkel
Ftot_lambda2 = 0;

%% Unten obere Schleife aber nur für V Buffer
if buffer_YN
    for z=1:2:N_planes_buffer
    %  Ftot=Ftot+F(z)*exp(i*dq*zposition(z)); 
      Ftot_lambda1 = Ftot_lambda1 + (F(z)   * f.buffer_1layer) .* exp(1i*dq_lambda1*zposition(z)); % V  Ebene, EZ zu groß gewählt
      Ftot_lambda1 = Ftot_lambda1 + (F(z+1) * f.buffer_2layer) .* exp(1i*dq_lambda1*zposition(z+1)); % V Ebene (unterscheidung eigentlich überflüssig)

      Ftot_lambda2 = Ftot_lambda2 + (F(z)   * f.buffer_1layer) .* exp(1i*dq_lambda2*zposition(z)); % V  Ebene, EZ zu groß gewählt
      Ftot_lambda2 = Ftot_lambda2 + (F(z+1) * f.buffer_2layer) .* exp(1i*dq_lambda2*zposition(z+1)); % V Ebene (unterscheidung eigentlich überflüssig)

      % In obiger Gleichung ist dq ein Vektor!
      % F(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
      % gleichzeitig F(k,q) Winkelabhaengig sein
    end
end

%% So startet Übergitter mit Ti (NiSn)
if ~N_bilayer == 0 && (~N_uc_a == 0 || ~N_uc_b == 0)
    for z=1:2:N_planes
    % %  Ftot=Ftot+F(z)*exp(i*dq*zposition(z)); 
      Ftot_lambda1 = Ftot_lambda1 + (F(z)   * f.a.mat + (1-F(z))   * f.b.mat).* exp(1i*dq_lambda1*zposition(z)); % TiSn bzw. ZrHfSn Ebene
      Ftot_lambda1 = Ftot_lambda1 + (F(z+1) * f.Ni    + (1-F(z+1)) * f.Ni)   .* exp(1i*dq_lambda1*zposition(z+1)); % Ni Ebene (unterscheidung eigentlich überflüssig)

      Ftot_lambda2 = Ftot_lambda2 + (F(z)   * f.a.mat + (1-F(z))   * f.b.mat).* exp(1i*dq_lambda2*zposition(z)); % TiSn bzw. ZrHfSn Ebene
      Ftot_lambda2 = Ftot_lambda2 + (F(z+1) * f.Ni    + (1-F(z+1)) * f.Ni)   .* exp(1i*dq_lambda2*zposition(z+1)); % Ni Ebene (unterscheidung eigentlich überflüssig)

    %   % In obiger Gleichung ist dq ein Vektor!
    %   % F(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
    %   % gleichzeitig F(k,q) Winkelabhaengig sein
    end
end

Int_total_lambda1 = (abs(Ftot_lambda1)).^2;
Int_200_lambda1   = Int_total_lambda1(1:length(dq1_lambda1));
Int_400_lambda1   = Int_total_lambda1(length(dq1_lambda1)+1:end);

Int_total_lambda2 = (abs(Ftot_lambda2)).^2;
Int_200_lambda2   = Int_total_lambda2(1:length(dq1_lambda2));
Int_400_lambda2   = Int_total_lambda2(length(dq1_lambda2)+1:end);

       
%% Pseudo Voight parameters for the SL, 200 peak
       AG_200  = 1.62e+05;       AG2_200 = 3.954e+04;
       AL_200  = 4.523e+04;      AL2_200 = 9194;
       wG_200  = 0.06369;        wG2_200 = 0.04053;
       wL_200  = 0.05701;        wL2_200 = 0.1533;
       y0_200  = 0.0009166;
        
%% Pseudo Voight parameters for the SL, 400 peak
       AG_400  = 2.646e+04;      AG2_400 = 5.214e+04;
       AL_400  = 1.437e+04;      AL2_400 = 3.013e+04;
       wG_400  = 0.07409;        wG2_400 = 0.06688;
       wL_400  = 0.08299;        wL2_400 = 0.1215;
       y0_400  = 0.0003979;



%% Kalpha1 and Kalpha2 PseudoVoight shape of the peak
% IntensityVoight = zeros(1,length(twotheta_200) + length(twotheta_400));
IntVoight_200 = zeros(1, length(twotheta_200));
IntVoight_400 = zeros(1, length(twotheta_400));

for j = 1:length(twotheta_200)
    center_200 = twotheta_200(j);
    voight_fit_200 = y0_200 +...
        (AG_200/(wG_200 * sqrt(2 * pi)))* exp(-((twotheta_200 - center_200)/(sqrt(2) * wG_200)).^2) +...
        (AL_200/pi) * (wL_200./((twotheta_200 - center_200).^2 + wL_200^2)) +...
        (AG2_200/(wG2_200 * sqrt(2*pi)))* exp(-((twotheta_200-center_200)/(sqrt(2) * wG2_200)).^2) +...
        (AL2_200/pi) * (wL2_200./((twotheta_200-center_200).^2 + wL2_200^2));
    IntVoight_200(j) = voight_fit_200 * (Int_200_lambda1' + 0.5 * Int_200_lambda2');
end

for j = 1:length(twotheta_400)
    center_400 = twotheta_400(j);
    voight_fit_400 = y0_400 +...
        (AG_400/(wG_400 * sqrt(2 * pi)))* exp(-((twotheta_400 - center_400)/(sqrt(2) * wG_400)).^2) +...
        (AL_400/pi) * (wL_400./((twotheta_400 - center_400).^2 + wL_400^2)) +...
        (AG2_400/(wG2_400 * sqrt(2*pi)))* exp(-((twotheta_400 - center_400)/(sqrt(2) * wG2_400)).^2) +...
        (AL2_400/pi) * (wL2_400./((twotheta_400 - center_400).^2 + wL2_400^2));
    IntVoight_400(j) = voight_fit_400*(Int_400_lambda1' + 0.5*Int_400_lambda2');
end

% Intensities of Pseudo Voight profiles for Ka1 and Ka2 lines of Cu Xray source
% peaks normalized to unity
IntVoight_200 = Int_correction(1:length(twotheta_200)) .* IntVoight_200 /...
    max(Int_correction(1:length(twotheta_200)) .* IntVoight_200);
IntVoight_400 = Int_correction(length(twotheta_200)+1:end) .* IntVoight_400 /...
    max(Int_correction(length(twotheta_200)+1:end) .* IntVoight_400);

% IntVoight_200 = IntVoight_200/max(IntVoight_200);
% IntVoight_400 = IntVoight_400/max(IntVoight_400);

