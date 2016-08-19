function thickness_perm = GaussDistributionOfThicknessesInUC(N_uc, rangeOfChange_uc, std_dev_norm, No_periods)
% clear all, close all, clc
% 
% 
% N_uc = 15;              % average thickness of a single layer in uc
% rangeOfChange_uc = 1.5; % how many uc the thickness can deviate from a mean value
% std_dev_norm = 0.25;    % standard deviation from a mean value in normal distribution (in uc)
% No_periods = 20;        % how many layers of a given material is in the total film = how many periods

N_uc_range = N_uc-rangeOfChange_uc:.25:N_uc+rangeOfChange_uc;
N_uc_norm = normpdf(N_uc_range,N_uc,std_dev_norm);

N_uc_distribution = [N_uc_range', N_uc_norm'];

N_uc_norm = No_periods/sum(N_uc_norm)*N_uc_norm; % to have necessary number of layers
N_uc_distribution(:,2) = round(No_periods*N_uc_distribution(:,2)/sum(N_uc_distribution(:,2)));

%                                             plot(N_uc_range,N_uc_norm); hold on;
%                                             plot(N_uc_distribution(:,1), N_uc_distribution(:,2), '.');
%                                             bar(N_uc_distribution(:,1), N_uc_distribution(:,2));
% 
%                                             sum(N_uc_norm)
%                                             sum(N_uc_distribution(:,2))

    difference = round(sum(N_uc_norm) - sum(N_uc_distribution(:,2)));

if difference > 0
    while difference > 0
        index = find(N_uc_distribution(:,1)==N_uc);
        N_uc_distribution(index,2) = N_uc_distribution(index,2) + 1;
        difference = difference - 1;
    end
    
elseif difference < 0
    while difference < 0
        index = find(N_uc_distribution(:,1)==N_uc);
        N_uc_distribution(index,2) = N_uc_distribution(index,2) - 1;
        difference = difference + 1;
    end
end

%                                         plot(N_uc_distribution(:,1), N_uc_distribution(:,2), 'r');
%                                         sum(N_uc_distribution(:,2))

thickness_layers = 0;
for j = 1:length(N_uc_distribution)
    for k = 1:N_uc_distribution(j,2)
        thickness_layers = [thickness_layers, N_uc_distribution(j,1)];
    end
end

thicknesses = thickness_layers(2:end);

perm = randperm(length(thicknesses));
for i = 1:length(perm)
    p = perm(i);
    thickness_perm(i) = thicknesses(p);
end

%                                         sum(thickness_perm)
%                                         figure
%                                         plot(thickness_perm)