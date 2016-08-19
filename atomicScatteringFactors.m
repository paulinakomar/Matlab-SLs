clear all, close all, clc


% http://lamp.tu-graz.ac.at/~hadley/ss1/crystaldiffraction/atomicformfactors/formfactors.php
lambda1 = 1.54056;     

    % two theta range
    twotheta = 0:0.01:90; %range(1,1):range(1,2):range(1,3); % in degrees


    twotheta_rad_200 = twotheta/180*pi/2; % in radians
%     twotheta_rad_400 = twotheta_400/180*pi/2; % in radians
        thetar = twotheta/180*pi/2; % 200 and 400 range in radians

    % momentum transfer
    dq_lambda1 = 4*pi/lambda1*sin(twotheta_rad_200);

% Vanadium
a.V = 6.2;   %   6.24; %strained value  %d_buffer=6.048;%=unstrained % 2*bulk lattice constant of Vanadium
a.Va = [10.2971 7.3511  2.0703   2.0571];
b.Va = [ 6.8657 0.4385 26.8938 102.478];
c.Va = [ 1.2199 0       0        0];
B.Va = 0.5855; %A^2
disp_corr_1.Va = 0.2;
disp_corr_2.Va = 2.3;

% Ni
a.Ni = [12.838 7.292  4.444  2.380];
b.Ni = [ 3.878 0.257 12.176 66.342];
c.Ni = [ 1.034 0      0      0];
B.Ni = 0.3644;
disp_corr_1.Ni = -3.1;
disp_corr_2.Ni = 0.6;

% Ti
a.Ti = [9.7595 7.3558 1.6991   1.9021];
b.Ti = [7.8508 0.500 35.6338 116.105];
c.Ti = [1.2807  0     0      0];
B.Ti = 0.5261;
disp_corr_1.Ti = 0.2;
disp_corr_2.Ti = 1.9;

% Sn
a.Sn = [19.189 19.101  4.458  2.466];
b.Sn = [ 5.830  0.503 26.891 83.957];
c.Sn = [ 4.782  0      0      0];
B.Sn = 1.1596;
disp_corr_1.Sn = -0.7;
disp_corr_2.Sn = 5.8;

% Hf
a.Hf = [29.144 15.173 14.759  4.300];
b.Hf = [ 1.833  9.600  0.275 72.029];
c.Hf = [ 8.582  0      0      0];
B.Hf = 0.41;
disp_corr_1.Hf = -7;
disp_corr_2.Hf = 5;

% Zr
a.Zr = [17.87650 10.948 5.417320  3.65721];
b.Zr = [ 1.27618 11.916 0.117622 87.66270];
c.Zr = [ 2.06929 0      0         0];
B.Zr = 0.5822;
disp_corr_1.Zr = -0.6;
disp_corr_2.Zr = 2.5;

    f.Ti = 0;    f.Ni = 0;    f.Sn = 0;   f.Hf = 0;    f.Zr = 0;     f.V = 0;
    
for k=1:4
   f.Ti = f.Ti + a.Ti(k)*exp(-b.Ti(k)*(dq_lambda1/(4*pi)).^2) + c.Ti(k);
   f.Ni = f.Ni + a.Ni(k)*exp(-b.Ni(k)*(dq_lambda1/(4*pi)).^2) + c.Ni(k);
   f.Sn = f.Sn + a.Sn(k)*exp(-b.Sn(k)*(dq_lambda1/(4*pi)).^2) + c.Sn(k);
   f.Hf = f.Hf + a.Hf(k)*exp(-b.Hf(k)*(dq_lambda1/(4*pi)).^2) + c.Hf(k);
   f.Zr = f.Zr + a.Zr(k)*exp(-b.Zr(k)*(dq_lambda1/(4*pi)).^2) + c.Zr(k);
   f.V  = f.V  + a.Va(k)*exp(-b.Va(k)*(dq_lambda1/(4*pi)).^2) + c.Va(k);
end

% dispersion corrections for X-ray scattering, of atoms. 

f.Ti = (f.Ti + disp_corr_1.Ti + 1i*disp_corr_2.Ti) .*  exp (-B.Ti*(dq_lambda1/(4*pi)).^2);
f.Ni = (f.Ni + disp_corr_1.Ni + 1i*disp_corr_2.Ni) .*  exp (-B.Ni*(dq_lambda1/(4*pi)).^2);
f.Sn = (f.Sn + disp_corr_1.Sn + 1i*disp_corr_2.Sn) .*  exp (-B.Sn*(dq_lambda1/(4*pi)).^2);
f.Hf = (f.Hf + disp_corr_1.Hf + 1i*disp_corr_2.Hf) .*  exp (-B.Hf*(dq_lambda1/(4*pi)).^2);
f.Zr = (f.Zr + disp_corr_1.Zr + 1i*disp_corr_2.Zr) .*  exp (-B.Zr*(dq_lambda1/(4*pi)).^2);
f.V  = (f.V  + disp_corr_1.Va + 1i*disp_corr_2.Va) .*  exp (-B.Va*(dq_lambda1/(4*pi)).^2);



plot(twotheta, f.Ti, 'k'); hold on;
plot(twotheta, f.Ni, 'm');
plot(twotheta, f.Sn, 'b');
plot(twotheta, f.Hf, 'g');
plot(twotheta, f.Zr, 'c');
plot(twotheta, f.V, 'r');
%     xlim([25 35]);
legend('Ti', 'Ni', 'Sn', 'Hf', 'Zr', 'V');