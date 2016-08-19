function setRange_slider_numberOfUC_buffer(handles);
    s1max = handles.divide_uc*handles.UnitCell_buffer + 0.1;
    s1min = handles.divide_uc*handles.UnitCell_buffer - 0.1;
        set(handles.slider_numberOfUC_buffer, 'Value', handles.divide_uc*handles.UnitCell_buffer);
        set(handles.slider_numberOfUC_buffer, 'Max', s1max);
        set(handles.slider_numberOfUC_buffer, 'Min', s1min);
            set(handles.edit_numberOfUCCurrent_buffer, 'String', get(handles.slider_numberOfUC_buffer, 'Value'));
            set(handles.edit_numberOfUCFrom_buffer, 'String', s1min);
            set(handles.edit_numberOfUCTo_buffer, 'String', s1max);
