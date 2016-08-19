%% Description
% The function "run_CADEM" is an alternative way of starting "CADEM" compared
% to the GUI.
%==========================================================================
% Input:
% - conffile - is a configuration file in .txt or .dat format that contains
%       all details about the investigated system.
%       The configuration file consists of 17 rows and 2 columns. The fist 
%       column contains description of the parameter that is specified in 
%       the second column. Detailed description:
%       1. system 
%          is equal to one of the following: 1 for V, 2 for a stack
%          substrate/TiNiSn/HfNiSn..., 3 for a stack substrate/HfNiSn/TiNiSn....
%       2. 2theta_002_from
%          is the starting value of 2theta for the calculation of (002) reflection.
%       3. 2theta_002_step
%          is the calculation step for (002) reflection.
%       4. 2theta_002_to
%          is the final value of 2theta for the calculation of (002) reflection.
%       5. 2theta_004_from 
%          is the starting value of 2theta for the calculation of (004) reflection.
%       6. 2theta_004_step 
%          is the calculation step for (004) reflection.
%       7. 2theta_004_to
%          is the final value of 2theta for the calculation of (004) reflection.
%       8. layerA_latticeconstant_A 
%          is the lattice constant (in angstrom) of a layer that lies on 
%          top of the substrate. In case of system = 2, layer A is TiNiSn.
%       9. layerB_latticeconstant_A
%          is the lattice constant (in angstrom) of the layer B. In case of
%          system = 2, layer B is HfNiSn.
%       10. periodicArrangement
%          is an argument that allows to specify if the investigated layer 
%          arrangement is periodic (then set value equal to 1) or non-periodic
%          (any other value). Periodic arrangement means a SL with well 
%          defined SL period and number of bilayers. Non-periodic arrangement
%          can be any arbitrary layer stack that will be loaded from a file. 
%          For details about the file structure see point 14.
%       11. layerA_thickness_uc
%          is the thickness of layer A in unit cells. In case of system = 2,
%          layer A is TiNiSn.
%       12. layerB_thickness_uc
%          is the thickness of layer B in unit cells. In case of system = 2,
%          layer B is HfNiSn.
%       13. numberOfbilayers
%          is an integer number of periods (bilayers) of the periodic layer 
%          arrangement. E.g. by setting this value to 1 and layerB_thickness_uc = 0
%          one can study finite size oscillations of layer A.
%       14. non-periodicArrangement_file
%          a path to the file that contains non-periodic layer arrangement, 
%          e.g. ArbitraryStack1.dat. A file can have .txt or .dat extension. 
%          It must contain an even number of elements. Assuming system = 2,
%          a series of numbers [13; 14; 2; 8] saved in a file will mean: 
%          substrate/TiNiSn(13uc)/HfNiSn(14uc)/TiNiSn(2uc)/HfNiSn(8uc), 
%          conversely [13; 14; 2; 0] will skip the last HfNiSn layer, 
%          however, it must be specified for correct operation of the program.
%       15. numberOfUnitCellsOfIntermixing
%          is the length (in unit cells) at the interface, where the 
%          intermixing takes place.
%       16. VanadiumLayer_latticeconstant_A
%          is the lattice constant of vanadium in unit cells. Must be 
%          specified if system = 1.
%       17. VanadiumLayer_thickness_uc
%          is the thickness of vanadium in unit cells. Must be specified if
%          system = 1.
% The files cf1.dat ... cf5.dat are few examples of configuration files.
%==========================================================================
% Created by Paulina Komar   &   Gerhard Jakob
% holuj@uni-mainz.de             jakob@uni-mainz.de
% komarpaulina@outlook.com
% Last modified August 2016
%==========================================================================

function run_CADEM(conffile)

[names, values] = textread(conffile, '%s %s');

system        = str2num(values{1});                                               % specify the system 
twotheta_002  = str2num(values{2}) : str2num(values{3}) : str2num(values{4});     % angular ranges in degrees
twotheta_004  = str2num(values{5}) : str2num(values{6}) : str2num(values{7});

const = constants(system);
if system == 1 || system == 4
    const.d_a_new = str2num(values{16});               % lattice spacing
    const.d_b_new = str2num(values{16});
    n = 0;
    stack = [str2num(values{17}) 0];
else 
    if str2num(values{10}) == 1 % create a stack
        for i = 1:str2num(values{13})
            stack(2*i-1) = str2num(values{11});
            stack(2*i)   = str2num(values{12});
        end
    else
        stack = importdata(values{14});
    end
    const.d_a_new = str2num(values{8});                % lattice spacing of layer A
    const.d_b_new = str2num(values{9});                % lattice spacing of layer B
    n = str2num(values{15});  % number of atomic planes with affected d at the interface 
end

% calculate atomic scattering factor
f = atomicScatteringFactor(const, twotheta_002, twotheta_004);

% calculate XRD intensity
[IntVoigt_002, IntVoigt_004, effective_stack] = CADEM(stack,...
                            const, f, twotheta_002, twotheta_004, system, n);

% write calculated data to the .dat file
csvwrite('CalculatedPattern.dat', [[twotheta_002;IntVoigt_002], [twotheta_004;IntVoigt_004]]');

%% Plot results
f1 = figure('units', 'centimeters', 'position', [5000 5000 24 16]);
movegui(f1,'center');
measured = importdata('M4A6_XRD.dat');
% Plot layer stack
subplot(2,2,1:2)
    bar(effective_stack)
    title('Arrangement of the layers');
    xlabel('Ordinal number of a layer', 'fontsize', 15);
    ylabel('thickness (uc)', 'fontsize', 15);
    set(gca, 'fontsize', 15);
    if length(effective_stack)>10
        set(gca, 'XTick', round(linspace(1,length(effective_stack),10)));
    end
    grid on, box on;
    
% Plot calculated XRD
subplot(2,2,3)
    semilogy(twotheta_002, IntVoigt_002, 'linewidth', 1.5); hold on;
    semilogy(measured(:,1), smooth(measured(:,2))/max(measured(1:405,2)), 'k');
        xlabel('2\theta (°)', 'fontsize', 15);
        xlim([25 35]);
        ylim([1e-3 1]);
        xlim([twotheta_002(1) twotheta_002(length(twotheta_002))]);
        title('002 reflection');
        ylabel('I/I_{max}', 'fontsize', 15);
        set(gca, 'fontsize', 15);
        box on, grid on;
subplot(2,2,4)
    semilogy(twotheta_004, IntVoigt_004, 'linewidth', 1.5); hold on;
    semilogy(measured(:,1), measured(:,2), 'k');
        xlim([55 66]);
        xlabel('2\theta (°)', 'fontsize', 15);
        xlim([twotheta_004(1) twotheta_004(length(twotheta_004))]);
        title('004 reflection');
%         ylabel('I/I_{max}', 'fontsize', 15);
        set(gca, 'fontsize', 15);
        box on, grid on;
