function varargout = testgui(varargin)
% TESTGUI MATLAB code for testgui.fig
%      TESTGUI, by itself, creates a new TESTGUI or raises the existing
%      singleton*.
%
%      H = TESTGUI returns the handle to a new TESTGUI or the handle to
%      the existing singleton*.
%
%      TESTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTGUI.M with the given input arguments.
%
%      TESTGUI('Property;;0      ','Value',...) creates a new TESTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testgui

% Last Modified by GUIDE v2.5 27-Mar-2019 19:49:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testgui_OpeningFcn, ...
                   'gui_OutputFcn',  @testgui_OutputFcn, ...
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


% --- Executes just before testgui is made visible.
function testgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testgui (see VARARGIN)

% Choose default command line output for testgui
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'Type','axes'),'XTick',[],'YTick',[]);
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rgb rgb1 inp;
[FileName, PathName] = uigetfile({'*.*','*.bmp,*.jpg'},'Select a image file');
inp=[PathName FileName];
rgb=imread(inp);
rgb=im2double(rgb);
rgb1=rgb;
axes(handles.axes3);
imshow(rgb);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global res
[sz1,sz2]=size(res);
[FileName1, PathName1] = uigetfile({'*.*','*.bmp,*.jpg'},'Select a image file');
inp1=[PathName1 FileName1];
trs=imread(inp1);
ts1=im2bw(trs);
ts=imresize(ts1,[sz1,sz2]);
[OverlapImage,DiceCoef] = DiceSimilarity2DImage(res, ts);
[jaccardIdx,jaccardDist2] = jaccard_coefficient(res,ts);
Aj=round(jaccardDist2*100);
msgbox(sprintf('Accuracy of DiceSimalarity %d',DiceCoef));
msgbox(sprintf('Accuracy of Jaccard_coefficient percentage is %d',Aj));


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rgb rgb1 m n;
rgb1=double(rgb2gray(rgb));
[m,n]=size(rgb1);
axes(handles.axes4);
imshow(rgb1);

function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gb rgb1;
gb = imgaussfilt(rgb1,0.3);
axes(handles.axes5);
imshow(gb);

function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global re gb rgb1 m n;
max1=max(max(gb));
max2=max1-0.3;
loc=find(gb<max2);
re=zeros(m,n);
re(loc)=rgb1(loc);
axes(handles.axes6);
imshow(re);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global re lg;
lg=edge(re,'canny');
axes(handles.axes7);
imshow(lg);

function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lg fh;
bw=bwmorph(lg,'bridge',inf);
fh=imfill(bw,'holes');
axes(handles.axes8);
imshow(fh);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fh frs re m n inp res;
bw1=bwmorph(fh,'close',inf);
rn=bwareaopen(bw1,1000);
% figure,imshow(rn);
dif=fh-rn;
% figure,imshow(dif);
rn1=bwareaopen(dif,150);
imd=bwmorph(rn1,'open');
im2 = imdilate(imd, strel('disk',5));
% figure,imshow(rn1);
loc1=find(rn1==1);
re(loc1)=0;
%  figure,imshow(re);
imd1=bwmorph(re,'erode',5);
 res=bwareaopen(imd1,300);
% figure,imshow(res);
f=imread(inp);
 redChannel = zeros(m, n, 'uint8');
  greenChannel = zeros(m, n, 'uint8');
  blueChannel = zeros(m, n, 'uint8');
   frs = cat(3, redChannel, greenChannel, blueChannel);
 [I1,J1]=find(res~=0);
for jj=1:length(J1)
      frs(I1(jj),J1(jj),1)=f(I1(jj),J1(jj),1);
 frs(I1(jj),J1(jj),2)=f(I1(jj),J1(jj),2);
  frs(I1(jj),J1(jj),3)=f(I1(jj),J1(jj),3);
end
axes(handles.axes9);
imshow(frs);
