% function [twotheta1, Intensity1_lambda1, twotheta2, Intensity2_lambda1, IntensityVoight1, IntensityVoight2,...
%     d_buffer, d_a, d_b] = SL_buffer_input(buffer_YN, buffer_material, Nlayers_buffer,...
%     range, system, N_bilayer, N_EZ_a, N_EZ_b, d_buffer_new, d_a_new, d_b_new, w, Nrelaxation)
close all, clear all, clc
% Simulation der Satellitenpeaks um 200 und 400 peak
% beide Strukturfaktoren im jeweiligen Winkelbereich
% Ni=28;Ti=22;Zr=40;Hf=72;Sn=50;
% f1_V=18.05;   f1_Ni=23.3; f1_TiSn=17.05+42.2; f1_ZrHfSn=0.5*32.84+0.5*63.04+42.2; % für 30° in Twotheta
% f2_V=13.3597; f2_Ni=17.9; f2_TiSn=12.57+33.55; f2_ZrHfSn=0.5*26.17+0.5*52.47+33.55; % für 60° Strukturfaktoren für 1. und 2. Streubereich

%% data for MgO simulation
buffer_YN = 1;
buffer_material = 5;
Nlayers_buffer = 50000;
range(1,1) = 42.5; range(1,2) = 0.01; range(1,3) = 43.5;
% range(2,1) = 60; range(2,2) = 0.2; range(2,3) = 60.2;
system = 1;
N_bilayer = 0;
N_EZ_a = 4.5;
N_EZ_b = 4.5;
d_buffer_new = 4.21*2;
d_a_new = 4.5;
d_b_new = 4.5;
w = 0.1;
Nrelaxation = 0;


%% Parameters needed for the simulation of satellite peaks of 200 and 400 peaks
    % structure factors (from PowderCell) and lattice constants
    % all structure factors are real
    % Vanadium
%         F.V_200 = 18.05;
%         F.V_400 = 13.3597;
%             a.V = 6.2;   %   6.24; %strained value  %d_buffer=6.048;%=unstrained % 2*bulk lattice constant of Vanadium
            
    %% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! %%
        F.V_200 = 53/4; % this is Mgo, not V, but in order not to change all variables, I put the value here
        F.V_400 = 53/4;
            a.V = 4.210/2;

    % TiNiSn
        F.Ni.TNS_200 = 93.14/4;         F.Ni.TNS_400 = 70.03/4;
        F.Sn.TNS_200 = 168.75/4;        F.Sn.TNS_400 = 131.77/4;
        F.Ti.TNS_200 = 68.14/4;         F.Ti.TNS_400 = 49.08/4;
            F.TiSn.TNS_200 = F.Sn.TNS_200 + F.Ti.TNS_200;
            F.TiSn.TNS_400 = F.Sn.TNS_400 + F.Ti.TNS_400;
                a.TNS = 5.94;
                
                
    % ZrHfNiSn
        F.Ni.ZHNS_200 = 93.82/4;         F.Ni.ZHNS_400 = 71.22/4;
        F.Sn.ZHNS_200 = 169.87/4;        F.Sn.ZHNS_400 = 133.60/4;
        F.Zr.ZHNS_200 = 132.19/4;        F.Zr.ZHNS_400 = 104.24/4;
        F.Hf.ZHNS_200 = 253.33/4;        F.Hf.ZHNS_400 = 209.12/4;
            F.ZrHfSn.ZHNS_200 = F.Sn.ZHNS_200 + 0.5*(F.Zr.ZHNS_200 + F.Hf.ZHNS_200);
            F.ZrHfSn.ZHNS_400 = F.Sn.ZHNS_400 + 0.5*(F.Zr.ZHNS_400 + F.Hf.ZHNS_400);
                a.ZHNS = 6.1082;
                
                
    % ZrNiSn
        F.Ni.ZNS_200 = 93.83/4;         F.Ni.ZNS_400 = 71.23/4;
        F.Sn.ZNS_200 = 169.88/4;        F.Sn.ZNS_400 = 133.62/4;
        F.Zr.ZNS_200 = 302.09/4;        F.Zr.ZNS_400 = 237.88/4;
            F.ZrSn.ZNS_200 = F.Sn.ZNS_200 + F.Zr.ZNS_200;
            F.ZrSn.ZNS_400 = F.Sn.ZNS_400 + F.Zr.ZNS_400;
                a.ZNS = 6.11;
                
                
    % HfNiSn
        F.Ni.HNS_200 = 93.71/4;         F.Ni.HNS_400 = 71.02/4;
        F.Sn.HNS_200 = 169.69/4;        F.Sn.HNS_400 = 133.30/4;
        F.Hf.HNS_200 = 253.12/4;        F.Hf.HNS_400 = 208.72/4;
            F.HfSn.HNS_200 = F.Sn.HNS_200 + F.Hf.HNS_200;
            F.HfSn.HNS_400 = F.Sn.HNS_400 + F.Hf.HNS_400;
                a.HNS = 6.08;
            

                
%% choose material system
    switch system
        case 1 % TNS/HNS
            F.a200.mat = F.TiSn.TNS_200;       F.a200.Ni = F.Ni.TNS_200;   
            F.a400.mat = F.TiSn.TNS_400;       F.a400.Ni = F.Ni.TNS_400;  
            
            F.b200.mat = F.HfSn.HNS_200;       F.b200.Ni = F.Ni.HNS_200;   
            F.b400.mat = F.HfSn.HNS_400;       F.b400.Ni = F.Ni.HNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.TNS/4;             d_b = a.HNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
               
        case 2 % HNS/TNS
            F.a200.mat = F.HfSn.HNS_200;       F.a200.Ni = F.Ni.HNS_200;   
            F.a400.mat = F.HfSn.HNS_400;       F.a400.Ni = F.Ni.HNS_400;  

            F.b200.mat = F.TiSn.TNS_200;       F.b200.Ni = F.Ni.TNS_200;   
            F.b400.mat = F.TiSn.TNS_400;       F.b400.Ni = F.Ni.TNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.HNS/4;             d_b = a.TNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
               
        case 3 % TNS/ZHNS
            F.a200.mat = F.TiSn.TNS_200;       F.a200.Ni = F.Ni.TNS_200;   
            F.a400.mat = F.TiSn.TNS_400;       F.a400.Ni = F.Ni.TNS_400;  

            F.b200.mat = F.ZrHfSn.ZHNS_200;    F.b200.Ni = F.Ni.ZHNS_200;   
            F.b400.mat = F.ZrHfSn.ZHNS_400;    F.b400.Ni = F.Ni.ZHNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.TNS/4;             d_b = a.ZHNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
               
        case 4 % ZHNS/TNS
            F.a200.mat = F.ZrHfSn.ZHNS_200;    F.a200.Ni = F.Ni.ZHNS_200;   
            F.a400.mat = F.ZrHfSn.ZHNS_400;    F.a400.Ni = F.Ni.ZHNS_400;  

            F.b200.mat = F.TiSn.TNS_200;       F.b200.Ni = F.Ni.TNS_200;   
            F.b400.mat = F.TiSn.TNS_400;       F.b400.Ni = F.Ni.TNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.ZHNS/4;            d_b = a.TNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
               
        case 5 % HNS/ZHNS
            F.a200.mat = F.HfSn.HNS_200;       F.a200.Ni = F.Ni.HNS_200;   
            F.a400.mat = F.HfSn.HNS_400;       F.a400.Ni = F.Ni.HNS_400;  

            F.b200.mat = F.ZrHfSn.ZHNS_200;    F.b200.Ni = F.Ni.ZHNS_200;   
            F.b400.mat = F.ZrHfSn.ZHNS_400;    F.b400.Ni = F.Ni.ZHNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.HNS/4;            d_b = a.ZHNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
               
        case 6 % ZHNS/HNS
            F.a200.mat = F.ZrHfSn.ZHNS_200;    F.a200.Ni = F.Ni.ZHNS_200;   
            F.a400.mat = F.ZrHfSn.ZHNS_400;    F.a400.Ni = F.Ni.ZHNS_400;  
                
            F.b200.mat = F.HfSn.HNS_200;       F.b200.Ni = F.Ni.HNS_200;   
            F.b400.mat = F.HfSn.HNS_400;       F.b400.Ni = F.Ni.HNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.ZHNS/4;            d_b = a.HNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
            
        case 7 % ZNS/TNS
            F.a200.mat = F.ZrSn.ZNS_200;       F.a200.Ni = F.Ni.ZNS_200;   
            F.a400.mat = F.ZrSn.ZNS_400;       F.a400.Ni = F.Ni.ZNS_400;  
                
            F.b200.mat = F.TiSn.TNS_200;       F.b200.Ni = F.Ni.TNS_200;   
            F.b400.mat = F.TiSn.TNS_400;       F.b400.Ni = F.Ni.TNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.ZNS/4;             d_b = a.TNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
            
        case 8 % TNS/ZNS
            F.a200.mat = F.TiSn.TNS_200;       F.a200.Ni = F.Ni.TNS_200;   
            F.a400.mat = F.TiSn.TNS_400;       F.a400.Ni = F.Ni.TNS_400;  
                
            F.b200.mat = F.ZrSn.ZNS_200;       F.b200.Ni = F.Ni.ZNS_200;   
            F.b400.mat = F.ZrSn.ZNS_400;       F.b400.Ni = F.Ni.ZNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.TNS/4;             d_b = a.ZNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
            
        case 9 % ZNS/HNS
            F.a200.mat = F.ZrSn.ZNS_200;       F.a200.Ni = F.Ni.ZNS_200;   
            F.a400.mat = F.ZrSn.ZNS_400;       F.a400.Ni = F.Ni.ZNS_400;  
               
            F.b200.mat = F.HfSn.HNS_200;       F.b200.Ni = F.Ni.HNS_200;   
            F.b400.mat = F.HfSn.HNS_400;       F.b400.Ni = F.Ni.HNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.ZNS/4;             d_b = a.HNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
            
        case 10 % HNS/ZNS
            F.a200.mat = F.HfSn.HNS_200;       F.a200.Ni = F.Ni.HNS_200;   
            F.a400.mat = F.HfSn.HNS_400;       F.a400.Ni = F.Ni.HNS_400;  
                
            F.b200.mat = F.ZrSn.ZNS_200;       F.b200.Ni = F.Ni.ZNS_200;   
            F.b400.mat = F.ZrSn.ZNS_400;       F.b400.Ni = F.Ni.ZNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.HNS/4;             d_b = a.ZNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
            
        case 11 % ZNS/ZHNS
            F.a200.mat = F.ZrSn.ZNS_200;       F.a200.Ni = F.Ni.ZNS_200;   
            F.a400.mat = F.ZrSn.ZNS_400;       F.a400.Ni = F.Ni.ZNS_400;  
                
            F.b200.mat = F.ZrHfSn.ZHNS_200;    F.b200.Ni = F.Ni.ZHNS_200;   
            F.b400.mat = F.ZrHFSn.ZHNS_400;    F.b400.Ni = F.Ni.ZHNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.ZNS/4;             d_b = a.ZHNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
            
        case 12 % ZHNS/ZNS
            F.a200.mat = F.ZrHfSn.ZHNS_200;    F.a200.Ni = F.Ni.ZHNS_200;   
            F.a400.mat = F.ZrHfSn.ZHNS_400;    F.a400.Ni = F.Ni.ZHNS_400;  
                
            F.b200.mat = F.ZrSn.ZNS_200;       F.b200.Ni = F.Ni.ZNS_200;   
            F.b400.mat = F.ZrSn.ZNS_400;       F.b400.Ni = F.Ni.ZNS_400;   
                if isnan(d_a_new) || isnan(d_b_new)
                    d_a = a.ZHNS/4;            d_b = a.ZNS/4;
                else
                    d_a = d_a_new/4;           d_b = d_b_new/4;
                end
               
    end

%% buffer layer
    switch buffer_material
        case 0
            if isnan(d_buffer_new)
                d_buffer = a.TNS/4;
            else
                d_buffer = d_buffer_new/4;
            end   
            
        case 1 % TNS
            F.first200 = F.TiSn.TNS_200;          F.second200 = F.Ni.TNS_200;
            F.first400 = F.TiSn.TNS_400;          F.second400 = F.Ni.TNS_400;
                if isnan(d_buffer_new)
                    d_buffer = a.TNS/4;
                else
                    d_buffer = d_buffer_new/4;
                end                

        case 2 % HNS
            F.first200 = F.HfSn.HNS_200;          F.second200 = F.Ni.HNS_200;
            F.first400 = F.HfSn.HNS_400;          F.second400 = F.Ni.HNS_400;
                if isnan(d_buffer_new)
                    d_buffer = a.HNS/4;
                else
                    d_buffer = d_buffer_new/4;
                end 
              
        case 3 % ZNS
            F.first200 = F.ZrSn.ZNS_200;          F.second200 = F.Ni.ZNS_200;
            F.first400 = F.ZrSn.ZNS_400;          F.second400 = F.Ni.ZNS_400;
                if isnan(d_buffer_new)
                    d_buffer = a.ZNS/4;
                else
                    d_buffer = d_buffer_new/4;
                end 
              
        case 4 % ZHNS
            F.first200 = F.ZrHfSn.ZHNS_200;       F.second200 = F.Ni.ZHNS_200;
            F.first400 = F.ZrHfSn.ZHNS_400;       F.second400 = F.Ni.ZHNS_400;
                if isnan(d_buffer_new)
                    d_buffer = a.ZHNS/4;
                else
                    d_buffer = d_buffer_new/4;
                end 
              
        case 5 % V
            F.first200 = F.V_200;                 F.second200 = F.V_200;
            F.first400 = F.V_400;                 F.second400 = F.V_400;
                if isnan(d_buffer_new)
                    d_buffer = a.V/4;
                else
                    d_buffer = d_buffer_new/4;
                end 
              
    end

    
% d_buffer=5.94/4 %   6.24; %strained value  %d_buffer=6.048;%=unstrained % 2*bulk lattice constant of Vanadium
% Relaxation length in atomic layers

% d_a=5.94/4; % best: 5.91   Lit: 5.941  Gitterkonstante TiNiSn / 4 = echter Netzebenenabstand der Atomlagen im Realraum
% d_b=6.08/4; % best: 6.17   Lit: 6.070  Gitterkonstante Zr05Hf05NiSn
% d_inter=(d_a+d_b)/2;


    
    d_inter = (d_a + d_b)/2; % average lattice constant
    % absolute value of the strain = (unit cell of buffer layer / unit cell of substrate -1)
    lambda1 = 1.54056;     % wavelength (A)
    lambda2 = 1.54439;
    
    % two theta range
    twotheta_200 = range(1,1):range(1,2):range(1,3); % in degrees
%     twotheta_400 = range(2,1):range(2,2):range(2,3); % in degrees
        twotheta = [twotheta_200];% twotheta_400]; % 200 and 400 range in degrees
        
    twotheta_rad_200 = twotheta_200/180*pi/2; % in radians
%     twotheta_rad_400 = twotheta_400/180*pi/2; % in radians
%         thetar = twotheta/180*pi/2; % 200 and 400 range in radians
    
    % momentum transfer
    dq1_lambda1    = 4*pi/lambda1*sin(twotheta_rad_200);
%     dq2_lambda1    = 4*pi/lambda1*sin(twotheta_rad_400);
%         dq_lambda1 = 4*pi/lambda1*sin(thetar);
        
    dq1_lambda2    = 4*pi/lambda2*sin(twotheta_rad_200);
%     dq2_lambda2    = 4*pi/lambda2*sin(twotheta_rad_400);
%         dq_lambda2 = 4*pi/lambda2*sin(thetar);
        
% Impulsübertrag dq=[dq1 dq2] da in Bereich 1 andere Strukturfaktoren als
% in Bereich 2 benoetigt werden


% load v11fs.dat;
% tt1exp=v11fs(751:1250,1);counts1=v11fs(751:1250,2);counts1n=counts1./max(counts1);
% tt2exp=v11fs(2001:3000,1);counts2=v11fs(2001:3000,2);counts2n=counts2./max(counts2);

%% Construction of the superlattice 
% N_buffer=2;   % Anzahl EZ NiTiSn buffer bzw Halbe Anzahl EZ V Lagen (sollten 16 sein)
% N_bilayer=29; % How many times the bilayer is repeated
if buffer_YN
    N_buffer = Nlayers_buffer;%*10/d_buffer;
else
    N_buffer = 0;
end

% N_EZ_a = thickness_a*10/d_a; % Number of unit cells in layer a; muss in aktueller Version in 1/4 Schritten gewaehlt werden!
% N_EZ_b = thickness_b*10/d_b; % Number of unit cells in layer b
    N_a = N_EZ_a*4; % Number of planes
    N_b = N_EZ_b*4; % Anzahl Netzebenen Achtung > Anzahl EZ
        N = (N_a+N_b)*N_bilayer + N_buffer*4; % total number of planes

    strain = abs(d_buffer/5.95-1);
% 22nm=36EZ TiNiSn darunter + Start mit TiNiSn
% Letzter Term für TiNiSn Buffer
zposition = zeros(1,N+1);  % Ort der Netzebenen
f = zposition; % Scattering factor der Netzebenen
    currentN = 1; 
    currentposition = 0;
        f_a = 1; 
        f_b = 0; % f_a als logische Variable: Netzebene gehoert zu Typ a, f_a=1 oder Typ b f_b=0
% ermoeglicht spaeter Interpretation als interdiffusion und Prozentwerte 0<=f_a<=1
if buffer_YN
    for b = 1:N_buffer*4
        f(currentN) = f_a;   % Strukturfaktor der n-ten Netzebene starte Buffer mit a
       % zposition(currentN)=currentposition+d_a;  % z-Koordinate der n-ten Netzebene am Interface
      %  zposition(currentN)=currentposition+d_buffer+delta*(currentN/(N_buffer*4))^4;
      %  % Relaxation einbauen, Potenzverhalten
      if isnan(Nrelaxation)
          zposition(currentN) = currentposition + d_buffer;
      else
        zposition(currentN) = currentposition + d_buffer + strain*exp(-currentN/Nrelaxation);
      end   % Exponentielle Relaxation einbauen
         %dTemp2(b)=delta*exp(-currentN/Nrelaxation);  %Just saving Relaxation behavior separately
        currentposition = zposition(currentN);  % aktuelle z-Koordinate
        currentN = currentN + 1;
    end
end

if ~N_bilayer == 0 && (~N_EZ_a == 0 || ~N_EZ_b == 0)
    for b = 1:N_bilayer
        f(currentN) = f_a;   % Strukturfaktor der n-ten Netzebene starte mit a
        zposition(currentN) = currentposition + d_inter;  % z-Koordinate der n-ten Netzebene am Interface
        currentposition = zposition(currentN);  % aktuelle z-Koordinate
        currentN = currentN + 1;

        if N_a > 1
           for s = 2:N_a
             f(currentN) = f_a;   % Strukturfaktor der n-ten Netzebene
             zposition(currentN) = currentposition + d_a;  % z-Koordinate der n-ten Netzebene
             currentposition = zposition(currentN);  % aktuelle z-Koordinate
             currentN = currentN + 1;
           end % s 
        end % if

        f(currentN) = f_b;   % Strukturfaktor der n-ten Netzebene jetzt cfs
        zposition(currentN) = currentposition + d_inter;  % z-Koordinate der n-ten Netzebene am Interface
        currentposition = zposition(currentN);  % aktuelle z-Koordinate
        currentN = currentN + 1;

        if N_b > 1
          for c = 2:N_b  % war hier falsch
            f(currentN) = f_b;   % Strukturfaktor der n-ten Netzebene
            zposition(currentN) = currentposition + d_b;  % z-Koordinate der n-ten Netzebene
            currentposition = zposition(currentN);  % aktuelle z-Koordinate
            currentN = currentN + 1;
        end % c    
       end % if

    end % b    
end
% Bis hier Aufbau des Übergitters


Ftot_200_lambda1 = 0; 
Ftot_400_lambda1 = 0; % Ftot = Vektor mit Streukraeften als Fkt des Impulsuebertrages=Winkel
Ftot_200_lambda2 = 0; 
Ftot_400_lambda2 = 0;

% Unten obere Schleife aber nur für V Buffer
if buffer_YN
    for z=1:2:N_buffer*4
    %  Ftot=Ftot+f(z)*exp(i*dq*zposition(z)); 
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z)   * F.first200) * exp(i*dq1_lambda1*zposition(z)); % V  Ebene, EZ zu groß gewählt
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z+1) * F.second200)* exp(i*dq1_lambda1*zposition(z+1)); % V Ebene (unterscheidung eigentlich überflüssig)
%       Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z)   * F.first400) * exp(i*dq2_lambda1*zposition(z)); % V Ebene 
%       Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z+1) * F.second400)* exp(i*dq2_lambda1*zposition(z+1)); % V Ebene 
      
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z)   * F.first200) * exp(i*dq1_lambda2*zposition(z)); % V  Ebene, EZ zu groß gewählt
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z+1) * F.second200)* exp(i*dq1_lambda2*zposition(z+1)); % V Ebene (unterscheidung eigentlich überflüssig)
%       Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z)   * F.first400) * exp(i*dq2_lambda2*zposition(z)); % V Ebene 
%       Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z+1) * F.second400)* exp(i*dq2_lambda2*zposition(z+1)); % V Ebene 
      % In obiger Gleichung ist dq ein Vektor!
      % f(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
      % gleichzeitig f(k,q) Winkelabhaengig sein
    end
end

% So startet Übergitter mit Ti (NiSn)
if ~N_bilayer == 0 && (~N_EZ_a == 0 || ~N_EZ_b == 0)
    for z=1:2:N
    % %  Ftot=Ftot+f(z)*exp(i*dq*zposition(z)); 
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z)   * F.a200.mat + (1-f(z))   * F.b200.mat) * exp(i*dq1_lambda1*zposition(z)); % TiSn bzw. ZrHfSn Ebene
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z+1) * F.a200.Ni  + (1-f(z+1)) * F.b200.Ni)  * exp(i*dq1_lambda1*zposition(z+1)); % Ni Ebene (unterscheidung eigentlich überflüssig)
%       Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z)   * F.a400.mat + (1-f(z))   * F.b400.mat) * exp(i*dq2_lambda1*zposition(z)); % TiSn bzw. ZrHfSn Ebene 
%       Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z+1) * F.a400.Ni  + (1-f(z+1)) * F.b400.Ni)  * exp(i*dq2_lambda1*zposition(z+1)); % Ni Ebene 
      
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z)   * F.a200.mat + (1-f(z))   * F.b200.mat) * exp(i*dq1_lambda2*zposition(z)); % TiSn bzw. ZrHfSn Ebene
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z+1) * F.a200.Ni  + (1-f(z+1)) * F.b200.Ni)  * exp(i*dq1_lambda2*zposition(z+1)); % Ni Ebene (unterscheidung eigentlich überflüssig)
%       Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z)   * F.a400.mat + (1-f(z))   * F.b400.mat) * exp(i*dq2_lambda2*zposition(z)); % TiSn bzw. ZrHfSn Ebene 
%       Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z+1) * F.a400.Ni  + (1-f(z+1)) * F.b400.Ni)  * exp(i*dq2_lambda2*zposition(z+1)); % Ni Ebene 

    %   % In obiger Gleichung ist dq ein Vektor!
    %   % f(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
    %   % gleichzeitig f(k,q) Winkelabhaengig sein
    end
end

Ftotal_lambda1 = [Ftot_200_lambda1];% Ftot_400_lambda1];
Intensity_total_lambda1 = (abs(Ftotal_lambda1)).^2;
Intensity_total_lambda1 = Intensity_total_lambda1/max(Intensity_total_lambda1);
Intensity_200_lambda1 = ((abs(Ftot_200_lambda1)).^2)/max(Intensity_total_lambda1); 
% Intensity_400_lambda1 = ((abs(Ftot_400_lambda1)).^2)/max(Intensity_total_lambda1);

Ftotal_lambda2 = [Ftot_200_lambda2];% Ftot_400_lambda2];
Intensity_total_lambda2 = (abs(Ftotal_lambda2)).^2;
Intensity_total_lambda2 = Intensity_total_lambda2/max(Intensity_total_lambda2);
Intensity_200_lambda2 = ((abs(Ftot_200_lambda2)).^2)/max(Intensity_total_lambda2); 
% Intensity_400_lambda2 = ((abs(Ftot_400_lambda2)).^2)/max(Intensity_total_lambda2);
%plot(twotheta,Intensity)
%figure(1)
%semilogy(twotheta,Intensity+1e-6)

% w = 0.08; %war 0.12 für Übergitter
Ntwothetavalues = max(size(twotheta));

%% Gauss
    IntensityGauss = zeros(1,Ntwothetavalues);

    for k = 1:Ntwothetavalues  % daemlich das hier tausendmal zu berechnen
    center = twotheta(k);
    gauss = 1/w/sqrt(pi/2)*exp(-2/w/w*(twotheta-center).^2);
    IntensityGauss(k) = gauss*Intensity_total_lambda1';
    end

    IntensityGauss = IntensityGauss/max(IntensityGauss);
    IntensityGauss1 = IntensityGauss(1:length(twotheta_200));
    IntensityGauss1 = IntensityGauss1/max(IntensityGauss1);% 1 satz peaks getrennt normieren
%     IntensityGauss2 = IntensityGauss(length(twotheta_200)+1:Ntwothetavalues);


%% Pseudo Voight
       AG  = 7.158e+05; % (6.558e+05, 7.757e+05)
       AG2 = 3.592e+05;%  (3.434e+05, 3.75e+05)
       AL  = 1e+05; % (5.466e+04, 1.453e+05)
       AL2 = 9.735e+04; % (-4.095e+04, 2.357e+05)
       wG  = 0.02842; % (0.02776, 0.02907)
       wG2 = 0.02895; % (0.02818, 0.02972)
       wL  = 0.08467; % (-0.03675, 0.2061)
       wL2 = 0.2164;%  (-0.08882, 0.5217)
%        xc  = 42.93; % (42.93, 42.93)
%        xc2 = 43.04; % (43.04, 43.04)
       y0  = 0.1681; % (-7.704e+04, 7.704e+04)

%%
% Ntwothetavalues = max(size(twotheta));

%% Kalpha1 and Kalpha2 PseudoVoight shape of the peak
IntensityVoight = zeros(1,length(twotheta_200));% + length(twotheta_400));
for i = 1:length(twotheta_200)
    center_200 = twotheta_200(i);
    voight_fit_200 = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((twotheta_200-center_200)/(sqrt(2)*wG)).^2) + (AL/pi)*(wL./((twotheta_200-center_200).^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)))*exp(-((twotheta_200-center_200)/(sqrt(2)*wG2)).^2) + (AL2/pi)*(wL2./((twotheta_200-center_200).^2 + wL2^2));
    IntensityVoight_200(i) = voight_fit_200*(Intensity_200_lambda1' + 0.5*Intensity_200_lambda2');
end

% for i = 1:length(twotheta_400)
%     center_400 = twotheta_400(i);
%     voight_fit_400 = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((twotheta_400-center_400)/(sqrt(2)*wG)).^2) + (AL/pi)*(wL./((twotheta_400-center_400).^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)))*exp(-((twotheta_400-center_400)/(sqrt(2)*wG2)).^2) + (AL2/pi)*(wL2./((twotheta_400-center_400).^2 + wL2^2));
%     IntensityVoight_400(i) = voight_fit_400*(Intensity_400_lambda1' + 0.5*Intensity_400_lambda2');
% end

% Intensities of Pseudo Voight profiles for Ka1 and Ka2 lines of Cu Xray source
IntensityVoight  = [IntensityVoight_200];% IntensityVoight_400];
IntensityVoight  = IntensityVoight/max(IntensityVoight);
% IntensityVoight_200 = IntensityVoight(1:length(twotheta_200));
IntensityVoight_200 = IntensityVoight_200/max(IntensityVoight_200);% 1 satz peaks getrennt normieren
% IntensityVoight_400 = IntensityVoight(length(twotheta_200)+1:length(twotheta_200) + length(twotheta_400));



% -------------------------------------------------------------------------------
% %% plots for MgO
% --------------------------------------------------------------------------------
MgO_meas = importdata('MgO_t2t.txt');

figure('Units', 'centimeters', 'Position', [5 2 35 12]);
subplot(1,2,1)
    plot(twotheta_200, IntensityVoight_200, 'r', 'Linewidth', 1.5); hold on;
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), ':.k');
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    legend(['Pseudo Voight fit' char(10) 'K_{\alpha}_1 + K_{\alpha}_2'], 'Measured data');
    
        
subplot(1,2,2)
    plot(twotheta_200,IntensityGauss1, 'r', 'Linewidth', 1.5); hold on;
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), ':.k');
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on; box on;
    legend('Gaussian broadening', 'Measured data');

