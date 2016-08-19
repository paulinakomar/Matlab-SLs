function handles = range(handles)
    handles.range(1,1) = str2double(get(handles.edit_from200, 'String'));
    handles.range(2,1) = str2double(get(handles.edit_from400, 'String'));

    handles.range(1,3) = str2double(get(handles.edit_to200, 'String'));
    handles.range(2,3) = str2double(get(handles.edit_to400, 'String'));

    handles.range(1,2) = str2double(get(handles.edit_step200, 'String'));
    handles.range(2,2) = str2double(get(handles.edit_step400, 'String'));
