%% Description
%==========================================================================
% Input:
% - stack - column vector (length(stack) x 1 array). Specifies the 
%       thicknesses of layers that form the superlattice/multilayer. The
%       thicknesses of the layers must be given in unit cells. The layering
%       starts from the interface with a substrate, e.g. a superlattice 
%       substrate/[TiNiSn(3 uc)/HfNiSn(5 uc)]x4/air will be represented
%       by stack = [3 5 3 5 3 5 3 5]'; The "stack" vector must have even
%       number of elements. If you want to skip any layer, insert 0.
% - const - a structure containing all material dependent constants. For
%       detailed information read the description of constants.m function.
% - f - a structure containing angle dependent atomic scattering factors for 
%       the material system specified by the vaiable "system".
% - twotheta_002 & twotheta_004 - row vectors (1 x length(twotheta_002) & 
%       1 x length(twotheta_002) arrays). Specifies the range of angles 
%       (in degrees) taken for the XRD calculation, e.g. 
%       twotheta_002 = 25:0.01:35; 
%       twotheta_004 = 55:0.01:65;
% - system - integer from the range 1-3. Is used to choose from one of the
%       following material systems: 
%       1 = V, 2 = substrate/TiNnSn/HfNiSn, 3 = substrate/HfNiSn/TiNiSn,
% Output:
% - IntVoigt_002 & IntVoigt_004 - row vectors containing normalized
%       intensities of calculated diffraction patterns, convoluted with the 
%       Pseudo-Voigt peak shape. The convolution parameters come from the
%       fit to measured TiNiSn reflexions and are stored in the constants.m
%       function.
%==========================================================================
% Strain relaxation model:
% exponential relaxation: uncomment lines 95-97 and 100 and comment line 102
% power law relaxation: uncomment lines 95-97 and 101 and comment line 102
% DO NOT FORGET to specify the value of strain_relative (line 95) and a 
% numerical factor of exponent or power (line 97)
%==========================================================================
% Created by Paulina Komar   &   Gerhard Jakob
% holuj@uni-mainz.de             jakob@uni-mainz.de
% komarpaulina@outlook.com
% Last modified August 2016
%==========================================================================

function [IntVoigt_002, IntVoigt_004, thickness_uc] = CADEM(stack,...
                                const, f, twotheta_002, twotheta_004, system, n)

%% Definition of the ranges
% angular range converted into radians
theta_rad_002 = twotheta_002/180*pi/2; % in radians
theta_rad_004 = twotheta_004/180*pi/2;
    thetar    = [theta_rad_002 theta_rad_004];

% momentum transfer for Cu Kalpha1, Cu Kaplha2, and Cu Kbeta
dq1_Ka1    = 4*pi/const.lambda_Ka1*sin(theta_rad_002); % for (002) peak
dq2_Ka1    = 4*pi/const.lambda_Ka1*sin(theta_rad_004); % for (004) peak
    dq_Ka1 = [dq1_Ka1 dq2_Ka1];
    
dq1_Ka2    = 4*pi/const.lambda_Ka2*sin(theta_rad_002);
dq2_Ka2    = 4*pi/const.lambda_Ka2*sin(theta_rad_004);
    dq_Ka2 = [dq1_Ka2 dq2_Ka2];   
    
dq1_Kb     = 4*pi/const.lambda_Kb*sin(theta_rad_002);
dq2_Kb     = 4*pi/const.lambda_Kb*sin(theta_rad_004);
    dq_Kb  = [dq1_Kb dq2_Kb]; 

%% arrangement of the layers from the loaded data
thickness_uc       = stack; % thickness of individual layers in unit cells
% rounded thickness of individual layers in the number of atomic planes
% in order to prevent a situation that one will calculate XRD of 3.3 uc of 
% material while a unit cell can be divided into 4 atomic layers leading to
% possible values equal to 3, 3.25, 3.5 and 3.75.
thickness_atplanes = round(thickness_uc*const.divide_uc); 
thickness_uc       = thickness_atplanes/const.divide_uc;  
                                                          

%% Calculate atomic scattering factors
[f, const] = choose_system(system, f, const, stack);

%% Construct the layer stack
N_planes  = sum(thickness_atplanes); % number of atomic planes
zposition = zeros(1,N_planes);       % position in the stack (angstrom)
F         = zposition;               % allocate memory for the vector
                                     % specifynig which material is at
                                     % given position
currentN        = 1;
currentposition = 0;

F_a   = 1;                          % corresponds to layer A
F_b   = 0;                          % corresponds to layer B
mu_Ka = zeros(1,N_planes);          % linear attenuation coefficient
mu_Kb = zeros(1,N_planes);
n     = n * const.divide_uc;        % number of atomic layers for intermixing


if system == 1
% uncomment to use strain relaxation model
%      strain_relative = (const.d_a * const.divide_uc - const.d.V) / const.d.V;       
%      delta           = strain_relative * const.d.V;
%      power = 6;
    for k = 1:N_planes
        F(currentN)         = F_a;
%         zposition(currentN) = currentposition + const.d_a + delta*exp(-power * currentN/N_planes);      % exponential relaxation
%         zposition(currentN) = currentposition + const.d_a + delta*(currentN/(N_planes))^power ;         % power law relaxation
        zposition(currentN) = currentposition + const.d_a;            % comment this line if you use any strain relaxation model
        currentposition     = zposition(currentN);
        currentN            = currentN + 1;
    end
    scale_zpos = const.d_a * (currentN-1)/zposition(currentN-1); 
    zposition  = zposition * scale_zpos;
else      
    % construct a multilayer structure
    % modify atomic scattering factor and the lattice constant in case of intermixing
    for b = 1:length(thickness_atplanes)/2
        smax1 = thickness_atplanes(2*b-1)-floor(n/2);     
        k5 = floor(n/2);
              
        if b == 1
            for s = 1:smax1 % odd layers - material A
                F(currentN) = F_a;
                zposition(currentN) = currentposition + const.d_a;  
                currentposition = zposition(currentN);
                currentN = currentN + 1;
            end % s
        else
            for k1 = 1:floor(n/2)
                F(currentN) = (k1*F_a + (n-k1+1)*F_b)/(n+1);
                zposition(currentN) = currentposition + (k1*const.d_a + (n-k1+1)*const.d_b)/(n+1);  
                currentposition = zposition(currentN);
                currentN = currentN + 1;
            end % k1
            
            for k2 = floor(n/2)+1:n
                F(currentN) = (k2*F_a + (n-k2+1)*F_b)/(n+1);
                zposition(currentN) = currentposition + (k2*const.d_a + (n-k2+1)*const.d_b)/(n+1);  
                currentposition = zposition(currentN);
                currentN = currentN + 1;
            end % k2
            
            for s = n+1:thickness_atplanes(2*b-1) % odd layers - material A
                F(currentN) = F_a;
                zposition(currentN) = currentposition + const.d_a;  
                currentposition = zposition(currentN);
                currentN = currentN + 1;
            end % s
        end

        for k3 = 1:floor(n/2)
            F(currentN) = ((n-k3+1)*F_a + k3*F_b)/(n+1);
            zposition(currentN) = currentposition + ((n-k3+1)*const.d_a + k3*const.d_b)/(n+1);  
            currentposition = zposition(currentN);
            currentN = currentN + 1;
        end % k3
        
        for k4 = floor(n/2)+1:n
            F(currentN) = ((n-k4+1)*F_a + k4*F_b)/(n+1);
            zposition(currentN) = currentposition + ((n-k4+1)*const.d_a + k4*const.d_b)/(n+1);  
            currentposition = zposition(currentN);
            currentN = currentN + 1;
        end % k4
            
        for c = n+2:thickness_atplanes(2*b)+1     % even layers - material B
            F(currentN) = F_b;
            zposition(currentN) = currentposition + const.d_b;
            currentposition = zposition(currentN);  
            currentN = currentN + 1;
        end % c
    end % b
    
    for kk = 1:k5
        F(currentN) = F_b;
        zposition(currentN) = currentposition + const.d_b;
        currentposition = zposition(currentN);  
        currentN = currentN + 1;
    end % kk
end
%% Calculate structure factors
Ftot_Ka1 = 0; 
Ftot_Ka2 = 0;
Ftot_Kb  = 0;

if system == 1
    if mod(N_planes,2) == 0
        for z = 1:2:N_planes
            Ftot_Ka1 = Ftot_Ka1 + (F(z) * f.Ka1.a1 .* exp(1i*dq_Ka1*zposition(z)));
            Ftot_Ka2 = Ftot_Ka2 + (F(z) * f.Ka2.a1 .* exp(1i*dq_Ka2*zposition(z)));
            Ftot_Kb  = Ftot_Kb  + (F(z) * f.Kb.a1  .* exp(1i*dq_Kb*zposition(z)));

            Ftot_Ka1 = Ftot_Ka1 + (F(z+1) * f.Ka1.a2 .* exp(1i*dq_Ka1*zposition(z+1)));
            Ftot_Ka2 = Ftot_Ka2 + (F(z+1) * f.Ka2.a2 .* exp(1i*dq_Ka2*zposition(z+1)));
            Ftot_Kb  = Ftot_Kb  + (F(z+1) * f.Kb.a2  .* exp(1i*dq_Kb*zposition(z+1)));
        end
    else
        for z = 1:2:N_planes-1
            Ftot_Ka1 = Ftot_Ka1 + (F(z) * f.Ka1.a1 .* exp(1i*dq_Ka1*zposition(z)));
            Ftot_Ka2 = Ftot_Ka2 + (F(z) * f.Ka2.a1 .* exp(1i*dq_Ka2*zposition(z)));
            Ftot_Kb  = Ftot_Kb  + (F(z) * f.Kb.a1  .* exp(1i*dq_Kb*zposition(z)));

            Ftot_Ka1 = Ftot_Ka1 + (F(z+1) * f.Ka1.a2 .* exp(1i*dq_Ka1*zposition(z+1)));
            Ftot_Ka2 = Ftot_Ka2 + (F(z+1) * f.Ka2.a2 .* exp(1i*dq_Ka2*zposition(z+1)));
            Ftot_Kb  = Ftot_Kb  + (F(z+1) * f.Kb.a2  .* exp(1i*dq_Kb*zposition(z+1)));
        end
            Ftot_Ka1 = Ftot_Ka1 + (F(z+2) * f.Ka1.a1 .* exp(1i*dq_Ka1*zposition(z+2)));
            Ftot_Ka2 = Ftot_Ka2 + (F(z+2) * f.Ka2.a1 .* exp(1i*dq_Ka2*zposition(z+2)));
            Ftot_Kb  = Ftot_Kb  + (F(z+2) * f.Kb.a1  .* exp(1i*dq_Kb*zposition(z+2)));
    end
else
    %h = waitbar(0,'Please wait...');
    if mod(N_planes,2) == 0
        for z = 1:2:N_planes
            Ftot_Ka1 = Ftot_Ka1 + (F(z)   * f.Ka1.a1 + (1-F(z))   * f.Ka1.b1) .* exp(1i*dq_Ka1*zposition(z));
            Ftot_Ka1 = Ftot_Ka1 + (F(z+1) * f.Ka1.a2 + (1-F(z+1)) * f.Ka1.b2) .* exp(1i*dq_Ka1*zposition(z+1));

            Ftot_Ka2 = Ftot_Ka2 + (F(z)   * f.Ka2.a1 + (1-F(z))   * f.Ka2.b1) .* exp(1i*dq_Ka2*zposition(z));
            Ftot_Ka2 = Ftot_Ka2 + (F(z+1) * f.Ka2.a2 + (1-F(z+1)) * f.Ka2.b2) .* exp(1i*dq_Ka2*zposition(z+1));
            
            Ftot_Kb  = Ftot_Kb + (F(z)    * f.Kb.a1  + (1-F(z))   * f.Kb.b1)  .* exp(1i*dq_Kb*zposition(z));
            Ftot_Kb  = Ftot_Kb + (F(z+1)  * f.Kb.a2  + (1-F(z+1)) * f.Kb.b2)  .* exp(1i*dq_Kb*zposition(z+1));
            %waitbar(z / N_planes);
        end
        
    else % if N_planes is odd
         
        for z = 1:2:N_planes-1 % Ni/MSn sequence
            Ftot_Ka1 = Ftot_Ka1 + (F(z)   * f.Ka1.a1 + (1-F(z))   * f.Ka1.b1) .* exp(1i*dq_Ka1*zposition(z));
            Ftot_Ka1 = Ftot_Ka1 + (F(z+1) * f.Ka1.a2 + (1-F(z+1)) * f.Ka1.b2) .* exp(1i*dq_Ka1*zposition(z+1));

            Ftot_Ka2 = Ftot_Ka2 + (F(z)   * f.Ka2.a1 + (1-F(z))   * f.Ka2.b1) .* exp(1i*dq_Ka2*zposition(z));
            Ftot_Ka2 = Ftot_Ka2 + (F(z+1) * f.Ka2.a2 + (1-F(z+1)) * f.Ka2.b2) .* exp(1i*dq_Ka2*zposition(z+1));
            
            Ftot_Kb  = Ftot_Kb + (F(z)    * f.Kb.a1  + (1-F(z))   * f.Kb.b1)  .* exp(1i*dq_Kb*zposition(z));
            Ftot_Kb  = Ftot_Kb + (F(z+1)  * f.Kb.a2  + (1-F(z+1)) * f.Kb.b2)  .* exp(1i*dq_Kb*zposition(z+1));
            %waitbar(z / (N_planes-1));
        end
        
        Ftot_Ka1 = Ftot_Ka1 + (F(z+2) * f.Ka1.a1 + (1-F(z+2)) * f.Ka1.b1) .* exp(1i*dq_Ka1*zposition(z+2)); 
        Ftot_Ka2 = Ftot_Ka2 + (F(z+2) * f.Ka2.a1 + (1-F(z+2)) * f.Ka2.b1) .* exp(1i*dq_Ka2*zposition(z+2)); 
        Ftot_Kb  = Ftot_Kb  + (F(z+2) * f.Kb.a1  + (1-F(z+2)) * f.Kb.b1)  .* exp(1i*dq_Kb*zposition(z+2));
    end
end
%close(h);
% uncomment to include a polarization factor
% p    = (1 + (cos(2*thetar)).^2)/2;          % polarization factor, eq. 5a
% thetaM = specify!;
% p    = (1 + (cos(2*thetar)).^2 * (cos(2*thetaM)).^2)./(1+(cos(2*thetaM)).^2); % polarization factor, eq. 5b
L    = 1./sin(2*thetar);        % Lorentz factor
if isfield(const, 'd_b')
    t = sum(F) * const.d_a + (length(F) - sum(F)) * const.d_b; % total thickness in A
else
    t = sum(F) * const.d_a;
end

t    = t*1E-10; % total thickness in m
A_Ka = exp(-2*const.mu_Ka*t./sin(thetar));  % attenuation factor
A_Kb = exp(-2*const.mu_Kb*t./sin(thetar));

if exist('p')
    Int_correction_Ka = L.*p.*A_Ka;
    Int_correction_Kb = L.*p.*A_Kb;
else
    Int_correction_Ka = L.*A_Ka;
    Int_correction_Kb = L.*A_Kb;
end
 
Int_total_lambda1   = Int_correction_Ka .* (abs(Ftot_Ka1)).^2;
    Int_002_lambda1 = Int_total_lambda1(1:length(dq1_Ka1));
    Int_004_lambda1 = Int_total_lambda1(length(dq1_Ka1)+1:end);

Int_total_lambda2   = Int_correction_Ka .* (abs(Ftot_Ka2)).^2;
    Int_002_lambda2 = Int_total_lambda2(1:length(dq1_Ka2));
    Int_004_lambda2 = Int_total_lambda2(length(dq1_Ka2)+1:end);

Int_total_beta      = Int_correction_Kb .* (abs(Ftot_Kb)).^2;
    Int_002_beta    = Int_total_beta(1:length(dq1_Kb));
    Int_004_beta    = Int_total_beta(length(dq1_Kb)+1:end);
    
    
%% Pseudo-Voigt broadening
IntVoigt_002 = zeros(1, length(twotheta_002));
IntVoigt_004 = zeros(1, length(twotheta_004));

for j = 1:length(twotheta_002)
    center_002 = twotheta_002(j);
    voight_fit_002 = const.PV.y0_002 +...
        (const.PV.AG_002/(const.PV.wG_002 * sqrt(2 * pi)))* exp(-((twotheta_002 - center_002)/(sqrt(2) * const.PV.wG_002)).^2) +...
        (const.PV.AL_002/pi) * (const.PV.wL_002./((twotheta_002 - center_002).^2 + const.PV.wL_002^2)) +...
        (const.PV.AG2_002/(const.PV.wG2_002 * sqrt(2*pi)))* exp(-((twotheta_002-center_002)/(sqrt(2) * const.PV.wG2_002)).^2) +...
        (const.PV.AL2_002/pi) * (const.PV.wL2_002./((twotheta_002-center_002).^2 + const.PV.wL2_002^2));
    gauss_fit_Kbeta_200 = (const.G.AG3_002/(const.G.wG3_002 * sqrt(2 * pi)))* exp(-((twotheta_002 - center_002)/(sqrt(2) * const.G.wG3_002)).^2);
    IntVoigt_002(j) = voight_fit_002 * (Int_002_lambda1' + 0.5 * Int_002_lambda2') +  0.2 * gauss_fit_Kbeta_200 * Int_002_beta';
end

for j = 1:length(twotheta_004)
    center_004 = twotheta_004(j);
    voight_fit_004 = const.PV.y0_004 +...
        (const.PV.AG_004/(const.PV.wG_004 * sqrt(2 * pi)))* exp(-((twotheta_004 - center_004)/(sqrt(2) * const.PV.wG_004)).^2) +...
        (const.PV.AL_004/pi) * (const.PV.wL_004./((twotheta_004 - center_004).^2 + const.PV.wL_004^2)) +...
        (const.PV.AG2_004/(const.PV.wG2_004 * sqrt(2*pi)))* exp(-((twotheta_004 - center_004)/(sqrt(2) * const.PV.wG2_004)).^2) +...
        (const.PV.AL2_004/pi) * (const.PV.wL2_004./((twotheta_004 - center_004).^2 + const.PV.wL2_004^2));
    gauss_fit_Kbeta_400 = (const.G.AG3_004/(const.G.wG3_004 * sqrt(2 * pi)))* exp(-((twotheta_004 - center_004)/(sqrt(2) * const.G.wG3_004)).^2);
    IntVoigt_004(j) = voight_fit_004 * (Int_004_lambda1' + 0.5 * Int_004_lambda2') +  0.2 * gauss_fit_Kbeta_400 * Int_004_beta';
end


IntVoigt_002 = IntVoigt_002 / max(IntVoigt_002); % peaks (002) and (004) anre normalized
IntVoigt_004 = IntVoigt_004 / max(IntVoigt_004);

end
