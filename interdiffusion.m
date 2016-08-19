function F = interdiffusion(intermixing, divide_uc, N_planes_buffer, N_planes_a, N_planes_b, Nuc_intermixing_a, Nuc_intermixing_b, N_bilayer, F)
% clear all, close all, clc
% 
% intermixing = 1;
% divide_uc = 4;
% N_planes_buffer = 8*4;
% N_planes_a = 23*4;
% N_planes_b = 28*4;
% Nuc_intermixing_a = 5;
% Nuc_intermixing_b = 6;
% N_bilayer = 10;
% F = load('F.mat');
% F = F.F;

N_planes_diff_a = Nuc_intermixing_a * divide_uc;
N_planes_diff_b = Nuc_intermixing_b * divide_uc;


index_0 = find(F==0);
zero(1) = index_0(1) - 1;
for i = 2:length(index_0)-1
    if index_0(i+1) - index_0(i) > 1
        zero(length(zero)+1) = index_0(i+1) - 1;
    end
end

one(1) = 1;
index_1 = find(F==1);
for i = 2:length(index_1)-1
    if index_1(i+1) - index_1(i) > 1
        one(length(one)+1) = index_1(i+1) - 1;
    end
end
one(length(one)+1) = index_1(end);
one(1) = [];

switch intermixing
    case 1 % linear gradient
        for j = 1:N_bilayer
%             k = N_planes_buffer + round(mean(N_planes_a)*4)/4*j + round(mean(N_planes_b)*4)/4*(j-1);            
            if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
                break
            elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
                F(zero(j):zero(j)+N_planes_diff_b+1) = linspace(1,0,N_planes_diff_b+2);
            elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
                F(zero(j)-N_planes_diff_a:zero(j)+1) = linspace(1,0,N_planes_diff_a+2);
            else
                F(zero(j)-N_planes_diff_a:zero(j))     = linspace(1,0.5,N_planes_diff_a+1);
                F(zero(j)+1:zero(j)+N_planes_diff_b+1) = linspace(0.5,0,N_planes_diff_b+1);
            end
        end

        clear j;

        for j = 1:N_bilayer
%             k = N_planes_buffer + (round(mean(N_planes_a)*4)/4 + round(mean(N_planes_b)*4)/4)*j;
            if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
                break
            elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
                F(one(j)-N_planes_diff_b:one(j)+1) = linspace(0,1,N_planes_diff_b+2);
            elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
                F(one(j):one(j)+N_planes_diff_a+1) = linspace(0,1,N_planes_diff_a+2);
            else
                F(one(j)-N_planes_diff_b-1:one(j)-1) = linspace(0,0.5,N_planes_diff_b+1);
                F(one(j):one(j)+N_planes_diff_a)     = linspace(0.5,1,N_planes_diff_a+1);
            end
        end
        
    case 2 % logarithmic gradient
        dispersion_a_up   = logspace(-4, log10(0.5), N_planes_diff_a+1);
        dispersion_b_down = logspace(log10(0.5), -4, N_planes_diff_b+1);

        dispersion_a_down = logspace(log10(0.5), -4, N_planes_diff_a+1);
        dispersion_b_up   = logspace(-4, log10(0.5), N_planes_diff_b+1);
        
        for j = 1:N_bilayer
%             k = N_planes_buffer + round(mean(N_planes_a)*4)/4*j + round(mean(N_planes_b)*4)/4*(j-1);
            if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
                break
            elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
                F(zero(j)+1:zero(j)+N_planes_diff_b) = F(zero(j)+1:zero(j)+N_planes_diff_b) + dispersion_b_down(2:end);
            elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
                F(zero(j)-N_planes_diff_a+1:zero(j)) = F(zero(j)-N_planes_diff_a+1:zero(j)) - dispersion_a_up(1:length(dispersion_a_up)-1);
            else
                F(zero(j)-N_planes_diff_a+1:zero(j)) = F(zero(j)-N_planes_diff_a+1:zero(j)) - dispersion_a_up(1:length(dispersion_a_up)-1);
                F(zero(j)+1:zero(j)+N_planes_diff_b) = F(zero(j)+1:zero(j)+N_planes_diff_b) + dispersion_b_down(2:end);
            end
        end

        clear j;

        for j = 1:N_bilayer-1
%             k = N_planes_buffer + (round(mean(N_planes_a)*4)/4 + round(mean(N_planes_b)*4)/4)*j;
            if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
                break
            elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
                F(one(j)-N_planes_diff_b+1:one(j)) = F(one(j)-N_planes_diff_b+1:one(j)) + dispersion_b_up(1:length(dispersion_b_up)-1);
            elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
                F(one(j)+1:one(j)+N_planes_diff_a) = F(one(j)+1:one(j)+N_planes_diff_a) - dispersion_a_down(2:end);
            else
                F(one(j)-N_planes_diff_b+1:one(j)) = F(one(j)-N_planes_diff_b+1:one(j)) + dispersion_b_up(1:length(dispersion_b_up)-1);
                F(one(j)+1:one(j)+N_planes_diff_a) = F(one(j)+1:one(j)+N_planes_diff_a) - dispersion_a_down(2:end);
            end
        end
        
    case 3 % 50% occupation
        for j = 1:N_bilayer
%             k = N_planes_buffer + round(mean(N_planes_a)*4)/4*j + round(mean(N_planes_b)*4)/4*(j-1);
            if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
                break
            elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
                F(zero(j):zero(j)+N_planes_diff_b-1)   = linspace(0.5,0.5,N_planes_diff_b);
            elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
                F(zero(j)-N_planes_diff_a+1:zero(j)) = linspace(0.5,0.5,N_planes_diff_a);
            else
                F(zero(j)-N_planes_diff_a+1:zero(j)) = linspace(0.5,0.5,N_planes_diff_a);
                F(zero(j):zero(j)+N_planes_diff_b)   = linspace(0.5,0.5,N_planes_diff_b+1);
            end
        end

        clear j;

        for j = 1:N_bilayer-1
%             k = N_planes_buffer + (round(mean(N_planes_a)*4)/4 + round(mean(N_planes_b)*4)/4)*j;
            if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
                break
            elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
                F(one(j)-N_planes_diff_b+1:one(j)) = linspace(0.5,0.5,N_planes_diff_b);
            elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
                F(one(j)+1:one(j)+N_planes_diff_a) = linspace(0.5,0.5,N_planes_diff_a);
            else
                F(one(j)-N_planes_diff_b+1:one(j)) = linspace(0.5,0.5,N_planes_diff_b);
                F(one(j)+1:one(j)+N_planes_diff_a) = linspace(0.5,0.5,N_planes_diff_a);
            end
        end

end
