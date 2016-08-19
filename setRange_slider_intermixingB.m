function setRange_slider_intermixingB(handles)
    s2min = 0;
    s2max = floor(str2double(get(handles.edit_thicknessCurrent_B, 'String'))*4/2)/4;
    
    if s2max < str2num(get(handles.edit_intermixingcurrent_B, 'String'))
        set(handles.edit_intermixingcurrent_B, 'String', s2max);
        set(handles.slider_intermixingB, 'Value', s2max);
        msgbox('Intermixing of layer B was larger than the thickness of layer B! Current number of unit cells where intermixing occurs was changed to the maximum layer thickness!');
    end
    
        set(handles.slider_intermixingB, 'Max', s2max);
        set(handles.edit_intermixingto_B, 'String', s2max);
        set(handles.slider_intermixingB, 'Min', s2min);
        set(handles.edit_intermixingfrom_B, 'String', s2min);
            set(handles.slider_intermixingB, 'SliderStep', [1 1]/(4*(s2max-s2min)));
            set(handles.edit_intermixingcurrent_B, 'String', get(handles.slider_intermixingB, 'Value'));

