% 'y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) + (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-xc2)^2 + wL2^2))'


% voight_fit = 

%      General model:

%      Coefficients (with 95% confidence bounds):
close all, clear all, clc
       AG =   7.158e+05; % (6.558e+05, 7.757e+05)
       AG2 =   3.592e+05;%  (3.434e+05, 3.75e+05)
       AL =       1e+05; % (5.466e+04, 1.453e+05)
       AL2 =   9.735e+04; % (-4.095e+04, 2.357e+05)
       wG =     0.02842; % (0.02776, 0.02907)
       wG2 =     0.02895; % (0.02818, 0.02972)
       wL =     0.08467; % (-0.03675, 0.2061)
       wL2 =      0.2164;%  (-0.08882, 0.5217)
       xc =       42.93; % (42.93, 42.93)
       xc2 =       43.04; % (43.04, 43.04)
       y0 =      0.1681; % (-7.704e+04, 7.704e+04)
x = 42.5:0.01:43.5;
y = zeros(1,101);
y(41) = 1;

for i = 1:101
    voight_fit(i) = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x(i)-xc)/(sqrt(2)*wG))^2) + (AL/pi)*(wL./((x(i)-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)))*exp(-((x(i)-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x(i)-xc2)^2 + wL2^2));
end

MgO = importdata('MgO_t2t.txt');

x_MgO = MgO(:,1);
y_MgO = MgO(:,2);

subplot(2,1,1)
plot(x, voight_fit.*y, 'r', x_MgO, y_MgO, '.k');
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on
subplot(2,1,2)
plot(x, y, 'r');