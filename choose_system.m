function [f_a_mat, f_b_mat, d_a, d_b, mu] = choose_system(system, d_a_new, d_b_new, f, a, divide_uc, mass, MassAttenuation, density)

switch system
    case 1 % TNS/HNS
        f_a_mat = f.Ti + f.Sn;
        f_b_mat = f.Hf + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.TNS/divide_uc;
            d_b = a.HNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.TNS_HNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + mass.Hf;
            fraction.TNS_HNS.Ti = mass.Ti/mass.TNS_HNS;
            fraction.TNS_HNS.Ni = 2*mass.Ni/mass.TNS_HNS;
            fraction.TNS_HNS.Sn = 2*mass.Sn/mass.TNS_HNS;
            fraction.TNS_HNS.Hf = mass.Hf/mass.TNS_HNS;
            
        MassAttenuation.TNS_HNS = MassAttenuation.Ti * fraction.TNS_HNS.Ti +...
                                MassAttenuation.Ni * fraction.TNS_HNS.Ni +...
                                MassAttenuation.Sn * fraction.TNS_HNS.Sn +...
                                MassAttenuation.Hf * fraction.TNS_HNS.Hf;

        mu = MassAttenuation.TNS_HNS * (density.TNS + density.HNS)/2; % (1/cm)
        mu = mu/0.01;

    case 2 % HNS/TNS
        f_a_mat = f.Hf + f.Sn;
        f_b_mat = f.Ti + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.HNS/divide_uc;
            d_b = a.TNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.TNS_HNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + mass.Hf;
            fraction.TNS_HNS.Ti = mass.Ti/mass.TNS_HNS;
            fraction.TNS_HNS.Ni = 2*mass.Ni/mass.TNS_HNS;
            fraction.TNS_HNS.Sn = 2*mass.Sn/mass.TNS_HNS;
            fraction.TNS_HNS.Hf = mass.Hf/mass.TNS_HNS;
            
        MassAttenuation.TNS_HNS = MassAttenuation.Ti * fraction.TNS_HNS.Ti +...
                                MassAttenuation.Ni * fraction.TNS_HNS.Ni +...
                                MassAttenuation.Sn * fraction.TNS_HNS.Sn +...
                                MassAttenuation.Hf * fraction.TNS_HNS.Hf;

        mu = MassAttenuation.TNS_HNS * (density.TNS + density.HNS)/2; % (1/cm)
        mu = mu/0.01;

    case 3 % TNS/ZHNS
        f_a_mat = f.Ti + f.Sn;
        f_b_mat = f.Sn + 0.5*(f.Hf + f.Zr);

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.TNS/divide_uc;
            d_b = a.ZHNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.TNS_ZHNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
            fraction.TNS_ZHNS.Ti = mass.Ti/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Ni = 2*mass.Ni/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Sn = 2*mass.Sn/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Hf = 0.5*mass.Hf/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Zr = 0.5*mass.Zr/mass.TNS_ZHNS;
            
        MassAttenuation.TNS_ZHNS = MassAttenuation.Ti * fraction.TNS_ZHNS.Ti +...
                                MassAttenuation.Ni * fraction.TNS_ZHNS.Ni +...
                                MassAttenuation.Sn * fraction.TNS_ZHNS.Sn +...
                                MassAttenuation.Hf * fraction.TNS_ZHNS.Hf + ...
                                MassAttenuation.Zr * fraction.TNS_ZHNS.Zr;

        mu = MassAttenuation.TNS_ZHNS * (density.TNS + density.ZHNS)/2; % (1/cm)
        mu = mu/0.01;

    case 4 % ZHNS/TNS
        f_a_mat = f.Sn + 0.5*(f.Hf + f.Zr);
        f_b_mat = f.Ti + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.ZHNS/divide_uc;
            d_b = a.TNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.TNS_ZHNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
            fraction.TNS_ZHNS.Ti = mass.Ti/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Ni = 2*mass.Ni/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Sn = 2*mass.Sn/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Hf = 0.5*mass.Hf/mass.TNS_ZHNS;
            fraction.TNS_ZHNS.Zr = 0.5*mass.Zr/mass.TNS_ZHNS;
            
        MassAttenuation.TNS_ZHNS = MassAttenuation.Ti * fraction.TNS_ZHNS.Ti +...
                                MassAttenuation.Ni * fraction.TNS_ZHNS.Ni +...
                                MassAttenuation.Sn * fraction.TNS_ZHNS.Sn +...
                                MassAttenuation.Hf * fraction.TNS_ZHNS.Hf + ...
                                MassAttenuation.Zr * fraction.TNS_ZHNS.Zr;

        mu = MassAttenuation.TNS_ZHNS * (density.TNS + density.ZHNS)/2; % (1/cm)
        mu = mu/0.01;

    case 5 % HNS/ZHNS
        f_a_mat = f.Hf + f.Sn;
        f_b_mat = f.Sn + 0.5*(f.Hf + f.Zr);

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.HNS/divide_uc;
            d_b = a.ZHNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.HNS_ZHNS = mass.Hf + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
            fraction.HNS_ZHNS.Zr = 0.5 * mass.Zr/mass.HNS_ZHNS;
            fraction.HNS_ZHNS.Ni = 2*mass.Ni/mass.HNS_ZHNS;
            fraction.HNS_ZHNS.Sn = 2*mass.Sn/mass.HNS_ZHNS;
            fraction.HNS_ZHNS.Hf = 1.5*mass.Hf/mass.HNS_ZHNS;
            
        MassAttenuation.HNS_ZHNS = MassAttenuation.Hf * fraction.HNS_ZHNS.Ti +...
                                MassAttenuation.Ni * fraction.HNS_ZHNS.Ni +...
                                MassAttenuation.Sn * fraction.HNS_ZHNS.Sn +...
                                MassAttenuation.Hf * fraction.HNS_ZHNS.Hf + ...
                                MassAttenuation.Zr * fraction.HNS_ZHNS.Zr;

        mu = MassAttenuation.HNS_ZHNS * (density.HNS + density.ZHNS)/2; % (1/cm)
        mu = mu/0.01;

    case 6 % ZHNS/HNS
        f_a_mat = f.Sn + 0.5*(f.Hf + f.Zr);
        f_b_mat = f.Hf + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.ZHNS/divide_uc;
            d_b = a.HNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.HNS_ZHNS = mass.Hf + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
            fraction.HNS_ZHNS.Zr = 0.5 * mass.Zr/mass.HNS_ZHNS;
            fraction.HNS_ZHNS.Ni = 2*mass.Ni/mass.HNS_ZHNS;
            fraction.HNS_ZHNS.Sn = 2*mass.Sn/mass.HNS_ZHNS;
            fraction.HNS_ZHNS.Hf = 1.5*mass.Hf/mass.HNS_ZHNS;
            
        MassAttenuation.HNS_ZHNS = MassAttenuation.Hf * fraction.HNS_ZHNS.Ti +...
                                MassAttenuation.Ni * fraction.HNS_ZHNS.Ni +...
                                MassAttenuation.Sn * fraction.HNS_ZHNS.Sn +...
                                MassAttenuation.Hf * fraction.HNS_ZHNS.Hf + ...
                                MassAttenuation.Zr * fraction.HNS_ZHNS.Zr;

        mu = MassAttenuation.HNS_ZHNS * (density.HNS + density.ZHNS)/2; % (1/cm)
        mu = mu/0.01;

    case 7 % ZNS/TNS
        f_a_mat = f.Zr + f.Sn;
        f_b_mat = f.Ti + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.ZNS/divide_uc;
            d_b = a.TNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.TNS_ZNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + mass.Zr;
            fraction.TNS_ZNS.Ti = mass.Ti/mass.TNS_ZNS;
            fraction.TNS_ZNS.Ni = 2*mass.Ni/mass.TNS_ZNS;
            fraction.TNS_ZNS.Sn = 2*mass.Sn/mass.TNS_ZNS;
            fraction.TNS_ZNS.Zr = mass.Zr/mass.TNS_ZNS;
            
        MassAttenuation.TNS_ZNS = MassAttenuation.Ti * fraction.TNS_ZNS.Ti +...
                                MassAttenuation.Ni * fraction.TNS_ZNS.Ni +...
                                MassAttenuation.Sn * fraction.TNS_ZNS.Sn +...
                                MassAttenuation.Zr * fraction.TNS_ZNS.Zr;

        mu = MassAttenuation.ZNS_HNS * (density.TNS + density.ZNS)/2; % (1/cm)
        mu = mu/0.01; % (1/m)

    case 8 % TNS/ZNS
        f_a_mat = f.Ti + f.Sn;
        f_b_mat = f.Zr + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.TNS/divide_uc;
            d_b = a.ZNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.TNS_ZNS = mass.Ti + 2*mass.Ni + 2*mass.Sn + mass.Zr;
            fraction.TNS_ZNS.Ti = mass.Ti/mass.TNS_ZNS;
            fraction.TNS_ZNS.Ni = 2*mass.Ni/mass.TNS_ZNS;
            fraction.TNS_ZNS.Sn = 2*mass.Sn/mass.TNS_ZNS;
            fraction.TNS_ZNS.Zr = mass.Zr/mass.TNS_ZNS;
            
        MassAttenuation.TNS_ZNS = MassAttenuation.Ti * fraction.TNS_ZNS.Ti +...
                                MassAttenuation.Ni * fraction.TNS_ZNS.Ni +...
                                MassAttenuation.Sn * fraction.TNS_ZNS.Sn +...
                                MassAttenuation.Zr * fraction.TNS_ZNS.Zr;

        mu = MassAttenuation.ZNS_HNS * (density.TNS + density.ZNS)/2; % (1/cm)
        mu = mu/0.01; % (1/m)

    case 9 % ZNS/HNS
        f_a_mat = f.Zr + f.Sn;
        f_b_mat = f.Hf + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.ZNS/divide_uc;
            d_b = a.HNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.ZNS_HNS = mass.Zr + 2*mass.Ni + 2*mass.Sn + mass.Hf;
            fraction.ZNS_HNS.Zr = mass.Zr/mass.ZNS_HNS;
            fraction.ZNS_HNS.Ni = 2*mass.Ni/mass.ZNS_HNS;
            fraction.ZNS_HNS.Sn = 2*mass.Sn/mass.ZNS_HNS;
            fraction.ZNS_HNS.Hf = mass.Hf/mass.ZNS_HNS;
            
        MassAttenuation.ZNS_HNS = MassAttenuation.Zr * fraction.ZNS_HNS.Zr +...
                                MassAttenuation.Ni * fraction.ZNS_HNS.Ni +...
                                MassAttenuation.Sn * fraction.ZNS_HNS.Sn +...
                                MassAttenuation.Hf * fraction.ZNS_HNS.Hf;

        mu = MassAttenuation.ZNS_HNS * (density.ZNS + density.HNS)/2; % (1/cm)
        mu = mu/0.01; % (1/m)

    case 10 % HNS/ZNS
        f_a_mat = f.Hf + f.Sn;
        f_b_mat = f.Zr + f.Sn;

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.HNS/divide_uc;
            d_b = a.ZNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.ZNS_HNS = mass.Zr + 2*mass.Ni + 2*mass.Sn + mass.Hf;
            fraction.ZNS_HNS.Zr = mass.Zr/mass.ZNS_HNS;
            fraction.ZNS_HNS.Ni = 2*mass.Ni/mass.ZNS_HNS;
            fraction.ZNS_HNS.Sn = 2*mass.Sn/mass.ZNS_HNS;
            fraction.ZNS_HNS.Hf = mass.Hf/mass.ZNS_HNS;
            
        MassAttenuation.ZNS_HNS = MassAttenuation.Zr * fraction.ZNS_HNS.Zr +...
                                MassAttenuation.Ni * fraction.ZNS_HNS.Ni +...
                                MassAttenuation.Sn * fraction.ZNS_HNS.Sn +...
                                MassAttenuation.Hf * fraction.ZNS_HNS.Hf;

        mu = MassAttenuation.ZNS_HNS * (density.ZNS + density.HNS)/2; % (1/cm)
        mu = mu/0.01; % (1/m)

    case 11 % ZNS/ZHNS
        f_a_mat = f.Zr + f.Sn;
        f_b_mat = f.Sn + 0.5*(f.Hf + f.Zr);

        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.ZNS/divide_uc;
            d_b = a.ZHNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.ZNS_ZHNS = mass.Zr + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
            fraction.ZNS_ZHNS.Zr = 1.5 * mass.Zr/mass.ZNS_ZHNS;
            fraction.ZNS_ZHNS.Ni = 2*mass.Ni/mass.ZNS_ZHNS;
            fraction.ZNS_ZHNS.Sn = 2*mass.Sn/mass.ZNS_ZHNS;
            fraction.ZNS_ZHNS.Hf = 0.5*mass.Hf/mass.ZNS_ZHNS;
            
        MassAttenuation.ZNS_ZHNS = MassAttenuation.Zr * fraction.ZNS_ZHNS.Zr +...
                    MassAttenuation.Ni * fraction.ZNS_ZHNS.Ni +...
                    MassAttenuation.Sn * fraction.ZNS_ZHNS.Sn +...
                    MassAttenuation.Hf * fraction.ZNS_ZHNS.Hf;

        mu = MassAttenuation.ZNS_ZHNS * (density.ZNS + density.ZHNS)/2; % (1/cm)
        mu = mu/0.01;

    case 12 % ZHNS/ZNS
        f_a_mat = f.Sn + 0.5*(f.Hf + f.Zr);
        f_b_mat = f.Zr + f.Sn;


        if isnan(d_a_new) || isnan(d_b_new)
            d_a = a.ZHNS/divide_uc;
            d_b = a.ZNS/divide_uc;
        else
            d_a = d_a_new/divide_uc;
            d_b = d_b_new/divide_uc;
        end
        
        mass.ZNS_ZHNS = mass.Zr + 2*mass.Ni + 2*mass.Sn + 0.5*mass.Hf + 0.5*mass.Zr;
            fraction.ZNS_ZHNS.Zr = 1.5 * mass.Zr/mass.ZNS_ZHNS;
            fraction.ZNS_ZHNS.Ni = 2*mass.Ni/mass.ZNS_ZHNS;
            fraction.ZNS_ZHNS.Sn = 2*mass.Sn/mass.ZNS_ZHNS;
            fraction.ZNS_ZHNS.Hf = 0.5*mass.Hf/mass.ZNS_ZHNS;
            
        MassAttenuation.ZNS_ZHNS = MassAttenuation.Zr * fraction.ZNS_ZHNS.Zr +...
                    MassAttenuation.Ni * fraction.ZNS_ZHNS.Ni +...
                    MassAttenuation.Sn * fraction.ZNS_ZHNS.Sn +...
                    MassAttenuation.Hf * fraction.ZNS_ZHNS.Hf;

        mu = MassAttenuation.ZNS_ZHNS * (density.ZNS + density.ZHNS)/2; % (1/cm)
        mu = mu/0.01;

end