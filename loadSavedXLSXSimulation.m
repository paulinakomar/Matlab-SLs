function handles = loadSavedXLSXSimulation(index);


switch index
    case 0, return
    case 1
        [num, txt, raw] = xlsread(sprintf('%s%s', Path, FileName));
        
        % Sample name
        if isnan(raw{2,1}), set(handles.SampleName, 'String', ' ');
        else set(handles.SampleName, 'String', raw{2,1});
        end
        
        % Material system
        handles.matSyst = raw{3,2};
        switch raw{3,2}
            case 'TNS/HNS',  set(handles.popup_materialSystem, 'Value', 1);
            case 'HNS/TNS',  set(handles.popup_materialSystem, 'Value', 2);
            case 'TNS/ZHNS', set(handles.popup_materialSystem, 'Value', 3);
            case 'ZHNS/TNS', set(handles.popup_materialSystem, 'Value', 4);
            case 'HNS/ZHNS', set(handles.popup_materialSystem, 'Value', 5);
            case 'ZHNS/HNS', set(handles.popup_materialSystem, 'Value', 6);
            case 'ZNS/TNS',  set(handles.popup_materialSystem, 'Value', 7);
            case 'TNS/ZNS',  set(handles.popup_materialSystem, 'Value', 8);
            case 'ZNS/HNS',  set(handles.popup_materialSystem, 'Value', 9);
            case 'HNS/ZNS',  set(handles.popup_materialSystem, 'Value', 10);
            case 'ZNS/ZHNS', set(handles.popup_materialSystem, 'Value', 11);
            case 'ZHNS/ZNS', set(handles.popup_materialSystem, 'Value', 12);
        end
        
        % Number of periods
        set(handles.edit_NoPeriods, 'String', raw{4,2});
        
        % Superlattice parameters
        set(handles.text_thickness_A, 'String', raw{6,2});
        set(handles.edit_thicknessCurrent_A, 'String', raw{7,2});
        set(handles.edit_thicknessFrom_A, 'String', raw{26,2});
        set(handles.edit_thicknessTo_A, 'String', raw{26,3});
        set(handles.edit_thicknessCurrent_A, 'String', raw{26,4});
        set(handles.slider_thicknessLayerA, 'Max', raw{26,3});
        set(handles.slider_thicknessLayerA, 'Min', raw{26,2});
        set(handles.slider_thicknessLayerA, 'Value', raw{26,4});
        set(handles.slider_thicknessLayerA, 'SliderStep', [1 1]/(raw{26,3}-raw{26,2}));
        
        set(handles.text_thickness_B, 'String', raw{10,2});
        set(handles.edit_thicknessCurrent_B, 'String', raw{11,2});
        set(handles.edit_thicknessFrom_B, 'String', raw{28,2});
        set(handles.edit_thicknessTo_B, 'String', raw{28,3});
        set(handles.edit_thicknessCurrent_B, 'String', raw{28,4});
        set(handles.slider_thicknessLayerB, 'Max', raw{28,3});
        set(handles.slider_thicknessLayerB, 'Min', raw{28,2});
        set(handles.slider_thicknessLayerB, 'Value', raw{28,4});
        set(handles.slider_thicknessLayerB, 'SliderStep', [1 1]/(raw{28,3}-raw{28,2}));
        
        handles.d_a = raw{8,2};
        handles.d_b = raw{12,2};
        
        % Vary lattice parameters
        if isnan(raw{27,2})
            set(handles.checkbox_varyLatticeParameters, 'Value', 0);
        else
            set(handles.checkbox_varyLatticeParameters, 'Value', 1);
            set(handles.text34, 'Visible', 'on');
            set(handles.slider_numberOfUC_A, 'Visible', 'on');
            set(handles.edit_numberOfUCFrom_A, 'Visible', 'on');
            set(handles.edit_numberOfUCCurrent_A, 'Visible', 'on');
            set(handles.edit_numberOfUCTo_A, 'Visible', 'on');
            set(handles.text35, 'Visible', 'on');
            set(handles.slider_numberOfUC_B, 'Visible', 'on');
            set(handles.edit_numberOfUCFrom_B, 'Visible', 'on');
            set(handles.edit_numberOfUCCurrent_B, 'Visible', 'on');
            set(handles.edit_numberOfUCTo_B, 'Visible', 'on');
            
            set(handles.edit_numberOfUCFrom_A, 'String', raw{27,2});
            set(handles.edit_numberOfUCTo_A, 'String', raw{27,3});
            set(handles.edit_numberOfUCCurrent_A, 'String', raw{27,4});
            set(handles.slider_numberOfUC_A, 'Max', raw{27,3});
            set(handles.slider_numberOfUC_A, 'Min', raw{27,2});
            set(handles.slider_numberOfUC_A, 'Value', raw{27,4});
            
            set(handles.edit_numberOfUCFrom_B, 'String', raw{29,2});
            set(handles.edit_numberOfUCTo_B, 'String', raw{29,3});
            set(handles.edit_numberOfUCCurrent_B, 'String', raw{29,4});
            set(handles.slider_numberOfUC_B, 'Max', raw{29,3});
            set(handles.slider_numberOfUC_B, 'Min', raw{29,2});
            set(handles.slider_numberOfUC_B, 'Value', raw{29,4});
        end
        
        % Buffer layer
        switch raw{13,2}
            case 'no', set(handles.checkbox_bufferLayer, 'Value', 0);
            case 'yes'
                set(handles.checkbox_bufferLayer, 'Value', 1);
                set(handles.uipanel9, 'Visible', 'on');
                set(handles.popup_chooseBufferLayer, 'Visible', 'on');
                set(handles.edit_thicknessCurrent_buffer, 'Visible', 'on');
                set(handles.text23, 'Visible', 'on');
                set(handles.slider_thicknessBufferLayer, 'Visible', 'on');
                set(handles.edit_thicknessFrom_buffer, 'Visible', 'on');
                set(handles.edit_thicknessTo_buffer, 'Visible', 'on');
                set(handles.BufferThickness, 'Visible', 'on');
                set(handles.text37, 'Visible', 'on');
                set(handles.checkbox_relaxationAndStrain, 'Enable', 'on');
                handles.bufferMat = raw{14,2};
                
                switch raw{14,2}
                    case 'TNS',  set(handles.popup_materialSystem, 'Value', 1);
                    case 'HNS',  set(handles.popup_materialSystem, 'Value', 2);
                    case 'ZNS',  set(handles.popup_materialSystem, 'Value', 3);
                    case 'ZHNS', set(handles.popup_materialSystem, 'Value', 4);
                    case 'V',    set(handles.popup_materialSystem, 'Value', 5);
                end
                
                set(handles.edit_thicknessFrom_buffer, 'String', raw{30,2});
                set(handles.edit_thicknessTo_buffer, 'String', raw{30,3});
                set(handles.edit_thicknessCurrent_buffer, 'String', raw{30,4});
                set(handles.slider_thicknessBufferLayer, 'Max', raw{30,3});
                set(handles.slider_thicknessBufferLayer, 'Min', raw{30,2});
                set(handles.slider_thicknessBufferLayer, 'Value', raw{30,4});
                set(handles.slider_thicknessBufferLayer, 'SliderStep', [1 1]/(raw{30,3}-raw{30,2}));
                set(handles.BufferThickness, 'String', raw{15,2});
        end
        
        % Set range
        handles.range(1,1) = raw{22,2};           handles.range(2,1) = raw{23,2};
        handles.range(1,3) = raw{22,3};           handles.range(2,3) = raw{23,3};
        handles.range(1,2) = raw{22,4};           handles.range(2,2) = raw{23,4};
        
        set(handles.edit_from200, 'String', raw{22,2});
        set(handles.edit_to200, 'String', raw{22,3});
        set(handles.edit_step200, 'String', raw{22,4});
        
        set(handles.edit_from400, 'String', raw{23,2});
        set(handles.edit_to400, 'String', raw{23,3});
        set(handles.edit_step400, 'String', raw{23,4});
        
        
        % Strain and relaxation length
        % Buffer layer
        switch raw{17,2}
            case 'no', set(handles.checkbox_relaxationAndStrain, 'Value', 0);
            case 'yes'
                set(handles.checkbox_relaxationAndStrain, 'Value', 1);
                set(handles.text31, 'Visible', 'on');
                set(handles.slider_numberOfUC_buffer, 'Visible', 'on');
                set(handles.edit_numberOfUCFrom_buffer, 'Visible', 'on');
                set(handles.edit_numberOfUCCurrent_buffer, 'Visible', 'on');
                set(handles.edit_numberOfUCTo_buffer, 'Visible', 'on');
                set(handles.text24, 'Visible', 'on');
                set(handles.slider_relaxationLength, 'Visible', 'on');
                set(handles.edit_relaxationFrom, 'Visible', 'on');
                set(handles.edit_relaxationCurrent, 'Visible', 'on');
                set(handles.edit_relaxationTo, 'Visible', 'on');
                
                set(handles.edit_numberOfUCFrom_buffer, 'String', raw{31,2});
                set(handles.edit_numberOfUCTo_buffer, 'String', raw{31,3});
                set(handles.edit_numberOfUCCurrent_buffer, 'String', raw{31,4});
                set(handles.slider_numberOfUC_buffer, 'Max', raw{31,3});
                set(handles.slider_numberOfUC_buffer, 'Min', raw{31,2});
                set(handles.slider_numberOfUC_buffer, 'Value', raw{31,4});
                
                set(handles.edit_relaxationFrom, 'String', raw{32,2});
                set(handles.edit_relaxationTo, 'String', raw{32,3});
                set(handles.edit_relaxationCurrent, 'String', raw{32,4});
                set(handles.slider_relaxationLength, 'Max', raw{32,3});
                set(handles.slider_relaxationLength, 'Min', raw{32,2});
                set(handles.slider_relaxationLength, 'Value', raw{32,4});
                set(handles.slider_relaxationLength, 'SliderStep', [1 1]/(raw{32,3}-raw{32,2}));
        end
        
    case 2
        open(sprintf('%s%s', Path, FileName));
        
end