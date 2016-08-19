% clear all, close all, clc

ab = ones(1, 12);
a1 = ones(1,29);
a0 = zeros(1,12);

f = [ab a1 a0 a1 a0 a1 a0 a1 a0];
f(2,:) = f(1,:);
f(3,:) = f(1,:);
f(4,:) = f(1,:);

N_bilayer = 4;
N_planes_buffer = length(ab);
N_planes_a = length(a1);
N_planes_b = length(a0);
% gradient
N_planes_diff_a = 2;
N_planes_diff_b = 6;

dispersion_a_up   = logspace(-4, log10(0.5), N_planes_diff_a+1);
dispersion_b_down = logspace(log10(0.5), -4, N_planes_diff_b+1);

dispersion_a_down = logspace(log10(0.5), -4, N_planes_diff_a+1);
dispersion_b_up   = logspace(-4, log10(0.5), N_planes_diff_b+1);



        
for j = 1:N_bilayer
    k = N_planes_buffer + N_planes_a*j + N_planes_b*(j-1);
    if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
        break
    elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
        f(2,k:k+N_planes_diff_b-1)   = linspace(0.5,0.5,N_planes_diff_b);
    elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
        f(2,k-N_planes_diff_a+1:k) = linspace(0.5,0.5,N_planes_diff_a);
    else
        f(2,k-N_planes_diff_a+1:k) = linspace(0.5,0.5,N_planes_diff_a);
        f(2,k:k+N_planes_diff_b)   = linspace(0.5,0.5,N_planes_diff_b+1);
    end
end

clear j, k;

for j = 1:N_bilayer-1
    k = N_planes_buffer + (N_planes_a + N_planes_b)*j;
    if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
        break
    elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
        f(2,k-N_planes_diff_b+1:k) = linspace(0.5,0.5,N_planes_diff_b);
    elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
        f(2,k+1:k+N_planes_diff_a)   = linspace(0.5,0.5,N_planes_diff_a);
    else
        f(2,k-N_planes_diff_b+1:k) = linspace(0.5,0.5,N_planes_diff_b);
        f(2,k+1:k+N_planes_diff_a)   = linspace(0.5,0.5,N_planes_diff_a);
    end
end
        
        
%         for j = 1:N_bilayer
%             k = N_planes_buffer + N_planes_a*j;
%             if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
%                 break
%             elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
%                 if f(k) == 1
%                     f(k+1:k+N_planes_diff_b) = f(k+1:k+N_planes_diff_b) + dispersion_b_down(2:end);
%                 else
%                     f(k-N_planes_diff_b+1:k) = f(k-N_planes_diff_b+1:k) + dispersion_b_up(1:length(dispersion_b_up)-1);
%                 end
%             elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
%                 if f(k) == 1
%                     f(k-N_planes_diff_a+1:k) = f(k-N_planes_diff_a+1:k) - dispersion_a_up(1:length(dispersion_a_up)-1);
%                 else
%                     f(k+1:k+N_planes_diff_a) = f(k+1:k+N_planes_diff_a) - dispersion_a_down(2:end);
%                 end
%             else
%                 if f(k) == 1
%                     f(k-N_planes_diff_a+1:k) = f(k-N_planes_diff_a+1:k) - dispersion_a_up(1:length(dispersion_a_up)-1);
%                     f(k+1:k+N_planes_diff_b) = f(k+1:k+N_planes_diff_b) + dispersion_b_down(2:end);
%                 else
%                     f(k-N_planes_diff_b+1:k) = f(k-N_planes_diff_b+1:k) + dispersion_b_up(1:length(dispersion_b_up)-1);
%                     f(k+1:k+N_planes_diff_a) = f(k+1:k+N_planes_diff_a) - dispersion_a_down(2:end);
%                 end
%             end
%         end


% for j = 1:N_bilayer
%     k = N_planes_buffer + N_planes_a*j + N_planes_b*(j-1);
%     if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
%         break
%     elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
%         f(2,k+1:k+N_planes_diff_b) = f(2,k+1:k+N_planes_diff_b) + dispersion_b_down(2:end);
%     elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
%         f(2,k-N_planes_diff_a+1:k) = f(2,k-N_planes_diff_a+1:k) - dispersion_a_up(1:length(dispersion_a_up)-1);
%     else
%         f(2,k-N_planes_diff_a+1:k) = f(2,k-N_planes_diff_a+1:k) - dispersion_a_up(1:length(dispersion_a_up)-1);
%         f(2,k+1:k+N_planes_diff_b) = f(2,k+1:k+N_planes_diff_b) + dispersion_b_down(2:end);
%     end
% end
% 
% clear j, k;
% 
% for j = 1:N_bilayer-1
%     k = N_planes_buffer + (N_planes_a + N_planes_b)*j;
%     if (N_planes_diff_a == 0 && N_planes_diff_b == 0)
%         break
%     elseif (N_planes_diff_a == 0 && ~N_planes_diff_b == 0)
%         f(2,k-N_planes_diff_b+1:k) = f(2,k-N_planes_diff_b+1:k) + dispersion_b_up(1:length(dispersion_b_up)-1);
%     elseif (~N_planes_diff_a == 0 && N_planes_diff_b == 0)
%         f(2,k+1:k+N_planes_diff_a) = f(2,k+1:k+N_planes_diff_a) - dispersion_a_down(2:end);
%     else
%         f(2,k-N_planes_diff_b+1:k) = f(2,k-N_planes_diff_b+1:k) + dispersion_b_up(1:length(dispersion_b_up)-1);
%         f(2,k+1:k+N_planes_diff_a) = f(2,k+1:k+N_planes_diff_a) - dispersion_a_down(2:end);
%     end
% end
        
%                 if f(m) == 1
%                     f(2,m-N_planes_diff_a:m)     = linspace(0,0.5,N_planes_diff_a+1);
%                     f(2,m+1:m+N_planes_diff_b+1) = linspace(0.5,1,N_planes_diff_b+1);
%                 else
%                     f(2,m-N_planes_diff_b-1:m-1) = linspace(0.5,1,N_planes_diff_b+1);
%                     f(2,m:m+N_planes_diff_a)     = linspace(0,0.5,N_planes_diff_a+1);
%                 end
% end

plot(f(2,:));

% dispersion_a_up = logspace(-4, log10(0.5), N_planes_diff_a+1);
% dispersion_b_down = logspace(log10(0.5), -4, N_planes_diff_b+1);
% 
% dispersion_a_down = logspace(log10(0.5), -4, N_planes_diff_a+1);
% dispersion_b_up = logspace(-4, log10(0.5), N_planes_diff_b+1);

% for j = 1:4
% %     k = N_planes_buffer + N_planes_a*j;
%         k = 20 * j;
% %     for k = N_planes_a*j-1:N_planes_a*j+2
%         if a(1,k) == 1
% %             a(2,k-N_planes_diff_a+1:k) = a(2,k-N_planes_diff_a+1:k) - dispersion_a_up(1:length(dispersion_a_up)-1);
%             a(2,k+1:k+N_planes_diff_b) = a(2,k+1:k+N_planes_diff_b) + dispersion_b_down(2:end);
%         else
%             a(2,k-N_planes_diff_b+1:k)   = a(2,k-N_planes_diff_b+1:k) + dispersion_b_up(1:length(dispersion_b_up)-1);
% %             a(2,k+1:k+N_planes_diff_a) = a(2,k+1:k+N_planes_diff_a) - dispersion_a_down(2:end);
%         end
% %     end
% end