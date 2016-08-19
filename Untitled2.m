% clear all, close all, clc

% fitfcn = @(p,xdata)p(1) + p(2)*xdata + p(3)*sin(xdata) + p(4)*(log(xdata));

% N = 100;
% preal = [13 1.8 135 7];
data  = importdata('\\fs01\holuj$\Dokumente\Results\XRD\SL-TH\SL-TH_135-138\SL-TH_135_200t2t.txt');
xdata = data.data(:,1);
ydata = data.data(:,2);

param0 = [10 10 5.94 5.94 6.08];
lb     = [ 9  9 5.85 5.85 6.00];
ub     = [12 12 6.05 6.05 6.25];


[xfitted,errorfitted,residual,exitflag,output,lambda] = lsqcurvefit(@SL_buffer_input, param0, xdata, ydata/max(ydata), lb, ub);

semilogy(xdata, ydata/max(ydata), 'o');
hold on;
semilogy(xdata, SL_buffer_input(xfitted, xdata), 'r');
semilogy(xdata, abs(residual), 'k');

% fitfcn = @(p,xdata)p(1) + p(2)*xdata(:,1).*sin(p(3)*xdata(:,2)+p(4));
% 
% 
% rng default % for reproducibility
% N = 200; % number of data points
% preal = [-3,1/4,1/2,1]; % real coefficients
% 
% xdata = 5*rand(N,2); % data points
% ydata = fitfcn(preal,xdata) + 0.1*randn(N,1); % response data with noise
% 
% lb = [-Inf,-Inf,-20,-pi];
% ub = [Inf,Inf,20,pi];
% 
% p0 = 5*ones(1,4); % Arbitrary initial point
% p0(4) = 0; % so the initial point satisfies the bounds
% 
% 
% [xfitted,errorfitted] = lsqnonlin(fitfcn,p0)
% 
% problem = createOptimProblem('lsqcurvefit','x0',p0,'objective',fitfcn,'lb',lb,'ub',ub,'xdata',xdata,'ydata',ydata);
% 
% 
% ms = MultiStart('PlotFcns',@gsplotbestf);
% [xmulti,errormulti] = run(ms,problem,50)