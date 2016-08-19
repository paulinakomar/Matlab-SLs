function setRange_slider_numberOfUC_A(handles)
    if str2num(get(handles.edit_numberOfUCTo_A, 'String')) < str2num(get(handles.edit_numberOfUCCurrent_A, 'String'))
        s2max = str2num(get(handles.edit_numberOfUCCurrent_A, 'String'));
        set(handles.edit_numberOfUCTo_A, 'String', get(handles.edit_numberOfUCCurrent_A, 'String'));
    else
        s2max = str2num(get(handles.edit_numberOfUCTo_A, 'String'));
    end
    
    if str2num(get(handles.edit_numberOfUCFrom_A, 'String')) > str2num(get(handles.edit_numberOfUCCurrent_A, 'String'))
        s2min = str2num(get(handles.edit_numberOfUCCurrent_A, 'String'));
        set(handles.edit_numberOfUCFrom_A, 'String', get(handles.edit_numberOfUCCurrent_A, 'String'));
    else
        s2min = str2num(get(handles.edit_numberOfUCFrom_A, 'String'));
    end
    
        set(handles.slider_numberOfUC_A, 'Max', s2max);
        set(handles.slider_numberOfUC_A, 'Min', s2min);
