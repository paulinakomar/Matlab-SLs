function setRange_slider_relaxation(handles)
    if str2num(get(handles.edit_relaxationFrom, 'String')) > str2num(get(handles.edit_relaxationCurrent, 'String'))
        s1min = str2num(get(handles.edit_relaxationCurrent, 'String'));
        set(handles.edit_relaxationFrom, 'String', get(handles.edit_relaxationCurrent, 'String'));
    else
        s1min = str2num(get(handles.edit_relaxationFrom, 'String'));
    end

    s1max = handles.divide_uc*str2double(get(handles.edit_thicknessCurrent_buffer, 'String'));
        set(handles.slider_relaxationLength, 'Max', s1max);
        set(handles.slider_relaxationLength, 'Min', s1min);        
            set(handles.slider_relaxationLength, 'SliderStep', [1 1]/(s1max-s1min));
            set(handles.edit_relaxationCurrent, 'String', get(handles.slider_relaxationLength, 'Value'));
