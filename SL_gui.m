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

% Edit the above text to modify the response to help_menu SL_gui

% Last Modified by GUIDE v2.5 15-Apr-2014 15:10:06

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
% clc
handles.output = hObject;

s1max = str2num(get(handles.nTo_A, 'String'));
s1min = str2num(get(handles.nFrom_A, 'String'));
    set(handles.ThicknessLayerA_slider, 'Value', (s1max+s1min)/2);
    set(handles.ThicknessLayerA_slider, 'Max', s1max);
    set(handles.ThicknessLayerA_slider, 'Min', s1min);
    set(handles.ThicknessLayerA_slider, 'SliderStep', [1 1]/(4*(s1max-s1min)));
        set(handles.nActual_A, 'String', get(handles.ThicknessLayerA_slider, 'Value'));
        
s2max = str2num(get(handles.nTo_B, 'String'));
s2min = str2num(get(handles.nFrom_B, 'String'));
    set(handles.ThicknessLayerB_slider, 'Value', (s2max+s2min)/2);
    set(handles.ThicknessLayerB_slider, 'Max', s2max);
    set(handles.ThicknessLayerB_slider, 'Min', s2min);
    set(handles.ThicknessLayerB_slider, 'SliderStep', [1 1]/(4*(s2max-s2min)));
        set(handles.nActual_B, 'String', get(handles.ThicknessLayerB_slider, 'Value'));
             


 MaterialSystem_popup = get(handles.MaterialSystem_popup, 'Value');
 NoPeriods = int32(str2num(get(handles.NoPeriods, 'String')));
 buffer_YN = get(handles.BufferLayer_checkbox, 'Value');
 
 if buffer_YN
    buffer_material  = get(handles.BufferLayer_choose_popup, 'Value');
    Nlayers_buffer = str2double(get(handles.dActual_buffer, 'String'));
 else
     buffer_material = 0;
     Nlayers_buffer = 0;
     set(handles.RelaxationAndStrain_checkbox, 'Enable', 'off');
 end
 
if get(handles.MaterialSystem_popup, 'Value') == 1
    set(handles.Thickness_A, 'String', 5.94*str2num(get(handles.nActual_A, 'String'))/10);
    set(handles.Thickness_B, 'String', 6.08*str2num(get(handles.nActual_B, 'String'))/10);
else
    set(handles.Thickness_A, 'String', handles.d_a*4*str2num(get(handles.nActual_A, 'String'))/10);
    set(handles.Thickness_B, 'String', handles.d_b*4*str2num(get(handles.nActual_B, 'String'))/10);
end

if get(handles.BufferLayer_choose_popup, 'Value') == 1
    set(handles.BufferThickness, 'String', 5.94*str2num(get(handles.dActual_buffer, 'String'))/10);
else
    set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.dActual_buffer, 'String'))/10);
end
  
 NumberUnitCells_A = get(handles.ThicknessLayerA_slider, 'Value');
 NumberUnitCells_B = get(handles.ThicknessLayerB_slider, 'Value');

set(handles.BufferThickness, 'Visible', 'off');
set(handles.text37, 'Visible', 'off');

handles = range(handles);
handles.Grid = 'off';
handles.Difference = 'lin';
    
if get(handles.RelaxationAndStrain_checkbox, 'Value')
    strain = str2double(get(handles.UnitCellBuffer_actual, 'String'));
else
    strain = 0;
end

    d_a = str2double(get(handles.UnitCellActual_A, 'String'));
    d_b = str2double(get(handles.UnitCellActual_B, 'String'));
    d_buffer = str2double(get(handles.UnitCellBuffer_actual, 'String'));
    w   = str2double(get(handles.GaussPeakWidth, 'String'));
    Nrelaxation =  str2double(get(handles.RelaxationLength, 'String'));
    %
    [handles.twotheta1, handles.Intensity1, handles.twotheta2, handles.Intensity2,...
        handles.IntensityGauss1, handles.IntensityGauss2, handles.UnitCell_buffer,...
        handles.d_a, handles.d_b] = SL_buffer_input(buffer_YN,...
        buffer_material, Nlayers_buffer,...
        handles.range, MaterialSystem_popup, NoPeriods, NumberUnitCells_A, NumberUnitCells_B,...
        d_buffer, d_a, d_b, w, Nrelaxation);
    plot_xrd(handles);
    
handles.matSyst = 'TNS/HNS';
guidata(hObject, handles);
%         


%% start of the gui
function SampleName_Callback(hObject, eventdata, handles)
function SampleName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% build superlattice - material
% choose the appropriate material system from popup menu
function handles = MaterialSystem_popup_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
        
    a.TNS = 5.94; a.HNS = 6.08; a.ZNS = 6.11; a.ZHNS = 6.1082; a.V = 6.2;

    switch get(handles.MaterialSystem_popup, 'Value')
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

        
    setUnitCellLayerA_Slider(handles);
    setUnitCellLayerB_Slider(handles); 
    
    if get(handles.MaterialSystem_popup, 'Value') == 1
        set(handles.Thickness_A, 'String', 5.94*str2num(get(handles.nActual_A, 'String'))/10);
        set(handles.Thickness_B, 'String', 6.08*str2num(get(handles.nActual_B, 'String'))/10);
        handles.matSyst = 'TNS/HNS';
    else
        set(handles.Thickness_A, 'String', handles.d_a*4*str2num(get(handles.nActual_A, 'String'))/10);
        set(handles.Thickness_B, 'String', handles.d_b*4*str2num(get(handles.nActual_B, 'String'))/10);
    end
    
    plot_xrd(handles);
        guidata(hObject, handles);
        
function MaterialSystem_popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% number of periods
function NoPeriods_Callback(hObject, eventdata, handles)
        if str2num(get(handles.NoPeriods, 'String')) == 0
        set(handles.text14, 'Visible', 'off');
        set(handles.ThicknessLayerA_slider, 'Visible', 'off');
        set(handles.text15, 'Visible', 'off');
        set(handles.ThicknessLayerB_slider, 'Visible', 'off');
        set(handles.nFrom_A, 'Visible', 'off');
        set(handles.nTo_A, 'Visible', 'off');
        set(handles.nActual_A, 'Visible', 'off');
        set(handles.Thickness_A, 'Visible', 'off');
        set(handles.nFrom_B, 'Visible', 'off');
        set(handles.nTo_B, 'Visible', 'off');
        set(handles.nActual_B, 'Visible', 'off');
        set(handles.Thickness_B, 'Visible', 'off');
        set(handles.text36, 'Visible', 'off');
        
        set(handles.BufferLayer_checkbox, 'Value', 1);
        guidata(hObject, handles);
        BufferLayer_checkbox_Callback(hObject, eventdata, handles);
    else
        set(handles.text14, 'Visible', 'on');
        set(handles.ThicknessLayerA_slider, 'Visible', 'on');
        set(handles.text15, 'Visible', 'on');
        set(handles.ThicknessLayerB_slider, 'Visible', 'on');
        set(handles.nFrom_A, 'Visible', 'on');
        set(handles.nTo_A, 'Visible', 'on');
        set(handles.nActual_A, 'Visible', 'on');
        set(handles.Thickness_A, 'Visible', 'on');
        set(handles.nFrom_B, 'Visible', 'on');
        set(handles.nTo_B, 'Visible', 'on');
        set(handles.nActual_B, 'Visible', 'on');
        set(handles.Thickness_B, 'Visible', 'on');
        set(handles.text36, 'Visible', 'on');
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function NoPeriods_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
    
% thickness of the layers 
function ThicknessLayerA_slider_Callback(hObject, eventdata, handles)
set(handles.nActual_A, 'String', get(handles.ThicknessLayerA_slider, 'Value'));
%     if get(handles.MaterialSystem_popup, 'Value') == 1
%         set(handles.Thickness_A, 'String', 5.94*str2num(get(handles.nActual_A, 'String'))/10);
%     else
        set(handles.Thickness_A, 'String', handles.d_a*4*str2num(get(handles.nActual_A, 'String'))/10);
%     end
    
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function ThicknessLayerA_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function nFrom_A_Callback(hObject, eventdata, handles)
        setRange_ThicknessLayerA_slider(handles);
    function nFrom_A_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
    function nTo_A_Callback(hObject, eventdata, handles)
        setRange_ThicknessLayerA_slider(handles);
    function nTo_A_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

    function nActual_A_Callback(hObject, eventdata, handles)
        if str2double(get(handles.nActual_A, 'String')) > get(handles.ThicknessLayerA_slider, 'Max')
            set(handles.ThicknessLayerA_slider, 'Max', str2double(get(handles.nActual_A, 'String')));
            set(handles.nTo_A, 'String', get(handles.nActual_A, 'String'));
        end
        
        if str2double(get(handles.nActual_A, 'String')) < get(handles.ThicknessLayerA_slider, 'Min')
            set(handles.ThicknessLayerA_slider, 'Min', str2double(get(handles.nActual_A, 'String')));
            set(handles.nFrom_A, 'String', get(handles.nActual_A, 'String'));
        end
        
    set(handles.ThicknessLayerA_slider, 'Value', str2num(get(handles.nActual_A, 'String')));
%         if get(handles.MaterialSystem_popup, 'Value') == 1
%             set(handles.Thickness_A, 'String', 5.94*str2num(get(handles.nActual_A, 'String'))/10);
%         else
            set(handles.Thickness_A, 'String', handles.d_a*4*str2num(get(handles.nActual_A, 'String'))/10);
%         end
    
        setRange_ThicknessLayerA_slider(handles);
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function nActual_A_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end
        
        

function ThicknessLayerB_slider_Callback(hObject, eventdata, handles)
    set(handles.nActual_B, 'String', get(handles.ThicknessLayerB_slider, 'Value'));
%         if get(handles.MaterialSystem_popup, 'Value') == 1
%             set(handles.Thickness_B, 'String', 6.08*str2num(get(handles.nActual_B, 'String'))/10);
%         else
            set(handles.Thickness_B, 'String', handles.d_b*4*str2num(get(handles.nActual_B, 'String'))/10);
%         end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function ThicknessLayerB_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function nFrom_B_Callback(hObject, eventdata, handles)
        setRange_ThicknessLayerB_slider(handles);
    function nFrom_B_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

    function nTo_B_Callback(hObject, eventdata, handles)
        setRange_ThicknessLayerB_slider(handles);
    function nTo_B_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

    function nActual_B_Callback(hObject, eventdata, handles)
        if str2double(get(handles.nActual_B, 'String')) > get(handles.ThicknessLayerB_slider, 'Max')
            set(handles.ThicknessLayerB_slider, 'Max', str2double(get(handles.nActual_B, 'String')));
            set(handles.nTo_B, 'String', get(handles.nActual_B, 'String'));
        end
        
        if str2double(get(handles.nActual_B, 'String')) < get(handles.ThicknessLayerB_slider, 'Min')
            set(handles.ThicknessLayerB_slider, 'Min', str2double(get(handles.nActual_B, 'String')));
            set(handles.nFrom_B, 'String', get(handles.nActual_B, 'String'));
        end
              
        set(handles.ThicknessLayerB_slider, 'Value', str2num(get(handles.nActual_B, 'String')));
%             if get(handles.MaterialSystem_popup, 'Value') == 1
%                 set(handles.Thickness_B, 'String', 6.08*str2num(get(handles.nActual_B, 'String'))/10);
%             else
                set(handles.Thickness_B, 'String', handles.d_b*4*str2num(get(handles.nActual_B, 'String'))/10);
%             end
            
        setRange_ThicknessLayerB_slider(handles);    
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function nActual_B_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


        
function Thickness_A_Callback(hObject, eventdata, handles)
function Thickness_A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Thickness_B_Callback(hObject, eventdata, handles)
function Thickness_B_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

        
% Vary the lattice parameters of layers
function VaryLatticeParameters_checkbox_Callback(hObject, eventdata, handles)

        if get(handles.VaryLatticeParameters_checkbox, 'Value')
            set(handles.text34, 'Visible', 'on');
            set(handles.UnitCellLayerA_slider, 'Visible', 'on');
            set(handles.UnitCell_AFrom, 'Visible', 'on');
            set(handles.UnitCellActual_A, 'Visible', 'on');
            set(handles.UnitCell_ATo, 'Visible', 'on');
            set(handles.text35, 'Visible', 'on');
            set(handles.UnitCellLayerB_slider, 'Visible', 'on');
            set(handles.UnitCell_BFrom, 'Visible', 'on');
            set(handles.UnitCellActual_B, 'Visible', 'on');
            set(handles.UnitCell_BTo, 'Visible', 'on');
        else
            set(handles.text34, 'Visible', 'off');
            set(handles.UnitCellLayerA_slider, 'Visible', 'off');
            set(handles.UnitCell_AFrom, 'Visible', 'off');
            set(handles.UnitCellActual_A, 'Visible', 'off');
            set(handles.UnitCell_ATo, 'Visible', 'off');
            set(handles.text35, 'Visible', 'off');
            set(handles.UnitCellLayerB_slider, 'Visible', 'off');
            set(handles.UnitCell_BFrom, 'Visible', 'off');
            set(handles.UnitCellActual_B, 'Visible', 'off');
            set(handles.UnitCell_BTo, 'Visible', 'off');
        end
        
        
    handles = simulate(handles);
        guidata(hObject, handles);
        
    setUnitCellLayerA_Slider(handles);
    setUnitCellLayerB_Slider(handles); 
        
function UnitCellLayerA_slider_Callback(hObject, eventdata, handles)
    set(handles.UnitCellActual_A, 'String', get(handles.UnitCellLayerA_slider, 'Value'));
        handles.d_a = str2num(get(handles.UnitCellActual_A, 'String'))/4;
        set(handles.Thickness_A, 'String', handles.d_a*4*str2num(get(handles.nActual_A, 'String'))/10);
        
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function UnitCellLayerA_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function UnitCell_AFrom_Callback(hObject, eventdata, handles)
        setRange_UnitCellLayerA_slider(handles);
    function UnitCell_AFrom_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function UnitCell_ATo_Callback(hObject, eventdata, handles)
        setRange_UnitCellLayerA_slider(handles);
    function UnitCell_ATo_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function UnitCellActual_A_Callback(hObject, eventdata, handles)
        if str2double(get(handles.UnitCellActual_A, 'String')) > get(handles.UnitCellLayerA_slider, 'Max')
            set(handles.UnitCellLayerA_slider, 'Max', str2double(get(handles.UnitCellActual_A, 'String')));
            set(handles.UnitCell_ATo, 'String', get(handles.UnitCellActual_A, 'String'));
        end

        if str2double(get(handles.UnitCellActual_A, 'String')) < get(handles.UnitCellLayerA_slider, 'Min')
            set(handles.UnitCellLayerA_slider, 'Min', str2double(get(handles.UnitCellActual_A, 'String')));
            set(handles.UnitCell_AFrom, 'String', get(handles.UnitCellActual_A, 'String'));
        end
     
    handles.d_a = str2num(get(handles.UnitCellActual_A, 'String'))/4;
    set(handles.Thickness_A, 'String', handles.d_a*4*str2num(get(handles.nActual_A, 'String'))/10);
    set(handles.UnitCellLayerA_slider, 'Value', str2num(get(handles.UnitCellActual_A, 'String')));
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function UnitCellActual_A_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    

function UnitCellLayerB_slider_Callback(hObject, eventdata, handles)
    set(handles.UnitCellActual_B, 'String', get(handles.UnitCellLayerB_slider, 'Value'));
        handles.d_b = str2num(get(handles.UnitCellActual_B, 'String'))/4;
        set(handles.Thickness_B, 'String', handles.d_b*4*str2num(get(handles.nActual_B, 'String'))/10);
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function UnitCellLayerB_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

    function UnitCell_BFrom_Callback(hObject, eventdata, handles)
        setRange_UnitCellLayerB_slider(handles);
    function UnitCell_BFrom_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function UnitCell_BTo_Callback(hObject, eventdata, handles)
        setRange_UnitCellLayerB_slider(handles);
    function UnitCell_BTo_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

    function UnitCellActual_B_Callback(hObject, eventdata, handles)
        if str2double(get(handles.UnitCellActual_B, 'String')) > get(handles.UnitCellLayerB_slider, 'Max')
            set(handles.UnitCellLayerB_slider, 'Max', str2double(get(handles.UnitCellActual_B, 'String')));
            set(handles.UnitCell_BTo, 'String', get(handles.UnitCellActual_B, 'String'));
        end

        if str2double(get(handles.UnitCellActual_B, 'String')) < get(handles.UnitCellLayerB_slider, 'Min')
            set(handles.UnitCellLayerB_slider, 'Min', str2double(get(handles.UnitCellActual_B, 'String')));
            set(handles.UnitCell_BFrom, 'String', get(handles.UnitCellActual_B, 'String'));
        end
    
    handles.d_b = str2num(get(handles.UnitCellActual_B, 'String'))/4;
    set(handles.Thickness_B, 'String', handles.d_b*4*str2num(get(handles.nActual_A, 'String'))/10);    
    set(handles.UnitCellLayerB_slider, 'Value', str2num(get(handles.UnitCellActual_B, 'String')));
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
    function UnitCellActual_B_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


    
%% buffer layer
    % tick if there is an additional buffer layer
function BufferLayer_checkbox_Callback(hObject, eventdata, handles)
        if get(handles.BufferLayer_checkbox, 'Value')
            set(handles.BufferLayer_choose_popup, 'Visible', 'on');
            set(handles.dActual_buffer, 'Visible', 'on');
            set(handles.uipanel9, 'Visible', 'on');
            set(handles.text23, 'Visible', 'on');
            set(handles.ThicknessBufferLayer_slider, 'Visible', 'on');
            set(handles.dFrom_buffer, 'Visible', 'on');
            set(handles.dTo_buffer, 'Visible', 'on');
            set(handles.BufferThickness, 'Visible', 'on');
            set(handles.text37, 'Visible', 'on');
            handles.bufferMat = 'TNS';
            handles.UnitCell_buffer = 5.94/4;
            set(handles.RelaxationAndStrain_checkbox, 'Enable', 'on');
        else
            set(handles.BufferLayer_choose_popup, 'Visible', 'off');
            set(handles.dActual_buffer, 'Visible', 'off');
            set(handles.uipanel9, 'Visible', 'off');
            set(handles.text23, 'Visible', 'off');
            set(handles.ThicknessBufferLayer_slider, 'Visible', 'off');
            set(handles.dFrom_buffer, 'Visible', 'off');
            set(handles.dTo_buffer, 'Visible', 'off');
            set(handles.BufferThickness, 'Visible', 'off');
            set(handles.text37, 'Visible', 'off');
            set(handles.RelaxationAndStrain_checkbox, 'Enable', 'off');

        end
        
        s3max = str2num(get(handles.dTo_buffer, 'String'));
        s3min = str2num(get(handles.dFrom_buffer, 'String'));
        set(handles.ThicknessBufferLayer_slider, 'Value', (s3max+s3min)/2);
        set(handles.ThicknessBufferLayer_slider, 'Max', s3max);
        set(handles.ThicknessBufferLayer_slider, 'Min', s3min);
        set(handles.ThicknessBufferLayer_slider, 'SliderStep', [1 1]/(s3max-s3min));
            set(handles.dActual_buffer, 'String', get(handles.ThicknessBufferLayer_slider, 'Value'));
        SetRange_bufferLayer_slider(handles);
        
        if get(handles.BufferLayer_choose_popup, 'Value') == 1
            set(handles.BufferThickness, 'String', 5.94*str2num(get(handles.dActual_buffer, 'String'))/10);
        else
            set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.dActual_buffer, 'String'))/10);
        end
            
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
                
                
    % choose material that there is as a buffer layer
    function handles = BufferLayer_choose_popup_Callback(hObject, eventdata, handles)
        handles = simulate(handles);
            guidata(hObject, handles);
            
%             if get(handles.RelaxationAndStrain_checkbox, 'Value')
        a.TNS = 5.94/4; a.HNS = 6.08/4; a.ZNS = 6.11/4; a.ZHNS = 6.1082/4; a.V = 6.2/4;

        switch get(handles.BufferLayer_choose_popup, 'Value')
            case 1,     handles.UnitCell_buffer = a.TNS;    handles.bufferMat = 'TNS';
            case 2,     handles.UnitCell_buffer = a.HNS;    handles.bufferMat = 'HNS';
            case 3,     handles.UnitCell_buffer = a.ZNS;    handles.bufferMat = 'ZNS';
            case 4,     handles.UnitCell_buffer = a.ZHNS;   handles.bufferMat = 'ZHNS';
            case 5,     handles.UnitCell_buffer = a.V;      handles.bufferMat = 'V';
        end
%             end
        
                
        set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.dActual_buffer, 'String'))/10);
        
        
        setRangeUnitCellBuffer_Slider(handles);
        set(handles.text40, 'String', round((abs(str2num(get(handles.UnitCellBuffer_actual, 'String'))/5.95-1))*10000)/10000);

            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);           
    function BufferLayer_choose_popup_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

        
        function ThicknessBufferLayer_slider_Callback(hObject, eventdata, handles)
            set(handles.dActual_buffer, 'String', get(handles.ThicknessBufferLayer_slider, 'Value'));
            set(handles.RelaxationLength_slider, 'Max', 4*str2double(get(handles.dActual_buffer, 'String')));
            set(handles.Relaxation_To, 'String', 4*str2double(get(handles.dActual_buffer, 'String')));
%                 setRelaxation_slider(handles);
            smax = str2num(get(handles.Relaxation_To, 'String'));
            smin = str2num(get(handles.Relaxation_From, 'String'));
                set(handles.RelaxationLength_slider, 'SliderStep', [1 1]/(smax-smin));
            
            SetRange_bufferLayer_slider(handles);        
                set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.dActual_buffer, 'String'))/10);

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
        function ThicknessBufferLayer_slider_CreateFcn(hObject, eventdata, handles)
        if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        end

        function dFrom_buffer_Callback(hObject, eventdata, handles)
            SetRange_bufferLayer_slider(handles);
        function dFrom_buffer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

        function dTo_buffer_Callback(hObject, eventdata, handles)
            SetRange_bufferLayer_slider(handles);
        function dTo_buffer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

        function dActual_buffer_Callback(hObject, eventdata, handles)
            if str2double(get(handles.dActual_buffer, 'String')) > get(handles.ThicknessBufferLayer_slider, 'Max')
                set(handles.ThicknessBufferLayer_slider, 'Max', str2double(get(handles.dActual_buffer, 'String')));
                set(handles.dTo_buffer, 'String', get(handles.dActual_buffer, 'String'));
            end

            if str2double(get(handles.dActual_buffer, 'String')) < get(handles.ThicknessBufferLayer_slider, 'Min')
                set(handles.ThicknessBufferLayer_slider, 'Min', str2double(get(handles.dActual_buffer, 'String')));
                set(handles.dFrom_buffer, 'String', get(handles.dActual_buffer, 'String'));
            end
            
                    
            set(handles.ThicknessBufferLayer_slider, 'Value', str2num(get(handles.dActual_buffer, 'String')));
            set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.dActual_buffer, 'String'))/10);
                        
            set(handles.RelaxationLength_slider, 'Max', 4*str2double(get(handles.dActual_buffer, 'String')));
            set(handles.Relaxation_To, 'String', 4*str2double(get(handles.dActual_buffer, 'String')));    
                smax = str2num(get(handles.Relaxation_To, 'String'));
                smin = str2num(get(handles.Relaxation_From, 'String'));
                set(handles.RelaxationLength_slider, 'SliderStep', [1 1]/(smax-smin));
           
            SetRange_bufferLayer_slider(handles);

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
        function dActual_buffer_CreateFcn(hObject, eventdata, handles)
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end


%% relaxation and strain

function RelaxationAndStrain_checkbox_Callback(hObject, eventdata, handles)

        if get(handles.RelaxationAndStrain_checkbox, 'Value')
            set(handles.text31, 'Visible', 'on');
            set(handles.UnitCellBuffer_slider, 'Visible', 'on');
            set(handles.UnitCellBuffer_From, 'Visible', 'on');
            set(handles.UnitCellBuffer_actual, 'Visible', 'on');
            set(handles.UnitCellBuffer_To, 'Visible', 'on');
            set(handles.text24, 'Visible', 'on');
            set(handles.RelaxationLength_slider, 'Visible', 'on');
            set(handles.Relaxation_From, 'Visible', 'on');
            set(handles.RelaxationLength, 'Visible', 'on');
            set(handles.Relaxation_To, 'Visible', 'on', 'Enable', 'off');
            set(handles.text41, 'Visible', 'on');
            set(handles.text40, 'Visible', 'on');
        else
            set(handles.text31, 'Visible', 'off');
            set(handles.UnitCellBuffer_slider, 'Visible', 'off');
            set(handles.UnitCellBuffer_From, 'Visible', 'off');
            set(handles.UnitCellBuffer_actual, 'Visible', 'off', 'String', 'NaN');
            set(handles.UnitCellBuffer_To, 'Visible', 'off');
            set(handles.text24, 'Visible', 'off');
            set(handles.RelaxationLength_slider, 'Visible', 'off');
            set(handles.Relaxation_From, 'Visible', 'off');
            set(handles.RelaxationLength, 'Visible', 'off');
            set(handles.Relaxation_To, 'Visible', 'off');
            set(handles.RelaxationLength, 'String', 'NaN');
            set(handles.text41, 'Visible', 'off');
            set(handles.text40, 'Visible', 'off');
        end
        
    set(handles.Relaxation_To, 'String', 4*str2double(get(handles.dActual_buffer, 'String')));
    s4max = str2num(get(handles.Relaxation_To, 'String'));
    s4min = str2num(get(handles.Relaxation_From, 'String'));
        set(handles.RelaxationLength_slider, 'Max', s4max);
        set(handles.RelaxationLength_slider, 'Min', s4min);        
        set(handles.RelaxationLength_slider, 'Value', (s4max+s4min)/2);
            set(handles.RelaxationLength_slider, 'SliderStep', [1 1]/(s4max-s4min));
            set(handles.RelaxationLength, 'String', get(handles.RelaxationLength_slider, 'Value'));

%     s5max = str2double(get(handles.UnitCellBuffer_To, 'String'));
%     s5min = str2double(get(handles.UnitCellBuffer_From, 'String'));
%         set(handles.UnitCellBuffer_slider, 'Value', (s5max+s5min)/2);
%         set(handles.UnitCellBuffer_slider, 'Max', s5max);
%         set(handles.UnitCellBuffer_slider, 'Min', s5min);
%             set(handles.UnitCellBuffer_actual, 'String', get(handles.UnitCellBuffer_slider, 'Value'));
        
        setRangeUnitCellBuffer_Slider(handles);
        setRelaxation_slider(handles);
        set(handles.text40, 'String', round((abs(str2num(get(handles.UnitCellBuffer_actual, 'String'))/5.95-1))*10000)/10000);
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
     
function RelaxationLength_slider_Callback(hObject, eventdata, handles)
        set(handles.RelaxationLength, 'String', get(handles.RelaxationLength_slider, 'Value'));
            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function RelaxationLength_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Relaxation_From_Callback(hObject, eventdata, handles)
    setRelaxation_slider(handles);
function Relaxation_From_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Relaxation_To_Callback(hObject, eventdata, handles)
    set(handles.Relaxation_To, 'String', 4*get(handles.dActual_buffer, 'String'));
    set(handles.Relaxation_To, 'Enable', 'off');
    setRelaxation_slider(handles);
function Relaxation_To_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function RelaxationLength_Callback(hObject, eventdata, handles)
%     set(handles.Relaxation_To, 'String', 4*get(handles.dActual_buffer, 'String'));
%     if str2double(get(handles.RelaxationLength, 'String')) > get(handles.RelaxationLength_slider, 'Max')
%         set(handles.RelaxationLength_slider, 'Max', str2double(get(handles.RelaxationLength, 'String')));
%         set(handles.Relaxation_To, 'String', get(handles.RelaxationLength, 'String'));
%     end

    if str2double(get(handles.RelaxationLength, 'String')) < get(handles.RelaxationLength_slider, 'Min')
        set(handles.RelaxationLength_slider, 'Min', str2double(get(handles.RelaxationLength, 'String')));
        set(handles.Relaxation_From, 'String', get(handles.RelaxationLength, 'String'));
    end
    
    set(handles.RelaxationLength_slider, 'Value', str2num(get(handles.RelaxationLength, 'String')));
        setRelaxation_slider(handles);
        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
function RelaxationLength_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function UnitCellBuffer_slider_Callback(hObject, eventdata, handles)
    set(handles.UnitCellBuffer_actual, 'String', get(handles.UnitCellBuffer_slider, 'Value'));
    set(handles.text40, 'String', round((abs(str2num(get(handles.UnitCellBuffer_actual, 'String'))/5.95-1))*10000)/10000);
        handles = simulate(handles);
        guidata(hObject, handles);
        set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.dActual_buffer, 'String'))/10);

        handles = simulate(handles);
            guidata(hObject, handles);
        plot_xrd(handles);
            guidata(hObject, handles);
function UnitCellBuffer_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function UnitCellBuffer_From_Callback(hObject, eventdata, handles)
    setUCellBuffer_slider(handles);
function UnitCellBuffer_From_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function UnitCellBuffer_To_Callback(hObject, eventdata, handles)
    setUCellBuffer_slider(handles);
function UnitCellBuffer_To_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function UnitCellBuffer_actual_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    if str2double(get(handles.UnitCellBuffer_actual, 'String')) > get(handles.UnitCellBuffer_slider, 'Max')
        set(handles.UnitCellBuffer_slider, 'Max', str2double(get(handles.UnitCellBuffer_actual, 'String')));
        set(handles.UnitCellBuffer_To, 'String', get(handles.UnitCellBuffer_actual, 'String'));
    end

    if str2double(get(handles.UnitCellBuffer_actual, 'String')) < get(handles.UnitCellBuffer_slider, 'Min')
        set(handles.UnitCellBuffer_slider, 'Min', str2double(get(handles.UnitCellBuffer_actual, 'String')));
        set(handles.UnitCellBuffer_From, 'String', get(handles.UnitCellBuffer_actual, 'String'));
    end
        set(handles.text40, 'String', round((abs(str2num(get(handles.UnitCellBuffer_actual, 'String'))/5.95-1))*10000)/10000);
        set(handles.UnitCellBuffer_slider, 'Value', str2num(get(handles.UnitCellBuffer_actual, 'String')));

        set(handles.BufferThickness, 'String', handles.UnitCell_buffer*4*str2num(get(handles.dActual_buffer, 'String'))/10);

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
function UnitCellBuffer_actual_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end      
                


%% Graphs parameters
function from200_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function from200_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function to200_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function to200_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function step200_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function step200_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function Offset200_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function Offset200_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    
function from400_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function from400_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function to400_Callback(hObject, eventdata, handles)
    if isfield(handles, 'T2T')
    handles = LoadFromFS(handles);
        guidata(hObject, handles);
    end
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function to400_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function step400_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function step400_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function Offset400_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function Offset400_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    
function GaussPeakWidth_Callback(hObject, eventdata, handles)
    handles = simulate(handles);
        guidata(hObject, handles);
    plot_xrd(handles);
        guidata(hObject, handles);
function GaussPeakWidth_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


    


%% additional functions - simulate and plot functions
                
function handles = simulate(handles)
     MaterialSystem_popup = get(handles.MaterialSystem_popup, 'Value');
     NoPeriods = int32(str2num(get(handles.NoPeriods, 'String')));
     buffer_YN = get(handles.BufferLayer_checkbox, 'Value');
         if buffer_YN
            buffer_material  = get(handles.BufferLayer_choose_popup, 'Value');
            Nlayers_buffer = str2double(get(handles.dActual_buffer, 'String'));
         else
             buffer_material = 0;
             Nlayers_buffer = 0;
         end
     NumberUnitCells_A = get(handles.ThicknessLayerA_slider, 'Value');
     NumberUnitCells_B = get(handles.ThicknessLayerB_slider, 'Value');

    handles = range(handles);
    
    if get(handles.RelaxationAndStrain_checkbox, 'Value')
        strain = str2double(get(handles.UnitCellBuffer_actual, 'String'));
    else
        strain = 0;
    end
    
    d_a = str2double(get(handles.UnitCellActual_A, 'String'));
    d_b = str2double(get(handles.UnitCellActual_B, 'String'));
    d_buffer = str2double(get(handles.UnitCellBuffer_actual, 'String'));
    w   = str2double(get(handles.GaussPeakWidth, 'String'));
    Nrelaxation =  str2double(get(handles.RelaxationLength, 'String'));
    %
    [handles.twotheta1, handles.Intensity1,...
        handles.twotheta2, handles.Intensity2,...
        handles.IntensityGauss1, handles.IntensityGauss2,...
        handles.UnitCell_buffer, handles.d_a, handles.d_b] = SL_buffer_input(buffer_YN,...
        buffer_material, Nlayers_buffer,...
        handles.range, MaterialSystem_popup,...
        NoPeriods, NumberUnitCells_A, NumberUnitCells_B,...
        d_buffer, d_a, d_b, w, Nrelaxation);
    
    NumOfPoints1 = length(handles.Intensity1);
    for i = 1:NumOfPoints1
        Chi1sq = (log10(handles.Intensity1(i)) - log10(handles.IntensityGauss1(i)/max(handles.IntensityGauss1)))^2;
    end
    
    NumOfPoints2 = length(handles.Intensity2);
    for i = 1:NumOfPoints2
        Chi2sq = (log10(handles.Intensity2(i)) - log10(handles.IntensityGauss2(i)/max(handles.IntensityGauss2)))^2;
    end
    
    disp(Chi1sq + Chi2sq)
    
function handles = plot_xrd(handles)
    if ~isfield(handles, 'Font')
        handles.Font.FontName   = 'Helvetica';
        handles.Font.FontWeight = 'normal';
        handles.Font.FontAngle  = 'normal';
        handles.Font.FontUnits  = 'points';
        handles.Font.FontSize   = 10;
    end
    
    if ~isfield(handles, 'LWidth'), handles.LWidth = {'0.5'; '0.5'}; end
    
    % first plot
    if isfield(handles, 'color')
        plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityGauss1,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else
        handles.h1 = plot(handles.plot_T_2T_200_lin, handles.twotheta1,...
            handles.IntensityGauss1, 'r', 'LineWidth', str2num(handles.LWidth{1}));
    end

        set(handles.plot_T_2T_200_lin, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));

        xlabel(handles.plot_T_2T_200_lin, '2\it{\theta} (deg)');
        ylabel(handles.plot_T_2T_200_lin, 'Normalized intensity');

            if isfield(handles, 'T2T_200')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityGauss1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityGauss1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);    
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityGauss1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_200_lin, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);        
                    plot(handles.plot_T_2T_200_lin, handles.twotheta1, handles.IntensityGauss1,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                 
                legend(handles.plot_T_2T_200_lin, 'simulation', 'measured data', 'Location', 'Best');
                    xlabel(handles.plot_T_2T_200_lin, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_200_lin, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_200_lin, [handles.range(1,1) handles.range(1,3)]);
        
               
    % second plot
    
    if isfield(handles, 'color')
        plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityGauss2,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else
        plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityGauss2,...
            'r', 'LineWidth', str2num(handles.LWidth{1}));
    end
    
        set(handles.plot_T_2T_400_lin, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));
   
            xlabel(handles.plot_T_2T_400_lin, '2\it{\theta} (deg)');
            ylabel(handles.plot_T_2T_400_lin, 'Normalized intensity');

            if isfield(handles, 'T2T_400')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityGauss2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityGauss2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityGauss2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_400_lin, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_lin, handles.twotheta2, handles.IntensityGauss2,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                
                
                legend(handles.plot_T_2T_400_lin, 'simulation', 'measured data', 'Location', 'Best');
                    xlabel(handles.plot_T_2T_400_lin, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_400_lin, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_400_lin, [handles.range(2,1) handles.range(2,3)]);

    % third plot
    
    offset200 = str2double(get(handles.Offset200, 'String'));
    if isfield(handles, 'color')
        semilogy(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityGauss1 + offset200,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else semilogy(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityGauss1 + offset200,...
            'r', 'LineWidth', str2num(handles.LWidth{1}));
    end
 
        set(handles.plot_T_2T_200_log, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));

            xlabel(handles.plot_T_2T_200_log, '2\it{\theta} (deg)');
            ylabel(handles.plot_T_2T_200_log, 'Normalized intensity');

            if isfield(handles, 'T2T_200')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName, 'FontWeight',...
                        handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityGauss1 + offset200,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityGauss1 + offset200,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityGauss1 + offset200,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_200_log, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_200_log, handles.twotheta1, handles.IntensityGauss1 + offset200,... 
                        handles.T2T_200.data(:,1), handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                
                    xlabel(handles.plot_T_2T_200_log, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_200_log, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_200_log, [handles.range(1,1) handles.range(1,3)]);
                
    % fourth plot
    
    offset400 = str2double(get(handles.Offset400, 'String'));
    if isfield(handles, 'color')
        semilogy(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityGauss2 + offset400,...
            'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
    else
        semilogy(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityGauss2 + offset400,...
            'r', 'LineWidth', str2num(handles.LWidth{1}));
    end
    
        set(handles.plot_T_2T_400_log, 'FontName', handles.Font.FontName,...
            'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
            'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
            'LineWidth', str2num(handles.LWidth{2}));

            xlabel(handles.plot_T_2T_400_log, '2\it{\theta} (deg)');
            ylabel(handles.plot_T_2T_400_log, 'Normalized intensity');

            if isfield(handles, 'T2T_400')
                if isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [handles.color; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityGauss2 + offset400,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif isfield(handles, 'color') && ~isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [handles.color; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityGauss2 + offset400,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                elseif ~isfield(handles, 'color') && isfield(handles, 'colormeas')
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [[1,0,0]; handles.colormeas],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName, 'FontWeight',...
                        handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityGauss2 + offset400,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                else
                    set(handles.plot_T_2T_400_log, 'ColorOrder', [[1,0,0]; [0,0,1]],...
                        'nextplot', 'replacechildren', 'FontName', handles.Font.FontName,...
                        'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                        'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize);
                    plot(handles.plot_T_2T_400_log, handles.twotheta2, handles.IntensityGauss2 + offset400,... 
                        handles.T2T_400.data(:,1), handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)),...
                        'LineWidth', str2num(handles.LWidth{1}));
                end
                
                    xlabel(handles.plot_T_2T_400_log, '2\it{\theta} (deg)');
                    ylabel(handles.plot_T_2T_400_log, 'Normalized intensity');
            end
        xlim(handles.plot_T_2T_400_log, [handles.range(2,1) handles.range(2,3)]);
        
        
    % fifth plot
    if isfield(handles, 'T2T_200')
        if isfield(handles, 'color')
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference200, handles.twotheta1, abs(handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityGauss1'),...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference200, handles.twotheta1, handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityGauss1',...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, 'Data-Sim');
            end
        else
            
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference200, handles.twotheta1,...
                        abs(handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityGauss1'), 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference200, handles.twotheta1,...
                        handles.T2T_200.data(:,2)/max(handles.T2T_200.data(:,2)) - handles.IntensityGauss1', 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference200, 'Data-Sim');
            end
                    
        end

            set(handles.plot_difference200, 'FontName', handles.Font.FontName,...
                'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
                'LineWidth', str2num(handles.LWidth{2}));

            xlim(handles.plot_difference200, [handles.range(1,1) handles.range(1,3)]);
    else
        plot(handles.plot_difference200, NaN, NaN);
        set(handles.plot_difference200, 'XTickLabel', {});
        set(handles.plot_difference200, 'YTickLabel', {});
    end
    

    
    % sixth plot
    if isfield(handles, 'T2T_400')
        if isfield(handles, 'color')
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference400, handles.twotheta2, abs(handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityGauss2'),...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference400, handles.twotheta2, handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityGauss2',...
                        'Color', handles.color, 'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, 'Data-Sim');
            end
        else
            
            switch handles.Difference
                case 'log'
                    semilogy(handles.plot_difference400, handles.twotheta2,...
                        abs(handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityGauss2'), 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, '|Data-Sim|');
                case 'lin'
                    plot(handles.plot_difference400, handles.twotheta2,...
                        handles.T2T_400.data(:,2)/max(handles.T2T_400.data(:,2)) - handles.IntensityGauss2', 'r',...
                        'LineWidth', str2num(handles.LWidth{1}));
                    ylabel(handles.plot_difference400, 'Data-Sim');
            end
            
        end

            set(handles.plot_difference400, 'FontName', handles.Font.FontName,...
                'FontWeight', handles.Font.FontWeight, 'FontAngle', handles.Font.FontAngle,...
                'FontUnits', handles.Font.FontUnits, 'FontSize', handles.Font.FontSize,...
                'LineWidth', str2num(handles.LWidth{2}));

            xlim(handles.plot_difference400, [handles.range(2,1) handles.range(2,3)]);
    else
        plot(handles.plot_difference400, NaN, NaN);
        set(handles.plot_difference400, 'XTickLabel', {});
        set(handles.plot_difference400, 'YTickLabel', {});
    end
        
        axis([handles.plot_difference200 handles.plot_difference400], 'tight');    
    
        switch handles.Grid 
            case 'off'
                grid(handles.plot_T_2T_200_lin, 'off');
                grid(handles.plot_T_2T_200_log, 'off');
                grid(handles.plot_T_2T_400_lin, 'off');
                grid(handles.plot_T_2T_400_log, 'off');
                if isfield(handles, 'T2T_200')
                    grid(handles.plot_difference200, 'off');
                end
                if isfield(handles, 'T2T_400')
                    grid(handles.plot_difference400, 'off');
                end
            case 'on'
                grid(handles.plot_T_2T_200_lin, 'on');
                grid(handles.plot_T_2T_200_log, 'on');
                grid(handles.plot_T_2T_400_lin, 'on');
                grid(handles.plot_T_2T_400_log, 'on');
                if isfield(handles, 'T2T_200')
                    grid(handles.plot_difference200, 'on');
                end
                if isfield(handles, 'T2T_400')
                    grid(handles.plot_difference400, 'on');
                end
        end

%% set functions
function setUnitCellLayerA_Slider(handles);
    s1max = 4*handles.d_a + 0.1;
    s1min = 4*handles.d_a - 0.1;
        set(handles.UnitCellLayerA_slider, 'Value', 4*handles.d_a);
        set(handles.UnitCellLayerA_slider, 'Max', s1max);
        set(handles.UnitCellLayerA_slider, 'Min', s1min);
            set(handles.UnitCellActual_A, 'String', get(handles.UnitCellLayerA_slider, 'Value'));
            set(handles.UnitCell_AFrom, 'String', s1min);
            set(handles.UnitCell_ATo, 'String', s1max);

function setUnitCellLayerB_Slider(handles);
    s2max = 4*handles.d_b + 0.1;
    s2min = 4*handles.d_b - 0.1;
        set(handles.UnitCellLayerB_slider, 'Value', 4*handles.d_b);
        set(handles.UnitCellLayerB_slider, 'Max', s2max);
        set(handles.UnitCellLayerB_slider, 'Min', s2min);
            set(handles.UnitCellActual_B, 'String', get(handles.UnitCellLayerB_slider, 'Value'));
            set(handles.UnitCell_BFrom, 'String', s2min);
            set(handles.UnitCell_BTo, 'String', s2max); 

function setRangeUnitCellBuffer_Slider(handles);
    s1max = 4*handles.UnitCell_buffer + 0.1;
    s1min = 4*handles.UnitCell_buffer - 0.1;
        set(handles.UnitCellBuffer_slider, 'Value', 4*handles.UnitCell_buffer);
        set(handles.UnitCellBuffer_slider, 'Max', s1max);
        set(handles.UnitCellBuffer_slider, 'Min', s1min);
            set(handles.UnitCellBuffer_actual, 'String', get(handles.UnitCellBuffer_slider, 'Value'));
            set(handles.UnitCellBuffer_From, 'String', s1min);
            set(handles.UnitCellBuffer_To, 'String', s1max);
            
function setRange_ThicknessLayerA_slider(handles)
    if str2num(get(handles.nTo_A, 'String')) < str2num(get(handles.nActual_A, 'String'))
        s1max = str2num(get(handles.nActual_A, 'String'));
        set(handles.nTo_A, 'String', get(handles.nActual_A, 'String'));
    else
        s1max = str2num(get(handles.nTo_A, 'String'));
    end
    
    if str2num(get(handles.nFrom_A, 'String')) > str2num(get(handles.nActual_A, 'String'))
        s1min = str2num(get(handles.nActual_A, 'String'));
        set(handles.nFrom_A, 'String', get(handles.nActual_A, 'String'));
    else
        s1min = str2num(get(handles.nFrom_A, 'String'));
    end
    
        set(handles.ThicknessLayerA_slider, 'Max', s1max);
        set(handles.ThicknessLayerA_slider, 'Min', s1min);
        set(handles.ThicknessLayerA_slider, 'SliderStep', [1 1]/(4*(s1max-s1min)));
            set(handles.nActual_A, 'String', get(handles.ThicknessLayerA_slider, 'Value'));
        
function setRange_ThicknessLayerB_slider(handles)
    if str2num(get(handles.nTo_B, 'String')) < str2num(get(handles.nActual_B, 'String'))
        s2max = str2num(get(handles.nActual_B, 'String'));
        set(handles.nTo_B, 'String', get(handles.nActual_B, 'String'));
    else
        s2max = str2num(get(handles.nTo_B, 'String'));
    end
    
    if str2num(get(handles.nFrom_B, 'String')) > str2num(get(handles.nActual_B, 'String'))
        s2min = str2num(get(handles.nActual_B, 'String'));
        set(handles.nFrom_B, 'String', get(handles.nActual_B, 'String'));
    else
        s2min = str2num(get(handles.nFrom_A, 'String'));
    end    
        set(handles.ThicknessLayerB_slider, 'Max', s2max);
        set(handles.ThicknessLayerB_slider, 'Min', s2min);
        set(handles.ThicknessLayerB_slider, 'SliderStep', [1 1]/(4*(s2max-s2min)));
            set(handles.nActual_B, 'String', get(handles.ThicknessLayerB_slider, 'Value'));

function setRange_UnitCellLayerA_slider(handles)
    if str2num(get(handles.UnitCell_ATo, 'String')) < str2num(get(handles.UnitCellActual_A, 'String'))
        s2max = str2num(get(handles.UnitCellActual_A, 'String'));
        set(handles.UnitCell_ATo, 'String', get(handles.UnitCellActual_A, 'String'));
    else
        s2max = str2num(get(handles.UnitCell_ATo, 'String'));
    end
    
    if str2num(get(handles.UnitCell_AFrom, 'String')) > str2num(get(handles.UnitCellActual_A, 'String'))
        s2min = str2num(get(handles.UnitCellActual_A, 'String'));
        set(handles.UnitCell_AFrom, 'String', get(handles.UnitCellActual_A, 'String'));
    else
        s2min = str2num(get(handles.UnitCell_AFrom, 'String'));
    end
    
        set(handles.UnitCellLayerA_slider, 'Max', s2max);
        set(handles.UnitCellLayerA_slider, 'Min', s2min);
        
function setRange_UnitCellLayerB_slider(handles)
    if str2num(get(handles.UnitCell_BTo, 'String')) < str2num(get(handles.UnitCellActual_B, 'String'))
        s2max = str2num(get(handles.UnitCellActual_B, 'String'));
        set(handles.UnitCell_BTo, 'String', get(handles.UnitCellActual_B, 'String'));
    else
        s2max = str2num(get(handles.UnitCell_BTo, 'String'));
    end
    
    if str2num(get(handles.UnitCell_BFrom, 'String')) > str2num(get(handles.UnitCellActual_B, 'String'))
        s2min = str2num(get(handles.UnitCellActual_B, 'String'));
        set(handles.UnitCell_BFrom, 'String', get(handles.UnitCellActual_B, 'String'));
    else
        s2min = str2num(get(handles.UnitCell_BFrom, 'String'));
    end
    
        set(handles.UnitCellLayerB_slider, 'Max', s2max);
        set(handles.UnitCellLayerB_slider, 'Min', s2min);
        
function SetRange_bufferLayer_slider(handles)
    if str2num(get(handles.dTo_buffer, 'String')) < str2num(get(handles.dActual_buffer, 'String'))
        s1max = str2num(get(handles.dActual_buffer, 'String'));
        set(handles.dTo_buffer, 'String', get(handles.dActual_buffer, 'String'));
    else
        s1max = str2num(get(handles.dTo_buffer, 'String'));
    end
    
    if str2num(get(handles.dFrom_buffer, 'String')) > str2num(get(handles.dActual_buffer, 'String'))
        s1min = str2num(get(handles.dActual_buffer, 'String'));
        set(handles.dFrom_buffer, 'String', get(handles.dActual_buffer, 'String'));
    else
        s1min = str2num(get(handles.dFrom_buffer, 'String'));
    end
    
        set(handles.ThicknessBufferLayer_slider, 'Max', s1max);
        set(handles.ThicknessBufferLayer_slider, 'Min', s1min);
        set(handles.ThicknessBufferLayer_slider, 'SliderStep', [1 1]/(4*(s1max-s1min)));
%             set(handles.dActual_buffer, 'String', get(handles.ThicknessBufferLayer_slider, 'Value'));

function handles = range(handles)
    handles.range(1,1) = str2double(get(handles.from200, 'String'));
    handles.range(2,1) = str2double(get(handles.from400, 'String'));

    handles.range(1,3) = str2double(get(handles.to200, 'String'));
    handles.range(2,3) = str2double(get(handles.to400, 'String'));

    handles.range(1,2) = str2double(get(handles.step200, 'String'));
    handles.range(2,2) = str2double(get(handles.step400, 'String'));
    
function setRelaxation_slider(handles)
%     if str2num(get(handles.Relaxation_To, 'String')) < str2num(get(handles.RelaxationLength, 'String'))
%         s1max = str2num(get(handles.RelaxationLength, 'String'));
%         set(handles.Relaxation_To, 'String', get(handles.RelaxationLength, 'String'));
%     else
%         s1max = str2num(get(handles.Relaxation_To, 'String'));
%     end
    
    if str2num(get(handles.Relaxation_From, 'String')) > str2num(get(handles.RelaxationLength, 'String'))
        s1min = str2num(get(handles.RelaxationLength, 'String'));
        set(handles.Relaxation_From, 'String', get(handles.RelaxationLength, 'String'));
    else
        s1min = str2num(get(handles.Relaxation_From, 'String'));
    end

    s1max = 4*str2double(get(handles.dActual_buffer, 'String'));
        set(handles.RelaxationLength_slider, 'Max', s1max);
        set(handles.RelaxationLength_slider, 'Min', s1min);        
            set(handles.RelaxationLength_slider, 'SliderStep', [1 1]/(s1max-s1min));
            set(handles.RelaxationLength, 'String', get(handles.RelaxationLength_slider, 'Value'));
            
function setUCellBuffer_slider(handles)
    if str2num(get(handles.UnitCellBuffer_To, 'String')) < str2num(get(handles.UnitCellBuffer_actual, 'String'))
        s2max = str2num(get(handles.UnitCellBuffer_actual, 'String'));
        set(handles.UnitCellBuffer_To, 'String', get(handles.UnitCellBuffer_actual, 'String'));
    else
        s2max = str2num(get(handles.UnitCellBuffer_To, 'String'));
    end
    
    if str2num(get(handles.UnitCellBuffer_From, 'String')) > str2num(get(handles.UnitCellBuffer_actual, 'String'))
        s2min = str2num(get(handles.UnitCellBuffer_actual, 'String'));
        set(handles.UnitCellBuffer_From, 'String', get(handles.UnitCellBuffer_actual, 'String'));
    else
        s2min = str2num(get(handles.UnitCellBuffer_From, 'String'));
    end
    
        set(handles.UnitCellBuffer_slider, 'Max', s2max);
        set(handles.UnitCellBuffer_slider, 'Min', s2min);
            set(handles.UnitCellBuffer_actual, 'String', get(handles.UnitCellBuffer_slider, 'Value'));
            
% ------------------------------------------------------

function BufferThickness_Callback(hObject, eventdata, handles)
function BufferThickness_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
    % --------------------------------------------------------------------
    function Save_Callback(hObject, eventdata, handles)
               
    [FileName, Path, filterindex] = uiputfile({'*.fig'; '*.pdf'; '*.xlsx'}, 'Save as...');
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
                S(4,2) = num2cell(str2double(get(handles.NoPeriods, 'String')));

                S(6,2) = num2cell(str2double(get(handles.Thickness_A, 'String')));
                S(7,2) = num2cell(str2double(get(handles.nActual_A, 'String')));
                
                if get(handles.VaryLatticeParameters_checkbox, 'Value')
                    S(8,2)  = num2cell(str2double(get(handles.UnitCellActual_A, 'String')));
                    S(12,2) = num2cell(str2double(get(handles.UnitCellActual_B, 'String')));
                else
                    S(8,2)  = num2cell(handles.d_a*4);
                    S(12,2) = num2cell(handles.d_b*4);
                end

                S(10,2) = num2cell(str2double(get(handles.Thickness_B, 'String')));
                S(11,2) = num2cell(str2double(get(handles.nActual_B, 'String')));
                
                if get(handles.BufferLayer_checkbox, 'Value') 
                    S(13,2) = cellstr('yes');                
                    S(14,2) = cellstr(handles.bufferMat);
                    S(15,2) = num2cell(str2double(get(handles.BufferThickness, 'String')));
                    S(16,2) = num2cell(str2double(get(handles.dActual_buffer, 'String')));
                else
                    S(13,2) = cellstr('no');
                    S(14,2) = cellstr('');
                    S(15,2) = cellstr('');
                    S(16,2) = cellstr('');
                end
             
                if get(handles.RelaxationAndStrain_checkbox, 'Value')
                    S(17,2) = cellstr('yes');                
                    S(18,2) = num2cell(str2double(get(handles.UnitCellBuffer_actual, 'String')));
                    S(19,2) = num2cell(str2double(get(handles.RelaxationLength, 'String')));
                else
                    S(17,2) = cellstr('no');
                    S(18,2) = cellstr('');
                    S(19,2) = cellstr('');
                end
                S(22,2) = num2cell(handles.range(1,1));
                S(22,3) = num2cell(handles.range(1,3));
                S(22,4) = num2cell(handles.range(1,2));
                S(22,5) = num2cell(str2double(get(handles.Offset200, 'String')));
                
                S(23,2) = num2cell(handles.range(2,1));
                S(23,3) = num2cell(handles.range(2,3));
                S(23,4) = num2cell(handles.range(2,2));
                S(23,5) = num2cell(str2double(get(handles.Offset400, 'String')));
                
                S(24,2) = num2cell(str2double(get(handles.GaussPeakWidth, 'String')));
                
                S(26,2) = num2cell(str2double(get(handles.nFrom_A, 'String')));
                S(26,3) = num2cell(str2double(get(handles.nTo_A, 'String')));
                S(26,4) = num2cell(str2double(get(handles.nActual_A, 'String')));
                
                if get(handles.VaryLatticeParameters_checkbox, 'Value')
                    S(27,2) = num2cell(str2double(get(handles.UnitCell_AFrom, 'String')));
                    S(27,3) = num2cell(str2double(get(handles.UnitCell_ATo, 'String')));
                    S(27,4) = num2cell(str2double(get(handles.UnitCellActual_A, 'String')));
                    
                    S(29,2) = num2cell(str2double(get(handles.UnitCell_BFrom, 'String')));
                    S(29,3) = num2cell(str2double(get(handles.UnitCell_BTo, 'String')));
                    S(29,4) = num2cell(str2double(get(handles.UnitCellActual_B, 'String')));
                else
                    S(27,2) = cellstr('NaN'); S(27,3) = cellstr('NaN'); S(27,4) = cellstr('NaN');
                    S(29,2) = cellstr('NaN'); S(29,3) = cellstr('NaN'); S(29,4) = cellstr('NaN');
                end
                                
                S(28,2) = num2cell(str2double(get(handles.nFrom_B, 'String')));
                S(28,3) = num2cell(str2double(get(handles.nTo_B, 'String')));
                S(28,4) = num2cell(str2double(get(handles.nActual_B, 'String')));
                
                
                if get(handles.BufferLayer_checkbox, 'Value')
                    S(30,2) = num2cell(str2double(get(handles.dFrom_buffer, 'String')));
                    S(30,3) = num2cell(str2double(get(handles.dTo_buffer, 'String')));
                    S(30,4) = num2cell(str2double(get(handles.dActual_buffer, 'String')));
                else S(30,2) = cellstr('NaN'); S(30,3) = cellstr('NaN'); S(30,4) = cellstr('NaN');
                end
                
                if get(handles.RelaxationAndStrain_checkbox, 'Value')
                    S(31,2) = num2cell(str2double(get(handles.UnitCellBuffer_From, 'String')));
                    S(31,3) = num2cell(str2double(get(handles.UnitCellBuffer_To, 'String')));
                    S(31,4) = num2cell(str2double(get(handles.UnitCellBuffer_actual, 'String')));

                    S(32,2) = num2cell(str2double(get(handles.Relaxation_From, 'String')));
                    S(32,3) = num2cell(str2double(get(handles.Relaxation_To, 'String')));
                    S(32,4) = num2cell(str2double(get(handles.RelaxationLength, 'String')));
                else
                    S(31,2) = cellstr('NaN'); S(31,3) = cellstr('NaN'); S(31,4) = cellstr('NaN');
                    S(32,2) = cellstr('NaN'); S(32,3) = cellstr('NaN'); S(32,4) = cellstr('NaN');
                end
                
            xlswrite(sprintf('%s%s', Path, FileName), S);
    end
    
        % --------------------------------------------------------------------
        function LoadXlsx_Callback(hObject, eventdata, handles)
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
                            case 'TNS/HNS',  set(handles.MaterialSystem_popup, 'Value', 1);
                            case 'HNS/TNS',  set(handles.MaterialSystem_popup, 'Value', 2);
                            case 'TNS/ZHNS', set(handles.MaterialSystem_popup, 'Value', 3);
                            case 'ZHNS/TNS', set(handles.MaterialSystem_popup, 'Value', 4);
                            case 'HNS/ZHNS', set(handles.MaterialSystem_popup, 'Value', 5);
                            case 'ZHNS/HNS', set(handles.MaterialSystem_popup, 'Value', 6);
                            case 'ZNS/TNS',  set(handles.MaterialSystem_popup, 'Value', 7);
                            case 'TNS/ZNS',  set(handles.MaterialSystem_popup, 'Value', 8);
                            case 'ZNS/HNS',  set(handles.MaterialSystem_popup, 'Value', 9);
                            case 'HNS/ZNS',  set(handles.MaterialSystem_popup, 'Value', 10);
                            case 'ZNS/ZHNS', set(handles.MaterialSystem_popup, 'Value', 11);
                            case 'ZHNS/ZNS', set(handles.MaterialSystem_popup, 'Value', 12);
                        end

                       % Number of periods
                       set(handles.NoPeriods, 'String', raw{4,2});

                       % Superlattice parameters
                       set(handles.Thickness_A, 'String', raw{6,2});
                       set(handles.nActual_A, 'String', raw{7,2});
                       set(handles.nFrom_A, 'String', raw{26,2});   
                       set(handles.nTo_A, 'String', raw{26,3});     
                       set(handles.nActual_A, 'String', raw{26,4}); 
                            set(handles.ThicknessLayerA_slider, 'Max', raw{26,3});
                            set(handles.ThicknessLayerA_slider, 'Min', raw{26,2});
                            set(handles.ThicknessLayerA_slider, 'Value', raw{26,4});
                            set(handles.ThicknessLayerA_slider, 'SliderStep', [1 1]/(raw{26,3}-raw{26,2}));

                       set(handles.Thickness_B, 'String', raw{10,2});
                       set(handles.nActual_B, 'String', raw{11,2});
                       set(handles.nFrom_B, 'String', raw{28,2});   
                       set(handles.nTo_B, 'String', raw{28,3});     
                       set(handles.nActual_B, 'String', raw{28,4}); 
                            set(handles.ThicknessLayerB_slider, 'Max', raw{28,3});
                            set(handles.ThicknessLayerB_slider, 'Min', raw{28,2});
                            set(handles.ThicknessLayerB_slider, 'Value', raw{28,4});
                            set(handles.ThicknessLayerB_slider, 'SliderStep', [1 1]/(raw{28,3}-raw{28,2}));

                       handles.d_a = raw{8,2};
                       handles.d_b = raw{12,2};

                       % Vary lattice parameters
                       if isnan(raw{27,2})
                           set(handles.VaryLatticeParameters_checkbox, 'Value', 0);
                       else
                           set(handles.VaryLatticeParameters_checkbox, 'Value', 1);
                                set(handles.text34, 'Visible', 'on');
                                set(handles.UnitCellLayerA_slider, 'Visible', 'on');
                                set(handles.UnitCell_AFrom, 'Visible', 'on');
                                set(handles.UnitCellActual_A, 'Visible', 'on');
                                set(handles.UnitCell_ATo, 'Visible', 'on');
                                set(handles.text35, 'Visible', 'on');
                                set(handles.UnitCellLayerB_slider, 'Visible', 'on');
                                set(handles.UnitCell_BFrom, 'Visible', 'on');
                                set(handles.UnitCellActual_B, 'Visible', 'on');
                                set(handles.UnitCell_BTo, 'Visible', 'on');

                           set(handles.UnitCell_AFrom, 'String', raw{27,2});   
                           set(handles.UnitCell_ATo, 'String', raw{27,3});     
                           set(handles.UnitCellActual_A, 'String', raw{27,4}); 
                               set(handles.UnitCellLayerA_slider, 'Max', raw{27,3});
                               set(handles.UnitCellLayerA_slider, 'Min', raw{27,2});
                               set(handles.UnitCellLayerA_slider, 'Value', raw{27,4});

                           set(handles.UnitCell_BFrom, 'String', raw{29,2});   
                           set(handles.UnitCell_BTo, 'String', raw{29,3});     
                           set(handles.UnitCellActual_B, 'String', raw{29,4}); 
                               set(handles.UnitCellLayerB_slider, 'Max', raw{29,3});
                               set(handles.UnitCellLayerB_slider, 'Min', raw{29,2});
                               set(handles.UnitCellLayerB_slider, 'Value', raw{29,4});
                       end

                       % Buffer layer
                       switch raw{13,2} 
                           case 'no', set(handles.BufferLayer_checkbox, 'Value', 0);
                           case 'yes'
                            set(handles.BufferLayer_checkbox, 'Value', 1);                
                            set(handles.uipanel9, 'Visible', 'on');
                            set(handles.BufferLayer_choose_popup, 'Visible', 'on');
                            set(handles.dActual_buffer, 'Visible', 'on');
                            set(handles.text23, 'Visible', 'on');
                            set(handles.ThicknessBufferLayer_slider, 'Visible', 'on');
                            set(handles.dFrom_buffer, 'Visible', 'on');
                            set(handles.dTo_buffer, 'Visible', 'on');
                            set(handles.BufferThickness, 'Visible', 'on');
                            set(handles.text37, 'Visible', 'on');
                            set(handles.RelaxationAndStrain_checkbox, 'Enable', 'on');
                            handles.bufferMat = raw{14,2};

                            switch raw{14,2}
                                case 'TNS',  set(handles.MaterialSystem_popup, 'Value', 1);
                                case 'HNS',  set(handles.MaterialSystem_popup, 'Value', 2);
                                case 'ZNS',  set(handles.MaterialSystem_popup, 'Value', 3);
                                case 'ZHNS', set(handles.MaterialSystem_popup, 'Value', 4);
                                case 'V',    set(handles.MaterialSystem_popup, 'Value', 5);
                            end

                            set(handles.dFrom_buffer, 'String', raw{30,2});
                            set(handles.dTo_buffer, 'String', raw{30,3});
                            set(handles.dActual_buffer, 'String', raw{30,4});
                                set(handles.ThicknessBufferLayer_slider, 'Max', raw{30,3});
                                set(handles.ThicknessBufferLayer_slider, 'Min', raw{30,2});
                                set(handles.ThicknessBufferLayer_slider, 'Value', raw{30,4});
                                set(handles.ThicknessBufferLayer_slider, 'SliderStep', [1 1]/(raw{30,3}-raw{30,2}));
                            set(handles.BufferThickness, 'String', raw{15,2});
                       end

                       % Set range
                       handles.range(1,1) = raw{22,2};           handles.range(2,1) = raw{23,2};
                       handles.range(1,3) = raw{22,3};           handles.range(2,3) = raw{23,3};
                       handles.range(1,2) = raw{22,4};           handles.range(2,2) = raw{23,4};

                       set(handles.from200, 'String', raw{22,2});
                       set(handles.to200, 'String', raw{22,3});
                       set(handles.step200, 'String', raw{22,4});
                       set(handles.Offset200, 'String', num(19,5));

                       set(handles.from400, 'String', raw{23,2});
                       set(handles.to400, 'String', raw{23,3});
                       set(handles.step400, 'String', raw{23,4});
                       set(handles.Offset400, 'String', num(20,5));

                       set(handles.GaussPeakWidth, 'String', raw{24,2});

                       % Strain and relaxation length
                                  % Buffer layer
                       switch raw{17,2} 
                           case 'no', set(handles.RelaxationAndStrain_checkbox, 'Value', 0);
                           case 'yes'
                            set(handles.RelaxationAndStrain_checkbox, 'Value', 1);                
                            set(handles.text31, 'Visible', 'on');
                            set(handles.UnitCellBuffer_slider, 'Visible', 'on');
                            set(handles.UnitCellBuffer_From, 'Visible', 'on');
                            set(handles.UnitCellBuffer_actual, 'Visible', 'on');
                            set(handles.UnitCellBuffer_To, 'Visible', 'on');
                            set(handles.text24, 'Visible', 'on');
                            set(handles.RelaxationLength_slider, 'Visible', 'on');
                            set(handles.Relaxation_From, 'Visible', 'on');
                            set(handles.RelaxationLength, 'Visible', 'on');
                            set(handles.Relaxation_To, 'Visible', 'on');

                            set(handles.UnitCellBuffer_From, 'String', raw{31,2});
                            set(handles.UnitCellBuffer_To, 'String', raw{31,3});
                            set(handles.UnitCellBuffer_actual, 'String', raw{31,4});
                                set(handles.UnitCellBuffer_slider, 'Max', raw{31,3});
                                set(handles.UnitCellBuffer_slider, 'Min', raw{31,2});
                                set(handles.UnitCellBuffer_slider, 'Value', raw{31,4});

                            set(handles.Relaxation_From, 'String', raw{32,2});
                            set(handles.Relaxation_To, 'String', raw{32,3});
                            set(handles.RelaxationLength, 'String', raw{32,4});
                                set(handles.RelaxationLength_slider, 'Max', raw{32,3});
                                set(handles.RelaxationLength_slider, 'Min', raw{32,2});
                                set(handles.RelaxationLength_slider, 'Value', raw{32,4});
                                set(handles.RelaxationLength_slider, 'SliderStep', [1 1]/(raw{32,3}-raw{32,2}));
                       end
           
                case 2
                    open(sprintf('%s%s', Path, FileName));
                    
            end
            
            

            handles = simulate(handles);
                guidata(hObject, handles);
            plot_xrd(handles);
                guidata(hObject, handles);
                
    % --------------------------------------------------------------------
    function Export_Callback(hObject, eventdata, handles)
        [FileName, Path, index] = uiputfile({'*.dat'; '*.txt'}, 'Save simulated patterns as...');
        switch index
            case 0, return
            case 1
                simulation200(:,1) = handles.twotheta1;
                simulation200(:,2) = handles.IntensityGauss1;

                simulation400(:,1) = handles.twotheta2;
                simulation400(:,2) = handles.IntensityGauss2;

                csvwrite(sprintf('%s200_%s', Path, FileName), simulation200);
                csvwrite(sprintf('%s400_%s', Path, FileName), simulation400);
        end
        
    % --------------------------------------------------------------------
    function Exit_Callback(hObject, eventdata, handles)
    close(gcbf);
        
    
% --------------------------------------------------------------------
function MeasuredData_Callback(hObject, eventdata, handles)
    % --------------------------------------------------------------------
    function Load_Callback(hObject, eventdata, handles)
        % --------------------------------------------------------------------
        function Load200_Callback(hObject, eventdata, handles)
            [FileName_200, path_200, index] = uigetfile({'*.txt'; '*.dat'}, 'Load measured (200) peak...');
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
        function Load400_Callback(hObject, eventdata, handles)
            [FileName_400, path_400, index] = uigetfile({'*.txt'; '*.dat'}, 'Load measured (400) peak...');
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
        function LoadBothXRD_Callback(hObject, eventdata, handles)
            [FileName, pathName, index] = uigetfile({'*.txt'; '*.dat'}, 'Load measured T-2T scan...');
            switch index
                case 0, return
                case {1, 2}
                    pathName = sprintf('%s%s', pathName, FileName);
                        handles.T2T = importdata(pathName);
                        set(handles.SampleName, 'String', handles.T2T.textdata(2));
                    handles = LoadFromFS(handles);
                        guidata(hObject, handles);
                    handles = simulate(handles);
                        guidata(hObject, handles);
                    plot_xrd(handles);
                        guidata(hObject, handles);
            end
            
        function handles = LoadFromFS(handles)
            from200 = find(handles.T2T.data(:,1) == str2num(get(handles.from200, 'String')));
            to200   = find(handles.T2T.data(:,1) == str2num(get(handles.to200, 'String')));    
            from400 = find(handles.T2T.data(:,1) == str2num(get(handles.from400, 'String')));
            to400   = find(handles.T2T.data(:,1) == str2num(get(handles.to400, 'String')));                         
                handles.T2T_200.data = handles.T2T.data(from200:to200,1:2);
                handles.T2T_400.data = handles.T2T.data(from400:to400,1:2);

    % --------------------------------------------------------------------
    function handles = Delete_Callback(hObject, eventdata, handles)
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
function GraphSettings_Callback(hObject, eventdata, handles)
    % --------------------------------------------------------------------
    function ChangeSimCol_Callback(hObject, eventdata, handles)
        % --------------------------------------------------------------------
        function SimColorChange_Callback(hObject, eventdata, handles)
            handles.color = uisetcolor;
            if handles.color == 0, return;  end
            guidata(hObject, handles);
            plot_xrd(handles);
            guidata(hObject, handles);
        % --------------------------------------------------------------------
        function MeasColorChange_Callback(hObject, eventdata, handles)
            handles.colormeas = uisetcolor;
            if handles.colormeas == 0, return;  end
            guidata(hObject, handles);
            plot_xrd(handles);
            guidata(hObject, handles);
               
    % --------------------------------------------------------------------
    function handles = FontSettings_Callback(hObject, eventdata, handles)
        handles.Font = uisetfont;
        if ~isfield(handles.Font, 'FontName')
            return
        end
            guidata(hObject, handles);
            plot_xrd(handles);
            guidata(hObject, handles);
        
    % --------------------------------------------------------------------
    function handles = LineWidth_Callback(hObject, eventdata, handles)
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
    function Grid_Callback(hObject, eventdata, handles)
        switch handles.Grid
            case 'off', handles.Grid = 'on';
            case 'on',  handles.Grid = 'off';
        end
        guidata(hObject, handles);
        plot_xrd(handles);
        guidata(hObject, handles);
        
    % --------------------------------------------------------------------
    function handles = DifferenceLinLog_Callback(hObject, eventdata, handles)
        switch handles.Difference
            case 'lin',  handles.Difference = 'log';
            case 'log',  handles.Difference = 'lin';
        end
        guidata(hObject, handles);
        plot_xrd(handles);
        guidata(hObject, handles);
        
    % --------------------------------------------------------------------
    function handles = PropertyEditorON_Callback(hObject, eventdata, handles)
        plottools('on','figurepalette');
        set(handles.PropertyEditorOFF, 'Enable', 'on');

    % --------------------------------------------------------------------
    function PropertyEditorOFF_Callback(hObject, eventdata, handles)
        plottools('off');
        set(handles.PropertyEditorOFF, 'Enable', 'off');
% --------------------------------------------------------------------
function Help_menu_Callback(hObject, eventdata, handles)

    % --------------------------------------------------------------------
    function About_Callback(hObject, eventdata, handles)
        message = {'Created by Paulina Holuj'; 'holuj@uni-mainz.de'; 'University of Mainz'; 'Institute of Physics';...
            'AG Klaui, http://www.klaeui-lab.physik.uni-mainz.de/'; '2014'};
        icon = importdata('JGU_Mainz_logo_crop.png');
        h = msgbox(message, 'Affiliations', 'custom', icon.cdata, jet(size(icon.cdata,2)));

    % --------------------------------------------------------------------
    function Help_Callback(hObject, eventdata, handles)
        open('Help.pdf');


%% Resize        
% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
    % Original position of controls
    uipanel2_org = [10, 10, 801, 650];
    uipanel3_org = [821, 494, 170, 132];
    uipanel4_org = [999, 494, 252, 131];
    uipanel5_org = [821, 230, 431, 255];
    uipanel9_org = [820, 11, 431, 210];

    text38_org     = [820, 630, 84, 21];
    SampleName_org = [931, 631, 320, 22];

    plot_T_2T_200_lin_org  = [60, 416, 325, 225];
    plot_T_2T_400_lin_org  = [455, 416, 325, 225];
    plot_T_2T_200_log_org  = [60, 150, 325, 225];
    plot_T_2T_400_log_org  = [455, 150, 325, 225];
    plot_difference200_org = [60 31 325 75];
    plot_difference400_org = [455 31 325 75];

    % Set units in pixels
    set(hObject, 'Units', 'pixels');
    % Original size of window
    Original_Size = [520 175 1260 671];
    % New size of window
    Figure_Size   = get(hObject, 'Position');

    % Check is new size is greater than the original
    if((Figure_Size(3) < Original_Size(3)) || (Figure_Size(4) < Original_Size(4)))
        if Figure_Size(4) < Original_Size(4)
            Figure_Size = [Figure_Size(1), Figure_Size(2), Figure_Size(3), Original_Size(4)];
        end
        
        % Scale panel with graphs
        set(handles.uipanel2, 'Units', 'pixels');
        set(handles.uipanel2, 'Position', [uipanel2_org(1)*(Figure_Size(3)/Original_Size(3)),...
            uipanel2_org(2)*(Figure_Size(4)/Original_Size(4)),...
            Figure_Size(3)-uipanel5_org(3)-35,...
            uipanel2_org(4)*(Figure_Size(4)/Original_Size(4))]);
        uipanel2_new = get(handles.uipanel2, 'Position');
        
        % Scale graph 1
        set(handles.plot_T_2T_200_lin, 'Units', 'pixels');
        set(handles.plot_T_2T_200_lin, 'Position', [plot_T_2T_200_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_200_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

        % Scale graph 2
        set(handles.plot_T_2T_400_lin, 'Units', 'pixels');
        set(handles.plot_T_2T_400_lin, 'Position', [plot_T_2T_400_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_400_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

        % Scale graph 3
        set(handles.plot_T_2T_200_log, 'Units', 'pixels');
        set(handles.plot_T_2T_200_log, 'Position', [plot_T_2T_200_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_200_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_200_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

        % Scale graph 4
        set(handles.plot_T_2T_400_log, 'Units', 'pixels');
        set(handles.plot_T_2T_400_log, 'Position', [plot_T_2T_400_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_T_2T_400_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_T_2T_400_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
        
        % Scale graph 5
        set(handles.plot_difference200, 'Units', 'pixels');
        set(handles.plot_difference200, 'Position', [plot_difference200_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference200_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_difference200_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference200_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
        
        % Scale graph 6
        set(handles.plot_difference400, 'Units', 'pixels');
        set(handles.plot_difference400, 'Position', [plot_difference400_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference400_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
            plot_difference400_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
            plot_difference400_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);


    end
    
    set(hObject, 'Position', Figure_Size);

    % Scale panel with graphs
    set(handles.uipanel2, 'Units', 'pixels');
    set(handles.uipanel2, 'Position', [uipanel2_org(1)*(Figure_Size(3)/Original_Size(3)),...
        uipanel2_org(2)*(Figure_Size(4)/Original_Size(4)),...
        Figure_Size(3)-uipanel5_org(3)-35,...
        uipanel2_org(4)*(Figure_Size(4)/Original_Size(4))]);
    uipanel2_new = get(handles.uipanel2, 'Position');

    % Scale panels with parameters
    set(handles.uipanel3, 'Units', 'pixels');
    set(handles.uipanel3, 'Position', [Figure_Size(3)-uipanel3_org(3)-275,...
        Figure_Size(4)-uipanel3_org(4)-40, uipanel3_org(3), uipanel3_org(4)]);

    set(handles.uipanel4, 'Units', 'pixels');
    set(handles.uipanel4, 'Position', [Figure_Size(3)-uipanel4_org(3)-15,...
        Figure_Size(4)-uipanel4_org(4)-40, uipanel4_org(3), uipanel4_org(4)]);

    set(handles.uipanel5, 'Units', 'pixels');
    set(handles.uipanel5, 'Position', [Figure_Size(3)-uipanel5_org(3)-15,...
        Figure_Size(4)-uipanel5_org(4)-182, uipanel5_org(3), uipanel5_org(4)]);

    set(handles.uipanel9, 'Units', 'pixels');
    set(handles.uipanel9, 'Position', [Figure_Size(3)-uipanel5_org(3)-15,...
        Figure_Size(4)-uipanel9_org(4)-450, uipanel9_org(3), uipanel9_org(4)]);

    set(handles.text38, 'Units', 'pixels');
    set(handles.text38, 'Position', [Figure_Size(3)-text38_org(3)-360,...
        Figure_Size(4)-text38_org(4)-15, text38_org(3), text38_org(4)]);

    set(handles.SampleName, 'Units', 'pixels');
    set(handles.SampleName, 'Position', [Figure_Size(3)-SampleName_org(3)-15,...
        Figure_Size(4)-SampleName_org(4)-13, SampleName_org(3), SampleName_org(4)]);

    % Scale graph 1
    set(handles.plot_T_2T_200_lin, 'Units', 'pixels');
    set(handles.plot_T_2T_200_lin, 'Position', [plot_T_2T_200_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_200_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 2
    set(handles.plot_T_2T_400_lin, 'Units', 'pixels');
    set(handles.plot_T_2T_400_lin, 'Position', [plot_T_2T_400_lin_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_lin_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_400_lin_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_lin_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 3
    set(handles.plot_T_2T_200_log, 'Units', 'pixels');
    set(handles.plot_T_2T_200_log, 'Position', [plot_T_2T_200_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_200_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_200_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 4
    set(handles.plot_T_2T_400_log, 'Units', 'pixels');
    set(handles.plot_T_2T_400_log, 'Position', [plot_T_2T_400_log_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_log_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_T_2T_400_log_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_T_2T_400_log_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
    
    % Scale graph 5
    set(handles.plot_difference200, 'Units', 'pixels');
    set(handles.plot_difference200, 'Position', [plot_difference200_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference200_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_difference200_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference200_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);

    % Scale graph 6
    set(handles.plot_difference400, 'Units', 'pixels');
    set(handles.plot_difference400, 'Position', [plot_difference400_org(1)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference400_org(2)*(uipanel2_new(4)/uipanel2_org(4)),...
        plot_difference400_org(3)*(uipanel2_new(3)/uipanel2_org(3)),...
        plot_difference400_org(4)*(uipanel2_new(4)/uipanel2_org(4))]);
