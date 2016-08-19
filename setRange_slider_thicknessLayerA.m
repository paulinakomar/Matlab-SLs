function setRange_slider_thicknessLayerA(handles)
    if str2num(get(handles.edit_thicknessTo_A, 'String')) < str2num(get(handles.edit_thicknessCurrent_A, 'String'))
        s1max = str2num(get(handles.edit_thicknessCurrent_A, 'String'));
        set(handles.edit_thicknessTo_A, 'String', get(handles.edit_thicknessCurrent_A, 'String'));
    else
        s1max = str2num(get(handles.edit_thicknessTo_A, 'String'));
    end
    
    if str2num(get(handles.edit_thicknessFrom_A, 'String')) > str2num(get(handles.edit_thicknessCurrent_A, 'String'))
        s1min = str2num(get(handles.edit_thicknessCurrent_A, 'String'));
        set(handles.edit_thicknessFrom_A, 'String', get(handles.edit_thicknessCurrent_A, 'String'));
    else
        s1min = str2num(get(handles.edit_thicknessFrom_A, 'String'));
    end
    
        set(handles.slider_thicknessLayerA, 'Max', s1max);
        set(handles.slider_thicknessLayerA, 'Min', s1min);
        set(handles.slider_thicknessLayerA, 'SliderStep', [1 1]/(4*(s1max-s1min)));
            set(handles.edit_thicknessCurrent_A, 'String', get(handles.slider_thicknessLayerA, 'Value'));
