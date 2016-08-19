%% Description
%==========================================================================
% Input:
% - const - a structure containing all material dependent constants. For
%       detailed information read the description of constants.m function.
% - twotheta_002 & twotheta_004 - row vectors (1 x length(twotheta_002) & 
%       1 x length(twotheta_002) arrays). Specifies the range of angles 
%       (in degrees) taken for the XRD calculation, e.g. 
%       twotheta_002 = 25:0.01:35; 
%       twotheta_004 = 55:0.01:65;
% Output:
% - f - structure containing angle dependent atomic scattering factors for
%       Ti, Ni, Zr, Sn, Hf, and V
%==========================================================================
% Created by Paulina Komar   &   Gerhard Jakob
% holuj@uni-mainz.de             jakob@uni-mainz.de
% komarpaulina@outlook.com
% Last modified August 2016
%==========================================================================

function f = atomicScatteringFactor(const, twotheta_002, twotheta_004)

% angular range converted into radians
theta_rad_002 = twotheta_002/180*pi/2; % in radians
theta_rad_004 = twotheta_004/180*pi/2;

% momentum transfer for Cu Kalpha1 and Cu Kaplha2
dq1_Ka1    = 4*pi/const.lambda_Ka1*sin(theta_rad_002); % for (002) peak
dq2_Ka1    = 4*pi/const.lambda_Ka1*sin(theta_rad_004); % for (004) peak
    dq_Ka1 = [dq1_Ka1 dq2_Ka1];
    
dq1_Ka2    = 4*pi/const.lambda_Ka2*sin(theta_rad_002); % for (002) peak
dq2_Ka2    = 4*pi/const.lambda_Ka2*sin(theta_rad_004); % for (004) peak
    dq_Ka2 = [dq1_Ka2 dq2_Ka2];
    
dq1_Kb     = 4*pi/const.lambda_Kb*sin(theta_rad_002); % for (002) peak
dq2_Kb     = 4*pi/const.lambda_Kb*sin(theta_rad_004); % for (004) peak
    dq_Kb  = [dq1_Kb dq2_Kb];
    
%% Calculate the atomic scattering factors in given angular ranges
elements = fieldnames(const.a);

for j = 1:length(elements)
f.Ka1.(elements{j}) = 0;    
f.Ka2.(elements{j}) = 0;    
f.Kb.(elements{j})  = 0;

    for k=1:4
       f.Ka1.(elements{j}) = f.Ka1.(elements{j}) +...
           const.a.(elements{j})(k)*exp(-const.b.(elements{j})(k)*(dq_Ka1/(4*pi)).^2) +...
           const.c.(elements{j})(k);

       f.Ka2.(elements{j}) = f.Ka2.(elements{j}) +...
           const.a.(elements{j})(k)*exp(-const.b.(elements{j})(k)*(dq_Ka2/(4*pi)).^2) +...
           const.c.(elements{j})(k);

       f.Kb.(elements{j})  = f.Kb.(elements{j}) +...
           const.a.(elements{j})(k)*exp(-const.b.(elements{j})(k)*(dq_Kb/(4*pi)).^2) +...
           const.c.(elements{j})(k);
    end

    % dispersion corrections for X-ray scattering
    f.Ka1.(elements{j}) = abs((f.Ka1.(elements{j}) +...
        const.disp_corr_1.(elements{j}) + 1i*const.disp_corr_2.(elements{j})) .*...
        exp(-const.B.(elements{j})*(dq_Ka1/(4*pi)).^2));

    f.Ka2.(elements{j}) = abs((f.Ka2.(elements{j}) +...
        const.disp_corr_1.(elements{j}) + 1i*const.disp_corr_2.(elements{j})) .*...
        exp(-const.B.(elements{j})*(dq_Ka2/(4*pi)).^2));

    f.Kb.(elements{j})  = abs((f.Kb.(elements{j}) +...
        const.disp_corr_1.(elements{j}) + 1i*const.disp_corr_2.(elements{j})) .*...
        exp(-const.B.(elements{j})*(dq_Kb/(4*pi)).^2));
end
