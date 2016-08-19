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

%  Auto-generated by MATLAB on 09-Oct-2014 13:48:56


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'P1./((x - xc1).^2 + P3) + P2./((x - xc2).^2 + P4) + C', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [0 0 0 0 0 42.8 43];
opts.MaxIter = 600;
opts.StartPoint = [0.913375856139019 0.63235924622541 0.0975404049994095 0.278498218867048 0.546881519204984 0.957506835434298 0.964888535199277];
opts.Upper = [1000 100000 1000000 0.2 0.2 42.95 43.1];

% Fit model to data.
[fitresult, gof, output] = fit( xData, yData, ft, opts );

% Plot fit with data.
subplot( 2, 2, 2 );
h = plot( fitresult, xData, yData, '.k' );
set(h, 'linewidth', 1.5);
legend( h, 'Measured data', sprintf('Lorentzian fit\nR^2=%0.4f', gof.rsquare), 'Location', 'NorthEast' );
% Label axes
xlabel( '{\it{2\theta}} (�)', 'fontsize', 15 );
ylabel( 'Intensity (a. u.)', 'FontSize', 15  );
set(gca, 'fontsize', 13);
grid on

% % Plot residuals.
% subplot( 4, 2, 4 );
% h = plot( fitresult, xData, yData, 'residuals' );
% legend( h, 'Lorentzian fit - residuals', 'Zero Line', 'Location', 'NorthEast' );
% % Label axes
% % xlabel( '{\it{2\theta}} (�)' );
% % ylabel( 'Intensity (a. u.)' );
% set(gca, 'fontsize', 12);
% grid on
% 
% 
