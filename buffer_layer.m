function [f_buffer_1layer, f_buffer_2layer, d_buffer] = buffer_layer(buffer_material, d_buffer_new, a, divide_uc, f)

switch buffer_material
    case 0
        f_buffer_1layer = 0;
        f_buffer_2layer = 0;
        
        if isnan(d_buffer_new)
            d_buffer = a.TNS/divide_uc;
        else
            d_buffer = d_buffer_new/divide_uc;
        end
        
    case 1 % TNS
        f_buffer_1layer = f.Ti + f.Sn;
        f_buffer_2layer = f.Ni;
        
        if isnan(d_buffer_new)
            d_buffer = a.TNS/divide_uc;
        else
            d_buffer = d_buffer_new/divide_uc;
        end
        
    case 2 % HNS
        f_buffer_1layer = f.Hf + f.Sn;
        f_buffer_2layer = f.Ni;
        
        if isnan(d_buffer_new)
            d_buffer = a.HNS/divide_uc;
        else
            d_buffer = d_buffer_new/divide_uc;
        end
        
    case 3 % ZNS
        f_buffer_1layer = f.Zr + f.Sn;
        f_buffer_2layer = f.Ni;
        
        if isnan(d_buffer_new)
            d_buffer = a.ZNS/divide_uc;
        else
            d_buffer = d_buffer_new/divide_uc;
        end
        
    case 4 % ZHNS
        f_buffer_1layer = f.Sn + 0.5*(f.Hf + f.Zr);
        f_buffer_2layer = f.Ni;
        
        if isnan(d_buffer_new)
            d_buffer = a.ZHNS/divide_uc;
        else
            d_buffer = d_buffer_new/divide_uc;
        end
        
    case 5 % V
        f_buffer_1layer = f.V;
        f_buffer_2layer = f.V;
        
        if isnan(d_buffer_new)
            d_buffer = a.V/divide_uc;
        else
            d_buffer = d_buffer_new/divide_uc;
        end
end