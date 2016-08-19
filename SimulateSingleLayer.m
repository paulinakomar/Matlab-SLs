close all, clear all, clc

MgO_meas = importdata('MgO_t2t.txt');

    F.MgO_400 = 53/4; %31.12
    d_MgO     = 4.210/2; %   6.24; %strained value  %d_buffer=6.048;%=unstrained % 2*bulk lattice constant of Vanadium

    lambda1 = 1.54056;     % wavelength (A)
    lambda2 = 1.54439;
    twotheta = 42.5:0.0005:43.5; % in degrees
    thetar2 = twotheta/180*pi/2; % in radians
    dq1 = 4*pi/lambda1*sin(thetar2); % momentum transfer
    dq2 = 4*pi/lambda2*sin(thetar2);
    
    N_buffer=50000;   % Anzahl EZ NiTiSn buffer bzw Halbe Anzahl EZ V Lagen (sollten 16 sein)
    N = N_buffer*2;

zposition = zeros(1,N+1);  % Ort der Netzebenen
f = zposition; % Scattering factor der Netzebenen
    currentN = 1; 
    currentposition = 0;
        f_a = 1; 
        f_b = 0; % f_a als logische Variable: Netzebene gehoert zu Typ a, f_a=1 oder Typ b f_b=0
% ermoeglicht spaeter Interpretation als interdiffusion und Prozentwerte 0<=f_a<=1
for b = 1:N_buffer*2
      f(currentN) = f_a;   % Strukturfaktor der n-ten Netzebene starte Buffer mit a
      zposition(currentN) = currentposition + d_MgO;
        % Exponentielle Relaxation einbauen
         %dTemp2(b)=delta*exp(-currentN/Nrelaxation);  %Just saving Relaxation behavior separately
        currentposition = zposition(currentN);  % aktuelle z-Koordinate
        currentN = currentN + 1;
end


Ftot = 0; % Ftot = Vektor mit Streukraeften als Fkt des Impulsuebertrages=Winkel
Ftot2 = 0;
% Unten obere Schleife aber nur für V Buffer
for z=1:2:N_buffer*2
      Ftot = Ftot + (f(z)   * F.MgO_400) * exp(i*dq1*zposition(z)); % V Ebene 
      Ftot = Ftot + (f(z+1) * F.MgO_400)* exp(i*dq1*zposition(z+1)); % V Ebene 
      
      Ftot2 = Ftot2 + (f(z)   * F.MgO_400) * exp(i*dq2*zposition(z)); % V Ebene 
      Ftot2 = Ftot2 + (f(z+1) * F.MgO_400)* exp(i*dq2*zposition(z+1)); % V Ebene
      % In obiger Gleichung ist dq ein Vektor!
      % f(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
      % gleichzeitig f(k,q) Winkelabhaengig sein
end

Intensity = (abs(Ftot)).^2;
Intensity = Intensity/max(Intensity);

Intensity2 = (abs(Ftot2)).^2;
Intensity2 = Intensity2/max(Intensity2);

w = 0.1; %war 0.12 für Übergitter
Ntwothetavalues = max(size(twotheta));
IntensityGauss = zeros(1,Ntwothetavalues);

for k = 1:Ntwothetavalues  % daemlich das hier tausendmal zu berechnen
center = twotheta(k);
gauss = 1/w/sqrt(pi/2)*exp(-2/w/w*(twotheta-center).^2);
IntensityGauss(k) = gauss*Intensity';
IntensityGauss2(k) = gauss*Intensity2';
end

IntensityGauss = IntensityGauss/max(IntensityGauss);
IntensityGauss2 = 0.5*IntensityGauss2/max(IntensityGauss2);

%% Pseudo Voight
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

IntensityVoight = zeros(1,Ntwothetavalues);
for i = 1:Ntwothetavalues
    center = twotheta(i);
    voight_fit = y0 + (AG/(wG*sqrt(2*pi)))*exp(-((twotheta-center)/(sqrt(2)*wG)).^2) + (AL/pi)*(wL./((twotheta-center).^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)))*exp(-((twotheta-center)/(sqrt(2)*wG2)).^2) + (AL2/pi)*(wL2./((twotheta-center).^2 + wL2^2));
    IntensityVoight(i) = voight_fit*(Intensity'+0.5*Intensity2');
end

IntensityVoight = IntensityVoight/max(IntensityVoight);


figure('Units', 'centimeters', 'Position', [5 2 30 15]);
subplot(121)
    plot(twotheta,Intensity + 0.5*Intensity2, 'b');    hold on;
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), 'k.');
    plot(twotheta,IntensityVoight, 'r');
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on
    
    legend('Simulation, MgO (200)', 'Measured data', 'Pseudo Voight fit');
    
subplot(122)
    plot(twotheta,Intensity + 0.5*Intensity2, 'b');    hold on;
    plot(MgO_meas(:,1), MgO_meas(:,2)/max(MgO_meas(:,2)), 'k.');
    plot(twotheta,IntensityGauss+1e-6, 'r');    hold on;
        xlabel( '{\it{2\theta}} (°)' , 'fontsize', 15);
        ylabel( 'Normalized intensity (a. u.)', 'FontSize', 15);
        set(gca, 'fontsize', 13);
        grid on
    
    legend('Simulation, MgO (200)', 'Measured data', 'Gaussian broadening of K\alpha peak');
    