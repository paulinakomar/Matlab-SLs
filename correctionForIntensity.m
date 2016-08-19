clear all, close all, clc

lambda1 = 1.54056;     

    % two theta range
    twotheta_200 = 25:0.1:35;
    twotheta_400 = 56:0.1:65;
    twotheta = [twotheta_200 twotheta_400]; %range(1,1):range(1,2):range(1,3); % in degrees
        thetar = twotheta/180*pi/2; % 200 and 400 range in radians

    % momentum transfer
    dq_lambda1 = 4*pi/lambda1*sin(thetar);
    
% MassAttenuation (cm2/g)           mass(g/mol)
MassAttenuation.V  = 2.217E2;       mass.V  = 50.94;
MassAttenuation.Ni = 4.952E1;       mass.Ni = 58.69;
MassAttenuation.Ti = 2.23E2;        mass.Ti = 47.87;
MassAttenuation.Sn = 2.5E2;         mass.Sn = 118.71;
MassAttenuation.Hf = 1.571E2;       mass.Hf = 178.5;
MassAttenuation.Zr = 1.356E2;       mass.Zr = 91.22;


% mass fractions in TiNiSn
mass.TNS_HNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + mass.Hf;
    fraction.TNS_HNS.Ti = mass.Ti/mass.TNS_HNS;
    fraction.TNS_HNS.Ni = 2*mass.Ni/mass.TNS_HNS;
    fraction.TNS_HNS.Sn = 2*mass.Sn/mass.TNS_HNS;
    fraction.TNS_HNS.Hf = mass.Hf/mass.TNS_HNS;
    
mass.TNS_ZHNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
    fraction.TNS_ZHNS.Ti = mass.Ti/mass.TNS_ZHNS;
    fraction.TNS_ZHNS.Ni = 2*mass.Ni/mass.TNS_ZHNS;
    fraction.TNS_ZHNS.Sn = 2*mass.Sn/mass.TNS_ZHNS;
    fraction.TNS_ZHNS.Hf = 0.5*mass.Hf/mass.TNS_ZHNS;
    fraction.TNS_ZHNS.Zr = 0.5*mass.Zr/mass.TNS_ZHNS;
    
mass.ZNS_ZHNS = mass.Zr + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
    fraction.ZNS_ZHNS.Zr = 1.5 * mass.Zr/mass.ZNS_ZHNS;
    fraction.ZNS_ZHNS.Ni = 2*mass.Ni/mass.ZNS_ZHNS;
    fraction.ZNS_ZHNS.Sn = 2*mass.Sn/mass.ZNS_ZHNS;
    fraction.ZNS_ZHNS.Hf = 0.5*mass.Hf/mass.ZNS_ZHNS;
    
mass.HNS_ZHNS = mass.Hf + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
    fraction.HNS_ZHNS.Zr = 0.5 * mass.Zr/mass.HNS_ZHNS;
    fraction.HNS_ZHNS.Ni = 2*mass.Ni/mass.HNS_ZHNS;
    fraction.HNS_ZHNS.Sn = 2*mass.Sn/mass.HNS_ZHNS;
    fraction.HNS_ZHNS.Hf = 1.5*mass.Hf/mass.HNS_ZHNS;
    
mass.ZNS_HNS = mass.Zr + 2*mass.Ni + 2*mass.Sn + mass.Hf;
    fraction.ZNS_HNS.Zr = mass.Zr/mass.ZNS_HNS;
    fraction.ZNS_HNS.Ni = 2*mass.Ni/mass.ZNS_HNS;
    fraction.ZNS_HNS.Sn = 2*mass.Sn/mass.ZNS_HNS;
    fraction.ZNS_HNS.Hf = mass.Hf/mass.ZNS_HNS;
    
mass.TNS_ZNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + mass.Zr;
    fraction.TNS_ZNS.Ti = mass.Ti/mass.TNS_ZNS;
    fraction.TNS_ZNS.Ni = 2*mass.Ni/mass.TNS_ZNS;
    fraction.TNS_ZNS.Sn = 2*mass.Sn/mass.TNS_ZNS;
    fraction.TNS_ZNS.Zr = mass.Zr/mass.TNS_ZNS;
    
% density
density.TNS = 7.14;
density.HNS = 10.517;
density.ZNS = 7.822;
density.ZHNS = 9.101;
    
MassAttenuation.TNS_HNS = MassAttenuation.Ti * fraction.TNS_HNS.Ti +...
                        MassAttenuation.Ni * fraction.TNS_HNS.Ni +...
                        MassAttenuation.Sn * fraction.TNS_HNS.Sn +...
                        MassAttenuation.Hf * fraction.TNS_HNS.Hf;
                    
mu = MassAttenuation.TNS_HNS * (density.TNS + density.HNS)/2; % (1/cm)
mu = mu/0.01;
                    
% MassAttenuation.TNS_ZHNS = MassAttenuation.Ti * fraction.TNS_ZHNS.Ti +...
%                         MassAttenuation.Ni * fraction.TNS_ZHNS.Ni +...
%                         MassAttenuation.Sn * fraction.TNS_ZHNS.Sn +...
%                         MassAttenuation.Hf * fraction.TNS_ZHNS.Hf + ...
%                         MassAttenuation.Zr * fraction.TNS_ZHNS.Zr;
%                     
% mu = MassAttenuation.TNS_ZHNS * (density.TNS + density.ZHNS)/2; % (1/cm)
% mu = mu/0.01;
% 
% MassAttenuation.HNS_ZHNS = MassAttenuation.Hf * fraction.HNS_ZHNS.Hf +...
%                         MassAttenuation.Ni * fraction.HNS_ZHNS.Ni +...
%                         MassAttenuation.Sn * fraction.HNS_ZHNS.Sn + ...
%                         MassAttenuation.Zr * fraction.HNS_ZHNS.Zr;
%                     
% mu = MassAttenuation.HNS_ZHNS * (density.HNS + density.ZHNS)/2; % (1/cm)
% mu = mu/0.01;
%                     
% MassAttenuation.ZNS_ZHNS = MassAttenuation.Zr * fraction.ZNS_ZHNS.Zr +...
%                         MassAttenuation.Ni * fraction.ZNS_ZHNS.Ni +...
%                         MassAttenuation.Sn * fraction.ZNS_ZHNS.Sn +...
%                         MassAttenuation.Hf * fraction.ZNS_ZHNS.Hf;
%                     
% mu = MassAttenuation.ZNS_ZHNS * (density.ZNS + density.ZHNS)/2; % (1/cm)
% mu = mu/0.01;
%                     
% MassAttenuation.ZNS_HNS = MassAttenuation.Zr * fraction.ZNS_HNS.Zr +...
%                         MassAttenuation.Ni * fraction.ZNS_HNS.Ni +...
%                         MassAttenuation.Sn * fraction.ZNS_HNS.Sn +...
%                         MassAttenuation.Hf * fraction.ZNS_HNS.Hf;
%                     
% mu = MassAttenuation.ZNS_HNS * (density.ZNS + density.HNS)/2; % (1/cm)
% mu = mu/0.01; % (1/m)
% 
% MassAttenuation.TNS_ZNS = MassAttenuation.Ti * fraction.TNS_ZNS.Ti +...
%                         MassAttenuation.Ni * fraction.TNS_ZNS.Ni +...
%                         MassAttenuation.Sn * fraction.TNS_ZNS.Sn +...
%                         MassAttenuation.Zr * fraction.TNS_ZNS.Zr;
%                     
% mu = MassAttenuation.ZNS_HNS * (density.TNS + density.ZNS)/2; % (1/cm)
% mu = mu/0.01; % (1/m)

t = 1e-6;

% twotheta = 10:0.1:70;
% theta_r = twotheta/180*pi/2;

Int_correction = ((1 + cos(2*thetar).^2)./sin(2*thetar)) .* (1 - exp(-2*mu*t./sin(thetar)));

plot(twotheta, Int_correction);






