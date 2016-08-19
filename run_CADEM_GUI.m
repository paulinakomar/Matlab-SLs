%% Description
% Run the GUI to calculate x-ray diffraction patterns of epitaxial
% multilayers and superlattices.
%==========================================================================
% Created by Paulina Komar   &   Gerhard Jakob
% holuj@uni-mainz.de             jakob@uni-mainz.de
% komarpaulina@outlook.com
% Last modified August 2016
%==========================================================================
function varargout = run_CADEM_GUI(varargin)
% RUN_CADEM_GUI MATLAB code for run_CADEM_GUI.fig
%      RUN_CADEM_GUI, by itself, creates a new RUN_CADEM_GUI or raises the existing
%      singleton*.
%
%      H = RUN_CADEM_GUI returns the handle to a new RUN_CADEM_GUI or the handle to
%      the existing singleton*.
%
%      RUN_CADEM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUN_CADEM_GUI.M with the given input arguments.
%
%      RUN_CADEM_GUI('Property','Value',...) creates a new RUN_CADEM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before run_CADEM_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to run_CADEM_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help run_CADEM_GUI

% Last Modified by GUIDE v2.5 08-Aug-2016 15:47:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @run_CADEM_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @run_CADEM_GUI_OutputFcn, ...
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


% --- Executes just before run_CADEM_GUI is made visible.
function run_CADEM_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to run_CADEM_GUI (see VARARGIN)

% Choose default command line output for run_CADEM_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes run_CADEM_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

    title(handles.axis_bar_stack, 'Arrangement of the layers');
    xlabel(handles.axis_bar_stack, 'Ordinal number of a layer');
    ylabel(handles.axis_bar_stack, 'Thickness (uc)');
    grid(handles.axis_bar_stack, 'on');
    box(handles.axis_bar_stack, 'on');

    title(handles.axis_peak002, '(002) reflection');
    xlabel(handles.axis_peak002, '2\it{\theta} (deg)');
    ylabel(handles.axis_peak002, 'I/I_{max}');
    grid(handles.axis_peak002, 'on');
    box(handles.axis_peak002, 'on');

    title(handles.axis_peak004, '(004) reflection');
    xlabel(handles.axis_peak004, '2\it{\theta} (deg)');
    ylabel(handles.axis_peak004, '');
    grid(handles.axis_peak004, 'on');
    box(handles.axis_peak004, 'on');
    
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    handles.system = get(handles.popupmenu_system, 'value');
        set(handles.popupmenu_system, 'UserData', handles.system);
    handles.const = constants(handles.system);
    guidata(hObject, handles);
    
    movegui(hObject,'center')

% --- Outputs from this function are returned to the command line.
function varargout = run_CADEM_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function axis_peak004_CreateFcn(hObject, eventdata, handles)

%% Specify angular (2theta) limits for the calculation
function edit_from002_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
          
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_from002_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_to002_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_to002_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_step002_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end

    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_step002_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_from004_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end

    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_from004_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_to004_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end

    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_to004_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_step004_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end

    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_step004_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Edit fields => specify the layer thickness
function edit_d_vanadium_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    rounded = round(str2num(get(handles.edit_d_vanadium, 'String'))*handles.const.divide_uc)/handles.const.divide_uc;
    set(handles.edit_d_vanadium, 'String', rounded);
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_d_vanadium_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_d_materialA_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    rounded = round(str2num(get(handles.edit_d_materialA, 'String'))*handles.const.divide_uc)/handles.const.divide_uc;
    set(handles.edit_d_materialA, 'String', rounded);
    edit_intermixing_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_d_materialA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_d_materialB_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    rounded = round(str2num(get(handles.edit_d_materialB, 'String'))*handles.const.divide_uc)/handles.const.divide_uc;
    set(handles.edit_d_materialB, 'String', rounded);
    edit_intermixing_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_d_materialB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Edit fields => specify the lattice constants
function edit_c_vanadium_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_c_vanadium_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_c_materialA_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_c_materialA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_c_materialB_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_c_materialB_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Edit field => specify number of bilayers (periods)
function edit_NoBilayers_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    rounded = round(str2num(get(handles.edit_NoBilayers, 'String')));
    set(handles.edit_NoBilayers, 'String', rounded);
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    guidata(hObject, handles);
function edit_NoBilayers_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% Edit field => specify amount of intermixing (in unit cells)
function edit_intermixing_Callback(hObject, eventdata, handles)
    handles = commatodot(hObject, handles);
    if isfield(handles, 'msg'), return, end
    handles = checkvalues(hObject, handles);
    if isfield(handles, 'msg'), return, end
    
    rounded = round(str2num(get(handles.edit_intermixing, 'String'))*handles.const.divide_uc)/handles.const.divide_uc;
    set(handles.edit_intermixing, 'String', rounded);
    guidata(hObject, handles);
    n = str2num(get(handles.edit_intermixing, 'string'));
   
    if get(handles.popupmenu_periodicity, 'value') == 1
        d_materialA = str2num(get(handles.edit_d_materialA, 'string'));
        d_materialB = str2num(get(handles.edit_d_materialB, 'string'));

        n_max = min([d_materialA, d_materialB]);

        if n>n_max
            set(handles.edit_intermixing, 'string', n_max);
            msgbox('Maximum value of intermixing cannot be larger than the thickness of the thinnest constituent layer.');
        end
    else
        if isfield(handles, 'stack')
            n_max = min(handles.stack);
        else
            msgbox('Please load the file with the layer arrangement prior to changing the intermixing value.');
            return
        end
        
        if n>n_max
            set(handles.edit_intermixing, 'string', n_max);
            msgbox('Maximum value of intermixing cannot be larger than the double thickness of the thinnest constituent layer.');
        end
    end
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
function edit_intermixing_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Push button => load simulation parameters from the configuration file
function pushbutton_loadConfFile_Callback(hObject, eventdata, handles)
    [FileName, pathName, index] = uigetfile('*.txt', 'Load configuration file...');
        switch index
            case 0, return
            case 1
                [names, values] = textread(sprintf('%s\\%s', pathName, FileName), '%s %s');

                set(handles.popupmenu_system, 'value', str2num(values{1}));
                if str2num(values{1}) == 1
                    handles = set_visible_vanadium(handles);
                    values{15} = '0';
                    guidata(hObject, handles);
                    if isempty(str2num(values{8}))
                        values{8} = num2str(handles.const.d.TNS);
                    end
                    if isempty(str2num(values{9}))
                        values{9} = num2str(handles.const.d.HNS);
                    end
                    if isempty(str2num(values{10}))
                        values{10} = '1';
                        set(handles.popupmenu_periodicity, 'value', str2num(values{10}));
                    end
                    if isempty(str2num(values{11}))
                        values{11} = '10';
                    end
                    if isempty(str2num(values{12}))
                        values{12} = '10';
                    end
                    if isempty(str2num(values{13}))
                        values{13} = '1';
                    end
                    if isempty(str2num(values{14}))
                        values{14} = ' ';
                    end
                else
                    handles = set_visible_SL(handles);
                    guidata(hObject, handles);
                    if str2num(values{10}) == 1
                        set(handles.popupmenu_periodicity, 'value', 1);
                        set(handles.edit_d_materialA, 'string', str2num(values{11}));
                        set(handles.edit_d_materialB, 'string', str2num(values{12}));
                        set(handles.edit_NoBilayers, 'string', str2num(values{13}));
                        set(handles.uipanel_layerThicknesses, 'visible', 'on');
                        set(handles.uipanel_nonperiodicLayers, 'visible', 'off');
                    else
                        set(handles.popupmenu_periodicity, 'value', 2);
                        set(handles.popupmenu_periodicity, 'visible', 'on');
                        set(handles.text_filenameNonperiodic, 'String', values{14});
                        set(handles.uipanel_layerThicknesses, 'visible', 'off');
                        set(handles.uipanel_nonperiodicLayers, 'visible', 'on');
                        handles.stack = importdata(values{14});
                    end
                    if isempty(str2num(values{16}))
                        values{16} = num2str(handles.const.d.V);
                    end
                    if isempty(str2num(values{17}))
                        values{17} = '15';
                    end
                end
                set(handles.edit_from002, 'string', str2num(values{2}));
                set(handles.edit_step002, 'string', str2num(values{3}));
                set(handles.edit_to002, 'string', str2num(values{4}));
                set(handles.edit_from004, 'string', str2num(values{5}));
                set(handles.edit_step004, 'string', str2num(values{6}));
                set(handles.edit_to004, 'string', str2num(values{7}));
                set(handles.edit_c_materialA, 'string', str2num(values{8}));
                set(handles.edit_c_materialB, 'string', str2num(values{9}));
                set(handles.edit_intermixing, 'string', str2num(values{15}));
                set(handles.edit_c_vanadium, 'string', str2num(values{16}));
                set(handles.edit_d_vanadium, 'string', str2num(values{17}));
                 
        end
            resetGraphs(handles);
            handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
            edit_intermixing_Callback(hObject, eventdata, handles);
            set(handles.popupmenu_system, 'UserData', handles.system);
            guidata(hObject, handles);
            
            

%% Push button => save simulation parameters to the configuration file
function pushbutton_saveConfFile_Callback(hObject, eventdata, handles)
	[filename, pathname, index] = uiputfile('*.txt', 'Save the configuration file as...');
    
    switch index
        case 0, return
        case 1
            textdata = {'system', '2theta_002_from', '2theta_002_step', '2theta_002_to',...
                '2theta_004_from', '2theta_004_step', '2theta_004_to', 'layerA_latticeconstant_A',...
                'layerB_latticeconstant_A', 'periodicArrangement', 'layerA_thickness_uc',...
                'layerB_thickness_uc', 'numberOfbilayers', 'non-periodicArrangement_file',...
                'numberOfUnitCellsOfIntermixing', 'VanadiumLayer_latticeconstant_A',...
                'VanadiumLayer_thickness_uc'}';

            data{1}  = get(handles.popupmenu_system, 'value');
            data{2}  = get(handles.edit_from002, 'string');
            data{3}  = get(handles.edit_step002, 'string');
            data{4}  = get(handles.edit_to002, 'string');
            data{5}  = get(handles.edit_from004, 'string');
            data{6}  = get(handles.edit_step004, 'string');
            data{7}  = get(handles.edit_to004, 'string');


            data{8}  = get(handles.edit_c_materialA, 'string');
            data{9}  = get(handles.edit_c_materialB, 'string');
            if get(handles.popupmenu_periodicity, 'value') == 1
                data{10} = 1;
                data{14} = '';
            else
                data{10} = 0;
                data{14} = get(handles.text_filenameNonperiodic, 'String');
            end
            data{11} = get(handles.edit_d_materialA, 'string');
            data{12} = get(handles.edit_d_materialB, 'string');
            data{13} = get(handles.edit_NoBilayers, 'string');
            data{15} = get(handles.edit_intermixing, 'string');
            data{16} = get(handles.edit_c_vanadium, 'string');
            data{17} = get(handles.edit_d_vanadium, 'string');


            data = data';
            ConfData = [textdata, data];
            cell2csv(sprintf('%s\\%s', pathname, filename), ConfData, '\t');
    end
    
    
%% Push button => load measured data from the .txt or .dat file
function handles = pushbutton_loadMeasuredData_Callback(hObject, eventdata, handles)
    [FileName, pathName, index] = uigetfile({'*.txt'; '*.dat'}, 'Load measured data...');
        switch index
            case 0, return
            case {1, 2, 3}
                measured = importdata(sprintf('%s\\%s', pathName, FileName));
                datatype = whos('measured');
                if datatype.class == 'struct'
                    handles.T2T = measured.data(:,1);
                    handles.Int = measured.data(:,2);
                else
                    handles.T2T = measured(:,1);
                    handles.Int = measured(:,2);
                end
                guidata(hObject, handles);
        end
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    
    
    
%% Push button => save calculated data to the .txt or .dat file
function pushbutton_savePattern_Callback(hObject, eventdata, handles)
    [filename, pathname, index] = uiputfile('*.txt', 'Save the calculated pattern as...');
    switch index
        case 0, return
        case 1
            calculatedPattern = [[handles.twotheta_002; handles.IntVoigt_002], [handles.twotheta_004; handles.IntVoigt_004]]';
                csvwrite(sprintf('%s\\%s', pathname, filename), calculatedPattern);
    end

        
%% Popup menu => choose a system, 1 = V, 2 = sub/TiNiSn/HfNiSn, 3 = sub/HfNiSn/TiNiSn
function popupmenu_system_Callback(hObject, eventdata, handles)
    switch get(handles.popupmenu_system, 'Value');
        case {1, 4}
            if get(handles.popupmenu_system, 'UserData') == 1
                return
            elseif get(handles.popupmenu_system, 'UserData') == 2 || get(handles.popupmenu_system, 'UserData') == 3
                handles = set_visible_vanadium(handles);
                guidata(hObject, handles);
            end
        case 2
            if get(handles.popupmenu_system, 'UserData') == 1
                handles = set_visible_SL(handles);
                guidata(hObject, handles);
                set(handles.edit_c_materialA, 'String', handles.const.d.TNS);
                set(handles.edit_c_materialB, 'String', handles.const.d.HNS);
            elseif get(handles.popupmenu_system, 'UserData') == 2
                return
            elseif get(handles.popupmenu_system, 'UserData') == 3
                c_materialA = str2num(get(handles.edit_c_materialA, 'String'));
                c_materialB = str2num(get(handles.edit_c_materialB, 'String'));

                set(handles.edit_c_materialA, 'String', c_materialB);
                set(handles.edit_c_materialB, 'String', c_materialA);
            end
        case 3
            if get(handles.popupmenu_system, 'UserData') == 1
                handles = set_visible_SL(handles);
                guidata(hObject, handles);
                set(handles.edit_c_materialA, 'String', handles.const.d.HNS);
                set(handles.edit_c_materialB, 'String', handles.const.d.TNS);
            elseif get(handles.popupmenu_system, 'UserData') == 3
                return
            elseif get(handles.popupmenu_system, 'UserData') == 2
                c_materialA = str2num(get(handles.edit_c_materialA, 'String'));
                c_materialB = str2num(get(handles.edit_c_materialB, 'String'));

                set(handles.edit_c_materialA, 'String', c_materialB);
                set(handles.edit_c_materialB, 'String', c_materialA);
            end
    end
    resetGraphs(handles);
    handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
    set(handles.popupmenu_system, 'UserData', get(handles.popupmenu_system, 'Value'));
    guidata(hObject, handles);
function popupmenu_system_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function handles = set_visible_vanadium(handles)
    set(handles.text_vanadium, 'visible', 'on');
    set(handles.edit_c_vanadium, 'visible', 'on');
    set(handles.edit_d_vanadium, 'visible', 'on');
    set(handles.text_d_vanadium, 'visible', 'on');
    set(handles.text_c_materialA, 'visible', 'off');
    set(handles.text_c_materialB, 'visible', 'off');
    set(handles.edit_c_materialA, 'visible', 'off');
    set(handles.edit_c_materialB, 'visible', 'off');
    set(handles.popupmenu_periodicity, 'visible', 'off');
    set(handles.text_NoBilayers, 'visible', 'off');
    set(handles.edit_NoBilayers, 'visible', 'off');
    set(handles.text_d_materialA, 'visible', 'off');
    set(handles.text_d_materialB, 'visible', 'off');
    set(handles.edit_d_materialA, 'visible', 'off');
    set(handles.edit_d_materialB, 'visible', 'off');
    set(handles.uipanel_intermixing, 'visible', 'off');
    set(handles.uipanel_nonperiodicLayers, 'visible', 'off');
    if get(handles.popupmenu_periodicity, 'value') == 2
        set(handles.uipanel_layerThicknesses, 'visible', 'on');
    end
    
    
function handles = set_visible_SL(handles)
    if get(handles.popupmenu_periodicity, 'value') == 2
        set(handles.uipanel_layerThicknesses, 'visible', 'off');
        set(handles.uipanel_nonperiodicLayers, 'visible', 'on');
    end
    set(handles.text_vanadium, 'visible', 'off');
    set(handles.edit_c_vanadium, 'visible', 'off');
    set(handles.edit_d_vanadium, 'visible', 'off');
    set(handles.text_d_vanadium, 'visible', 'off');
    set(handles.text_c_materialA, 'visible', 'on');
    set(handles.text_c_materialB, 'visible', 'on');
    set(handles.edit_c_materialA, 'visible', 'on');
    set(handles.edit_c_materialB, 'visible', 'on');
    set(handles.popupmenu_periodicity, 'visible', 'on');
    set(handles.text_NoBilayers, 'visible', 'on');
    set(handles.edit_NoBilayers, 'visible', 'on');
    set(handles.text_d_materialA, 'visible', 'on');
    set(handles.text_d_materialB, 'visible', 'on');
    set(handles.edit_d_materialA, 'visible', 'on');
    set(handles.edit_d_materialB, 'visible', 'on');
    set(handles.uipanel_intermixing, 'visible', 'on');
    
    

%% Functions for plotting
function plotStack(handles)
    bar(handles.axis_bar_stack, handles.stack);
        title(handles.axis_bar_stack, 'Arrangement of the layers');
        xlabel(handles.axis_bar_stack, 'Ordinal number of a layer');
        ylabel(handles.axis_bar_stack, 'Thickness (uc)');
        grid(handles.axis_bar_stack, 'on');
        box(handles.axis_bar_stack, 'on');
        xlim(handles.axis_bar_stack, [0 length(handles.stack)]+1);
        if length(handles.stack)>10
            set(handles.axis_bar_stack, 'XTick', round(linspace(1,length(handles.stack),10)));
        end

        
function resetGraphs(handles)
    bar(handles.axis_bar_stack, []);
        title(handles.axis_bar_stack, 'Arrangement of the layers');
        xlabel(handles.axis_bar_stack, 'Ordinal number of a layer');
        ylabel(handles.axis_bar_stack, 'Thickness (uc)');
        grid(handles.axis_bar_stack, 'on');
        box(handles.axis_bar_stack, 'on');
    semilogy(handles.axis_peak002, [NaN], [NaN]);
        title(handles.axis_peak002, '(002) reflection');
        xlabel(handles.axis_peak002, '2\it{\theta} (deg)');
        ylabel(handles.axis_peak002, 'I/I_{max}');
        grid(handles.axis_peak002, 'on');
        box(handles.axis_peak002, 'on');
    semilogy(handles.axis_peak004, [NaN], [NaN]);
        title(handles.axis_peak004, '(004) reflection');
        xlabel(handles.axis_peak004, '2\it{\theta} (deg)');
        ylabel(handles.axis_peak004, '');
        grid(handles.axis_peak004, 'on');
        box(handles.axis_peak004, 'on');

        
function handles = plotData(handles)
    bar(handles.axis_bar_stack, handles.effective_stack);
        title(handles.axis_bar_stack, 'Arrangement of the layers');
        xlabel(handles.axis_bar_stack, 'Ordinal number of a layer');
        ylabel(handles.axis_bar_stack, 'Thickness (uc)');
        grid(handles.axis_bar_stack, 'on');
        box(handles.axis_bar_stack, 'on');
        xlim(handles.axis_bar_stack, [0 length(handles.effective_stack)+1]);
        if length(handles.effective_stack)>10
            set(handles.axis_bar_stack, 'XTick', round(linspace(1,length(handles.effective_stack),10)));
        end

    semilogy(handles.axis_peak002, handles.twotheta_002, handles.IntVoigt_002, 'r', 'linewidth', 1.5);
        xmin_002 = handles.from002;
        xmax_002 = handles.to002;
        if isfield(handles, 'T2T')
            index_xmin = max(find(handles.T2T < xmin_002));
            index_xmax = min(find(handles.T2T > xmax_002))-1;
            if isempty(index_xmin), index_xmin = 1; end
            semilogy(handles.axis_peak002, handles.twotheta_002, handles.IntVoigt_002, 'r',...
                handles.T2T(index_xmin:index_xmax), handles.Int(index_xmin:index_xmax)/max(handles.Int(index_xmin:index_xmax)),...
                'k', 'linewidth', 1.5);
        end
        title(handles.axis_peak002, '(002) reflection');
        xlabel(handles.axis_peak002, '2\it{\theta} (deg)');
        ylabel(handles.axis_peak002, 'I/I_{max}');
        grid(handles.axis_peak002, 'on');
        box(handles.axis_peak002, 'on');
        xlim(handles.axis_peak002, [xmin_002 xmax_002]);
        
    semilogy(handles.axis_peak004, handles.twotheta_004, handles.IntVoigt_004, 'r', 'linewidth', 1.5);
        xmin_004 = handles.from004;
        xmax_004 = handles.to004;
        if isfield(handles, 'T2T')
            index_xmin = max(find(handles.T2T < xmin_004))+1;
            index_xmax = min(find(handles.T2T > xmax_004))-1;
            if isempty(index_xmax), index_xmax = length(handles.T2T); end
            semilogy(handles.axis_peak004, handles.twotheta_004, handles.IntVoigt_004, 'r',...
                handles.T2T(index_xmin:index_xmax), handles.Int(index_xmin:index_xmax)/max(handles.Int(index_xmin:index_xmax)),...
                'k', 'linewidth', 1.5);
            legend('calculated', 'measured', 'location', 'best');
        end
        title(handles.axis_peak004, '(004) reflection');
        xlabel(handles.axis_peak004, '2\it{\theta} (deg)');
        ylabel(handles.axis_peak004, '');
        grid(handles.axis_peak004, 'on');
        box(handles.axis_peak004, 'on');
        xlim(handles.axis_peak004, [xmin_004 xmax_004]);


        
%% Popup menu => periodic/nonperiodic layer arrangement
function popupmenu_periodicity_Callback(hObject, eventdata, handles)
    if get(handles.popupmenu_periodicity, 'Value') == 1
        set(handles.uipanel_layerThicknesses, 'visible', 'on');
        set(handles.uipanel_nonperiodicLayers, 'visible', 'off');
        set(handles.text_filenameNonperiodic, 'String', '');
        resetGraphs(handles);
        handles = pushbutton_calculate_Callback(hObject, eventdata, handles);
        guidata(hObject, handles);
    else
        set(handles.uipanel_layerThicknesses, 'visible', 'off');
        set(handles.uipanel_nonperiodicLayers, 'visible', 'on');
        
        resetGraphs(handles);
    end
    guidata(hObject, handles);
function popupmenu_periodicity_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function handles = pushbutton_nonperiodicStack_Callback(hObject, eventdata, handles)
    [FileName, pathName, index] = uigetfile({'*.txt'; '*.dat'}, 'Load a file with non-periodic layer arrangement...');

        switch index
            case 0, return
            case {1, 2, 3}
                set(handles.text_filenameNonperiodic, 'string', sprintf('%s\\%s', pathName, FileName));
                guidata(hObject, handles);
        end
        
        handles.stack = importdata(sprintf('%s\\%s', pathName, FileName));
        resetGraphs(handles);
        edit_intermixing_Callback(hObject, eventdata, handles);
        guidata(hObject, handles);
   
        

%% Pushbutton => calculate the pattern
function handles = pushbutton_calculate_Callback(hObject, eventdata, handles)
handles = checkvalues(hObject, handles);
if isfield(handles, 'msg'), return, end
    
set(handles.figure1, 'pointer', 'watch'); 
drawnow; pause(0.1)
    handles.from002 = str2num(get(handles.edit_from002, 'string'));
    handles.step002 = str2num(get(handles.edit_step002, 'string'));
    handles.to002   = str2num(get(handles.edit_to002, 'string'));
    handles.from004 = str2num(get(handles.edit_from004, 'string'));
    handles.step004 = str2num(get(handles.edit_step004, 'string'));
    handles.to004   = str2num(get(handles.edit_to004, 'string'));
    
    handles.twotheta_002  = handles.from002 : handles.step002 : handles.to002;
    handles.twotheta_004  = handles.from004 : handles.step004 : handles.to004;

    handles.system = get(handles.popupmenu_system, 'value');
    handles.const = constants(handles.system);
    
    if isempty(get(handles.edit_intermixing, 'string'))
        set(handles.edit_intermixing, 'string', 0);
    end
    
    if handles.system == 1
        handles.const.d_a_new = str2num(get(handles.edit_c_vanadium, 'string'));
        handles.const.d_b_new = str2num(get(handles.edit_c_vanadium, 'string'));
        n = 0;
        stack = [str2num(get(handles.edit_d_vanadium, 'string')), 0];
    else
        handles.const.d_a_new = str2num(get(handles.edit_c_materialA, 'string'));                
        handles.const.d_b_new = str2num(get(handles.edit_c_materialB, 'string'));
        n = str2num(get(handles.edit_intermixing, 'string'));
        if get(handles.popupmenu_periodicity, 'value') == 1
            for i = 1:str2num(get(handles.edit_NoBilayers, 'string'))
                stack(2*i-1) = str2num(get(handles.edit_d_materialA, 'string'));
                stack(2*i)   = str2num(get(handles.edit_d_materialB, 'string'));
            end
        else
            if isempty(get(handles.text_filenameNonperiodic, 'String'))
                msgbox('Please choose the file with layer arrangement.');
                return
            end
            FileName = get(handles.text_filenameNonperiodic, 'String');
            stack = importdata(FileName);
        end
    end
                    
    % calculate atomic scattering factor
    if ~isfield(handles, 'const.f')
        f = atomicScatteringFactor(handles.const, handles.twotheta_002, handles.twotheta_004);
    end
    
    % calculate XRD intensity
    [handles.IntVoigt_002, handles.IntVoigt_004, handles.effective_stack] = CADEM(stack,...
            handles.const, f, handles.twotheta_002, handles.twotheta_004, handles.system, n);
    plotData(handles);
    guidata(hObject, handles);

set(handles.figure1, 'pointer', 'arrow');
    


%% Convert a decimal comma to a decimal dot
function handles = commatodot(hObject, handles)
if isfield(handles, 'msg'), handles = rmfield(handles, 'msg'); end
    if length(str2num(get(hObject, 'string'))) == 2
        entry = get(hObject, 'string');
            comma_pos = strfind(entry, ',');
            dot_pos   = strfind(entry, '.');
            if ~isempty(dot_pos) && ~isempty(comma_pos)
                handles.msg = msgbox('Please do not insert decimal commas and dots simultaneously.');
                guidata(hObject, handles);
                return
            else
                newentry = sprintf('%s.%s', entry(1:comma_pos-1),  entry(comma_pos+1:end));
                set(hObject, 'string', newentry);
            end
    elseif length(str2num(get(hObject, 'string'))) > 2
        handles.msg = msgbox('Please do not enter characters other than numbers.');
        guidata(hObject, handles);
        return
    elseif isempty(str2num(get(handles.edit_d_materialA, 'string')))
        if isfield(handles, 'msg'), handles = rmfield(handles, 'msg'); end
    end
    guidata(hObject, handles);
    
%% Check if the values entered in edit fields are correct
function handles = checkvalues(hObject, handles)
if isfield(handles, 'msg'), handles = rmfield(handles, 'msg'); end
limits = {'edit_from002', 'edit_from004', 'edit_to002', 'edit_to004'};

for i = 1:4
    if isempty(str2num(get(handles.(sprintf('%s', limits{i})), 'string'))) || ~isreal(str2num(get(handles.(sprintf('%s', limits{i})), 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of 2theta angle!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.(sprintf('%s', limits{i})), 'string')) < 0 || str2num(get(handles.(sprintf('%s', limits{i})), 'string')) == 0
        handles.msg = msgbox('Please specify positive value of 2theta angle!');
        guidata(hObject, handles);
        return
    end
end
    
steps = {'edit_step002', 'edit_step004'};
for j = 1:2
    if isempty(str2num(get(handles.(sprintf('%s', steps{j})), 'string'))) || ~isreal(str2num(get(handles.(sprintf('%s', steps{j})), 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the step!');
        guidata(hObject, handles);
        return
    elseif isempty(str2num(get(handles.(sprintf('%s', steps{j})), 'string'))) < 0
        set(hObject, 'string', abs(str2num(get(hObject, 'string'))));
    end
end

    if str2num(get(handles.edit_from002, 'string')) > str2num(get(handles.edit_to002, 'string')) ||...
       str2num(get(handles.edit_from002, 'string')) == str2num(get(handles.edit_to002, 'string'))
       handles.msg = msgbox('Please specify a value that is smaller than the value "(002) to"');
       guidata(hObject, handles);
       return
    end

    if str2num(get(handles.edit_from004, 'string')) > str2num(get(handles.edit_to004, 'string')) ||...
        str2num(get(handles.edit_from004, 'string')) == str2num(get(handles.edit_to004, 'string'))
        handles.msg = msgbox('Please specify a value that is smaller than the value "(004) to"');
        guidata(hObject, handles);
        return
    end
    
    if str2num(get(handles.edit_to002, 'string')) == 0 ||...
        str2num(get(handles.edit_to002, 'string')) < str2num(get(handles.edit_from002, 'string')) ||...
        str2num(get(handles.edit_to002, 'string')) == str2num(get(handles.edit_from002, 'string'))
        handles.msg = msgbox('Please specify a value that is larger that the value "(002) from"');
        guidata(hObject, handles);
        return
    end
    
    if str2num(get(handles.edit_to004, 'string')) == 0 ||...
        str2num(get(handles.edit_to004, 'string')) < str2num(get(handles.edit_from004, 'string')) ||...
        str2num(get(handles.edit_to004, 'string')) == str2num(get(handles.edit_from004, 'string'))
        handles.msg = msgbox('Please specify a value that is larger than the value "(004) from"');
        guidata(hObject, handles);
        return
    end
    
    if isempty(str2num(get(handles.edit_d_vanadium, 'string'))) || ~isreal(str2num(get(handles.edit_d_vanadium, 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the layer thickness!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_d_vanadium, 'string')) < 0
        set(handles.edit_d_vanadium, 'string', abs(str2num(get(handles.edit_d_vanadium, 'string'))));
    end
    
    if isempty(str2num(get(handles.edit_d_materialA, 'string'))) || ~isreal(str2num(get(handles.edit_d_materialA, 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the layer thickness!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_d_materialA, 'string')) < 0
        set(handles.edit_d_materialA, 'string', abs(str2num(get(handles.edit_d_materialA, 'string'))));
    end
    
    if isempty(str2num(get(handles.edit_d_materialB, 'string'))) || ~isreal(str2num(get(handles.edit_d_materialB, 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the layer thickness!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_d_materialB, 'string')) < 0
        set(handles.edit_d_materialB, 'string', abs(str2num(get(handles.edit_d_materialB, 'string'))));
    end
    
    if isempty(str2num(get(handles.edit_c_vanadium, 'string'))) || ~isreal(str2num(get(handles.edit_c_vanadium, 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the lattice constant!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_c_vanadium, 'string')) < 0
        set(handles.edit_c_vanadium, 'string', abs(str2num(get(handles.edit_c_vanadium, 'string'))));
    end
    
    if isempty(str2num(get(handles.edit_c_materialA, 'string'))) || ~isreal(str2num(get(handles.edit_c_materialA, 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the lattice constant!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_c_materialA, 'string')) < 0
        set(handles.edit_c_materialA, 'string', abs(str2num(get(handles.edit_c_materialA, 'string'))));
    end
    
    if isempty(str2num(get(handles.edit_c_materialB, 'string'))) || ~isreal(str2num(get(handles.edit_c_materialB, 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the lattice constant!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_c_materialB, 'string')) < 0
        set(handles.edit_c_materialB, 'string', abs(str2num(get(handles.edit_c_materialB, 'string'))));
    end
    
    if isempty(str2num(get(handles.edit_NoBilayers, 'string'))) || ~isreal(str2num(get(handles.edit_NoBilayers, 'string')))
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the number of bilayers!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_NoBilayers, 'string')) < 0
        set(handles.edit_NoBilayers, 'string', abs(str2num(get(handles.edit_NoBilayers, 'string'))));
    elseif str2num(get(handles.edit_NoBilayers, 'string')) == 0
        set(handles.edit_NoBilayers, 'string', 1);
        msgbox('Number of bilayers must be equal to at least 1');
    end
    
    if isempty(str2num(get(handles.edit_intermixing, 'string'))) || ~isreal(str2num(get(handles.edit_intermixing, 'string')))
        set(handles.edit_intermixing, 'string', 0);
        handles.msg = msgbox('Please do not enter characters other than numbers. Please specify positive value of the number of unit cells for intemixing!');
        guidata(hObject, handles);
        return
    elseif str2num(get(handles.edit_intermixing, 'string')) < 0
        set(handles.edit_intermixing, 'string', abs(str2num(get(handles.edit_intermixing, 'string'))));
    end
    
    if ~(get(handles.popupmenu_periodicity, 'value') == 1) && ~isfield(handles, 'stack')
        handles.msg = msgbox('Please load the file with the layer arrangement prior to changing the intermixing value.');
        guidata(hObject, handles);
        return
    end
        
guidata(hObject, handles);
