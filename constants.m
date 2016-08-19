%% Description
% Read the body of this function to find out the details.
%==========================================================================
% Input:
% - system - integer from the range 1-3. Is used to choose from one of the
%       following material systems: 
%       1 = V, 2 = substrate/TiNnSn/HfNiSn, 3 = substrate/HfNiSn/TiNiSn,
%==========================================================================
% Created by Paulina Komar   &   Gerhard Jakob
% holuj@uni-mainz.de             jakob@uni-mainz.de
% komarpaulina@outlook.com
% Last modified August 2016
%==========================================================================

function const = constants(system)

if system == 1
    const.divide_uc = 2; % V has bcc unit cell and can be divided into 2 layers
else
    const.divide_uc = 4; % HH materials can be divided into 4 atomic layers
end


%% Cu radiation wavelength (A)
const.lambda_Ka1 = 1.54056;
const.lambda_Ka2 = 1.54439;
const.lambda_Kb  = 1.39217;

%% Parameters to calculate the atomic scattering factor
% taken from the International Tables for X-ray Crystallography

% Vanadium
const.a.V = [10.2971 7.3511  2.0703   2.0571];  % see Eq.(7) in Supplementary Material
const.b.V = [ 6.8657 0.4385 26.8938 102.478];   % see Eq.(7) in Supplementary Material
const.c.V = [ 1.2199 0       0        0];       % see Eq.(7) in Supplementary Material
const.B.V = 0.5855; % A^2                       % Debye-Waller factor
const.disp_corr_1.V = 0.2;                      % Delta f'  - see Eq.(8) in Supplementary Material
const.disp_corr_2.V = 2.3;                      % Delta f'' - see Eq.(8) in Supplementary Material

% Ti
const.a.Ti = [9.7595 7.3558 1.6991   1.9021];
const.b.Ti = [7.8508 0.500 35.6338 116.105];
const.c.Ti = [1.2807  0     0      0];
const.B.Ti = 0.5261; % A^2
const.disp_corr_1.Ti = 0.2;
const.disp_corr_2.Ti = 1.9;

% Ni
const.a.Ni = [12.838 7.292  4.444  2.380];
const.b.Ni = [ 3.878 0.257 12.176 66.342];
const.c.Ni = [ 1.034 0      0      0];
const.B.Ni = 0.3644; % A^2
const.disp_corr_1.Ni = -3.1;
const.disp_corr_2.Ni = 0.6;

% Zr
const.a.Zr = [17.87650 10.948 5.417320  3.65721];
const.b.Zr = [ 1.27618 11.916 0.117622 87.66270];
const.c.Zr = [ 2.06929 0      0         0];
const.B.Zr = 0.5822; % A^2
const.disp_corr_1.Zr = -0.6;
const.disp_corr_2.Zr = 2.5;

% Sn
const.a.Sn = [19.189 19.101  4.458  2.466];
const.b.Sn = [ 5.830  0.503 26.891 83.957];
const.c.Sn = [ 4.782  0      0      0];
const.B.Sn = 1.1596; % A^2
const.disp_corr_1.Sn = -0.7;
const.disp_corr_2.Sn = 5.8;

% Hf
const.a.Hf = [29.144 15.173 14.759  4.300];
const.b.Hf = [ 1.833  9.600  0.275 72.029];
const.c.Hf = [ 8.582  0      0      0];
const.B.Hf = 0.41; % A^2
const.disp_corr_1.Hf = -7;
const.disp_corr_2.Hf = 5;


%% lattice constant (A)           density (g/cm3)
const.d.TNS  = 5.94;              const.density.TNS  = 7.14;
const.d.ZHNS = 6.1082;            const.density.ZHNS = 9.101;
const.d.ZNS  = 6.11;              const.density.ZNS  = 7.822;
const.d.HNS  = 6.08;              const.density.HNS  = 10.517;
const.d.V    = 3.02;              const.density.V    = 6.11;
            
%% MassAttenuation mu/rho (cm2/g), see Eq.(10) in Supplementary Material           
const.masAbsCoeff_alpha.V  = 222.6;   const.masAbsCoeff_beta.V  = 168.0;
const.masAbsCoeff_alpha.Ti = 202.4;   const.masAbsCoeff_beta.Ti = 153.2;
const.masAbsCoeff_alpha.Ni = 48.8;    const.masAbsCoeff_beta.Ni = 282.8;
const.masAbsCoeff_alpha.Zr = 136.8;   const.masAbsCoeff_beta.Zr = 101.3;
const.masAbsCoeff_alpha.Sn = 253.3;   const.masAbsCoeff_beta.Sn = 193.1;
const.masAbsCoeff_alpha.Hf = 157.7;   const.masAbsCoeff_beta.Hf = 121.0;

%% mass(g/mol)                    density (g/cm3)
const.mass.V  = 50.94;            const.density.V  = 6.11;
const.mass.Ti = 47.87;            const.density.Ti = 4.506;
const.mass.Ni = 58.69;            const.density.Ni = 8.90;
const.mass.Zr = 91.22;            const.density.Zr = 6.52;
const.mass.Sn = 118.71;           const.density.Sn = 7.287;
const.mass.Hf = 178.5;            const.density.Hf = 13.3;

%% Pseudo-Voigt broadening parameters
% y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) +,...
%      (AL/pi)*(wL./((x-xc)^2 + wL^2)) +,...
%      (AG2/(wG2*sqrt(2*pi)))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) +,...
%      (AL2/pi)*(wL2./((x-xc2)^2 + wL2^2)) +,...
%      (AG3/(wG3*sqrt(2*pi)))*exp(-((x-xc3)/(sqrt(2)*wG3))^2)
% parameters for the SL, 002 peak - based on (002) TiNiSn - Ka1 and Ka2
const.PV.AG_002  = 1.925E4;        const.PV.AG2_002 = 6902;    
const.PV.AL_002  = 1.013E4;        const.PV.AL2_002 = 1.009e+4;
const.PV.wG_002  = 0.04648;        const.PV.wG2_002 = 0.05624;
const.PV.wL_002  = 0.06108;        const.PV.wL2_002 = 0.0621;
const.PV.y0_002  = 0.003465;

% Kb - modeled with Gauss
const.G.AG3_002 = 18.78;
const.G.wG3_002 = 0.06508;

% parameters for the SL, 004 peak - based on (004) TiNiSn
const.PV.AG_004  = 4363;        const.PV.AG2_004 = 6232;
const.PV.AL_004  = 7451;        const.PV.AL2_004 = 3101;
const.PV.wG_004  = 0.1015;      const.PV.wG2_004 = 0.1141;
const.PV.wL_004  = 0.1033;      const.PV.wL2_004 = 0.1205;
const.PV.y0_004  = 0.003979;

% Kb - modeled with Gauss
const.G.AG3_004 = 250;
const.G.wG3_004 = 0.13;
