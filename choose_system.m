%% Description
%==========================================================================
% Input:
% - system - integer from the range 1-2. Is used to choose from one of the
%       following material systems: 
%       1 = V, 2 = substrate/TiNnSn/HfNiSn, 3 = substrate/HfNiSn/TiNiSn,
% - f - a structure containing angle dependent atomic scattering factors for
%       Ti, Ni, Zr, Sn, Hf
% - const - a structure containing all material dependent constants. For
%       detailed information read the description of constants.m function.
% Output:
% - f - a structure containing angle dependent atomic scattering factors for
%       Ti, Ni, Zr, Sn, Hf and the mixed layers for specified material
%       system, e.g. for TiNnSn/HfNiSn f.a_mat = (f.Ti + f.Sn)/2; and
%       f.b_mat = (f.Hf + f.Sn)/2;
% - const - a structure containing all material dependent constants. For
%       detailed information read the description of constants.m function.
%       In the function "choose_system" the structure is updated with the 
%       values of linear attenuation coefficients (const.mu_1 and const.mu_2)
%       as well as current spacing between the layers of materials a and b 
%       (const.d_a and const.d_b). These are lattice parameters divided by 
%       number of layers in one unit cell.
%==========================================================================
% Created by Paulina Komar   &   Gerhard Jakob
% holuj@uni-mainz.de             jakob@uni-mainz.de
% komarpaulina@outlook.com
% Last modified August 2016
%==========================================================================

function [f, const] = choose_system(system, f, const, stack)

%% Calculate mass absorption coefficients

switch system
    case 1 % Vanadium
        f.Ka1.a1 = f.Ka1.V;  % assign atomic scattering factor to a variable f.Ka1.a1...  
        f.Ka2.a1 = f.Ka2.V;  % that is used in the function CADEM
        f.Kb.a1  = f.Kb.V;
        f.Ka1.a2 = f.Ka1.V;  % assign atomic scattering factor to a variable f.Ka1.a2...  
        f.Ka2.a2 = f.Ka2.V;  % that is used in the function CADEM
        f.Kb.a2  = f.Kb.V;
    
    if isnan(const.d_a_new)     % if you do not specify a new value of lattice constant (const.d_a_new),
        const.d_a = const.d.V/const.divide_uc;       % the bulk value will be used
    else                                             % otherwise,
        const.d_a = const.d_a_new/const.divide_uc;   % a value specified by a user will be used
    end
    
    % calculate the linear attenuation coefficient for Cu Kalpha and Kbeta radiation wavelengths
    const.mu_Ka = const.masAbsCoeff_alpha.V * const.density.V; % (1/cm)
    const.mu_Ka = const.mu_Ka/0.01; % (1/m)
    
    const.mu_Kb = const.masAbsCoeff_beta.V * const.density.V; % (1/cm)
    const.mu_Kb = const.mu_Kb/0.01; % (1/m)
        
    case 2 % TNS/HNS = material a/b
        f.Ka1.a1 = f.Ka1.Ti + f.Ka1.Sn;    % calculate atomic scattering factor
        f.Ka2.a1 = f.Ka2.Ti + f.Ka2.Sn;
        f.Kb.a1  = f.Kb.Ti  + f.Kb.Sn;
        f.Ka1.a2 = f.Ka1.Ni;
        f.Ka2.a2 = f.Ka2.Ni;
        f.Kb.a2  = f.Kb.Ni;
        
        f.Ka1.b1 = f.Ka1.Hf + f.Ka1.Sn;
        f.Ka2.b1 = f.Ka2.Hf + f.Ka2.Sn;
        f.Kb.b1  = f.Kb.Hf  + f.Kb.Sn;
        f.Ka1.b2 = f.Ka1.Ni;
        f.Ka2.b2 = f.Ka2.Ni;
        f.Kb.b2  = f.Kb.Ni;

        if isnan(const.d_a_new) || isnan(const.d_b_new)
            const.d_a = const.d.TNS/const.divide_uc;
            const.d_b = const.d.HNS/const.divide_uc;
        else
            const.d_a = const.d_a_new/const.divide_uc;
            const.d_b = const.d_b_new/const.divide_uc;
        end
        
        for i = 1:length(stack)/2
            t_TNS(i) = stack(2*i-1);    % thickness of TiNiSn in uc
            t_HNS(i) = stack(2*i);      % thickness of HfNiSn in uc
        end
        
        t_TNS_tot = sum(t_TNS);         
        t_HNS_tot = sum(t_HNS);
        t_tot     = sum(stack);         % total thickness in uc
        
        % TiSn layer
        const.mass.TiNiSn              = const.mass.Ti + const.mass.Ni + const.mass.Sn;
        const.masAbsCoeff_alpha.TiNiSn = const.masAbsCoeff_alpha.Ti * const.mass.Ti/const.mass.TiNiSn +...
            const.masAbsCoeff_alpha.Ni * const.mass.Ni/const.mass.TiNiSn +...
            const.masAbsCoeff_alpha.Sn * const.mass.Sn/const.mass.TiNiSn;
        const.mu_TiNiSn_Ka             = const.masAbsCoeff_alpha.TiNiSn * const.density.TNS; % (1/cm)
        const.mu_TiNiSn_Ka             = const.mu_TiNiSn_Ka/0.01; % linear absorption coefficient for material a for Cu Ka1

        const.masAbsCoeff_beta.TiNiSn  = const.masAbsCoeff_beta.Ti * const.mass.Ti/const.mass.TiNiSn +...
            const.masAbsCoeff_beta.Ni * const.mass.Ni/const.mass.TiNiSn +...
            const.masAbsCoeff_beta.Sn * const.mass.Sn/const.mass.TiNiSn;
        const.mu_TiNiKb.Sn             = const.masAbsCoeff_beta.TiNiSn * const.density.TNS; % (1/cm)
        const.mu_TiNiKb.Sn             = const.mu_TiNiKb.Sn/0.01; % linear absorption coefficient for material a for Cu Ka2

        % HfSn layer
        const.mass.HfNiSn              = const.mass.Hf + const.mass.Ni + const.mass.Sn;
        const.masAbsCoeff_alpha.HfNiSn = const.masAbsCoeff_alpha.Hf * const.mass.Hf/const.mass.HfNiSn +...
            const.masAbsCoeff_alpha.Ni * const.mass.Ni/const.mass.HfNiSn +...
            const.masAbsCoeff_alpha.Sn * const.mass.Sn/const.mass.HfNiSn;
        const.mu_HfNiSn_Ka             = const.masAbsCoeff_alpha.HfNiSn * const.density.HNS; % (1/cm)
        const.mu_HfNiSn_Ka             = const.mu_HfNiSn_Ka/0.01; % linear absorption coefficient for material a for Cu Ka1

        const.masAbsCoeff_beta.HfNiSn  = const.masAbsCoeff_beta.Hf * const.mass.Hf/const.mass.HfNiSn +...
            const.masAbsCoeff_beta.Ni * const.mass.Ni/const.mass.HfNiSn +...
            const.masAbsCoeff_beta.Sn * const.mass.Sn/const.mass.HfNiSn;
        const.mu_HfNiKb.Sn             = const.masAbsCoeff_beta.HfNiSn * const.density.HNS; % (1/cm)
        const.mu_HfNiKb.Sn             = const.mu_HfNiKb.Sn/0.01; % linear absorption coefficient for material a for Cu Ka2

        % The linear attenuation factor for a stack depending on a
        % percentage share of compounds in the total stack
        const.mu_Ka = (const.mu_TiNiSn_Ka * t_TNS_tot + const.mu_HfNiSn_Ka * t_HNS_tot)/t_tot;
        const.mu_Kb = (const.mu_TiNiKb.Sn * t_TNS_tot + const.mu_HfNiKb.Sn * t_HNS_tot)/t_tot;
      

    case 3 % HNS/TNS
        f.Ka1.a1 = f.Ka1.Hf + f.Ka1.Sn;    % calculate atomic scattering factor
        f.Ka2.a1 = f.Ka2.Hf + f.Ka2.Sn;
        f.Kb.a1  = f.Kb.Hf  + f.Kb.Sn;
        f.Ka1.a2 = f.Ka1.Ni;
        f.Ka2.a2 = f.Ka2.Ni;
        f.Kb.a2  = f.Kb.Ni;
        
        f.Ka1.b1 = f.Ka1.Ti + f.Ka1.Sn;
        f.Ka2.b1 = f.Ka2.Ti + f.Ka2.Sn;
        f.Kb.b1  = f.Kb.Ti  + f.Kb.Sn;
        f.Ka1.b2 = f.Ka1.Ni;
        f.Ka2.b2 = f.Ka2.Ni;
        f.Kb.b2  = f.Kb.Ni;

        if isnan(const.d_a_new) || isnan(const.d_b_new)
            const.d_a = const.d.HNS/const.divide_uc;
            const.d_b = const.d.TNS/const.divide_uc;
        else
            const.d_a = const.d_a_new/const.divide_uc;
            const.d_b = const.d_b_new/const.divide_uc;
        end
        
        for i = 1:length(stack)/2
            t_HNS(i) = stack(2*i-1);        % thickness of HfNiSn in uc
            t_TNS(i) = stack(2*i);          % thickness of TiNiSn in uc
        end
        
        t_TNS_tot = sum(t_TNS);
        t_HNS_tot = sum(t_HNS);
        t_tot     = sum(stack);             % total thickness in uc
        
        % TiSn layer
        const.mass.TiNiSn              = const.mass.Ti + const.mass.Ni + const.mass.Sn;
        const.masAbsCoeff_alpha.TiNiSn = const.masAbsCoeff_alpha.Ti * const.mass.Ti/const.mass.TiNiSn +...
            const.masAbsCoeff_alpha.Ni * const.mass.Ni/const.mass.TiNiSn +...
            const.masAbsCoeff_alpha.Sn * const.mass.Sn/const.mass.TiNiSn;
        const.mu_TiNiSn_Ka             = const.masAbsCoeff_alpha.TiNiSn * const.density.TNS; % (1/cm)
        const.mu_TiNiSn_Ka             = const.mu_TiNiSn_Ka/0.01; % linear absorption coefficient for material a for Cu Ka1

        const.masAbsCoeff_beta.TiNiSn  = const.masAbsCoeff_beta.Ti * const.mass.Ti/const.mass.TiNiSn +...
            const.masAbsCoeff_beta.Ni * const.mass.Ni/const.mass.TiNiSn +...
            const.masAbsCoeff_beta.Sn * const.mass.Sn/const.mass.TiNiSn;
        const.mu_TiNiKb.Sn             = const.masAbsCoeff_beta.TiNiSn * const.density.TNS; % (1/cm)
        const.mu_TiNiKb.Sn             = const.mu_TiNiKb.Sn/0.01; % linear absorption coefficient for material a for Cu Ka2

        % HfSn layer
        const.mass.HfNiSn              = const.mass.Hf + const.mass.Ni + const.mass.Sn;
        const.masAbsCoeff_alpha.HfNiSn = const.masAbsCoeff_alpha.Hf * const.mass.Hf/const.mass.HfNiSn +...
            const.masAbsCoeff_alpha.Ni * const.mass.Ni/const.mass.HfNiSn +...
            const.masAbsCoeff_alpha.Sn * const.mass.Sn/const.mass.HfNiSn;
        const.mu_HfNiSn_Ka             = const.masAbsCoeff_alpha.HfNiSn * const.density.HNS; % (1/cm)
        const.mu_HfNiSn_Ka             = const.mu_HfNiSn_Ka/0.01; % linear absorption coefficient for material a for Cu Ka1

        const.masAbsCoeff_beta.HfNiSn  = const.masAbsCoeff_beta.Hf * const.mass.Hf/const.mass.HfNiSn +...
            const.masAbsCoeff_beta.Ni * const.mass.Ni/const.mass.HfNiSn +...
            const.masAbsCoeff_beta.Sn * const.mass.Sn/const.mass.HfNiSn;
        const.mu_HfNiKb.Sn             = const.masAbsCoeff_beta.HfNiSn * const.density.HNS; % (1/cm)
        const.mu_HfNiKb.Sn             = const.mu_HfNiKb.Sn/0.01; % linear absorption coefficient for material a for Cu Ka2
        
        % The linear attenuation factor for a stack depending on a
        % percentage share of compounds in the total stack
        const.mu_Ka = (const.mu_TiNiSn_Ka * t_TNS_tot + const.mu_HfNiSn_Ka * t_HNS_tot)/t_tot;
        const.mu_Kb = (const.mu_TiNiKb.Sn * t_TNS_tot + const.mu_HfNiKb.Sn * t_HNS_tot)/t_tot;
        
end
        
end

