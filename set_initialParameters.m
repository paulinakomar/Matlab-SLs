function handles = set_initialParameters(handles)

s1max = str2num(get(handles.edit_thicknessTo_A, 'String'));
s1min = str2num(get(handles.edit_thicknessFrom_A, 'String'));
    set(handles.slider_thicknessLayerA, 'Value', (s1max+s1min)/2);
    set(handles.slider_thicknessLayerA, 'Max', s1max);
    set(handles.slider_thicknessLayerA, 'Min', s1min);
    set(handles.slider_thicknessLayerA, 'SliderStep', [1 1]/(handles.divide_uc*(s1max-s1min)));
        set(handles.edit_thicknessCurrent_A, 'String', get(handles.slider_thicknessLayerA, 'Value'));
        
s2max = str2num(get(handles.edit_thicknessTo_B, 'String'));
s2min = str2num(get(handles.edit_thicknessFrom_B, 'String'));
    set(handles.slider_thicknessLayerB, 'Value', (s2max+s2min)/2);
    set(handles.slider_thicknessLayerB, 'Max', s2max);
    set(handles.slider_thicknessLayerB, 'Min', s2min);
    set(handles.slider_thicknessLayerB, 'SliderStep', [1 1]/(handles.divide_uc*(s2max-s2min)));
        set(handles.edit_thicknessCurrent_B, 'String', get(handles.slider_thicknessLayerB, 'Value'));
        
set(handles.edit_intermixingcurrent_A, 'String', 0);
set(handles.edit_intermixingcurrent_B, 'String', 0);
setRange_slider_intermixingA(handles);
setRange_slider_intermixingB(handles);
             
 popup_materialSystem = get(handles.popup_materialSystem, 'Value');
 edit_NoPeriods = int32(str2num(get(handles.edit_NoPeriods, 'String')));
 buffer_YN = get(handles.checkbox_bufferLayer, 'Value');
 
 if buffer_YN
    buffer_material  = get(handles.popup_chooseBufferLayer, 'Value');
    Nlayers_buffer = str2double(get(handles.edit_thicknessCurrent_buffer, 'String'));
 else
     buffer_material = 0;
     Nlayers_buffer = 0;
     set(handles.checkbox_relaxationAndStrain, 'Enable', 'off');
 end
 
if get(handles.popup_materialSystem, 'Value') == 1
    set(handles.text_thickness_A, 'String', 5.94*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
    set(handles.text_thickness_B, 'String', 6.08*str2num(get(handles.edit_thicknessCurrent_B, 'String'))/10);
else
    set(handles.text_thickness_A, 'String', handles.d_a*handles.divide_uc*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
    set(handles.text_thickness_B, 'String', handles.d_b*handles.divide_uc*str2num(get(handles.edit_thicknessCurrent_B, 'String'))/10);
end

if get(handles.popup_chooseBufferLayer, 'Value') == 1
    set(handles.BufferThickness, 'String', 5.94*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);
else
    set(handles.BufferThickness, 'String', handles.UnitCell_buffer*handles.divide_uc*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);
end
  
 NumberUnitCells_A = get(handles.slider_thicknessLayerA, 'Value');
 NumberUnitCells_B = get(handles.slider_thicknessLayerB, 'Value');

set(handles.BufferThickness, 'Visible', 'off');
set(handles.text37, 'Visible', 'off');

handles = range(handles);
handles.Grid = 'on';
handles.Difference = 'lin';
    
if get(handles.checkbox_relaxationAndStrain, 'Value')
    strain = str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String'));
else
    strain = 0;
end

if get(handles.checkbox_intermixing, 'Value')
    intermixing_case = get(handles.popup_materialSystem, 'Value');
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
    
    dev_thicknessUC_a = 0.5;%
    set(handles.edit_UCRange_layerA, 'String', 0.5);
    dev_thicknessUC_b = 0.5;%
    set(handles.edit_UCRange_layerB, 'String', 0.5);
    std_dev_gaussthicknessUC_a = str2double(get(handles.edit_UCGauss_layerA, 'String'));
    std_dev_gaussthicknessUC_b = str2double(get(handles.edit_UCGauss_layerB, 'String'));

    dev_UCsize_a = 0.02;%
    set(handles.edit_UCSize_layerA, 'String', 0.02);
    dev_UCsize_b = 0.02;%
    set(handles.edit_UCSize_layerB, 'String', 0.02);
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
    
    plot_xrd(handles);
    
handles.matSyst = 'TNS/HNS';