function setRange_slider_thicknessLayerB(handles)
    if str2num(get(handles.edit_thicknessTo_B, 'String')) < str2num(get(handles.edit_thicknessCurrent_B, 'String'))
        s2max = str2num(get(handles.edit_thicknessCurrent_B, 'String'));
        set(handles.edit_thicknessTo_B, 'String', get(handles.edit_thicknessCurrent_B, 'String'));
    else
        s2max = str2num(get(handles.edit_thicknessTo_B, 'String'));
    end
    
    if str2num(get(handles.edit_thicknessFrom_B, 'String')) > str2num(get(handles.edit_thicknessCurrent_B, 'String'))
        s2min = str2num(get(handles.edit_thicknessCurrent_B, 'String'));
        set(handles.edit_thicknessFrom_B, 'String', get(handles.edit_thicknessCurrent_B, 'String'));
    else
        s2min = str2num(get(handles.edit_thicknessFrom_B, 'String'));
    end    
        set(handles.slider_thicknessLayerB, 'Max', s2max);
        set(handles.slider_thicknessLayerB, 'Min', s2min);
        set(handles.slider_thicknessLayerB, 'SliderStep', [1 1]/(handles.divide_uc*(s2max-s2min)));
            set(handles.edit_thicknessCurrent_B, 'String', get(handles.slider_thicknessLayerB, 'Value'));
