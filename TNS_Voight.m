function [fitresult, gof, output] = createFit(x, y)
%CREATEFIT(X,Y)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : x
%      Y Output: y
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 09-Oct-2014 15:35:16


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) + (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-xc2)^2 + wL2^2))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [0 0 0 0 0 0 0 0 62.2 62.2 0];
opts.StartPoint = [0.421761282626275 0.915735525189067 0.792207329559554 0.959492426392903 0.655740699156587 0.0357116785741896 0.849129305868777 0.933993247757551 0.678735154857773 0.757740130578333 0.743132468124916];
opts.Upper = [100000 Inf Inf Inf 0.2 0.2 0.2 0.2 62.8 62.8 1000];

% Fit model to data.
[fitresult, gof, output] = fit( xData, yData, ft, opts );

% Create a figure for the plots.
% figure( 'Name', 'untitled fit 1' );

% Plot fit with data.
subplot( 2, 2, 3 );
h = plot( fitresult, xData, yData, '.k' );
set(h, 'linewidth', 1.5);
legend( h, 'Measured data', sprintf('Pseudo Voigt\nR^2=%0.4f', gof.rsquare), 'Location', 'NorthEast' );
% Label axes
xlabel( '{\it{2\theta}} (�)', 'FontSize', 15  );
ylabel( 'Intensity (a. u.)', 'FontSize', 15 );
set(gca, 'fontsize', 13);
grid on

% % Plot residuals.
% subplot( 4, 2, 7 );
% h = plot( fitresult, xData, yData, 'residuals' );
% legend( h, 'Pseudo Voight fit - residuals', 'Zero Line', 'Location', 'NorthEast' );
% % Label axes
% xlabel( '{\it{2\theta}} (�)', 'FontSize', 13 );
% ylabel( 'Intensity (a. u.)', 'FontSize', 13 );
% set(gca, 'fontsize', 12);
% grid on


