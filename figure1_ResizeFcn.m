%% Resize        
% --- Executes when figure1 is resized.
function handles =  figure1_ResizeFcn(hObject, eventdata, handles)
    % Original position of controls
    uipanel2_org = [10, 10, 801, 650];
    uipanel3_org = [821, 490, 170, 151];
    uipanel4_org = [995, 490, 151, 151];
    uipanel5_org = [821, 200, 431, 285];
    uipanel9_org = [821, 200, 431, 285];

    text38_org     = [820, 630, 84, 21];
    SampleName_org = [931, 631, 320, 22];

    plot_T_2T_200_lin_org  = [60, 416, 325, 225];
    plot_T_2T_400_lin_org  = [455, 416, 325, 225];
    plot_T_2T_200_log_org  = [60, 150, 325, 225];
    plot_T_2T_400_log_org  = [455, 150, 325, 225];
    plot_difference200_org = [60 31 325 75];
    plot_difference400_org = [455 31 325 75];
    plot_profile_org       = [1160 490 90 130];

    % Set units in pixels
    set(hObject, 'Units', 'pixels');
    % Original size of window
    Original_Size = [520 175 1260 671];
    % New size of window
    Figure_Size   = get(hObject, 'Position');

    % Check is new size is greater than the original
    if((Figure_Size(3) < Original_Size(3)) || (Figure_Size(4) < Original_Size(4)))
        if Figure_Size(4) < Original_Size(4)
            Figure_Size = [Figure_Size(1), Figure_Size(2), Figure_Size(3), Original_Size(4)];
        end
        
        % Scale panel with graphs
        set(handles.uipanel2, 'Units', 'pixels');
        set(handles.uipanel2, 'Position', [uipanel2_org(1)*(Figure_Size(3)/Original_Size(3)),...
            uipanel2_org(2)*(Figure_Size(4)/Original_Size(4)),...
            Figure_Size(3)-uipanel5_org(3)-35,...
            uipanel2_org(4)*(Figure_Size(4)/Original_Size(4))]);
        uipanel2_new = get(handles.uipanel2, 'Position');
        
        % Scale graph 1
        set(handles.plot_T_2T_200_lin, 'Units', 'pixels');
        set(handles.plot_T_2T_200_lin, 'Position', [plot_T_2T_200_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_200_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

        % Scale graph 2
        set(handles.plot_T_2T_400_lin, 'Units', 'pixels');
        set(handles.plot_T_2T_400_lin, 'Position', [plot_T_2T_400_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_400_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

        % Scale graph 3
        set(handles.plot_T_2T_200_log, 'Units', 'pixels');
        set(handles.plot_T_2T_200_log, 'Position', [plot_T_2T_200_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_200_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

        % Scale graph 4
        set(handles.plot_T_2T_400_log, 'Units', 'pixels');
        set(handles.plot_T_2T_400_log, 'Position', [plot_T_2T_400_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_400_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
        
        % Scale graph 5
        set(handles.plot_difference200, 'Units', 'pixels');
        set(handles.plot_difference200, 'Position', [plot_difference200_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference200_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_difference200_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference200_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
        
        % Scale graph 6
        set(handles.plot_difference400, 'Units', 'pixels');
        set(handles.plot_difference400, 'Position', [plot_difference400_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference400_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_difference400_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference400_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);


    end
    
    set(hObject, 'Position', Figure_Size);

    % Scale panel with graphs
    set(handles.uipanel2, 'Units', 'pixels');
    set(handles.uipanel2, 'Position', [uipanel2_org(1)*(Figure_Size(3)/Original_Size(3)),...
        uipanel2_org(2)*(Figure_Size(4)/Original_Size(4)),...
        Figure_Size(3)-uipanel5_org(3)-35,...
        uipanel2_org(4)*(Figure_Size(4)/Original_Size(4))]);
    uipanel2_new = get(handles.uipanel2, 'Position');

    % Scale panels with parameters
    set(handles.uipanel3, 'Units', 'pixels');
    set(handles.uipanel3, 'Position', [Figure_Size(3)-uipanel3_org(3)-275,...
        Figure_Size(4)-uipanel3_org(4)-40, uipanel3_org(3), uipanel3_org(4)]);

    set(handles.uipanel4, 'Units', 'pixels');
    set(handles.uipanel4, 'Position', [Figure_Size(3)-uipanel4_org(3)-120,...
        Figure_Size(4)-uipanel4_org(4)-40, uipanel4_org(3), uipanel4_org(4)]);
    
    set(handles.uipanel5, 'Units', 'pixels');
    set(handles.uipanel5, 'Position', [Figure_Size(3)-uipanel5_org(3)-15,...
        Figure_Size(4)-uipanel5_org(4)-185, uipanel5_org(3), uipanel5_org(4)]);

    set(handles.uipanel9, 'Units', 'pixels');
    set(handles.uipanel9, 'Position', [Figure_Size(3)-uipanel5_org(3)-15,...
        Figure_Size(4)-uipanel9_org(4)-185, uipanel9_org(3), uipanel9_org(4)]);

    set(handles.text38, 'Units', 'pixels');
    set(handles.text38, 'Position', [Figure_Size(3)-text38_org(3)-360,...
        Figure_Size(4)-text38_org(4)-15, text38_org(3), text38_org(4)]);

    set(handles.SampleName, 'Units', 'pixels');
    set(handles.SampleName, 'Position', [Figure_Size(3)-SampleName_org(3)-15,...
        Figure_Size(4)-SampleName_org(4)-13, SampleName_org(3), SampleName_org(4)]);

    % Scale graph 1
    set(handles.plot_T_2T_200_lin, 'Units', 'pixels');
    set(handles.plot_T_2T_200_lin, 'Position', [plot_T_2T_200_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_200_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 2
    set(handles.plot_T_2T_400_lin, 'Units', 'pixels');
    set(handles.plot_T_2T_400_lin, 'Position', [plot_T_2T_400_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_400_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 3
    set(handles.plot_T_2T_200_log, 'Units', 'pixels');
    set(handles.plot_T_2T_200_log, 'Position', [plot_T_2T_200_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_200_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 4
    set(handles.plot_T_2T_400_log, 'Units', 'pixels');
    set(handles.plot_T_2T_400_log, 'Position', [plot_T_2T_400_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_400_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
    
    % Scale graph 5
    set(handles.plot_difference200, 'Units', 'pixels');
    set(handles.plot_difference200, 'Position', [plot_difference200_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference200_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_difference200_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference200_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 6
    set(handles.plot_difference400, 'Units', 'pixels');
    set(handles.plot_difference400, 'Position', [plot_difference400_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference400_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_difference400_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference400_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
    
    % Scale graph 7
    set(handles.axes7, 'Units', 'pixels');
    set(handles.axes7, 'Position', [Figure_Size(3)-uipanel3_org(3)-220,...
        Figure_Size(4)-uipanel3_org(4)-480, 350, 150]);