function handles = plot_xrd(handles)
    if ~isfield(handles, 'Font')
        handles.Font.FontName   = 'Helvetica';
        handles.Font.FontWeight = 'normal';
        handles.Font.FontAngle  = 'normal';
        handles.Font.FontUnits  = 'points';
        handles.Font.FontSize   = 10;
    end
    
    if ~isfield(handles, 'LWidth'), handles.LWidth = {'2'; '0.5'}; end
    
    % first plot
    if isfield(handles, 'color')
        plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityPV1,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else
        handles.h1 = plot(handles.plot_T_2T_200_lin, handles.twotheta1,...
            handles.IntensityPV1, 'r', 'LineWidth', str2num(handles.LWidth{1}));
    end

        set(handles.plot_T_2T_200_lin, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));

        xlabel(handles.plot_T_2T_200_lin, '2\it{\theta} (deg)');
        ylabel(handles.plot_T_2T_200_lin, 'Normalized intensity');

            if isfield(handles, 'T2T_200')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);    
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);        
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                 
                legend(handles.plot_T_2T_200_lin, 'simulation', 'measured data', 'Location', 'Best');
                    xlabel(handles.plot_T_2T_200_lin, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_200_lin, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_200_lin, [handles.range(1,1) handles.range(1,3)]);
        
               
    % second plot
    if isfield(handles, 'color')
        plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityPV2,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else
        plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityPV2,...
            'r', 'LineWidth', str2num(handles.LWidth{1}));
    end
    
        set(handles.plot_T_2T_400_lin, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));
   
            xlabel(handles.plot_T_2T_400_lin, '2\it{\theta} (deg)');
            ylabel(handles.plot_T_2T_400_lin, 'Normalized intensity');

            if isfield(handles, 'T2T_400')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                
                
                legend(handles.plot_T_2T_400_lin, 'simulation', 'measured data', 'Location', 'Best');
                    xlabel(handles.plot_T_2T_400_lin, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_400_lin, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_400_lin, [handles.range(2,1) handles.range(2,3)]);

    % third plot
    if isfield(handles, 'color')
        semilogy(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityPV1,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else semilogy(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityPV1,...
            'r', 'LineWidth', str2num(handles.LWidth{1}));
    end
 
        set(handles.plot_T_2T_200_log, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));

            xlabel(handles.plot_T_2T_200_log, '2\it{\theta} (deg)');
            ylabel(handles.plot_T_2T_200_log, 'Normalized intensity');

            if isfield(handles, 'T2T_200')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName, 'FontWeight',...
                        handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityPV1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                
                    xlabel(handles.plot_T_2T_200_log, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_200_log, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_200_log, [handles.range(1,1) handles.range(1,3)]);
                
    % fourth plot
    if isfield(handles, 'color')
        semilogy(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityPV2,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else
        semilogy(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityPV2,...
            'r', 'LineWidth', str2num(handles.LWidth{1}));
    end
    
        set(handles.plot_T_2T_400_log, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));

            xlabel(handles.plot_T_2T_400_log, '2\it{\theta} (deg)');
            ylabel(handles.plot_T_2T_400_log, 'Normalized intensity');

            if isfield(handles, 'T2T_400')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName, 'FontWeight',...
                        handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityPV2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                
                    xlabel(handles.plot_T_2T_400_log, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_400_log, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_400_log, [handles.range(2,1) handles.range(2,3)]);
        
        
    % fifth plot
    if isfield(handles, 'T2T_200')
        if isfield(handles, 'color')
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference200, handles.twotheta1, abs(handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityPV1'),...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference200, handles.twotheta1, handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityPV1',...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, 'Data-Sim');
            end
        else
            
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference200, handles.twotheta1,...
                        abs(handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityPV1'), 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference200, handles.twotheta1,...
                        handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityPV1', 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, 'Data-Sim');
            end
                    
        end

            set(handles.plot_difference200, 'FontName', handles.Font.FontName,...
                'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
                'LineWidth', str2num(handles.LWidth{2}));

            xlim(handles.plot_difference200, [handles.range(1,1) handles.range(1,3)]);
    else
        plot(handles.plot_difference200, NaN, NaN);
        set(handles.plot_difference200, 'XTickLabel', {});
        set(handles.plot_difference200, 'YTickLabel', {});
    end
    

    
    % sixth plot
    if isfield(handles, 'T2T_400')
        if isfield(handles, 'color')
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference400, handles.twotheta2, abs(handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityPV2'),...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference400, handles.twotheta2, handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityPV2',...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, 'Data-Sim');
            end
        else
            
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference400, handles.twotheta2,...
                        abs(handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityPV2'), 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference400, handles.twotheta2,...
                        handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityPV2', 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, 'Data-Sim');
            end
            
        end

            set(handles.plot_difference400, 'FontName', handles.Font.FontName,...
                'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
                'LineWidth', str2num(handles.LWidth{2}));

            xlim(handles.plot_difference400, [handles.range(2,1) handles.range(2,3)]);
    else
        plot(handles.plot_difference400, NaN, NaN);
        set(handles.plot_difference400, 'XTickLabel', {});
        set(handles.plot_difference400, 'YTickLabel', {});
    end
        
        axis([handles.plot_difference200 handles.plot_difference400], 'tight');    
    
    % seventh plot
    if length(handles.f) > 500
        plot(handles.axes7, handles.f(1:500));
    else
        plot(handles.axes7, handles.f);
    end
        set(get(handles.axes7, 'XLabel'), 'String', '# of layer');
        set(handles.axes7, 'YTick', [0 1]);
        set(handles.axes7, 'YTickLabel', {'HNS', 'TNS'});
        
    % Gauss histogram plots
    middle1 = str2double(get(handles.edit_thicknessCurrent_A, 'String'));
    pm1 = str2double(get(handles.edit_UCRange_layerA, 'String'));
    hist(handles.plot_ucdistr_layerA, handles.thickness_perm_a, middle1 - pm1:0.5:middle1 + pm1);
        set(get(handles.plot_ucdistr_layerA, 'XLabel'), 'String', '# of uc');
        set(get(handles.plot_ucdistr_layerA, 'YLabel'), 'String', '# of layers');
        set(handles.plot_ucdistr_layerA, 'xlim',...
            [middle1 - pm1 - 0.5, middle1 + pm1 + 0.5]);
        
    middle2 = str2double(get(handles.edit_thicknessCurrent_B, 'String'));
    pm2 = str2double(get(handles.edit_UCRange_layerB, 'String'));
    hist(handles.plot_ucdistr_layerB, handles.thickness_perm_b, middle2 - pm2:0.5:middle2 + pm2);
        set(get(handles.plot_ucdistr_layerB, 'XLabel'), 'String', '# of uc');
        set(handles.plot_ucdistr_layerB, 'xlim',...
            [middle2 - pm2 - 0.5, middle2 + pm2 + 0.5]);
       
    middle3 = str2double(get(handles.edit_numberOfUCCurrent_A, 'String'));
    pm3 = str2double(get(handles.edit_UCSize_layerA, 'String'));
        if isempty(get(handles.edit_numberOfUCCurrent_A, 'String'))
            middle3 = 5.94;
        end
        hist(handles.axes12, handles.divide_uc*handles.d_perm_a, middle3 - pm3:0.002:middle3 + pm3);
            set(get(handles.axes12, 'XLabel'), 'String', 'lattice parameter (A)');
            set(get(handles.axes12, 'YLabel'), 'String', '# of atomic planes');
            set(handles.axes12, 'xlim', [middle3 - pm3 - 0.002, middle3 + pm3 + 0.002]);
        
    middle4 = str2double(get(handles.edit_numberOfUCCurrent_B, 'String'));
    pm4 = str2double(get(handles.edit_UCSize_layerB, 'String'));
        if isempty(get(handles.edit_numberOfUCCurrent_B, 'String'))
            middle4 = 6.08;
        end
        hist(handles.axes13, handles.divide_uc*handles.d_perm_b, middle4 - pm4:0.002:middle4 + pm4);
            set(get(handles.axes13, 'XLabel'), 'String', 'lattice parameter (A)');
            set(handles.axes13, 'xlim',[middle4 - pm4 - 0.002, middle4 + pm4 + 0.002]);
        
            
        switch handles.Grid 
            case 'off'
                grid(handles.plot_T_2T_200_lin, 'off');
                grid(handles.plot_T_2T_200_log, 'off');
                grid(handles.plot_T_2T_400_lin, 'off');
                grid(handles.plot_T_2T_400_log, 'off');
                if isfield(handles, 'T2T_200')
                    grid(handles.plot_difference200, 'off');
                end
                if isfield(handles, 'T2T_400')
                    grid(handles.plot_difference400, 'off');
                end
            case 'on'
                grid(handles.plot_T_2T_200_lin, 'on');
                grid(handles.plot_T_2T_200_log, 'on');
                grid(handles.plot_T_2T_400_lin, 'on');
                grid(handles.plot_T_2T_400_log, 'on');
                if isfield(handles, 'T2T_200')
                    grid(handles.plot_difference200, 'on');
                end
                if isfield(handles, 'T2T_400')
                    grid(handles.plot_difference400, 'on');
                end
        end