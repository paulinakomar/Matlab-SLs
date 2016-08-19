close all, clear all, clc

satellites = importdata('SL-TH_61_200-2T.txt');

satellites = satellites.data();
sim = importdata('200_61.dat');


twotheta = satellites(:,1);
w1 = 0.9;  w2 = 0.9;
r1 = 0.03;  r2 = 0.055;
center1 = satellites(find(satellites(:,2) == max(satellites(:,2))),1)-0.08;
center2 = center1 + 1.05;

% center1 = 29.356;
% center2 = 30.064;

a=0.000003;
lin = a*(100 - twotheta);

for k=1:length(twotheta)
    gauss1 = 1/w1/sqrt(pi/2)*exp(-2/w1/w1*(twotheta-center1).^2);
    gauss2 = 1/w2/sqrt(pi/2)*exp(-2/w2/w2*(twotheta-center2).^2);
end



subplot(1,3,1)
    semilogy(satellites(:,1), satellites(:,2)/max(satellites(:,2))); hold on;
    semilogy(sim(:,1), (r1*gauss1 + r2*gauss2 + sim(:,2) + lin)/max(r1*gauss1 + r2*gauss2 + sim(:,2) + lin), ':r',...
        twotheta, r1*gauss1, 'k', twotheta, r2*gauss2, 'g', twotheta, lin, 'b', 'Linewidth', 1.5);
        ylim([1E-5 1]);
    
subplot(1,3,2)
    semilogy(satellites(:,1), satellites(:,2)/max(satellites(:,2))); hold on;
    semilogy(sim(:,1), sim(:,2), 'r:','Linewidth', 1.5);
        ylim([1E-5 1]);
        
subplot(1,3,3)
    semilogy(satellites(:,1), satellites(:,2)/max(satellites(:,2))); hold on;
    semilogy(sim(:,1), (r1*gauss1 + r2*gauss2 + sim(:,2) + lin)/max(r1*gauss1 + r2*gauss2 + sim(:,2) + lin), 'r:', 'Linewidth', 1.5);
        ylim([1E-5 1]);