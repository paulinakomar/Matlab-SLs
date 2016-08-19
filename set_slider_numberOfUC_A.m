function set_slider_numberOfUC_A(handles);
    s1max = handles.divide_uc*handles.d_a + 0.1;
    s1min = handles.divide_uc*handles.d_a - 0.1;
        set(handles.slider_numberOfUC_A, 'Value', handles.divide_uc*handles.d_a);
        set(handles.slider_numberOfUC_A, 'Max', s1max);
        set(handles.slider_numberOfUC_A, 'Min', s1min);
            set(handles.edit_numberOfUCCurrent_A, 'String', get(handles.slider_numberOfUC_A, 'Value'));
            set(handles.edit_numberOfUCFrom_A, 'String', s1min);
            set(handles.edit_numberOfUCTo_A, 'String', s1max);
