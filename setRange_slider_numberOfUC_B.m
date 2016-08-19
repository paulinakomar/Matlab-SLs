function setRange_slider_numberOfUC_B(handles)
    if str2num(get(handles.edit_numberOfUCTo_B, 'String')) < str2num(get(handles.edit_numberOfUCCurrent_B, 'String'))
        s2max = str2num(get(handles.edit_numberOfUCCurrent_B, 'String'));
        set(handles.edit_numberOfUCTo_B, 'String', get(handles.edit_numberOfUCCurrent_B, 'String'));
    else
        s2max = str2num(get(handles.edit_numberOfUCTo_B, 'String'));
    end
    
    if str2num(get(handles.edit_numberOfUCFrom_B, 'String')) > str2num(get(handles.edit_numberOfUCCurrent_B, 'String'))
        s2min = str2num(get(handles.edit_numberOfUCCurrent_B, 'String'));
        set(handles.edit_numberOfUCFrom_B, 'String', get(handles.edit_numberOfUCCurrent_B, 'String'));
    else
        s2min = str2num(get(handles.edit_numberOfUCFrom_B, 'String'));
    end
    
        set(handles.slider_numberOfUC_B, 'Max', s2max);
        set(handles.slider_numberOfUC_B, 'Min', s2min);
