function handles = simulate(handles)
    
set(handles.figure1, 'pointer', 'watch'); 
drawnow; pause(0.1)

     popup_materialSystem = get(handles.popup_materialSystem, 'Value');
     edit_NoPeriods = int32(str2num(get(handles.edit_NoPeriods, 'String')));
     buffer_YN = get(handles.checkbox_bufferLayer, 'Value');
         if buffer_YN
            buffer_material  = get(handles.popup_chooseBufferLayer, 'Value');
            Nlayers_buffer = str2double(get(handles.edit_thicknessCurrent_buffer, 'String'));
         else
             buffer_material = 0;
             Nlayers_buffer = 0;
         end
     NumberUnitCells_A = get(handles.slider_thicknessLayerA, 'Value');
     NumberUnitCells_B = get(handles.slider_thicknessLayerB, 'Value');

    handles = range(handles);
    
    if get(handles.checkbox_relaxationAndStrain, 'Value')
        strain = str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String'));
    else
        strain = 0;
    end
    
    if get(handles.checkbox_intermixing, 'Value')
        intermixing_case = get(handles.popup_intermixing, 'Value');
        Nuc_intermixing_a = str2double(get(handles.edit_intermixingcurrent_A, 'String'));
        Nuc_intermixing_b = str2double(get(handles.edit_intermixingcurrent_B, 'String'));
    else
        intermixing_case  = 0;
        Nuc_intermixing_a = 0;
        Nuc_intermixing_b = 0;
    end
    
    d_a = str2double(get(handles.edit_numberOfUCCurrent_A, 'String'));
    d_b = str2double(get(handles.edit_numberOfUCCurrent_B, 'String'));
    d_buffer = str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String'));
    Nrelaxation =  str2double(get(handles.edit_relaxationCurrent, 'String'));
    %
    
    dev_thicknessUC_a = str2double(get(handles.edit_UCRange_layerA, 'String'));
    dev_thicknessUC_b = str2double(get(handles.edit_UCRange_layerB, 'String'));
    std_dev_gaussthicknessUC_a = str2double(get(handles.edit_UCGauss_layerA, 'String'));
    std_dev_gaussthicknessUC_b = str2double(get(handles.edit_UCGauss_layerB, 'String'));
    
    dev_UCsize_a = str2double(get(handles.edit_UCSize_layerA, 'String'));
    dev_UCsize_b = str2double(get(handles.edit_UCSize_layerA, 'String'));
    std_dev_gausssizeUC_a = str2double(get(handles.edit_stddev_UCsize_A, 'String'));
    std_dev_gausssizeUC_b = str2double(get(handles.edit_stddev_UCsize_B, 'String'));
    
    
    [handles.twotheta1, handles.twotheta2,...
        handles.IntensityPV1, handles.IntensityPV2, handles.UnitCell_buffer,...
        handles.d_a, handles.d_b, handles.f, handles.thickness_perm_a,...
        handles.thickness_perm_b, handles.d_perm_a, handles.d_perm_b] = SL_buffer_input(buffer_YN,...
        buffer_material, Nlayers_buffer, handles.range, popup_materialSystem,...
        edit_NoPeriods, NumberUnitCells_A, NumberUnitCells_B,...
        d_buffer, d_a, d_b, Nrelaxation, intermixing_case, Nuc_intermixing_a, Nuc_intermixing_b,...
        dev_thicknessUC_a, dev_thicknessUC_b, std_dev_gaussthicknessUC_a, std_dev_gaussthicknessUC_b,...
        dev_UCsize_a, dev_UCsize_b, std_dev_gausssizeUC_a, std_dev_gausssizeUC_b);
    
%code in here that does something...
set(handles.figure1, 'pointer', 'arrow');