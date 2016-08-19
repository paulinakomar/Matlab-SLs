clear all, close all, clc

calculated = importdata('4p03A_44uc.dat');
measured   = importdata('M4A6_XRD.dat');
peakfit    = importdata('VO1_substratePeak.dat');

pf_interp = interp1(peakfit(:,1), peakfit(:,2), calculated(:,1));

semilogy(measured(:,1), measured(:,2), 'k'); hold on;
semilogy(peakfit(:,1), peakfit(:,2), 'r');
semilogy(calculated(:,1), 1000*calculated(:,2), 'b');
semilogy(calculated(:,1), 1000*calculated(:,2) + pf_interp, 'm');
    xlim([18 26]);