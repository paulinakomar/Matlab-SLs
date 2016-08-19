clear all, close all, clc

with_200 = importdata('roughness\200_withRoughness.dat');
with_400 = importdata('roughness\400_withRoughness.dat');

gradient_200 = importdata('roughness\200_withGradient.dat');
gradient_400 = importdata('roughness\400_withGradient.dat');

oneSide_200 = importdata('roughness\200_oneSide.dat');
oneSide_400 = importdata('roughness\400_oneSide.dat');

without_200 = importdata('roughness\200_withoutRoughness.dat');
without_400 = importdata('roughness\400_withoutRoughness.dat');

subplot(121)
    semilogy(without_200(:,1), without_200(:,2),...
        with_200(:,1), with_200(:,2),...
        gradient_200(:,1), gradient_200(:,2),...
        oneSide_200(:,1), oneSide_200(:,2));
    
subplot(122)
    semilogy(without_400(:,1), without_400(:,2),...
        with_400(:,1), with_400(:,2),...
        gradient_400(:,1), gradient_400(:,2),...
        oneSide_400(:,1), oneSide_400(:,2));
    
    legend('without', '0.5 occ on 4 layers', 'gradient', 'one side');
    title('10 x [6 uc/6 uc] + buffer 15 uc');