function [twotheta_200, twotheta_400, IntVoight_200, IntVoight_400,...
    d_buffer, d_a, d_b] = SL_buffer_input(buffer_YN, buffer_material, N_uc_buffer,...
    range, system, N_bilayer, N_uc_a, N_uc_b, d_buffer_new, d_a_new, d_b_new, Nrelaxation)

% close all, clear all, clc
% Simulation der Satellitenpeaks um 200 und 400 peak
% beide Strukturfaktoren im jeweiligen Winkelbereich
% Ni=28;Ti=22;Zr=40;Hf=72;Sn=50;
% f1_V=18.05;   f1_Ni=23.3; f1_TiSn=17.05+42.2; f1_ZrHfSn=0.5*32.84+0.5*63.04+42.2; % für 30° in Twotheta
% f2_V=13.3597; f2_Ni=17.9; f2_TiSn=12.57+33.55; f2_ZrHfSn=0.5*26.17+0.5*52.47+33.55; % für 60° Strukturfaktoren für 1. und 2. Streubereich


%% Parameters needed for the simulation of satellite peaks of 200 and 400 peaks
    % structure factors (from PowderCell) and lattice constants
    % all structure factors are real
divide_uc = 4;
% Vanadium
    F.V_200 = 18.05;
    F.V_400 = 13.3597;
        a.V = 6.2;   %   6.24; %strained value  %d_buffer=6.048;%=unstrained % 2*bulk lattice constant of Vanadium


% TiNiSn
    F.Ni.TNS_200 = 93.14/divide_uc;         
    F.Ni.TNS_400 = 70.03/divide_uc;

    F.Sn.TNS_200 = 168.75/divide_uc;        
    F.Sn.TNS_400 = 131.77/divide_uc;

    F.Ti.TNS_200 = 68.14/divide_uc;         
    F.Ti.TNS_400 = 49.08/divide_uc;

        F.TiSn.TNS_200 = F.Sn.TNS_200 + F.Ti.TNS_200;
        F.TiSn.TNS_400 = F.Sn.TNS_400 + F.Ti.TNS_400;
            a.TNS = 5.94;


% ZrHfNiSn
    F.Ni.ZHNS_200 = 93.82/divide_uc;         
    F.Ni.ZHNS_400 = 71.22/divide_uc;

    F.Sn.ZHNS_200 = 169.87/divide_uc;        
    F.Sn.ZHNS_400 = 133.60/divide_uc;

    F.Zr.ZHNS_200 = 132.19/divide_uc;        
    F.Zr.ZHNS_400 = 104.24/divide_uc;

    F.Hf.ZHNS_200 = 253.33/divide_uc;        
    F.Hf.ZHNS_400 = 209.12/divide_uc;

        F.ZrHfSn.ZHNS_200 = F.Sn.ZHNS_200 + 0.5*(F.Zr.ZHNS_200 + F.Hf.ZHNS_200);
        F.ZrHfSn.ZHNS_400 = F.Sn.ZHNS_400 + 0.5*(F.Zr.ZHNS_400 + F.Hf.ZHNS_400);
            a.ZHNS = 6.1082;


% ZrNiSn
    F.Ni.ZNS_200 = 93.83/divide_uc;         
    F.Ni.ZNS_400 = 71.23/divide_uc;
    
    F.Sn.ZNS_200 = 169.88/divide_uc;        
    F.Sn.ZNS_400 = 133.62/divide_uc;
    
    F.Zr.ZNS_200 = 302.09/divide_uc;        
    F.Zr.ZNS_400 = 237.88/divide_uc;
    
        F.ZrSn.ZNS_200 = F.Sn.ZNS_200 + F.Zr.ZNS_200;
        F.ZrSn.ZNS_400 = F.Sn.ZNS_400 + F.Zr.ZNS_400;
            a.ZNS = 6.11;


% HfNiSn
    F.Ni.HNS_200 = 93.71/divide_uc;         
    F.Ni.HNS_400 = 71.02/divide_uc;
    
    F.Sn.HNS_200 = 169.69/divide_uc;        
    F.Sn.HNS_400 = 133.30/divide_uc;
    
    F.Hf.HNS_200 = 253.12/divide_uc;        
    F.Hf.HNS_400 = 208.72/divide_uc;
    
        F.HfSn.HNS_200 = F.Sn.HNS_200 + F.Hf.HNS_200;
        F.HfSn.HNS_400 = F.Sn.HNS_400 + F.Hf.HNS_400;
            a.HNS = 6.08;
            

                
%% choose material system
switch system
    case 1 % TNS/HNS
        F.a200.mat = F.TiSn.TNS_200;       
        F.a200.Ni  = F.Ni.TNS_200;   

        F.a400.mat = F.TiSn.TNS_400;       
        F.a400.Ni  = F.Ni.TNS_400;  

        F.b200.mat = F.HfSn.HNS_200;       
        F.b200.Ni  = F.Ni.HNS_200;   

        F.b400.mat = F.HfSn.HNS_400;       
        F.b400.Ni  = F.Ni.HNS_400; 

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.TNS/divide_uc;             
                d_b = a.HNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 2 % HNS/TNS
        F.a200.mat = F.HfSn.HNS_200;       
        F.a200.Ni  = F.Ni.HNS_200;   

        F.a400.mat = F.HfSn.HNS_400;       
        F.a400.Ni  = F.Ni.HNS_400;  

        F.b200.mat = F.TiSn.TNS_200;       
        F.b200.Ni  = F.Ni.TNS_200;   

        F.b400.mat = F.TiSn.TNS_400;       
        F.b200.Ni  = F.Ni.TNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.HNS/divide_uc;             
                d_b = a.TNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 3 % TNS/ZHNS
        F.a200.mat = F.TiSn.TNS_200;       
        F.a200.Ni  = F.Ni.TNS_200;   

        F.a400.mat = F.TiSn.TNS_400;       
        F.a400.Ni  = F.Ni.TNS_400;  

        F.b200.mat = F.ZrHfSn.ZHNS_200;    
        F.b200.Ni  = F.Ni.ZHNS_200;   

        F.b400.mat = F.ZrHfSn.ZHNS_400;    
        F.b400.Ni  = F.Ni.ZHNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.TNS/divide_uc;             
                d_b = a.ZHNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 4 % ZHNS/TNS
        F.a200.mat = F.ZrHfSn.ZHNS_200;    
        F.a200.Ni  = F.Ni.ZHNS_200;   

        F.a400.mat = F.ZrHfSn.ZHNS_400;    
        F.a400.Ni  = F.Ni.ZHNS_400;  

        F.b200.mat = F.TiSn.TNS_200;       
        F.b200.Ni  = F.Ni.TNS_200;   

        F.b400.mat = F.TiSn.TNS_400;       
        F.b400.Ni  = F.Ni.TNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.ZHNS/divide_uc;            
                d_b = a.TNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 5 % HNS/ZHNS
        F.a200.mat = F.HfSn.HNS_200;       
        F.a200.Ni  = F.Ni.HNS_200;   

        F.a400.mat = F.HfSn.HNS_400;       
        F.a400.Ni  = F.Ni.HNS_400;  

        F.b200.mat = F.ZrHfSn.ZHNS_200;    
        F.b200.Ni  = F.Ni.ZHNS_200;   

        F.b400.mat = F.ZrHfSn.ZHNS_400;    
        F.b400.Ni  = F.Ni.ZHNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.HNS/divide_uc;            
                d_b = a.ZHNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 6 % ZHNS/HNS
        F.a200.mat = F.ZrHfSn.ZHNS_200;    
        F.a200.Ni  = F.Ni.ZHNS_200; 

        F.a400.mat = F.ZrHfSn.ZHNS_400;    
        F.a400.Ni  = F.Ni.ZHNS_400;  

        F.b200.mat = F.HfSn.HNS_200;       
        F.b200.Ni  = F.Ni.HNS_200;   

        F.b400.mat = F.HfSn.HNS_400;       
        F.b400.Ni  = F.Ni.HNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.ZHNS/divide_uc;            
                d_b = a.HNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 7 % ZNS/TNS
        F.a200.mat = F.ZrSn.ZNS_200;       
        F.a200.Ni  = F.Ni.ZNS_200;   

        F.a400.mat = F.ZrSn.ZNS_400;       
        F.a400.Ni  = F.Ni.ZNS_400;  

        F.b200.mat = F.TiSn.TNS_200;       
        F.b200.Ni  = F.Ni.TNS_200;   

        F.b400.mat = F.TiSn.TNS_400;       
        F.b400.Ni  = F.Ni.TNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.ZNS/divide_uc;             
                d_b = a.TNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 8 % TNS/ZNS
        F.a200.mat = F.TiSn.TNS_200;       
        F.a200.Ni  = F.Ni.TNS_200;   

        F.a400.mat = F.TiSn.TNS_400;       
        F.a400.Ni  = F.Ni.TNS_400;  

        F.b200.mat = F.ZrSn.ZNS_200;       
        F.b200.Ni  = F.Ni.ZNS_200;   

        F.b400.mat = F.ZrSn.ZNS_400;       
        F.b400.Ni  = F.Ni.ZNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.TNS/divide_uc;             
                d_b = a.ZNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 9 % ZNS/HNS
        F.a200.mat = F.ZrSn.ZNS_200;       
        F.a200.Ni  = F.Ni.ZNS_200;   

        F.a400.mat = F.ZrSn.ZNS_400;       
        F.a400.Ni  = F.Ni.ZNS_400;  

        F.b200.mat = F.HfSn.HNS_200;       
        F.b200.Ni  = F.Ni.HNS_200;   

        F.b400.mat = F.HfSn.HNS_400;       
        F.b400.Ni  = F.Ni.HNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.ZNS/divide_uc;             
                d_b = a.HNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 10 % HNS/ZNS
        F.a200.mat = F.HfSn.HNS_200;       
        F.a200.Ni  = F.Ni.HNS_200;   

        F.a400.mat = F.HfSn.HNS_400;       
        F.a400.Ni  = F.Ni.HNS_400;  

        F.b200.mat = F.ZrSn.ZNS_200;       
        F.b200.Ni  = F.Ni.ZNS_200;   

        F.b400.mat = F.ZrSn.ZNS_400;       
        F.b400.Ni  = F.Ni.ZNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.HNS/divide_uc;             
                d_b = a.ZNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 11 % ZNS/ZHNS
        F.a200.mat = F.ZrSn.ZNS_200;       
        F.a200.Ni  = F.Ni.ZNS_200;   

        F.a400.mat = F.ZrSn.ZNS_400;       
        F.a400.Ni  = F.Ni.ZNS_400;  

        F.b200.mat = F.ZrHfSn.ZHNS_200;    
        F.b200.Ni  = F.Ni.ZHNS_200;   

        F.b400.mat = F.ZrHFSn.ZHNS_400;    
        F.b400.Ni  = F.Ni.ZHNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.ZNS/divide_uc;             
                d_b = a.ZHNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

    case 12 % ZHNS/ZNS
        F.a200.mat = F.ZrHfSn.ZHNS_200;    
        F.a200.Ni  = F.Ni.ZHNS_200;   

        F.a400.mat = F.ZrHfSn.ZHNS_400;    
        F.a400.Ni  = F.Ni.ZHNS_400;  

        F.b200.mat = F.ZrSn.ZNS_200;       
        F.b200.Ni  = F.Ni.ZNS_200;   

        F.b400.mat = F.ZrSn.ZNS_400;       
        F.b400.Ni  = F.Ni.ZNS_400;   

            if isnan(d_a_new) || isnan(d_b_new)
                d_a = a.ZHNS/divide_uc;            
                d_b = a.ZNS/divide_uc;
            else
                d_a = d_a_new/divide_uc;           
                d_b = d_b_new/divide_uc;
            end

end

%% buffer layer
switch buffer_material
    case 0
        if isnan(d_buffer_new)
            d_buffer = a.TNS/divide_uc;
        else
            d_buffer = d_buffer_new/divide_uc;
        end   

    case 1 % TNS
        F.buffer200_1layer = F.TiSn.TNS_200;          
        F.buffer200_2layer = F.Ni.TNS_200;

        F.buffer400_1layer = F.TiSn.TNS_400;          
        F.buffer400_2layer = F.Ni.TNS_400;

            if isnan(d_buffer_new)
                d_buffer = a.TNS/divide_uc;
            else
                d_buffer = d_buffer_new/divide_uc;
            end                

    case 2 % HNS
        F.buffer200_1layer = F.HfSn.HNS_200;          
        F.buffer200_2layer = F.Ni.HNS_200;

        F.buffer400_1layer = F.HfSn.HNS_400;          
        F.buffer400_2layer = F.Ni.HNS_400;

            if isnan(d_buffer_new)
                d_buffer = a.HNS/divide_uc;
            else
                d_buffer = d_buffer_new/divide_uc;
            end 

    case 3 % ZNS
        F.buffer200_1layer = F.ZrSn.ZNS_200;          
        F.buffer200_2layer = F.Ni.ZNS_200;

        F.buffer400_1layer = F.ZrSn.ZNS_400;          
        F.buffer400_2layer = F.Ni.ZNS_400;

            if isnan(d_buffer_new)
                d_buffer = a.ZNS/divide_uc;
            else
                d_buffer = d_buffer_new/divide_uc;
            end 

    case 4 % ZHNS
        F.buffer200_1layer = F.ZrHfSn.ZHNS_200;       
        F.buffer200_2layer = F.Ni.ZHNS_200;

        F.buffer400_1layer = F.ZrHfSn.ZHNS_400;       
        F.buffer400_2layer = F.Ni.ZHNS_400;

            if isnan(d_buffer_new)
                d_buffer = a.ZHNS/divide_uc;
            else
                d_buffer = d_buffer_new/divide_uc;
            end 

    case 5 % V
        F.buffer200_1layer = F.V_200;                 
        F.buffer200_2layer = F.V_200;

        F.buffer400_1layer = F.V_400;                 
        F.buffer400_2layer = F.V_400;

            if isnan(d_buffer_new)
                d_buffer = a.V/divide_uc;
            else
                d_buffer = d_buffer_new/divide_uc;
            end 
end

%% range of the calculation
    % average lattice constant
    d_mean = (d_a + d_b)/2; 
    
    % Cu radiation wavelength (A)
    lambda1 = 1.54056;     
    lambda2 = 1.54439;

    % two theta range
    twotheta_200 = range(1,1):range(1,2):range(1,3); % in degrees
    twotheta_400 = range(2,1):range(2,2):range(2,3); % in degrees
        twotheta = [twotheta_200 twotheta_400]; % 200 and 400 range in degrees

    twotheta_rad_200 = twotheta_200/180*pi/2; % in radians
    twotheta_rad_400 = twotheta_400/180*pi/2; % in radians
        thetar = twotheta/180*pi/2; % 200 and 400 range in radians

    % momentum transfer
    dq1_lambda1 = 4*pi/lambda1*sin(twotheta_rad_200);
    dq2_lambda1 = 4*pi/lambda1*sin(twotheta_rad_400);

    dq1_lambda2 = 4*pi/lambda2*sin(twotheta_rad_200);
    dq2_lambda2 = 4*pi/lambda2*sin(twotheta_rad_400);
        
% Impulsübertrag dq=[dq1 dq2] da in Bereich 1 andere Strukturfaktoren als
% in Bereich 2 benoetigt werden
   

%% Construction of the superlattice 
if buffer_YN
    N_planes_buffer = N_uc_buffer*divide_uc;
else
    N_planes_buffer = 0;
end

    N_planes_a = N_uc_a*divide_uc; % Number of planes
    N_planes_b = N_uc_b*divide_uc; % Anzahl Netzebenen Achtung > Anzahl EZ
        N_planes = (N_planes_a + N_planes_b) * N_bilayer + N_planes_buffer; % total number of planes
        
    % absolute value of the strain = (unit cell of buffer layer / unit cell of substrate -1)
    strain = abs(d_buffer*divide_uc/5.95-1);

zposition = zeros(1,N_planes+1);  % Ort der Netzebenen
f = zposition; % Scattering factor der Netzebenen; 
            % zposition is the total thickness of film in A; 
            % f gives information whether a given layer belongs to material a or b
    currentN = 1; 
    currentposition = 0;
        f_a = 1; 
        f_b = 0; % f_a als logische Variable: Netzebene gehoert zu Typ a, f_a=1 oder Typ b f_b=0
                 % ermoeglicht spaeter Interpretation als interdiffusion und Prozentwerte 0<=f_a<=1
                 
if buffer_YN
    for b = 1:N_planes_buffer
        f(currentN) = f_a;
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
        f(currentN) = f_a;   % Strukturfaktor der n-ten Netzebene starte mit a
        zposition(currentN) = currentposition + d_mean;  % z-Koordinate der n-ten Netzebene am Interface
        currentposition = zposition(currentN);  % aktuelle z-Koordinate
        currentN = currentN + 1;

        if N_planes_a > 1
           for s = 2:N_planes_a
             f(currentN) = f_a;   % Strukturfaktor der n-ten Netzebene
             zposition(currentN) = currentposition + d_a;  % z-Koordinate der n-ten Netzebene
             currentposition = zposition(currentN);  % aktuelle z-Koordinate
             currentN = currentN + 1;
           end % s 
        end % if

        f(currentN) = f_b;   % Strukturfaktor der n-ten Netzebene jetzt cfs
        zposition(currentN) = currentposition + d_mean;  % z-Koordinate der n-ten Netzebene am Interface
        currentposition = zposition(currentN);  % aktuelle z-Koordinate
        currentN = currentN + 1;

        if N_planes_b > 1
          for c = 2:N_planes_b  % war hier falsch
            f(currentN) = f_b;   % Strukturfaktor der n-ten Netzebene
            zposition(currentN) = currentposition + d_b;  % z-Koordinate der n-ten Netzebene
            currentposition = zposition(currentN);  % aktuelle z-Koordinate
            currentN = currentN + 1;
        end % c    
       end % if

    end % b    
end
% Bis hier Aufbau des Übergitters // till here the creation of a grid for the SL 

%%
Ftot_200_lambda1 = 0; 
Ftot_400_lambda1 = 0; % Ftot = Vektor mit Streukraeften als Fkt des Impulsuebertrages=Winkel
Ftot_200_lambda2 = 0; 
Ftot_400_lambda2 = 0;

%% Unten obere Schleife aber nur für V Buffer
if buffer_YN
    for z=1:2:N_planes_buffer
    %  Ftot=Ftot+f(z)*exp(i*dq*zposition(z)); 
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z)* F.buffer200_1layer) * exp(i*dq1_lambda1*zposition(z)); % V  Ebene, EZ zu groß gewählt
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z+1) * F.buffer200_2layer)* exp(i*dq1_lambda1*zposition(z+1)); % V Ebene (unterscheidung eigentlich überflüssig)
      Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z)* F.buffer400_1layer) * exp(i*dq2_lambda1*zposition(z)); % V Ebene 
      Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z+1) * F.buffer400_2layer)* exp(i*dq2_lambda1*zposition(z+1)); % V Ebene 
      
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z)* F.buffer200_1layer) * exp(i*dq1_lambda2*zposition(z)); % V  Ebene, EZ zu groß gewählt
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z+1) * F.buffer200_2layer)* exp(i*dq1_lambda2*zposition(z+1)); % V Ebene (unterscheidung eigentlich überflüssig)
      Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z)* F.buffer400_1layer) * exp(i*dq2_lambda2*zposition(z)); % V Ebene 
      Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z+1) * F.buffer400_2layer)* exp(i*dq2_lambda2*zposition(z+1)); % V Ebene 
      % In obiger Gleichung ist dq ein Vektor!
      % f(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
      % gleichzeitig f(k,q) Winkelabhaengig sein
    end
end

%% So startet Übergitter mit Ti (NiSn)
if ~N_bilayer == 0 && (~N_uc_a == 0 || ~N_uc_b == 0)
    for z=1:2:N_planes
    % %  Ftot=Ftot+f(z)*exp(i*dq*zposition(z)); 
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z)   * F.a200.mat + (1-f(z))   * F.b200.mat) * exp(i*dq1_lambda1*zposition(z)); % TiSn bzw. ZrHfSn Ebene
      Ftot_200_lambda1 = Ftot_200_lambda1 + (f(z+1) * F.a200.Ni  + (1-f(z+1)) * F.b200.Ni)  * exp(i*dq1_lambda1*zposition(z+1)); % Ni Ebene (unterscheidung eigentlich überflüssig)
      Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z)   * F.a400.mat + (1-f(z))   * F.b400.mat) * exp(i*dq2_lambda1*zposition(z)); % TiSn bzw. ZrHfSn Ebene 
      Ftot_400_lambda1 = Ftot_400_lambda1 + (f(z+1) * F.a400.Ni  + (1-f(z+1)) * F.b400.Ni)  * exp(i*dq2_lambda1*zposition(z+1)); % Ni Ebene 
      
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z)   * F.a200.mat + (1-f(z))   * F.b200.mat) * exp(i*dq1_lambda2*zposition(z)); % TiSn bzw. ZrHfSn Ebene
      Ftot_200_lambda2 = Ftot_200_lambda2 + (f(z+1) * F.a200.Ni  + (1-f(z+1)) * F.b200.Ni)  * exp(i*dq1_lambda2*zposition(z+1)); % Ni Ebene (unterscheidung eigentlich überflüssig)
      Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z)   * F.a400.mat + (1-f(z))   * F.b400.mat) * exp(i*dq2_lambda2*zposition(z)); % TiSn bzw. ZrHfSn Ebene 
      Ftot_400_lambda2 = Ftot_400_lambda2 + (f(z+1) * F.a400.Ni  + (1-f(z+1)) * F.b400.Ni)  * exp(i*dq2_lambda2*zposition(z+1)); % Ni Ebene 

    %   % In obiger Gleichung ist dq ein Vektor!
    %   % f(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
    %   % gleichzeitig f(k,q) Winkelabhaengig sein
    end
end

Ftotal_lambda1 = [Ftot_200_lambda1 Ftot_400_lambda1];
Int_total_lambda1 = (abs(Ftotal_lambda1)).^2;
Int_total_lambda1 = Int_total_lambda1/max(Int_total_lambda1);
Int_200_lambda1   = ((abs(Ftot_200_lambda1)).^2)/max(Int_total_lambda1); 
Int_400_lambda1   = ((abs(Ftot_400_lambda1)).^2)/max(Int_total_lambda1);

Ftotal_lambda2 = [Ftot_200_lambda2 Ftot_400_lambda2];
Int_total_lambda2 = (abs(Ftotal_lambda2)).^2;
Int_total_lambda2 = Int_total_lambda2/max(Int_total_lambda2);
Int_200_lambda2   = ((abs(Ftot_200_lambda2)).^2)/max(Int_total_lambda2); 
Int_400_lambda2   = ((abs(Ftot_400_lambda2)).^2)/max(Int_total_lambda2);

       
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
IntensityVoight = zeros(1,length(twotheta_200) + length(twotheta_400));
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
IntVoight_200 = IntVoight_200/max(IntVoight_200);
IntVoight_400 = IntVoight_400/max(IntVoight_400);

