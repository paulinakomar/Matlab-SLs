function handles = set_tabs(handles)

handles.hTabGroup = uitabgroup; drawnow;
handles.tab1 = uitab(handles.hTabGroup, 'title','SL');
    set(handles.text14,'parent', handles.tab1); 
    set(handles.text13,'parent', handles.tab1);
    set(handles.edit_NoPeriods,'parent', handles.tab1);
    set(handles.text55,'parent', handles.tab1);
    set(handles.text15,'parent', handles.tab1);
    set(handles.text60,'parent', handles.tab1);
    set(handles.text61,'parent', handles.tab1);
    set(handles.text_thickness_A,'parent', handles.tab1);
    set(handles.text_thickness_B,'parent', handles.tab1);
    set(handles.slider_thicknessLayerA,'parent', handles.tab1);
    set(handles.slider_thicknessLayerB,'parent', handles.tab1);
    set(handles.edit_thicknessFrom_A,'parent', handles.tab1);
    set(handles.edit_thicknessFrom_B,'parent', handles.tab1);
    set(handles.edit_thicknessTo_A,'parent', handles.tab1);
    set(handles.edit_thicknessTo_B,'parent', handles.tab1);
    set(handles.edit_thicknessCurrent_A,'parent', handles.tab1);
    set(handles.edit_thicknessCurrent_B,'parent', handles.tab1);
    set(handles.text56,'parent', handles.tab1);
    set(handles.text34,'parent', handles.tab1);
    set(handles.text35,'parent', handles.tab1);
    set(handles.text57,'parent', handles.tab1);
    set(handles.text58,'parent', handles.tab1);
    set(handles.text59,'parent', handles.tab1);
    set(handles.popup_intermixing,'parent', handles.tab1);
    set(handles.slider_numberOfUC_A,'parent', handles.tab1);
    set(handles.slider_numberOfUC_B,'parent', handles.tab1);
    set(handles.slider_intermixingA,'parent', handles.tab1);
    set(handles.slider_intermixingB,'parent', handles.tab1);
    set(handles.edit_numberOfUCFrom_A,'parent', handles.tab1);
    set(handles.edit_numberOfUCFrom_B,'parent', handles.tab1);
    set(handles.edit_numberOfUCTo_A,'parent', handles.tab1);
    set(handles.edit_numberOfUCTo_B,'parent', handles.tab1);
    set(handles.edit_numberOfUCCurrent_A,'parent', handles.tab1);
    set(handles.edit_numberOfUCCurrent_B,'parent', handles.tab1);
    set(handles.edit_intermixingfrom_A,'parent', handles.tab1);
    set(handles.edit_intermixingfrom_B,'parent', handles.tab1);
    set(handles.edit_intermixingto_A,'parent', handles.tab1);
    set(handles.edit_intermixingto_B,'parent', handles.tab1);
    set(handles.edit_intermixingcurrent_A,'parent', handles.tab1);
    set(handles.edit_intermixingcurrent_B,'parent', handles.tab1);
handles.tab2 = uitab(handles.hTabGroup, 'title','Buffer layer');
    set(handles.popup_chooseBufferLayer, 'parent', handles.tab2);
    set(handles.text37,'parent', handles.tab2);
    set(handles.text23,'parent', handles.tab2);
    set(handles.text31,'parent', handles.tab2);
    set(handles.text24,'parent', handles.tab2);
    set(handles.text41,'parent', handles.tab2);
    set(handles.text40,'parent', handles.tab2);
    set(handles.BufferThickness,'parent', handles.tab2);
    set(handles.slider_thicknessBufferLayer,'parent', handles.tab2);
    set(handles.slider_numberOfUC_buffer,'parent', handles.tab2);
    set(handles.slider_relaxationLength,'parent', handles.tab2);
    set(handles.edit_thicknessFrom_buffer,'parent', handles.tab2);
    set(handles.edit_thicknessCurrent_buffer,'parent', handles.tab2);
    set(handles.edit_thicknessTo_buffer,'parent', handles.tab2);
    set(handles.edit_numberOfUCFrom_buffer,'parent', handles.tab2);
    set(handles.edit_numberOfUCTo_buffer,'parent', handles.tab2);
    set(handles.edit_numberOfUCCurrent_buffer,'parent', handles.tab2);
    set(handles.edit_relaxationFrom,'parent', handles.tab2);
    set(handles.edit_relaxationTo,'parent', handles.tab2);
    set(handles.edit_relaxationCurrent,'parent', handles.tab2);
handles.tab3 = uitab(handles.hTabGroup, 'title','Variation of the SL period');
    set(handles.uipanel14,'parent', handles.tab3);
    set(handles.plot_ucdistr_layerA,'parent', handles.tab3);
    set(handles.plot_ucdistr_layerB,'parent', handles.tab3);
    set(handles.text62,'parent', handles.tab3);
    set(handles.text63,'parent', handles.tab3);
    set(handles.text64,'parent', handles.tab3);
    set(handles.text65,'parent', handles.tab3);
    set(handles.edit_UCGauss_layerA,'parent', handles.tab3);
    set(handles.edit_UCGauss_layerB,'parent', handles.tab3);
    set(handles.edit_UCRange_layerA,'parent', handles.tab3);
    set(handles.edit_UCRange_layerB,'parent', handles.tab3);
handles.tab4 = uitab(handles.hTabGroup, 'title','Variation of the uc size');
    set(handles.uipanel16,'parent', handles.tab4);
    set(handles.axes12,'parent', handles.tab4);
    set(handles.axes13,'parent', handles.tab4);
    set(handles.text70,'parent', handles.tab4);
    set(handles.text72,'parent', handles.tab4);
    set(handles.text73,'parent', handles.tab4);
    set(handles.text74,'parent', handles.tab4);
    set(handles.edit_stddev_UCsize_A,'parent', handles.tab4);
    set(handles.edit_stddev_UCsize_B,'parent', handles.tab4);
    set(handles.edit_UCSize_layerA,'parent', handles.tab4);
    set(handles.edit_UCSize_layerB,'parent', handles.tab4);    
    
    
set(handles.hTabGroup, 'Parent', handles.uipanel5);
