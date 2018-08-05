% References used for this program :
% https://in.mathworks.com/help/matlab/ref/audioplayer.html
% http://matlab.izmiran.ru/help/techdoc/ref/audioplayer.html



function varargout = myscript(varargin)
% myscript MATLAB code for myscript.fig
%      myscript, by itself, creates a new myscript or raises the existing
%      singleton*.
%
%      H = myscript returns the handle to a new myscript or the handle to
%      the existing singleton*.
%
%      myscript('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in myscript.M with the given input arguments.
%
%      myscript('Property','Value',...) creates a new myscript or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before myscript_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myscript_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 05-June-2018 20:40:57   monsijb

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myscript_OpeningFcn, ...
                   'gui_OutputFcn',  @myscript_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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



function myscript_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)


handles.output = hObject;
[filename pathname] = uigetfile({'*.wav'},'File Selector')
[sample_data, sample_freq] = audioread(filename);


%audioplayer(Y, Fs) creates an audioplayer object for signal Y, using
%    sample rate Fs.  A handle to the object is returned.
handles.player = audioplayer(sample_data, sample_freq);
handles.next_position = -1;
handles.length = length(sample_data);


% Update handles structure
guidata(hObject, handles);


function varargout = myscript_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function slider_for_audio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_for_audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[1.1 1.2 1.3]);
end



function slider_for_audio_Callback(hObject, eventdata, handles)
% hObject    handle to slider_for_audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


in_player = get(handles.player);
curr_pos = in_player.TotalSamples * get(hObject, 'Value');

if strcmp(get(handles.player, 'Running'), 'on')
    stop(handles.player);
    play(handles.player, round(curr_pos));
else
    handles.next_position = round(curr_pos);
    guidata(hObject, handles);
end


function play_button_Callback(hObject, eventdata, handles)
% hObject    handle to play_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(get(handles.player, 'Running'), 'off')
    if handles.next_position >= 0
        play(handles.player, handles.next_position);

        handles.next_position = -1;
        guidata(hObject, handles);
    else
        resume(handles.player);
    end

    while strcmp(get(handles.player, 'Running'), 'on')
        in_player = get(handles.player);
        curr_pos = in_player.CurrentSample / in_player.TotalSamples;
        set(handles.slider_for_audio, 'Value', curr_pos);

        pause(1.5);
    end
end


if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[1.1 1.2 1.3]);
end

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Auxiliary Functions


function edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function pause_button_Callback(hObject, eventdata, handles)
% hObject    handle to pause_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(get(handles.player, 'Running'), 'on')
    pause(handles.player);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
