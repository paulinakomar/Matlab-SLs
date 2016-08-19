function varargout = SL_gui(varargin)
% SL_GUI MATLAB code for SL_gui.fig
%      SL_GUI, by itself, creates a new SL_GUI or raises the existing
%      singleton*.
%
%      H = SL_GUI returns the handle to a new SL_GUI or the handle to
%      the existing singleton*.
%
%      SL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SL_GUI.M with the given input arguments.
%
%      SL_GUI('Property','Value',...) creates a new SL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SL_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SL_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to menu_help SL_gui

% Last Modified by GUIDE v2.5 01-Apr-2015 09:48:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SL_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @SL_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SL_gui is made visible.
function SL_gui_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);
    
% --- Outputs from this function are returned to the command line.
function varargout = SL_gui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%% Initialization
clc
handles.output = hObject;

%% create tabs
handles = set_tabs(handles);

%% set all parameters
handles = set_initialParameters(handles);
guidata(hObject, handles);
        

%% start of the gui
function SampleName_Callback(hObject, eventdata, handles)
function SampleName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% build superlattice - material
% choose the appropriate material system from popup menu
function handles = popup_materialSystem_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
        
    a.TNS = 5.94; a.HNS = 6.08; a.ZNS = 6.11; a.ZHNS = 6.1082; a.V = 6.2;

    switch get(handles.popup_materialSystem, 'Value')
        case 1,     handles.d_a = a.TNS/4;   handles.d_b = a.HNS/4;   handles.matSyst = 'TNS/HNS';
        case 2,     handles.d_a = a.HNS/4;   handles.d_b = a.TNS/4;   handles.matSyst = 'HNS/TNS';
        case 3,     handles.d_a = a.TNS/4;   handles.d_b = a.ZHNS/4;  handles.matSyst = 'TNS/ZHNS';
        case 4,     handles.d_a = a.ZHNS/4;  handles.d_b = a.TNS/4;   handles.matSyst = 'ZHNS/TNS';
        case 5,     handles.d_a = a.HNS/4;   handles.d_b = a.ZHNS/4;  handles.matSyst = 'HNS/ZHNS';
        case 6,     handles.d_a = a.ZHNS/4;  handles.d_b = a.HNS/4;   handles.matSyst = 'ZHNS/HNS';
        case 7,     handles.d_a = a.ZNS/4;   handles.d_b = a.TNS/4;   handles.matSyst = 'ZNS/TNS';
        case 8,     handles.d_a = a.TNS/4;   handles.d_b = a.ZNS/4;   handles.matSyst = 'TNS/ZNS';
        case 9,     handles.d_a = a.ZNS/4;   handles.d_b = a.HNS/4;   handles.matSyst = 'ZNS/HNS';
        case 10,    handles.d_a = a.HNS/4;   handles.d_b = a.ZNS/4;   handles.matSyst = 'HNS/ZNS';
        case 11,    handles.d_a = a.ZNS/4;   handles.d_b = a.ZHNS/4;  handles.matSyst = 'ZNS/ZHNS';
        case 12,    handles.d_a = a.ZHNS/4;  handles.d_b = a.ZNS/4;   handles.matSyst = 'ZHNS/ZNS';
    end

        
    set_slider_numberOfUC_A(handles);
    set_slider_numberOfUC_B(handles); 
    
    if get(handles.popup_materialSystem, 'Value') == 1
        set(handles.text_thickness_A, 'String', 5.94*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
        set(handles.text_thickness_B, 'String', 6.08*str2num(get(handles.edit_thicknessCurrent_B, 'String'))/10);
        handles.matSyst = 'TNS/HNS';
    else
        set(handles.text_thickness_A, 'String', handles.d_a*4*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
        set(handles.text_thickness_B, 'String', handles.d_b*4*str2num(get(handles.edit_thicknessCurrent_B, 'String'))/10);
    end
    
    plot_xrd(handles);
        guidata(hObject, handles);
        
function popup_materialSystem_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% number of periods
function edit_NoPeriods_Callback(hObject, eventdata, handles)
    if str2num(get(handles.edit_NoPeriods, 'String')) == 0
        set(handles.text14, 'Visible', 'off');
        set(handles.slider_thicknessLayerA, 'Visible', 'off');
        set(handles.text15, 'Visible', 'off');
        set(handles.slider_thicknessLayerB, 'Visible', 'off');
        set(handles.edit_thicknessFrom_A, 'Visible', 'off');
        set(handles.edit_thicknessTo_A, 'Visible', 'off');
        set(handles.edit_thicknessCurrent_A, 'Visible', 'off');
        set(handles.text_thickness_A, 'Visible', 'off');
        set(handles.edit_thicknessFrom_B, 'Visible', 'off');
        set(handles.edit_thicknessTo_B, 'Visible', 'off');
        set(handles.edit_thicknessCurrent_B, 'Visible', 'off');
        set(handles.text_thickness_B, 'Visible', 'off');
%         set(handles.text36, 'Visible', 'off');
        
        set(handles.checkbox_bufferLayer, 'Value', 1);
        guidata(hObject, handles);
        checkbox_bufferLayer_Callback(hObject, eventdata, handles);
    else
        set(handles.text14, 'Visible', 'on');
        set(handles.slider_thicknessLayerA, 'Visible', 'on');
        set(handles.text15, 'Visible', 'on');
        set(handles.slider_thicknessLayerB, 'Visible', 'on');
        set(handles.edit_thicknessFrom_A, 'Visible', 'on');
        set(handles.edit_thicknessTo_A, 'Visible', 'on');
        set(handles.edit_thicknessCurrent_A, 'Visible', 'on');
        set(handles.text_thickness_A, 'Visible', 'on');
        set(handles.edit_thicknessFrom_B, 'Visible', 'on');
        set(handles.edit_thicknessTo_B, 'Visible', 'on');
        set(handles.edit_thicknessCurrent_B, 'Visible', 'on');
        set(handles.text_thickness_B, 'Visible', 'on');
%         set(handles.text36, 'Visible', 'on');
    end
    
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_NoPeriods_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    
% thickness of the layers 
function slider_thicknessLayerA_Callback(hObject, eventdata, handles)
    
set(handles.edit_thicknessCurrent_A, 'String', get(handles.slider_thicknessLayerA, 'Value'));
    set(handles.text_thickness_A, 'String', handles.d_a*4*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
    
    setRange_slider_intermixingA(handles);
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
        

function slider_thicknessLayerA_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function edit_thicknessFrom_A_Callback(hObject, eventdata, handles)
        setRange_slider_thicknessLayerA(handles);
    function edit_thicknessFrom_A_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
    function edit_thicknessTo_A_Callback(hObject, eventdata, handles)
        setRange_slider_thicknessLayerA(handles);
    function edit_thicknessTo_A_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

    function edit_thicknessCurrent_A_Callback(hObject, eventdata, handles)
        if str2double(get(handles.edit_thicknessCurrent_A, 'String')) > get(handles.slider_thicknessLayerA, 'Max')
            set(handles.slider_thicknessLayerA, 'Max', str2double(get(handles.edit_thicknessCurrent_A, 'String')));
            set(handles.edit_thicknessTo_A, 'String', get(handles.edit_thicknessCurrent_A, 'String'));
        end
        
        if str2double(get(handles.edit_thicknessCurrent_A, 'String')) < get(handles.slider_thicknessLayerA, 'Min')
            set(handles.slider_thicknessLayerA, 'Min', str2double(get(handles.edit_thicknessCurrent_A, 'String')));
            set(handles.edit_thicknessFrom_A, 'String', get(handles.edit_thicknessCurrent_A, 'String'));
        end
        
    set(handles.slider_thicknessLayerA, 'Value', str2num(get(handles.edit_thicknessCurrent_A, 'String')));
        set(handles.text_thickness_A, 'String', handles.d_a*4*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
    
        setRange_slider_thicknessLayerA(handles);
        setRange_slider_intermixingA(handles);
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function edit_thicknessCurrent_A_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
        

function slider_thicknessLayerB_Callback(hObject, eventdata, handles)
    set(handles.edit_thicknessCurrent_B, 'String', get(handles.slider_thicknessLayerB, 'Value'));
    set(handles.text_thickness_B, 'String', handles.d_b*4*str2num(get(handles.edit_thicknessCurrent_B, 'String'))/10);
    
    setRange_slider_intermixingB(handles);
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function slider_thicknessLayerB_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function edit_thicknessFrom_B_Callback(hObject, eventdata, handles)
        setRange_slider_thicknessLayerB(handles);
    function edit_thicknessFrom_B_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

    function edit_thicknessTo_B_Callback(hObject, eventdata, handles)
        setRange_slider_thicknessLayerB(handles);
    function edit_thicknessTo_B_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

    function edit_thicknessCurrent_B_Callback(hObject, eventdata, handles)
        if str2double(get(handles.edit_thicknessCurrent_B, 'String')) > get(handles.slider_thicknessLayerB, 'Max')
            set(handles.slider_thicknessLayerB, 'Max', str2double(get(handles.edit_thicknessCurrent_B, 'String')));
            set(handles.edit_thicknessTo_B, 'String', get(handles.edit_thicknessCurrent_B, 'String'));
        end
        
        if str2double(get(handles.edit_thicknessCurrent_B, 'String')) < get(handles.slider_thicknessLayerB, 'Min')
            set(handles.slider_thicknessLayerB, 'Min', str2double(get(handles.edit_thicknessCurrent_B, 'String')));
            set(handles.edit_thicknessFrom_B, 'String', get(handles.edit_thicknessCurrent_B, 'String'));
        end
              
        set(handles.slider_thicknessLayerB, 'Value', str2num(get(handles.edit_thicknessCurrent_B, 'String')));
            set(handles.text_thickness_B, 'String', handles.d_b*4*str2num(get(handles.edit_thicknessCurrent_B, 'String'))/10);
        
        setRange_slider_intermixingB(handles);
        setRange_slider_thicknessLayerB(handles);    
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function edit_thicknessCurrent_B_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


        
function text_thickness_A_Callback(hObject, eventdata, handles)
function text_thickness_A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function text_thickness_B_Callback(hObject, eventdata, handles)
function text_thickness_B_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

        
% Vary the lattice parameters of layers
function checkbox_varyLatticeParameters_Callback(hObject, eventdata, handles)

    if get(handles.checkbox_varyLatticeParameters, 'Value')
        set(handles.text34, 'Visible', 'on');
        set(handles.text56, 'Visible', 'on');
        set(handles.slider_numberOfUC_A, 'Visible', 'on');
        set(handles.edit_numberOfUCFrom_A, 'Visible', 'on');
        set(handles.edit_numberOfUCCurrent_A, 'Visible', 'on');
        set(handles.edit_numberOfUCTo_A, 'Visible', 'on');
        set(handles.text35, 'Visible', 'on');
        set(handles.slider_numberOfUC_B, 'Visible', 'on');
        set(handles.edit_numberOfUCFrom_B, 'Visible', 'on');
        set(handles.edit_numberOfUCCurrent_B, 'Visible', 'on');
        set(handles.edit_numberOfUCTo_B, 'Visible', 'on');
    else
        set(handles.text34, 'Visible', 'off');
        set(handles.text56, 'Visible', 'off');
        set(handles.slider_numberOfUC_A, 'Visible', 'off');
        set(handles.edit_numberOfUCFrom_A, 'Visible', 'off');
        set(handles.edit_numberOfUCCurrent_A, 'Visible', 'off');
        set(handles.edit_numberOfUCTo_A, 'Visible', 'off');
        set(handles.text35, 'Visible', 'off');
        set(handles.slider_numberOfUC_B, 'Visible', 'off');
        set(handles.edit_numberOfUCFrom_B, 'Visible', 'off');
        set(handles.edit_numberOfUCCurrent_B, 'Visible', 'off');
        set(handles.edit_numberOfUCTo_B, 'Visible', 'off');
    end

        
    handles = simulate(handles);
        guidata(hObject, handles);
        
    set_slider_numberOfUC_A(handles);
    set_slider_numberOfUC_B(handles); 
        
function slider_numberOfUC_A_Callback(hObject, eventdata, handles)
    set(handles.edit_numberOfUCCurrent_A, 'String', get(handles.slider_numberOfUC_A, 'Value'));
        handles.d_a = str2num(get(handles.edit_numberOfUCCurrent_A, 'String'))/4;
        set(handles.text_thickness_A, 'String', handles.d_a*4*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
        
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function slider_numberOfUC_A_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function edit_numberOfUCFrom_A_Callback(hObject, eventdata, handles)
        setRange_slider_numberOfUC_A(handles);
    function edit_numberOfUCFrom_A_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function edit_numberOfUCTo_A_Callback(hObject, eventdata, handles)
        setRange_slider_numberOfUC_A(handles);
    function edit_numberOfUCTo_A_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function edit_numberOfUCCurrent_A_Callback(hObject, eventdata, handles)
        if str2double(get(handles.edit_numberOfUCCurrent_A, 'String')) > get(handles.slider_numberOfUC_A, 'Max')
            set(handles.slider_numberOfUC_A, 'Max', str2double(get(handles.edit_numberOfUCCurrent_A, 'String')));
            set(handles.edit_numberOfUCTo_A, 'String', get(handles.edit_numberOfUCCurrent_A, 'String'));
        end

        if str2double(get(handles.edit_numberOfUCCurrent_A, 'String')) < get(handles.slider_numberOfUC_A, 'Min')
            set(handles.slider_numberOfUC_A, 'Min', str2double(get(handles.edit_numberOfUCCurrent_A, 'String')));
            set(handles.edit_numberOfUCFrom_A, 'String', get(handles.edit_numberOfUCCurrent_A, 'String'));
        end
     
    handles.d_a = str2num(get(handles.edit_numberOfUCCurrent_A, 'String'))/4;
    set(handles.text_thickness_A, 'String', handles.d_a*4*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);
    set(handles.slider_numberOfUC_A, 'Value', str2num(get(handles.edit_numberOfUCCurrent_A, 'String')));
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function edit_numberOfUCCurrent_A_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    

function slider_numberOfUC_B_Callback(hObject, eventdata, handles)
    set(handles.edit_numberOfUCCurrent_B, 'String', get(handles.slider_numberOfUC_B, 'Value'));
        handles.d_b = str2num(get(handles.edit_numberOfUCCurrent_B, 'String'))/4;
        set(handles.text_thickness_B, 'String', handles.d_b*4*str2num(get(handles.edit_thicknessCurrent_B, 'String'))/10);
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function slider_numberOfUC_B_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function edit_numberOfUCFrom_B_Callback(hObject, eventdata, handles)
        setRange_slider_numberOfUC_B(handles);
    function edit_numberOfUCFrom_B_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function edit_numberOfUCTo_B_Callback(hObject, eventdata, handles)
        setRange_slider_numberOfUC_B(handles);
    function edit_numberOfUCTo_B_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function edit_numberOfUCCurrent_B_Callback(hObject, eventdata, handles)
        if str2double(get(handles.edit_numberOfUCCurrent_B, 'String')) > get(handles.slider_numberOfUC_B, 'Max')
            set(handles.slider_numberOfUC_B, 'Max', str2double(get(handles.edit_numberOfUCCurrent_B, 'String')));
            set(handles.edit_numberOfUCTo_B, 'String', get(handles.edit_numberOfUCCurrent_B, 'String'));
        end

        if str2double(get(handles.edit_numberOfUCCurrent_B, 'String')) < get(handles.slider_numberOfUC_B, 'Min')
            set(handles.slider_numberOfUC_B, 'Min', str2double(get(handles.edit_numberOfUCCurrent_B, 'String')));
            set(handles.edit_numberOfUCFrom_B, 'String', get(handles.edit_numberOfUCCurrent_B, 'String'));
        end
    
    handles.d_b = str2num(get(handles.edit_numberOfUCCurrent_B, 'String'))/4;
    set(handles.text_thickness_B, 'String', handles.d_b*4*str2num(get(handles.edit_thicknessCurrent_A, 'String'))/10);    
    set(handles.slider_numberOfUC_B, 'Value', str2num(get(handles.edit_numberOfUCCurrent_B, 'String')));
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function edit_numberOfUCCurrent_B_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


    
%% buffer layer
    % tick if there is an additional buffer layer
function checkbox_bufferLayer_Callback(hObject, eventdata, handles)
    if get(handles.checkbox_bufferLayer, 'Value')
        set(handles.popup_chooseBufferLayer, 'Visible', 'on');
        set(handles.edit_thicknessCurrent_buffer, 'Visible', 'on');
        set(handles.uipanel9, 'Visible', 'on');
        set(handles.text23, 'Visible', 'on');
        set(handles.slider_thicknessBufferLayer, 'Visible', 'on');
        set(handles.edit_thicknessFrom_buffer, 'Visible', 'on');
        set(handles.edit_thicknessTo_buffer, 'Visible', 'on');
        set(handles.BufferThickness, 'Visible', 'on');
        set(handles.text37, 'Visible', 'on');
        handles.bufferMat = 'TNS';
        handles.UnitCell_buffer = 5.94/4;
        set(handles.checkbox_relaxationAndStrain, 'Enable', 'on');
        set(handles.uipanel9, 'parent', handles.tab2); drawnow;
    else
        set(handles.popup_chooseBufferLayer, 'Visible', 'off');
        set(handles.edit_thicknessCurrent_buffer, 'Visible', 'off');
        set(handles.uipanel9, 'Visible', 'off');
        set(handles.text23, 'Visible', 'off');
        set(handles.slider_thicknessBufferLayer, 'Visible', 'off');
        set(handles.edit_thicknessFrom_buffer, 'Visible', 'off');
        set(handles.edit_thicknessTo_buffer, 'Visible', 'off');
        set(handles.BufferThickness, 'Visible', 'off');
        set(handles.text37, 'Visible', 'off');
        set(handles.checkbox_relaxationAndStrain, 'Enable', 'off');

    end
        
        s3max = str2num(get(handles.edit_thicknessTo_buffer, 'String'));
        s3min = str2num(get(handles.edit_thicknessFrom_buffer, 'String'));
        set(handles.slider_thicknessBufferLayer, 'Value', (s3max+s3min)/2);
        set(handles.slider_thicknessBufferLayer, 'Max', s3max);
        set(handles.slider_thicknessBufferLayer, 'Min', s3min);
        set(handles.slider_thicknessBufferLayer, 'SliderStep', [1 1]/(s3max-s3min));
            set(handles.edit_thicknessCurrent_buffer, 'String', get(handles.slider_thicknessBufferLayer, 'Value'));
        setRange_slider_bufferLayer(handles);
        
        if get(handles.popup_chooseBufferLayer, 'Value') == 1
            set(handles.BufferThickness, 'String', 5.94*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);
        else
            set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);
        end
            
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
                
                
    % choose material that there is as a buffer layer
    function handles = popup_chooseBufferLayer_Callback(hObject, eventdata, handles)
        handles = simulate(handles);
            guidata(hObject, handles);
            
        a.TNS = 5.94/4; a.HNS = 6.08/4; a.ZNS = 6.11/4; a.ZHNS = 6.1082/4; a.V = 6.2/4;

        switch get(handles.popup_chooseBufferLayer, 'Value')
            case 1,     handles.UnitCell_buffer = a.TNS;    handles.bufferMat = 'TNS';
            case 2,     handles.UnitCell_buffer = a.HNS;    handles.bufferMat = 'HNS';
            case 3,     handles.UnitCell_buffer = a.ZNS;    handles.bufferMat = 'ZNS';
            case 4,     handles.UnitCell_buffer = a.ZHNS;   handles.bufferMat = 'ZHNS';
            case 5,     handles.UnitCell_buffer = a.V;      handles.bufferMat = 'V';
        end
        
                
        set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);
        
        
        setRange_slider_numberOfUC_buffer(handles);
        set(handles.text40, 'String', round((abs(str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'))/5.95-1))*10000)/10000);

            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);           
    function popup_chooseBufferLayer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

        
        function slider_thicknessBufferLayer_Callback(hObject, eventdata, handles)
            set(handles.edit_thicknessCurrent_buffer, 'String', get(handles.slider_thicknessBufferLayer, 'Value'));
            set(handles.slider_relaxationLength, 'Max', 4*str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
            set(handles.edit_relaxationTo, 'String', 4*str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
            smax = str2num(get(handles.edit_relaxationTo, 'String'));
            smin = str2num(get(handles.edit_relaxationFrom, 'String'));
                set(handles.slider_relaxationLength, 'SliderStep', [1 1]/(smax-smin));
            
            setRange_slider_bufferLayer(handles);        
                set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
        function slider_thicknessBufferLayer_CreateFcn(hObject, eventdata, handles)
        if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        end

        function edit_thicknessFrom_buffer_Callback(hObject, eventdata, handles)
            setRange_slider_bufferLayer(handles);
        function edit_thicknessFrom_buffer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

        function edit_thicknessTo_buffer_Callback(hObject, eventdata, handles)
            setRange_slider_bufferLayer(handles);
        function edit_thicknessTo_buffer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

        function edit_thicknessCurrent_buffer_Callback(hObject, eventdata, handles)
            if str2double(get(handles.edit_thicknessCurrent_buffer, 'String')) > get(handles.slider_thicknessBufferLayer, 'Max')
                set(handles.slider_thicknessBufferLayer, 'Max', str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
                set(handles.edit_thicknessTo_buffer, 'String', get(handles.edit_thicknessCurrent_buffer, 'String'));
            end

            if str2double(get(handles.edit_thicknessCurrent_buffer, 'String')) < get(handles.slider_thicknessBufferLayer, 'Min')
                set(handles.slider_thicknessBufferLayer, 'Min', str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
                set(handles.edit_thicknessFrom_buffer, 'String', get(handles.edit_thicknessCurrent_buffer, 'String'));
            end
            
                    
            set(handles.slider_thicknessBufferLayer, 'Value', str2num(get(handles.edit_thicknessCurrent_buffer, 'String')));
            set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);
                        
            set(handles.slider_relaxationLength, 'Max', 4*str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
            set(handles.edit_relaxationTo, 'String', 4*str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));    
                smax = str2num(get(handles.edit_relaxationTo, 'String'));
                smin = str2num(get(handles.edit_relaxationFrom, 'String'));
                set(handles.slider_relaxationLength, 'SliderStep', [1 1]/(smax-smin));
           
            setRange_slider_bufferLayer(handles);

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
        function edit_thicknessCurrent_buffer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


%% relaxation and strain
function checkbox_relaxationAndStrain_Callback(hObject, eventdata, handles)

    if get(handles.checkbox_relaxationAndStrain, 'Value')
        set(handles.text31, 'Visible', 'on');
        set(handles.slider_numberOfUC_buffer, 'Visible', 'on');
        set(handles.edit_numberOfUCFrom_buffer, 'Visible', 'on');
        set(handles.edit_numberOfUCCurrent_buffer, 'Visible', 'on');
        set(handles.edit_numberOfUCTo_buffer, 'Visible', 'on');
        set(handles.text24, 'Visible', 'on');
        set(handles.slider_relaxationLength, 'Visible', 'on');
        set(handles.edit_relaxationFrom, 'Visible', 'on');
        set(handles.edit_relaxationCurrent, 'Visible', 'on');
        set(handles.edit_relaxationTo, 'Visible', 'on', 'Enable', 'off');
        set(handles.text41, 'Visible', 'on');
        set(handles.text40, 'Visible', 'on');
    else
        set(handles.text31, 'Visible', 'off');
        set(handles.slider_numberOfUC_buffer, 'Visible', 'off');
        set(handles.edit_numberOfUCFrom_buffer, 'Visible', 'off');
        set(handles.edit_numberOfUCCurrent_buffer, 'Visible', 'off', 'String', 'NaN');
        set(handles.edit_numberOfUCTo_buffer, 'Visible', 'off');
        set(handles.text24, 'Visible', 'off');
        set(handles.slider_relaxationLength, 'Visible', 'off');
        set(handles.edit_relaxationFrom, 'Visible', 'off');
        set(handles.edit_relaxationCurrent, 'Visible', 'off');
        set(handles.edit_relaxationTo, 'Visible', 'off');
        set(handles.edit_relaxationCurrent, 'String', 'NaN');
        set(handles.text41, 'Visible', 'off');
        set(handles.text40, 'Visible', 'off');
    end
        
    set(handles.edit_relaxationTo, 'String', 4*str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
    s4max = str2num(get(handles.edit_relaxationTo, 'String'));
    s4min = str2num(get(handles.edit_relaxationFrom, 'String'));
        set(handles.slider_relaxationLength, 'Max', s4max);
        set(handles.slider_relaxationLength, 'Min', s4min);        
        set(handles.slider_relaxationLength, 'Value', (s4max+s4min)/2);
            set(handles.slider_relaxationLength, 'SliderStep', [1 1]/(s4max-s4min));
            set(handles.edit_relaxationCurrent, 'String', get(handles.slider_relaxationLength, 'Value'));

        
        setRange_slider_numberOfUC_buffer(handles);
        setRange_slider_relaxation(handles);
        set(handles.text40, 'String', round((abs(str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'))/5.95-1))*10000)/10000);
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
     
function slider_relaxationLength_Callback(hObject, eventdata, handles)
        set(handles.edit_relaxationCurrent, 'String', get(handles.slider_relaxationLength, 'Value'));
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function slider_relaxationLength_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit_relaxationFrom_Callback(hObject, eventdata, handles)
    setRange_slider_relaxation(handles);
function edit_relaxationFrom_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_relaxationTo_Callback(hObject, eventdata, handles)
    set(handles.edit_relaxationTo, 'String', 4*get(handles.edit_thicknessCurrent_buffer, 'String'));
    set(handles.edit_relaxationTo, 'Enable', 'off');
    setRange_slider_relaxation(handles);
function edit_relaxationTo_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_relaxationCurrent_Callback(hObject, eventdata, handles)
    if str2double(get(handles.edit_relaxationCurrent, 'String')) < get(handles.slider_relaxationLength, 'Min')
        set(handles.slider_relaxationLength, 'Min', str2double(get(handles.edit_relaxationCurrent, 'String')));
        set(handles.edit_relaxationFrom, 'String', get(handles.edit_relaxationCurrent, 'String'));
    end
    
    set(handles.slider_relaxationLength, 'Value', str2num(get(handles.edit_relaxationCurrent, 'String')));
        setRange_slider_relaxation(handles);
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
function edit_relaxationCurrent_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function slider_numberOfUC_buffer_Callback(hObject, eventdata, handles)
    set(handles.edit_numberOfUCCurrent_buffer, 'String', get(handles.slider_numberOfUC_buffer, 'Value'));
    set(handles.text40, 'String', round((abs(str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'))/5.95-1))*10000)/10000);
        handles = simulate(handles);
        guidata(hObject, handles);
        set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);

        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
function slider_numberOfUC_buffer_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function edit_numberOfUCFrom_buffer_Callback(hObject, eventdata, handles)
    set_slider_numberOfUC_buffer(handles);
function edit_numberOfUCFrom_buffer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_numberOfUCTo_buffer_Callback(hObject, eventdata, handles)
    set_slider_numberOfUC_buffer(handles);
function edit_numberOfUCTo_buffer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_numberOfUCCurrent_buffer_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    if str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String')) > get(handles.slider_numberOfUC_buffer, 'Max')
        set(handles.slider_numberOfUC_buffer, 'Max', str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String')));
        set(handles.edit_numberOfUCTo_buffer, 'String', get(handles.edit_numberOfUCCurrent_buffer, 'String'));
    end

    if str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String')) < get(handles.slider_numberOfUC_buffer, 'Min')
        set(handles.slider_numberOfUC_buffer, 'Min', str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String')));
        set(handles.edit_numberOfUCFrom_buffer, 'String', get(handles.edit_numberOfUCCurrent_buffer, 'String'));
    end
        set(handles.text40, 'String', round((abs(str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String'))/5.95-1))*10000)/10000);
        set(handles.slider_numberOfUC_buffer, 'Value', str2num(get(handles.edit_numberOfUCCurrent_buffer, 'String')));

        set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.edit_thicknessCurrent_buffer, 'String'))/10);

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function edit_numberOfUCCurrent_buffer_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end      
                


%% Graphs parameters
function edit_from200_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_from200_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function edit_to200_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_to200_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_step200_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_step200_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    
function edit_from400_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_from400_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function edit_to400_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_to400_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function edit_step400_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_step400_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
    
    
% --- Executes on button press in checkbox_intermixing.
function checkbox_intermixing_Callback(hObject, eventdata, handles)
    if get(handles.checkbox_intermixing, 'Value')
        set(handles.text57, 'Visible', 'on');
        set(handles.popup_intermixing, 'Visible', 'on');
        set(handles.text58, 'Visible', 'on');
        set(handles.slider_intermixingA, 'Visible', 'on');
        set(handles.edit_intermixingfrom_A, 'Visible', 'on');
        set(handles.edit_intermixingto_A, 'Visible', 'on');
        set(handles.edit_intermixingcurrent_A, 'Visible', 'on');
        set(handles.text59, 'Visible', 'on');
        set(handles.slider_intermixingB, 'Visible', 'on');
        set(handles.edit_intermixingfrom_B, 'Visible', 'on');
        set(handles.edit_intermixingto_B, 'Visible', 'on');
        set(handles.edit_intermixingcurrent_B, 'Visible', 'on');
        set(handles.axes7, 'Visible', 'on');
    else
        set(handles.text57, 'Visible', 'off');
        set(handles.popup_intermixing, 'Visible', 'off');
        set(handles.text58, 'Visible', 'off');
        set(handles.slider_intermixingA, 'Visible', 'off');
        set(handles.slider_intermixingA, 'Value', 0);
        set(handles.edit_intermixingfrom_A, 'Visible', 'off');
        set(handles.edit_intermixingto_A, 'Visible', 'off');
        set(handles.edit_intermixingcurrent_A, 'Visible', 'off');
        set(handles.edit_intermixingcurrent_A, 'String', '0');
        set(handles.text59, 'Visible', 'off');
        set(handles.slider_intermixingB, 'Visible', 'off');
        set(handles.slider_intermixingB, 'Value', 0);
        set(handles.edit_intermixingfrom_B, 'Visible', 'off');
        set(handles.edit_intermixingto_B, 'Visible', 'off');
        set(handles.edit_intermixingcurrent_B, 'Visible', 'off');
        set(handles.edit_intermixingcurrent_B, 'String', '0');
        set(handles.axes7, 'Visible', 'off');
    end
    
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);


function popup_intermixing_Callback(hObject, eventdata, handles)
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
function popup_intermixing_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on slider movement.
function slider_intermixingA_Callback(hObject, eventdata, handles)
    setRange_slider_intermixingA(handles)
        
    set(handles.edit_intermixingcurrent_A, 'String', get(handles.slider_intermixingA, 'Value'));
    handles.Nuc_intermixing_a = str2num(get(handles.edit_intermixingcurrent_A, 'String'));

        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
   
function slider_intermixingA_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider_intermixingB_Callback(hObject, eventdata, handles)
    setRange_slider_intermixingB(handles)
        
    set(handles.edit_intermixingcurrent_B, 'String', get(handles.slider_intermixingB, 'Value'));
    handles.Nuc_intermixing_a = str2num(get(handles.edit_intermixingcurrent_B, 'String'));

        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
            
function slider_intermixingB_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_intermixingfrom_A_Callback(hObject, eventdata, handles)
function edit_intermixingfrom_A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_intermixingfrom_B_Callback(hObject, eventdata, handles)
function edit_intermixingfrom_B_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_intermixingto_A_Callback(hObject, eventdata, handles)
function edit_intermixingto_A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_intermixingto_B_Callback(hObject, eventdata, handles)
function edit_intermixingto_B_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_intermixingcurrent_A_Callback(hObject, eventdata, handles)
    set(handles.slider_intermixingA, 'Value', str2num(get(handles.edit_intermixingcurrent_A, 'String')));

    if str2double(get(handles.edit_thicknessCurrent_A, 'String')) < str2num(get(handles.edit_intermixingcurrent_A, 'String'))
        set(handles.edit_intermixingcurrent_A, 'String', floor(srt2double(get(handles.edit_thicknessCurrent_A, 'String'))*4/2)/4);
        set(handles.slider_intermixingA, 'Value', floor(srt2double(get(handles.edit_thicknessCurrent_A, 'String'))*4/2)/4);
        msgbox('Intermixing of layer A was larger than the thickness of layer A! Current number of unit cells where intermixing occurs was changed to the maximum layer thickness!');
    end
    
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
function edit_intermixingcurrent_A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_intermixingcurrent_B_Callback(hObject, eventdata, handles)
    set(handles.slider_intermixingB, 'Value', str2num(get(handles.edit_intermixingcurrent_B, 'String')));
    
    if str2double(get(handles.edit_thicknessCurrent_B, 'String')) < str2num(get(handles.edit_intermixingcurrent_B, 'String'))
        set(handles.edit_intermixingcurrent_B, 'String', floor(srt2double(get(handles.edit_thicknessCurrent_B, 'String'))*4/2)/4);
        set(handles.slider_intermixingB, 'Value', floor(srt2double(get(handles.edit_thicknessCurrent_B, 'String'))*4/2)/4);
        msgbox('Intermixing of layer B was larger than the thickness of layer B! Current number of unit cells where intermixing occurs was changed to the maximum layer thickness!');
    end
    
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
function edit_intermixingcurrent_B_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

               
% ------------------------------------------------------

function BufferThickness_Callback(hObject, eventdata, handles)
function BufferThickness_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
    % --------------------------------------------------------------------
    function menu_save_Callback(hObject, eventdata, handles)
               
    [FileName, Path, filterindex] = uiputfile({'*.fig'; '*.pdf'; '*.xlsx'}, 'Save as...', '\\fs01\holuj$\Dokumente\Results\XRD');
    switch filterindex
        case 0, return
        case 1 % save as .fig
            hgsave(sprintf('%s%s', Path, FileName));        
        
        case 2 % save as .pdf
            set(handles.figure1, 'Units', 'pixels');
            ActualSize = get(handles.figure1, 'Position');
            % Original size of window
            Original_Size = [520 175 1260 671];
            set(handles.figure1, 'Position', [Original_Size(1), Original_Size(2),...
                Original_Size(3), Original_Size(4)]);

            set(handles.figure1, 'PaperPosition', [0.5 4 33.45 18.56],...
                'PaperOrientation', 'landscape', 'PaperType', 'B4');
            h = handles.figure1;
            saveas(h, sprintf('%s%s', Path, FileName));
            
            set(handles.figure1, 'Position', [ActualSize(1), ActualSize(2),...
                ActualSize(3), ActualSize(4)]);

        case 3 % save as .xlsx
            txt = {'Material system'; 'Number of periods';...
                'Layer A:'; '-thickness (nm)'; '-number of unit cells'; '-lattice parameter (A)';...
                'Layer B:'; '-thickness (nm)'; '-number of unit cells'; '-lattice parameter (A)';...
                'Buffer y/n'; '-material'; '-thickness (nm)'; '-number of unit cells';...
                'Strain y/n'; '-absolute value of strain'; '-relaxation length(at. layers)';...
                '------------------------------------------------';...
                'Graphs settings:'; '200'; '400'; 'Gauss width';...
                'Sliders settings:';...
                'layer A number of unit cells'; 'layer A lattice constant';...
                'layer B number of unit cells'; 'layer B lattice constant';...
                'buffer layer, number of unit cells'; 'strain'; 'relaxation length'};
            d = date;
            format shortg
            c = clock;
            DateAndTime = sprintf('%s, %0.f:%0.f:%0.f', d, c(4), c(5), c(6));
                S(1,1) = cellstr(DateAndTime);
                S(2,1) = cellstr(get(handles.SampleName, 'String'));
                S(3:length(txt)+2,1) = cellstr(txt);

                S(3,2) = cellstr(handles.matSyst);
                S(4,2) = num2cell(str2double(get(handles.edit_NoPeriods, 'String')));

                S(6,2) = num2cell(str2double(get(handles.text_thickness_A, 'String')));
                S(7,2) = num2cell(str2double(get(handles.edit_thicknessCurrent_A, 'String')));
                
                if get(handles.checkbox_varyLatticeParameters, 'Value')
                    S(8,2)  = num2cell(str2double(get(handles.edit_numberOfUCCurrent_A, 'String')));
                    S(12,2) = num2cell(str2double(get(handles.edit_numberOfUCCurrent_B, 'String')));
                else
                    S(8,2)  = num2cell(handles.d_a*4);
                    S(12,2) = num2cell(handles.d_b*4);
                end

                S(10,2) = num2cell(str2double(get(handles.text_thickness_B, 'String')));
                S(11,2) = num2cell(str2double(get(handles.edit_thicknessCurrent_B, 'String')));
                
                if get(handles.checkbox_bufferLayer, 'Value') 
                    S(13,2) = cellstr('yes');                
                    S(14,2) = cellstr(handles.bufferMat);
                    S(15,2) = num2cell(str2double(get(handles.BufferThickness, 'String')));
                    S(16,2) = num2cell(str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
                else
                    S(13,2) = cellstr('no');
                    S(14,2) = cellstr('');
                    S(15,2) = cellstr('');
                    S(16,2) = cellstr('');
                end
             
                if get(handles.checkbox_relaxationAndStrain, 'Value')
                    S(17,2) = cellstr('yes');                
                    S(18,2) = num2cell(str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String')));
                    S(19,2) = num2cell(str2double(get(handles.edit_relaxationCurrent, 'String')));
                else
                    S(17,2) = cellstr('no');
                    S(18,2) = cellstr('');
                    S(19,2) = cellstr('');
                end
                S(22,2) = num2cell(handles.range(1,1));
                S(22,3) = num2cell(handles.range(1,3));
                S(22,4) = num2cell(handles.range(1,2));
                
                S(23,2) = num2cell(handles.range(2,1));
                S(23,3) = num2cell(handles.range(2,3));
                S(23,4) = num2cell(handles.range(2,2));
                
                
                S(26,2) = num2cell(str2double(get(handles.edit_thicknessFrom_A, 'String')));
                S(26,3) = num2cell(str2double(get(handles.edit_thicknessTo_A, 'String')));
                S(26,4) = num2cell(str2double(get(handles.edit_thicknessCurrent_A, 'String')));
                
                if get(handles.checkbox_varyLatticeParameters, 'Value')
                    S(27,2) = num2cell(str2double(get(handles.edit_numberOfUCFrom_A, 'String')));
                    S(27,3) = num2cell(str2double(get(handles.edit_numberOfUCTo_A, 'String')));
                    S(27,4) = num2cell(str2double(get(handles.edit_numberOfUCCurrent_A, 'String')));
                    
                    S(29,2) = num2cell(str2double(get(handles.edit_numberOfUCFrom_B, 'String')));
                    S(29,3) = num2cell(str2double(get(handles.edit_numberOfUCTo_B, 'String')));
                    S(29,4) = num2cell(str2double(get(handles.edit_numberOfUCCurrent_B, 'String')));
                else
                    S(27,2) = cellstr('NaN'); S(27,3) = cellstr('NaN'); S(27,4) = cellstr('NaN');
                    S(29,2) = cellstr('NaN'); S(29,3) = cellstr('NaN'); S(29,4) = cellstr('NaN');
                end
                                
                S(28,2) = num2cell(str2double(get(handles.edit_thicknessFrom_B, 'String')));
                S(28,3) = num2cell(str2double(get(handles.edit_thicknessTo_B, 'String')));
                S(28,4) = num2cell(str2double(get(handles.edit_thicknessCurrent_B, 'String')));
                
                
                if get(handles.checkbox_bufferLayer, 'Value')
                    S(30,2) = num2cell(str2double(get(handles.edit_thicknessFrom_buffer, 'String')));
                    S(30,3) = num2cell(str2double(get(handles.edit_thicknessTo_buffer, 'String')));
                    S(30,4) = num2cell(str2double(get(handles.edit_thicknessCurrent_buffer, 'String')));
                else S(30,2) = cellstr('NaN'); S(30,3) = cellstr('NaN'); S(30,4) = cellstr('NaN');
                end
                
                if get(handles.checkbox_relaxationAndStrain, 'Value')
                    S(31,2) = num2cell(str2double(get(handles.edit_numberOfUCFrom_buffer, 'String')));
                    S(31,3) = num2cell(str2double(get(handles.edit_numberOfUCTo_buffer, 'String')));
                    S(31,4) = num2cell(str2double(get(handles.edit_numberOfUCCurrent_buffer, 'String')));

                    S(32,2) = num2cell(str2double(get(handles.edit_relaxationFrom, 'String')));
                    S(32,3) = num2cell(str2double(get(handles.edit_relaxationTo, 'String')));
                    S(32,4) = num2cell(str2double(get(handles.edit_relaxationCurrent, 'String')));
                else
                    S(31,2) = cellstr('NaN'); S(31,3) = cellstr('NaN'); S(31,4) = cellstr('NaN');
                    S(32,2) = cellstr('NaN'); S(32,3) = cellstr('NaN'); S(32,4) = cellstr('NaN');
                end
                
            xlswrite(sprintf('%s%s', Path, FileName), S);
    end
    
        % --------------------------------------------------------------------
        function menu_loadXlsx_Callback(hObject, eventdata, handles)
            [FileName, Path, index] = uigetfile({'*.xlsx; *.xls'; '*.fig'}, 'Load excel file with previous simulation parameters...');
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
            
            

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
                
    % --------------------------------------------------------------------
    function menu_export_Callback(hObject, eventdata, handles)
        [FileName, Path, index] = uiputfile({'*.dat'; '*.txt'}, 'Save simulated patterns as...');
        switch index
            case 0, return
            case 1
                simulation200(:,1) = handles.twotheta1;
                simulation200(:,2) = handles.IntensityPV1;

                simulation400(:,1) = handles.twotheta2;
                simulation400(:,2) = handles.IntensityPV2;

                csvwrite(sprintf('%s200_%s', Path, FileName), simulation200);
                csvwrite(sprintf('%s400_%s', Path, FileName), simulation400);
        end
        
    % --------------------------------------------------------------------
    function menu_exit_Callback(hObject, eventdata, handles)
    close(gcbf);
        
    
% --------------------------------------------------------------------
function menu_measuredData_Callback(hObject, eventdata, handles)
    % --------------------------------------------------------------------
    function menu_load_Callback(hObject, eventdata, handles)
        % --------------------------------------------------------------------
        function menu_load200_Callback(hObject, eventdata, handles)
            [FileName_200, path_200, index] = uigetfile({'*.txt'; '*.dat'}, 'Load measured (200) peak...', '\\fs01\holuj$\Dokumente\Results\XRD');
            switch index
                case 0, return
                case {1, 2}
                    path_200 = sprintf('%s%s', path_200, FileName_200);
                        handles.T2T_200 = importdata(path_200);
                        set(handles.SampleName, 'String', handles.T2T_200.textdata(2));
                    handles = simulate(handles);
                        guidata(hObject, handles);
                    plot_xrd(handles);
                        guidata(hObject, handles);
            end

        % --------------------------------------------------------------------
        function menu_load400_Callback(hObject, eventdata, handles)
            [FileName_400, path_400, index] = uigetfile({'*.txt'; '*.dat'}, 'Load measured (400) peak...', '\\fs01\holuj$\Dokumente\Results\XRD');
            switch index
                case 0, return
                case {1, 2}
                    path_400 = sprintf('%s%s', path_400, FileName_400);
                        handles.T2T_400 = importdata(path_400);
                        set(handles.SampleName, 'String', handles.T2T_400.textdata(2));
                    handles = simulate(handles);
                        guidata(hObject, handles);
                    plot_xrd(handles);
                        guidata(hObject, handles);
            end
            
        % --------------------------------------------------------------------
        function menu_loadBothXRD_Callback(hObject, eventdata, handles)
            [FileName, pathName, index] = uigetfile({'*.txt'; '*.dat'}, 'Load measured T-2T scan...', '\\fs01\holuj$\Dokumente\Results\XRD');
            switch index
                case 0, return
                case {1, 2}
                    pathName = sprintf('%s%s', pathName, FileName);
                        handles.T2T = importdata(pathName);
                        handles.T2T.data(:,1) = round(handles.T2T.data(:,1)*100)/100;
                        set(handles.SampleName, 'String', handles.T2T.textdata(2));
                    handles = LoadFromFS(handles);
                        guidata(hObject, handles);
                    handles = simulate(handles);
                        guidata(hObject, handles);
                    plot_xrd(handles);
                        guidata(hObject, handles);
            end
            
        function handles = LoadFromFS(handles)
            edit_from200 = find(handles.T2T.data(:,1) == str2num(get(handles.edit_from200, 'String')));
            edit_to200   = find(handles.T2T.data(:,1) == str2num(get(handles.edit_to200, 'String')));    
            edit_from400 = find(handles.T2T.data(:,1) == str2num(get(handles.edit_from400, 'String')));
            edit_to400   = find(handles.T2T.data(:,1) == str2num(get(handles.edit_to400, 'String')));                         
                handles.T2T_200.data = handles.T2T.data(edit_from200:edit_to200,1:2);
                handles.T2T_400.data = handles.T2T.data(edit_from400:edit_to400,1:2);

    % --------------------------------------------------------------------
    function handles = menu_delete_Callback(hObject, eventdata, handles)
        if isfield(handles, 'T2T_200') == 1 && isfield(handles, 'T2T_400') == 1 && isfield(handles, 'T2T') == 1
            handles = rmfield(handles, 'T2T_200');
                legend(handles.plot_T_2T_200_lin,'hide');
                legend(handles.plot_T_2T_200_log,'hide');
            handles = rmfield(handles, 'T2T_400');
                legend(handles.plot_T_2T_400_lin,'hide');
                legend(handles.plot_T_2T_400_log,'hide');
            handles = rmfield(handles, 'T2T');
        elseif isfield(handles, 'T2T_200') == 1 && isfield(handles, 'T2T_400') == 0
            handles = rmfield(handles, 'T2T_200');
                legend(handles.plot_T_2T_200_lin,'hide');
                legend(handles.plot_T_2T_200_log,'hide');
        elseif isfield(handles, 'T2T_200') == 0 && isfield(handles, 'T2T_400') == 1
            handles = rmfield(handles, 'T2T_400');
                legend(handles.plot_T_2T_400_lin,'hide');
                legend(handles.plot_T_2T_400_log,'hide');
        end
            guidata(hObject, handles);
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);

                
% --------------------------------------------------------------------
function menu_graphSettings_Callback(hObject, eventdata, handles)
    % --------------------------------------------------------------------
    function menu_changeSimCol_Callback(hObject, eventdata, handles)
        % --------------------------------------------------------------------
        function menu_simColorChange_Callback(hObject, eventdata, handles)
            handles.color = uisetcolor;
            if handles.color == 0, return;  end
            guidata(hObject, handles);
            plot_xrd(handles);
            guidata(hObject, handles);
        % --------------------------------------------------------------------
        function menu_measColorChange_Callback(hObject, eventdata, handles)
            handles.colormeas = uisetcolor;
            if handles.colormeas == 0, return;  end
            guidata(hObject, handles);
            plot_xrd(handles);
            guidata(hObject, handles);
               
    % --------------------------------------------------------------------
    function handles = menu_fontSettings_Callback(hObject, eventdata, handles)
        handles.Font = uisetfont;
        if ~isfield(handles.Font, 'FontName')
            return
        end
            guidata(hObject, handles);
            plot_xrd(handles);
            guidata(hObject, handles);
        
    % --------------------------------------------------------------------
    function handles = menu_lineWidth_Callback(hObject, eventdata, handles)
        guidata(hObject, handles);
        prompt = {'Line width of the curves:', 'Line width of the axes:'};
        dlg_title = 'Line width';
        num_lines = 1;
        
        if isfield(handles, 'LWidth'), def = handles.LWidth;
        else def = {'0.5'; '0.5'};
        end
        
        Answer = inputdlg(prompt, dlg_title, num_lines, def);
            handles.LWidth = Answer;
        
        if isempty(Answer), return; end
        
        guidata(hObject, handles);
        plot_xrd(handles);
        guidata(hObject, handles);

        
    % --------------------------------------------------------------------
    function menu_grid_Callback(hObject, eventdata, handles)
        switch handles.Grid
            case 'off', handles.Grid = 'on';
            case 'on',  handles.Grid = 'off';
        end
        guidata(hObject, handles);
        plot_xrd(handles);
        guidata(hObject, handles);
        
    % --------------------------------------------------------------------
    function handles = menu_differenceLinLog_Callback(hObject, eventdata, handles)
        switch handles.Difference
            case 'lin',  handles.Difference = 'log';
            case 'log',  handles.Difference = 'lin';
        end
        guidata(hObject, handles);
        plot_xrd(handles);
        guidata(hObject, handles);
        
    % --------------------------------------------------------------------
    function handles = menu_propertyEditorON_Callback(hObject, eventdata, handles)
        plottools('on','figurepalette');
        set(handles.menu_propertyEditorOFF, 'Enable', 'on');

    % --------------------------------------------------------------------
    function menu_propertyEditorOFF_Callback(hObject, eventdata, handles)
        plottools('off');
        set(handles.menu_propertyEditorOFF, 'Enable', 'off');
% --------------------------------------------------------------------
function menu_help_Callback(hObject, eventdata, handles)

    % --------------------------------------------------------------------
    function menu_about_Callback(hObject, eventdata, handles)
        message = {'Created by Paulina Holuj'; 'holuj@uni-mainz.de'; 'University of Mainz'; 'Institute of Physics';...
            'AG Klaui, http://www.klaeui-lab.physik.uni-mainz.de/'; '2014'};
        icon = importdata('JGU_Mainz_logo_crop.png');
        h = msgbox(message, 'Affiliations', 'custom', icon.cdata, jet(size(icon.cdata,2)));

    % --------------------------------------------------------------------
    function menu_showHelpFile_Callback(hObject, eventdata, handles)
        open('Help.pdf');

        
handles =  figure1_ResizeFcn(hObject, eventdata, handles)




function edit_UCGauss_layerA_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_UCGauss_layerA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_UCRange_layerA_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_UCRange_layerA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_UCGauss_layerB_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_UCGauss_layerB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_UCRange_layerB_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_UCRange_layerB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stddev_UCsize_A_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_stddev_UCsize_A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stddev_UCsize_B_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_stddev_UCsize_B_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_UCSize_layerA_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_UCSize_layerA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_UCSize_layerB_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function edit_UCSize_layerB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
