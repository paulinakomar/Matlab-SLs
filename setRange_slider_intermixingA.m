function setRange_slider_intermixingA(handles)
    s2min = 0;
    s2max = floor(str2double(get(handles.edit_thicknessCurrent_A, 'String'))*4/2)/4;
    
    if s2max < str2num(get(handles.edit_intermixingcurrent_A, 'String'))
        set(handles.edit_intermixingcurrent_A, 'String', s2max);
        set(handles.slider_intermixingA, 'Value', s2max);
        msgbox('Intermixing of layer A was larger than the thickness of layer A! Current number of unit cells where intermixing occurs was changed to the maximum layer thickness!');
    end
    
        set(handles.slider_intermixingA, 'Max', s2max);
        set(handles.edit_intermixingto_A, 'String', s2max);
        set(handles.slider_intermixingA, 'Min', s2min);
        set(handles.edit_intermixingfrom_A, 'String', s2min);
            set(handles.slider_intermixingA, 'SliderStep', [1 1]/(4*(s2max-s2min)));
            set(handles.edit_intermixingcurrent_A, 'String', get(handles.slider_intermixingA, 'Value'));
