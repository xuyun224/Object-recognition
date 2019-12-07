function varargout = myGUI(varargin)
%MYGUI MATLAB code file for myGUI.fig
%      MYGUI, by itself, creates a new MYGUI or raises the existing
%      singleton*.
%
%      H = MYGUI returns the handle to a new MYGUI or the handle to
%      the existing singleton*.
%
%      MYGUI('Property','Value',...) creates a new MYGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to myGUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      MYGUI('CALLBACK') and MYGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in MYGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help myGUI

% Last Modified by GUIDE v2.5 07-Dec-2019 21:21:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @myGUI_OutputFcn, ...
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


% --- Executes just before myGUI is made visible.
function myGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for myGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes myGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = myGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
axis off  %%关闭坐标轴显示  
[filename pathname] =uigetfile({'*.jpg';'*.bmp';'*.*'},'打开图片');

str=[pathname filename];  
%%打开图像  
im=imread(str);  
%%打开axes1的句柄 进行axes1的操作  
axes(handles.axes1);  
%%在axes1中显示 图像  
imshow(im);  


I=im;   
% I = imresize(I,0.5);
% imwrite(I,'s4-6.jpg');
img_hsv = rgb2hsv(I);
img_new1 = rgb2hsv(255*ones(size(I)));
img_new2 = rgb2hsv(255*ones(size(I)));
img_new3 = rgb2hsv(255*ones(size(I)));
img_new4 = rgb2hsv(255*ones(size(I)));

[row1, col1] = ind2sub(size(img_hsv),find(img_hsv(:,:,1)>0.7 ...
 & img_hsv(:,:,1)< 1 & img_hsv(:,:,2)>0.6 & img_hsv(:,:,2)<1 ...
 & img_hsv(:,:,3)>0.6 & img_hsv(:,:,3)<1));% 红色提取

[row2, col2] = ind2sub(size(img_hsv),find(img_hsv(:,:,1)>0.56 ...
 & img_hsv(:,:,1)< 0.69 & img_hsv(:,:,2)>0.2 & img_hsv(:,:,3)>0.2));% 蓝色提取

[row3, col3] = ind2sub(size(img_hsv),find(img_hsv(:,:,1)>0.05 ...
 & img_hsv(:,:,1)<0.5 & img_hsv(:,:,2)>0.5 & img_hsv(:,:,3)>0.5& img_hsv(:,:,3)<1));% 白色提取

[row4, col4] = ind2sub(size(img_hsv),find( ...
  img_hsv(:,:,1)> 0.6 & img_hsv(:,:,2)>0.2 & img_hsv(:,:,2)<0.65  & ...
  img_hsv(:,:,3)>0.2 & img_hsv(:,:,3)<0.65 ));% 褐色提取

for k = 1 : length(row1)
        img_new1(row1(k),col1(k),:) = img_hsv(row1(k),col1(k),:);
    end

img_c1 = hsv2rgb(img_new1);
% figure;
% imshow(img_c1);


bw1 = im2bw(img_c1);
bw1 = ~bw1;
se = strel('disk',2);
bw1 = imdilate(bw1,se);
% figure,imshow(bw1);



bwfill1 = imfill(bw1,'holes');
% figure,imshow(bwfill1);

bwao1=bwareaopen(bwfill1,6000);
% figure,imshow(bwao1);

bs1=bwboundaries(bwao1); 
% figure,imshow(I);
n1 = size(bs1,1);
% X=sprintf('有%d个桶',n1);
% disp(X);

for i = 1 : length(row2)
    img_new2(row2(i),col2(i),:) = img_hsv(row2(i),col2(i),:);
end

img_c2 = hsv2rgb(img_new2);
% figure;
% imshow(img_c2);


bw2 = im2bw(img_c2);
bw2 = ~bw2;
% figure,imshow(bw2);

bwfill2 = imfill(bw2,'holes');
% figure,imshow(bwfill2);

bwao2=bwareaopen(bwfill2,3000);
% figure,imshow(bwao2);

bs2=bwboundaries(bwao2); 
% figure,imshow(I);
n2 = size(bs2,1);
% Y=sprintf('有%d个抹布',n2);
% disp(Y);

for i = 1 : length(row3)
    img_new3(row3(i),col3(i),:) = img_hsv(row3(i),col3(i),:);
end

img_c3 = hsv2rgb(img_new3);
% figure;
% imshow(img_c3);


bw3 = im2bw(img_c3);
bw3 = ~bw3;
se3 = strel('disk',3);
bw3 = imdilate(bw3,se3);
% figure,imshow(bw3);

bwfill3 = imfill(bw3,'holes');
% figure,imshow(bwfill3);

bwao3=bwareaopen(bwfill3,2000);
% figure,imshow(bwao3);

bs3=bwboundaries(bwao3); 
% figure,imshow(I);
n3 = size(bs3,1);
% Z=sprintf('有%d个喷壶',n3);
% disp(Z);

for i = 1 : length(row4)
    img_new4(row4(i),col4(i),:) = img_hsv(row4(i),col4(i),:);
end

img_c4 = hsv2rgb(img_new4);
% figure;
% imshow(img_c4);


bw4 = im2bw(img_c4);
bw4 = ~bw4;
se2 = strel('disk',4);
bw4 = imdilate(bw4,se2);
% figure,imshow(bw4);

bwfill4 = imfill(bw4,'holes');
% figure,imshow(bwfill4);

bwao4=bwareaopen(bwfill4,10000);
% figure,imshow(bwao4);

bs4=bwboundaries(bwao4); 
figure,imshow(I);
title('识别结果图');
n4 = size(bs4,1);
% 
% fprintf('有%d个横幅\n',n4);


for i=1:size(bs1,1)
    boders=bs1{i};
    x=boders(:,2);
    y=boders(:,1);
    w=max(x)-min(x);
    h=max(y)-min(y);
    hold on;
    if(1)
        rectangle('position',[min(x),min(y),w,h'], 'edgecolor','r');
        text(median(x)-10,min(y)-25,'红桶','FontSize',12,'Color','red')
    end    

end

for i=1:size(bs2,1)
    boders=bs2{i};
    x=boders(:,2);
    y=boders(:,1);
    w=max(x)-min(x);
    h=max(y)-min(y);
    hold on;
    if(1)
        rectangle('position',[min(x),min(y),w,h'], 'edgecolor','b');
        text(median(x)-30,min(y)-25,'抹布','FontSize',12,'Color','blue')
    end    

end

for i=1:size(bs3,1)
    boders=bs3{i};
    x=boders(:,2);
    y=boders(:,1);
    w=max(x)-min(x);
    h=max(y)-min(y);
    hold on;
    if(1)
        rectangle('position',[min(x),min(y),w,h'], 'edgecolor','y');
        text(median(x)-15,min(y)-25,'喷壶','FontSize',12,'Color','yello')
    end    

end

for i=1:size(bs4,1)
    boders=bs4{i};
    x=boders(:,2);
    y=boders(:,1);
    w=max(x)-min(x);
    h=max(y)-min(y);
    hold on;
    if(1)
        rectangle('position',[min(x),min(y),w,h'], 'edgecolor','g');
        text(median(x)-30,min(y)-25,'横幅','FontSize',12,'Color','green')
    end    

end


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

print(1, '-dpng', 'test');
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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
