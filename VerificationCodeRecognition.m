function varargout = VerificationCodeRecognition(varargin)
% VERIFICATIONCODERECOGNITION MATLAB code for VerificationCodeRecognition.fig
%      VERIFICATIONCODERECOGNITION, by itself, creates a new VERIFICATIONCODERECOGNITION or raises the existing
%      singleton*.
%
%      H = VERIFICATIONCODERECOGNITION returns the handle to a new VERIFICATIONCODERECOGNITION or the handle to
%      the existing singleton*.
%
%      VERIFICATIONCODERECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VERIFICATIONCODERECOGNITION.M with the given input arguments.
%
%      VERIFICATIONCODERECOGNITION('Property','Value',...) creates a new VERIFICATIONCODERECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VerificationCodeRecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VerificationCodeRecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VerificationCodeRecognition

% Last Modified by GUIDE v2.5 17-May-2018 21:44:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VerificationCodeRecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @VerificationCodeRecognition_OutputFcn, ...
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


% --- Executes just before VerificationCodeRecognition is made visible.
function VerificationCodeRecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VerificationCodeRecognition (see VARARGIN)

% Choose default command line output for VerificationCodeRecognition
handles.output = hObject;
set(handles.show,'visible','off')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VerificationCodeRecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VerificationCodeRecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in testdata.
function testdata_Callback(hObject, eventdata, handles)
% hObject    handle to testdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenames
global filefolder
global imgfloder
global A
global B

A= get(handles.testdata,'string');
B= get(handles.testdata,'value');
imgfloder=[filefolder,'\',A{B,1}];
axes(handles.show);
imshow(imgfloder);
% Hints: contents = cellstr(get(hObject,'String')) returns testdata contents as cell array
%        contents{get(hObject,'Value')} returns selected item from testdata


% --- Executes during object creation, after setting all properties.
function testdata_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function predict_text_Callback(hObject, eventdata, handles)
% hObject    handle to predict_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of predict_text as text
%        str2double(get(hObject,'String')) returns contents of predict_text as a double


% --- Executes during object creation, after setting all properties.
function predict_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to predict_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in recognize.
function recognize_Callback(hObject, eventdata, handles)
% hObject    handle to recognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgfloder
global pre_text
global A
global B
global correct
global Correct
global number
global record_show

image=imread(imgfloder);
pre_text=TestFile(image);
set(handles.predict_text,'String',pre_text);

%计算正确率
c=0;
for i=1:length(pre_text)
    if A{B,1}(i)==pre_text(i)
        c=c+1;
    end
end

number=number+1;

correct=[num2str(double(c/length(pre_text)*100)),'%'];
Correct(number,1)=double(c/length(pre_text));
set(handles.edit2,'String',correct);

%在记录表中记录
record=[A{B,1},'/',pre_text,'/',num2str(correct)];

record_show{number,1}=record;
set(handles.record,'string',record_show);


% --- Executes on button press in delet.
function delet_Callback(hObject, eventdata, handles)
% hObject    handle to delet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global number
global record_show
global filenames

number=0;
record_show=cell(length(filenames),1);
set(handles.average,'string',0)
set(handles.record,'string',record_show);

% --- Executes on selection change in record.
function record_Callback(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% Hints: contents = cellstr(get(hObject,'String')) returns record contents as cell array
%        contents{get(hObject,'Value')} returns selected item from record


% --- Executes during object creation, after setting all properties.
function record_CreateFcn(hObject, eventdata, handles)
% hObject    handle to record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in error.
function error_Callback(hObject, eventdata, handles)
% hObject    handle to error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Tools_Callback(hObject, eventdata, handles)
% hObject    handle to Tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(VerificationCodeRecognition);

% --------------------------------------------------------------------
function image4_Callback(hObject, eventdata, handles)
% hObject    handle to image4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenames
global filefolder
global number
global record_show

%初始化number
number=0;

filefolder=fullfile('.\test_image4');
diroutput=dir(fullfile(filefolder,'*.bmp'));
filenames={diroutput.name};

record_show=cell(length(filenames),1);

set(handles.testdata,'String', filenames);


% --------------------------------------------------------------------
function imge6_Callback(hObject, eventdata, handles)
% hObject    handle to imge6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filenames
global filefolder
global number
global record_show

%初始化number
number=0;

filefolder=fullfile('.\test_image6');
diroutput=dir(fullfile(filefolder,'*.bmp'));
filenames={diroutput.name};

record_show=cell(length(filenames),1);

set(handles.testdata,'String', filenames);


% --- Executes during object creation, after setting all properties.
function show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: place code in OpeningFcn to populate show


% --- Executes on mouse press over axes background.
function show_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function average_Callback(hObject, eventdata, handles)
% hObject    handle to average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of average as text
%        str2double(get(hObject,'String')) returns contents of average as a double


% --- Executes during object creation, after setting all properties.
function average_CreateFcn(hObject, eventdata, handles)
% hObject    handle to average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Correct
average=[num2str((mean(Correct)*100)),'%'];
set(handles.average,'string',average);



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
