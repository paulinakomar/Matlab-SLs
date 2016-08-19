function [fitresult, gof, output] = Fit400Peak(x, y)
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

%  Auto-generated by MATLAB on 15-Oct-2014 11:10:42


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'y0 + (AG/(wG*sqrt(2*pi)))*exp(-((x-xc)/(sqrt(2)*wG))^2) + (AL/pi)*(wL./((x-xc)^2 + wL^2)) + (AG2/(wG2*sqrt(2*pi)))*exp(-((x-xc2)/(sqrt(2)*wG2))^2) + (AL2/pi)*(wL2./((x-xc2)^2 + wL2^2))', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [0 0 0 0 0 0 0 0 62 62 0];
opts.StartPoint = [0.913375856139019 0.63235924622541 0.0975404049994095 0.278498218867048 0.546881519204984 0.957506835434298 0.964888535199277 0.157613081677548 0.970592781760616 0.957166948242946 0.485375648722841];
opts.Upper = [100000 100000 100000 100000 0.5 0.5 0.5 0.5 63 63 1000];

% Fit model to data.
[fitresult, gof, output] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'y vs. x', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel( 'x' );
ylabel( 'y' );
grid on


