function setRange_slider_bufferLayer(handles)
    if str2num(get(handles.edit_thicknessTo_buffer, 'String')) < str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))
        s1max = str2num(get(handles.edit_thicknessCurrent_buffer, 'String'));
        set(handles.edit_thicknessTo_buffer, 'String', get(handles.edit_thicknessCurrent_buffer, 'String'));
    else
        s1max = str2num(get(handles.edit_thicknessTo_buffer, 'String'));
    end
    
    if str2num(get(handles.edit_thicknessFrom_buffer, 'String')) > str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))
        s1min = str2num(get(handles.edit_thicknessCurrent_buffer, 'String'));
        set(handles.edit_thicknessFrom_buffer, 'String', get(handles.edit_thicknessCurrent_buffer, 'String'));
    else
        s1min = str2num(get(handles.edit_thicknessFrom_buffer, 'String'));
    end
    
        set(handles.slider_thicknessBufferLayer, 'Max', s1max);
        set(handles.slider_thicknessBufferLayer, 'Min', s1min);
        set(handles.slider_thicknessBufferLayer, 'SliderStep', [1 1]/(handles.divide_uc*(s1max-s1min)));
