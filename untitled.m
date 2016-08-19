function [x,resnorm,residual,exitflag,output,lambda,jacobian] = untitled(x0,xdata,ydata,lb,ub,PrecondBandWidth_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('lsqcurvefit');
%% Modify options setting
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'FunValCheck', 'off');
options = optimoptions(options,'PrecondBandWidth', PrecondBandWidth_Data);
[x,resnorm,residual,exitflag,output,lambda,jacobian] = ...
lsqcurvefit(@(p,xdata)p(1)+p(2)*xdata(:,1).*sin(p(3)*xdata(:,2)+p(4)),x0,xdata,ydata,lb,ub,options);
