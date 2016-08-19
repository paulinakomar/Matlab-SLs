function set_slider_numberOfUC_B(handles);
    s2max = 4*handles.d_b + 0.1;
    s2min = 4*handles.d_b - 0.1;
        set(handles.slider_numberOfUC_B, 'Value', 4*handles.d_b);
        set(handles.slider_numberOfUC_B, 'Max', s2max);
        set(handles.slider_numberOfUC_B, 'Min', s2min);
            set(handles.edit_numberOfUCCurrent_B, 'String', get(handles.slider_numberOfUC_B, 'Value'));
            set(handles.edit_numberOfUCFrom_B, 'String', s2min);
            set(handles.edit_numberOfUCTo_B, 'String', s2max); 
