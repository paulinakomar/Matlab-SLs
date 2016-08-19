function set_slider_numberOfUC_buffer(handles)
    if str2num(get(handles.edit_numberOfUCTo_buffer, 'String')) < str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'))
        s2max = str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'));
        set(handles.edit_numberOfUCTo_buffer, 'String', get(handles.edit_numberOfUCCurrent_buffer, 'String'));
    else
        s2max = str2num(get(handles.edit_numberOfUCTo_buffer, 'String'));
    end
    
    if str2num(get(handles.edit_numberOfUCFrom_buffer, 'String')) > str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'))
        s2min = str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'));
        set(handles.edit_numberOfUCFrom_buffer, 'String', get(handles.edit_numberOfUCCurrent_buffer, 'String'));
    else
        s2min = str2num(get(handles.edit_numberOfUCFrom_buffer, 'String'));
    end
    
        set(handles.slider_numberOfUC_buffer, 'Max', s2max);
        set(handles.slider_numberOfUC_buffer, 'Min', s2min);
            set(handles.edit_numberOfUCCurrent_buffer, 'String', get(handles.slider_numberOfUC_buffer, 'Value'));
 