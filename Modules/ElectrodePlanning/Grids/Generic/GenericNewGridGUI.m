function varargout = GenericNewGridGUI(varargin)
%added by Hongsun
global g_strctModule
% GENERICCIRCULARGIRDGUI M-file for GenericCircularGirdGUI.fig
%      GENERICCIRCULARGIRDGUI, by itself, creates a new GENERICCIRCULARGIRDGUI or raises the existing
%      singleton*.
%
%      H = GENERICCIRCULARGIRDGUI returns the handle to a new GENERICCIRCULARGIRDGUI or the handle to
%      the existing singleton*.
%
%      GENERICCIRCULARGIRDGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERICCIRCULARGIRDGUI.M with the given input arguments.
%
%      GENERICCIRCULARGIRDGUI('Property','Value',...) creates a new GENERICCIRCULARGIRDGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GenericCircularGirdGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GenericCircularGirdGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GenericCircularGirdGUI

% Last Modified by GUIDE v2.5 07-Dec-2022 19:35:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GenericNewGridGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GenericNewGridGUI_OutputFcn, ...
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


% --- Executes just before GenericCircularGirdGUI is made visible.
function GenericNewGridGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GenericCircularGirdGUI (see VARARGIN)

% Choose default command line output for GenericCircularGirdGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

setappdata(handles.figure1,'bMouseDown',false);
if length(varargin) >= 1
    strCommand = varargin{1};
    switch strCommand
        case 'InitNewGrid'
            strctPlannerInfo = varargin{2};
            strctGridModel = varargin{3};
            strctGridFunc = varargin{4};
            strctGridName = varargin{5};

            set(handles.hRotationSlider,'min',-180,'max',180,'value',0);
            set(handles.hTiltSlider,'min',0,'max',45,'value',0);
            set(handles.hTranslationXSlider,'min',-30,'max',30,'value',0);
            set(handles.hTranslationYSlider,'min',-30,'max',30,'value',0);
                        
            set(handles.hGridHoleGroups,'String',strctGridModel.m_strctGridParams.m_acGroupNames,...
                'value',1);
            setappdata(handles.figure1,'strctGridName',strctGridName);
            setappdata(handles.figure1,'strctPlannerInfo',strctPlannerInfo);
            setappdata(handles.figure1,'strctGridModel',strctGridModel);
            setappdata(handles.figure1,'strctGridFunc',strctGridFunc);
            
%             %added by Hongsun
%             set(handles.hInnerDiameterEdit, 'string', ...
%                 num2str(strctGridModel.m_strctGridParams.m_fGridInnerDiameterMM));
    end
end
set(handles.figure1,'visible','on');

if get(handles.hPlaceElectrodes,'value')
    setappdata(handles.figure1,'strMouseMode','PlaceElectrodes'); 
else
    setappdata(handles.figure1,'strMouseMode','SelectHoles'); 
end
          
fnInvalidate(handles);
if ishandle(handles.figure1)
    set(handles.figure1,'WindowButtonMotionFcn',{@fnMouseMove,handles});
    set(handles.figure1,'WindowButtonDownFcn',{@fnMouseDown,handles});
    set(handles.figure1,'WindowButtonUpFcn',{@fnMouseUp,handles});
    set(handles.figure1,'KeyPressFcn',@fnKeyDown);
    set(handles.figure1,'KeyReleaseFcn',@fnKeyUp);
    guidata(hObject, handles);
end


function fnKeyDown(a,b)
if ~isempty(b) && strcmp(b.Key,'control')
    setappdata(a,'bControlDown',true);
end

function fnKeyUp(a,b)
if ~isempty(b) && strcmp(b.Key,'control')
    setappdata(a,'bControlDown',false);
end

function fnInvalidate(handles)
strctPlannerInfo = getappdata(handles.figure1,'strctPlannerInfo');
strctGridModel= getappdata(handles.figure1,'strctGridModel');
strctGridFunc = getappdata(handles.figure1,'strctGridFunc');
aiSelectedHoles = getappdata(handles.figure1,'aiSelectedHoles');
iActiveGroup = get(handles.hGridHoleGroups,'value');

strctDisplayParam.m_aiSelectedHoles = aiSelectedHoles;
strctDisplayParam.m_aiHighlightedGroups = iActiveGroup;
strctDisplayParam.m_bDisplayHoleDirection = get(handles.hDisplayHoleDirection,'value')>0;
feval(strctGridFunc.m_strDraw2D, strctGridModel, handles.axes1, strctDisplayParam);
% Update controllers
iHoleInGroup = find(strctGridModel.m_strctGridParams.m_aiGroupAssignment == iActiveGroup,1,'first');
fRotationDeg = strctGridModel.m_afGridHoleRotationDeg(iHoleInGroup);
fTiltDeg = strctGridModel.m_afGridHoleTiltDeg(iHoleInGroup);
fXMM = strctGridModel.m_strctGridParams.m_afGroupXMM(iActiveGroup);
fYMM = strctGridModel.m_strctGridParams.m_afGroupYMM(iActiveGroup);
set(handles.hRotationSlider, 'value', fRotationDeg);
set(handles.hRotationEdit, 'string', sprintf('%.2f',fRotationDeg));
set(handles.hTiltSlider, 'value', fTiltDeg);
set(handles.hTiltEdit, 'string', sprintf('%.2f',fTiltDeg));
set(handles.hTranslationXSlider, 'value', fXMM);
set(handles.hTranslationXEdit, 'string', sprintf('%.1f',fXMM));
set(handles.hTranslationYSlider, 'value', fYMM);
set(handles.hTranslationYEdit, 'string', sprintf('%.1f',fYMM));


% --- Outputs from this function are returned to the command line.
function varargout = GenericNewGridGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in hSplit.

% --- Executes on selection change in hGridHoleGroups.
function hGridHoleGroups_Callback(hObject, eventdata, handles)
fnInvalidate(handles);

% --- Executes during object creation, after setting all properties.
function hGridHoleGroups_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hGridHoleGroups (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hDeleteHoles_Callback(hObject, eventdata, handles)
aiSelectedHoles = getappdata(handles.figure1,'aiSelectedHoles');
strctGridModel = getappdata(handles.figure1,'strctGridModel');
if isempty(aiSelectedHoles)
    return;
end
strctGridModel = fnDeleteHoles(strctGridModel, aiSelectedHoles);
setappdata(handles.figure1,'aiSelectedHoles',[]);
fnUpdateGridModel(handles,strctGridModel);

% --- Executes on button press in hAddHolesToGroup.
% function hAddHolesToGroup_Callback(hObject, eventdata, handles)
% iActiveGroup = get(handles.hGridHoleGroups,'value');
% aiSelectedHoles = getappdata(handles.figure1,'aiSelectedHoles');
% strctGridModel = getappdata(handles.figure1,'strctGridModel');
% if isempty(aiSelectedHoles)
%     return;
% end
% 
% iHoleInGroup = find(strctGridModel.m_strctGridParams.m_aiGroupAssignment == iActiveGroup,1,'first');
% if ~isempty(iHoleInGroup)
%     strctGridModel.m_afGridHoleRotationDeg(aiSelectedHoles) = strctGridModel.m_afGridHoleRotationDeg(iHoleInGroup);
%     strctGridModel.m_afGridHoleTiltDeg(aiSelectedHoles) = strctGridModel.m_afGridHoleTiltDeg(iHoleInGroup);
% end
% strctGridModel.m_strctGridParams.m_aiGroupAssignment(aiSelectedHoles) = iActiveGroup;
% strctGridModel = fnBuildGridModelNew(strctGridModel.m_strctGridParams);
% 
% setappdata(handles.figure1,'aiSelectedHoles',[]);
% fnUpdateGridModel(handles,strctGridModel);
     
function fnModifyActiveGroupRotation(handles, fNewRotationAngle)
iActiveGroup = get(handles.hGridHoleGroups,'value');
strctGridModel = getappdata(handles.figure1,'strctGridModel');
% aiRelevantHoles =  find(strctGridModel.m_strctGridParams.m_aiGroupAssignment == iActiveGroup);
strctGridModel.m_strctGridParams.m_afGroupRotationDeg(iActiveGroup) = fNewRotationAngle;
strctGridModel = fnBuildGridModelNew(strctGridModel.m_strctGridParams);
fnUpdateGridModel(handles,strctGridModel);

% --- Executes on slider movement.
function hRotationSlider_Callback(hObject, eventdata, handles)
fNewRotationAngle = get(hObject,'value');
fnModifyActiveGroupRotation(handles, fNewRotationAngle);     
fnInvalidate(handles);

% --- Executes during object creation, after setting all properties.
function hRotationSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hRotationSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function fnModifyActiveGroupTilt(handles, fNewTiltAngle)
iActiveGroup = get(handles.hGridHoleGroups,'value');
strctGridModel = getappdata(handles.figure1,'strctGridModel');
aiRelevantHoles =  find(strctGridModel.m_strctGridParams.m_aiGroupAssignment == iActiveGroup);
iNumRelevantHoles = length(aiRelevantHoles);
fCurrentTiltAngle = strctGridModel.m_strctGridParams.m_afGroupTiltDeg(iActiveGroup);
bAutoShift = get(handles.hAutoShiftPosWhenTilt,'value')>0;
if bAutoShift
    fCurrentDistanceMM = 1/cos(fCurrentTiltAngle/180*pi);
    fNewDistanceMM = 1/cos(fNewTiltAngle/180*pi);
    fRatio = fNewDistanceMM./fCurrentDistanceMM;
    strctGridModel.m_strctGridParams.m_afGridHoleXMM(aiRelevantHoles) = ...
        strctGridModel.m_strctGridParams.m_afGridHoleXMM(aiRelevantHoles).*fRatio;
    strctGridModel.m_strctGridParams.m_afGridHoleYMM(aiRelevantHoles) = ...
        strctGridModel.m_strctGridParams.m_afGridHoleYMM(aiRelevantHoles).*fRatio;
end
strctGridModel.m_strctGridParams.m_afGroupTiltDeg(iActiveGroup) = fNewTiltAngle;
strctGridModel = fnBuildGridModelNew(strctGridModel.m_strctGridParams);
fnUpdateGridModel(handles, strctGridModel);


% --- Executes on slider movement.
function hTiltSlider_Callback(hObject, eventdata, handles)
fNewTiltAngle = get(hObject,'value');
fnModifyActiveGroupTilt(handles, fNewTiltAngle);
return;


% --- Executes during object creation, after setting all properties.
function hTiltSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hTiltSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in hDisplayHoleDirection.
function hDisplayHoleDirection_Callback(hObject, eventdata, handles)
fnInvalidate(handles);

function fnMouseUp(obj,eventdata,handles)
strMouseMode = getappdata(handles.figure1,'strMouseMode');
setappdata(handles.figure1,'bMouseDown',false);

switch strMouseMode
    case 'SelectHoles'
        hContourObject = getappdata(handles.figure1,'hContourObject');
        if ~ishandle(hContourObject)
            setappdata(handles.figure1,'hContourObject',[]);
            return;
        end
        afX = get(hContourObject,'xdata');
        afY = get(hContourObject,'ydata');
        bControlDown = getappdata(handles.figure1, 'bControlDown');
        fnSelectHoles(handles, [afX;afY], bControlDown);
        if ishandle(hContourObject)
            delete(hContourObject);
        end
        setappdata(handles.figure1,'hContourObject',hContourObject);
end

function fnSelectHoles(handles, apt2fPolygon, bAddToExistingSelection)
aiSelectedHoles = getappdata(handles.figure1,'aiSelectedHoles');
strctGridModel = getappdata(handles.figure1,'strctGridModel');
if isempty(apt2fPolygon)
    aiSelectedHoles = [];
else
    abInside = fnInsidePolygon([strctGridModel.m_afGridHolesX(:),strctGridModel.m_afGridHolesY(:)],apt2fPolygon');
    if bAddToExistingSelection
        aiSelectedHoles = unique([aiSelectedHoles;  find(abInside)]);
    else
        aiSelectedHoles =  find(abInside);
    end
end

setappdata(handles.figure1,'aiSelectedHoles',aiSelectedHoles);
fnInvalidate(handles);
return;


function fnMouseMove(obj,eventdata,handles)
strMouseMode = getappdata(handles.figure1,'strMouseMode');
bMouseDown = getappdata(handles.figure1,'bMouseDown');
switch strMouseMode
    case 'SelectHoles'
        if bMouseDown
            pt2fMousePosition = fnGetMouseCoordinate(handles.axes1);
%             if ~all(abs(pt2fMousePosition) < 10)
%                 return;
%             end
            hContourObject = getappdata(handles.figure1,'hContourObject');
            if ~isempty(hContourObject) && ishandle(hContourObject)
                afX = get(hContourObject,'xdata');
                afY = get(hContourObject,'ydata');
                set(hContourObject,'xdata',[ afX, pt2fMousePosition(1)],...
                    'ydata', [afY, pt2fMousePosition(2)]);
            else
                % How can this happen? It should have been
                % initialized when user clicked.
                hContourObject = plot(handles.axes1,pt2fMousePosition(1),pt2fMousePosition(2),'r','LineWidth',2);
                setappdata(handles.figure1,'hContourObject',hContourObject);
                
            end
        end
end



function fnMouseDown(obj,eventdata,handles)
setappdata(handles.figure1,'bMouseDown',true);
strMouseClick = fnGetClickType(handles.figure1);
strMouseMode = getappdata(handles.figure1,'strMouseMode');
switch strMouseMode
    case 'PlaceElectrodes'
        pt2fMouseDownPosition = fnGetMouseCoordinate(handles.axes1);
        % Find closest hole...
             strctGridModel = getappdata(handles.figure1,'strctGridModel');
        [fMinDistMM, iHoleIndex]=min(sqrt((strctGridModel.m_afGridHolesX - pt2fMouseDownPosition(1)).^2+...
        (strctGridModel.m_afGridHolesY - pt2fMouseDownPosition(2)).^2));
        if (fMinDistMM < strctGridModel.m_strctGridParams.m_fGridHoleDiameterMM/2)
            if strcmp(strMouseClick,'Left')
                % Place / Remove
                strctGridModel.m_strctGridParams.m_abSelectedHoles(iHoleIndex) = ~strctGridModel.m_strctGridParams.m_abSelectedHoles(iHoleIndex);
                fnUpdateGridModel(handles,strctGridModel);
            else
                strctGridModel.m_strctGridParams.m_abSelectedHoles(iHoleIndex) = true;
                fnUpdateGridModel(handles,strctGridModel);
                % Align to grid hole
                strctPlannerInfo = getappdata(handles.figure1,'strctPlannerInfo');
                feval(strctPlannerInfo.m_strCallback,'AlignToGridHole',iHoleIndex);
            end
        end
    case 'SelectHoles'
        pt2fMouseDownPosition = fnGetMouseCoordinate(handles.axes1);
        if ~all(abs(pt2fMouseDownPosition) < 10)
            return
        end            
        hContourObject = getappdata(handles.figure1,'hContourObject');
        if ~isempty(hContourObject) && ishandle(hContourObject)
            delete(hContourObject);
        end
        hContourObject = plot(handles.axes1,pt2fMouseDownPosition(1),pt2fMouseDownPosition(2),'r','LineWidth',2);
        setappdata(handles.figure1,'hContourObject',hContourObject);
end


function pt2fMouseDownPosition = fnGetMouseCoordinate(hAxes)
pt2fMouseDownPosition = get(hAxes,'CurrentPoint');
if size(pt2fMouseDownPosition,2) ~= 3
    pt2fMouseDownPosition = [-1 -1];
else
    pt2fMouseDownPosition = [pt2fMouseDownPosition(1,1), pt2fMouseDownPosition(1,2)];
end



% --- Executes on button press in hAddGroup.
function hAddGroup_Callback(hObject, eventdata, handles)
% hObject    handle to hAddGroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iNumGroups = length(strctGridModel.m_strctGridParams.m_acGroupNames);
iNewGroupIndex = iNumGroups+1;
a2fColors = lines(iNewGroupIndex);
afNextColor = a2fColors(end,:);
strctHoleGroup = fnDefaultHoleGroup();
iNumHoles = length(strctHoleGroup.a2fXc);

strctGridModel.m_strctGridParams.m_a2fGroupColor = ...
    [strctGridModel.m_strctGridParams.m_a2fGroupColor, afNextColor'];
strctGridModel.m_strctGridParams.m_acGroupNames = [strctGridModel.m_strctGridParams.m_acGroupNames ...
    sprintf('%d',iNewGroupIndex)];
strctGridModel.m_strctGridParams.m_aiGroupAssignment = [strctGridModel.m_strctGridParams.m_aiGroupAssignment ...
    repmat(iNewGroupIndex, 1, iNumHoles)];
strctGridModel.m_strctGridParams.m_afGridHoleXMM = [strctGridModel.m_strctGridParams.m_afGridHoleXMM ...
    strctHoleGroup.a2fXc];
strctGridModel.m_strctGridParams.m_afGridHoleYMM = [strctGridModel.m_strctGridParams.m_afGridHoleYMM ...
    strctHoleGroup.a2fYc];
strctGridModel.m_strctGridParams.m_afGroupRotationDeg(iNewGroupIndex) = 0;
strctGridModel.m_strctGridParams.m_afGroupTiltDeg(iNewGroupIndex) = 0;
strctGridModel.m_strctGridParams.m_afGroupXMM(iNewGroupIndex) = 0;
strctGridModel.m_strctGridParams.m_afGroupYMM(iNewGroupIndex) = 0;

setappdata(handles.figure1,'aiSelectedHoles',[]);
fnUpdateGridModel(handles,strctGridModel);
set(handles.hGridHoleGroups,'String',strctGridModel.m_strctGridParams.m_acGroupNames,'value',iNewGroupIndex);


% --- Executes on button press in hDeleteGroup.
function hDeleteGroup_Callback(hObject, eventdata, handles)
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
if iActiveGroup == 0
    return;
end
aiSelectedHoles = find(strctGridModel.m_strctGridParams.m_aiGroupAssignment == iActiveGroup);
% We need to re-order the groups assignments....

strctGridModel.m_strctGridParams.m_aiGroupAssignment(strctGridModel.m_strctGridParams.m_aiGroupAssignment>iActiveGroup) = ...
    strctGridModel.m_strctGridParams.m_aiGroupAssignment(strctGridModel.m_strctGridParams.m_aiGroupAssignment>iActiveGroup) - 1;
strctGridModel.m_strctGridParams.m_a2fGroupColor(:,iActiveGroup) = [];
strctGridModel.m_strctGridParams.m_acGroupNames(iActiveGroup) = [];
strctGridModel.m_strctGridParams.m_afGroupRotationDeg(iActiveGroup) = [];
strctGridModel.m_strctGridParams.m_afGroupTiltDeg(iActiveGroup) = [];
strctGridModel.m_strctGridParams.m_afGroupXMM(iActiveGroup) = [];
strctGridModel.m_strctGridParams.m_afGroupYMM(iActiveGroup) = [];
if ~isempty(aiSelectedHoles)
    strctGridModel = fnDeleteHoles(strctGridModel, aiSelectedHoles);
end
    
setappdata(handles.figure1,'aiSelectedHoles',[]);
fnUpdateGridModel(handles,strctGridModel);
set(handles.hGridHoleGroups,'String',strctGridModel.m_strctGridParams.m_acGroupNames,'value',length(strctGridModel.m_strctGridParams.m_acGroupNames));
       

function strctGridModel = fnDeleteHoles(strctGridModel, aiSelectedHoles)
strctGridModel.m_strctGridParams.m_afGridHoleXMM(aiSelectedHoles) = [];
strctGridModel.m_strctGridParams.m_afGridHoleYMM(aiSelectedHoles) = [];
strctGridModel.m_strctGridParams.m_aiGroupAssignment(aiSelectedHoles) = [];
% strctGridModel.m_afGridHoleRotationDeg(aiSelectedHoles) = [];
% strctGridModel.m_afGridHoleTiltDeg(aiSelectedHoles) = [];
strctGridModel.m_strctGridParams.m_abSelectedHoles(aiSelectedHoles) = [];
strctGridModel = fnBuildGridModelNew(strctGridModel.m_strctGridParams);
     


% --- Executes on button press in hDeleteInvalid.
function hDeleteInvalid_Callback(hObject, eventdata, handles)
strctGridModel = getappdata(handles.figure1,'strctGridModel');
aiSelectedHoles = find(strctGridModel.m_abIntersect);
if isempty(aiSelectedHoles)
    return;
end
strctGridModel = fnDeleteHoles(strctGridModel, aiSelectedHoles);
setappdata(handles.figure1,'aiSelectedHoles',[]);
fnUpdateGridModel(handles,strctGridModel);



function hAddHole_Callback(hObject, eventdata, handles)
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
if iActiveGroup == 0
    return;
end
iNumHoles = length(strctGridModel.m_strctGridParams.m_afGridHoleXMM);
iNewIndex = iNumHoles+1;
acCoord = inputdlg({'X:', 'Y:'}, 'Enter the XY-coordinate of the new hole');
fX = round(str2double(acCoord{1}));
fY = round(str2double(acCoord{2}));
if get(handles.hAutoShiftPosWhenTilt,'value')>0
    fCurrentTiltAngle = strctGridModel.m_strctGridParams.m_afGroupTiltDeg(iActiveGroup);
    fCurrentDistanceMM = 1/cos(fCurrentTiltAngle/180*pi);
    fX = fX.*fCurrentDistanceMM;
    fY = fY.*fCurrentDistanceMM;
end
strctGridModel.m_strctGridParams.m_aiGroupAssignment(iNewIndex) = iActiveGroup;
strctGridModel.m_strctGridParams.m_afGridHoleXMM(iNewIndex) = fX;
strctGridModel.m_strctGridParams.m_afGridHoleYMM(iNewIndex) = fY;

strctGridModel = fnBuildGridModelNew(strctGridModel.m_strctGridParams);
set(handles.hGridHoleGroups,'String',strctGridModel.m_strctGridParams.m_acGroupNames,'value',length(strctGridModel.m_strctGridParams.m_acGroupNames));
setappdata(handles.figure1,'aiSelectedHoles',[]);
fnUpdateGridModel(handles,strctGridModel);



% --- Executes on button press in hRenameGroup.
function hRenameGroup_Callback(hObject, eventdata, handles)
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
if iActiveGroup == 0
    return;
end
prompt={'Enter group name:'};
name='Name';
numlines=1;
defaultanswer={strctGridModel.m_strctGridParams.m_acGroupNames{iActiveGroup}};
answer=inputdlg(prompt,name,numlines,defaultanswer);
if ~isempty(answer)
    strctGridModel.m_strctGridParams.m_acGroupNames{iActiveGroup} = answer{1};
    fnUpdateGridModel(handles,strctGridModel);
    set(handles.hGridHoleGroups,'String',strctGridModel.m_strctGridParams.m_acGroupNames);
end
 return;

function hChangeGroupColor_Callback(hObject, eventdata, handles)
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
if iActiveGroup == 0
    return;
end
strctGridModel.m_strctGridParams.m_a2fGroupColor(:,iActiveGroup) = ...
    uisetcolor(strctGridModel.m_strctGridParams.m_a2fGroupColor(:,iActiveGroup));
fnUpdateGridModel(handles,strctGridModel);



function fnUpdateGridModel(handles,strctGridModel)
strctGridModel = fnBuildGridModelNew(strctGridModel.m_strctGridParams);
setappdata(handles.figure1,'strctGridModel',strctGridModel);
strctPlannerInfo = getappdata(handles.figure1,'strctPlannerInfo');
feval(strctPlannerInfo.m_strCallback,'UpdateGridModel',strctGridModel);
fnInvalidate(handles);
return;



function hRotationEdit_Callback(hObject, eventdata, handles)
fNewRotationAngle=str2num(get(handles.hRotationEdit,'string'));
if isempty(fNewRotationAngle)
    return;
end

fNewRotationAngle = mod(fNewRotationAngle + 180,360) - 180;

if (fNewRotationAngle >= -180 && fNewRotationAngle <= 180)
    fnModifyActiveGroupRotation(handles, fNewRotationAngle);
    set(handles.hRotationSlider,'value',fNewRotationAngle);
end
return;


function hTiltEdit_Callback(hObject, eventdata, handles)
fNewTiltAngle=str2num(get(handles.hTiltEdit,'string'));
if isempty(fNewTiltAngle)
    return;
end
if (fNewTiltAngle >= 0 && fNewTiltAngle <= 90)
    fnModifyActiveGroupTilt(handles, fNewTiltAngle);
    set(handles.hTiltSlider,'value',fNewTiltAngle);
end



% --- Executes during object creation, after setting all properties.
function hTranslationXSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hTranslationXSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function hTranslationYSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hTranslationYSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function hTranslationXSlider_Callback(hObject, eventdata, handles)
fShiftX = get(hObject,'value');
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
strctGridModel.m_strctGridParams.m_afGroupXMM(iActiveGroup) = fShiftX;
fnUpdateGridModel(handles,strctGridModel);
set(handles.hTranslationXEdit,'string',sprintf('%.1f',fShiftX));


function hTranslationXEdit_Callback(hObject, eventdata, handles)
fShiftX = str2double(get(handles.hTranslationXEdit,'string'));
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
strctGridModel.m_strctGridParams.m_afGroupXMM(iActiveGroup) = fShiftX;
fnUpdateGridModel(handles,strctGridModel);
set(handles.hTranslationXSlider,'value',fShiftX);


% --- Executes on slider movement.
function hTranslationYSlider_Callback(hObject, eventdata, handles)
fShiftY = get(hObject,'value');
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
strctGridModel.m_strctGridParams.m_afGroupYMM(iActiveGroup) = fShiftY;
fnUpdateGridModel(handles,strctGridModel);
set(handles.hTranslationYEdit,'string',sprintf('%.1f',fShiftY));


function hTranslationYEdit_Callback(hObject, eventdata, handles)
fShiftY = str2double(get(handles.hTranslationYEdit,'string'));
strctGridModel = getappdata(handles.figure1,'strctGridModel');
iActiveGroup = get(handles.hGridHoleGroups,'value');
strctGridModel.m_strctGridParams.m_afGroupYMM(iActiveGroup) = fShiftY;
fnUpdateGridModel(handles,strctGridModel);
set(handles.hTranslationYSlider,'value',fShiftY);


function hExportGrid_Callback(hObject, eventdata, handles)
%added by Hongsun
global g_strctModule

acVersions = {'Software\Solidworks\SolidWorks 2010',...
    'Software\Solidworks\SolidWorks 2011',...
    'Software\Solidworks\SolidWorks 2012',...
    'Software\Solidworks\SolidWorks 2013',...
    'Software\Solidworks\SolidWorks 2014',...
    'Software\Solidworks\SolidWorks 2015',...
    'Software\Solidworks\SolidWorks 2016',...
    'Software\Solidworks\SolidWorks 2017',... 
    'Software\Solidworks\SolidWorks 2019'}; % SolidWorks 2019, added by Hongsun
 
iVersion = -1;
for iIter=1:length(acVersions)
   try
    dummy = winqueryreg('name', 'HKEY_CURRENT_USER', acVersions{iIter});
    iVersion = iIter;
   catch
   end
end

if ~strcmpi(computer,'PCWIN64') && ~strcmpi(computer,'PCWIN32') 
    h=msgbox('Automatic model generation with solidworks is only available under Windows platform.');
    waitfor(h);
    return;
end
strctGridModel=getappdata(handles.figure1,'strctGridModel');

switch iVersion
    case -1
        fprintf('Solidworks is not installed/Version not suported. Cannot proceed!\n');
        return;
    case 9
        strctOutput =  SolidWorks2019ExportWizard(strctGridModel);
    otherwise
        strctOutput =  SolidWorksExportWizard(strctGridModel);
end

if isempty(strctOutput)
    return;
end

%added by Hongsun
chamberParams = g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}. ...
    m_astrctChambers(g_strctModule.m_iCurrChamber).m_strctModel.m_strctModel.strctParams;

%
P = [strctGridModel.m_afGridHolesX;strctGridModel.m_afGridHolesY];
N = size(P,2);
Tilt = strctGridModel.m_afGridHoleTiltDeg;
Rot = strctGridModel.m_afGridHoleRotationDeg;
Rad = strctOutput.m_afRad/2;

if ~strcmpi(computer, 'PCWIN64')
    fprintf('Grid export is only supported on Windows 64 bit machines!\n');
    return;
end

switch iVersion
    case -1
        fprintf('Solidworks is not installed/Version not suported. Cannot proceed!\n');
    case 1
        iErr = fndllSolidWorksRecordingChamber2010(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 2
        iErr = fndllSolidWorksRecordingChamber2011(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 3
        iErr = fndllSolidWorksRecordingChamber2012(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 4
        iErr = fndllSolidWorksRecordingChamber2013(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 5
        iErr = fndllSolidWorksRecordingChamber2014(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 6
        iErr = fndllSolidWorksRecordingChamber2015(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 7
        iErr = fndllSolidWorksRecordingChamber2016(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 8
        iErr = fndllSolidWorksRecordingChamber2017(P, Tilt, Rot, Rad, strctOutput.m_strTemplate, strctOutput.m_strOutputFile,strctOutput.m_bCloseSolidworksAfter);
    case 9
        %Added by Hongsun; strctOutput.m_strTemplate and
        %strctOutput.m_strOutputFile are obsolete
        chamber_innerDiameter = chamberParams.m_fInnerDiameterMM;
        chamber_outerDiameter = chamberParams.m_fOuterDiameterMM;
        chamber_height = chamberParams.m_fChamberH1;
        grid_innerDiamter = strctGridModel.m_strctGridParams.m_fGridInnerDiameterMM;
        grid_outerDiameter = strctGridModel.m_strctGridParams.m_fGridOuterDiameterMM;
        grid_outerHeight = strctGridModel.m_strctGridParams.m_fGridHeightMM + ...
            strctGridModel.m_strctGridParams.m_fGridHeightAboveMM;
        grid_innerHeight = strctGridModel.m_strctGridParams.m_fGridHeightMM;
        iErr = fndllSolidWorksCreateChamberCAP2019(P, Tilt, Rot, Rad, '', '', false, ...
            chamber_innerDiameter, ... %7
            chamber_outerDiameter, ... %8
            chamber_height, ... %9
            grid_innerDiamter, ... %10
            grid_outerDiameter, ... %11
            grid_innerHeight, ... %12
            grid_outerHeight, ... %13
            strctOutput.m_strChamberFileName, ... %14
            strctOutput.m_strCAPFileName, ... %15
            strctOutput.m_strGridFileName);  %16
end



function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
if get(handles.hSelectHoles,'value')
    setappdata(handles.figure1,'strMouseMode','SelectHoles'); 
else
    setappdata(handles.figure1,'strMouseMode','PlaceElectrodes'); 
end


% --- Executes on button press in hExportToMat.
function hExportToMat_Callback(hObject, eventdata, handles)
strctGridModel=getappdata(handles.figure1,'strctGridModel');
strctGridName=getappdata(handles.figure1,'strctGridName');
[strFile,strPath] = uiputfile([strctGridName,'.mat'],'Export grid as');
if strFile(1) == 0
    return
end
save(fullfile(strPath,strFile),'strctGridModel','strctGridName');


% --- Executes on button press in ExportXML.
function ExportXML_Callback(hObject, eventdata, handles)
strctGridModel=getappdata(handles.figure1,'strctGridModel');
strctGridName=getappdata(handles.figure1,'strctGridName');
[strFile,strPath] = uiputfile([strctGridName,'.xml'],'Export grid as');
if strFile(1) == 0
    return
end

numCirclePoints = 30;
numGridPoints = length(strctGridModel.m_strctGridParams.m_afGridHoleXMM);

hFileID = fopen(fullfile(strPath,strFile),'w+');

fprintf(hFileID,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(hFileID,'<CONTAINER type="CustomGrid" name="%s" ID="1" numAdvancerLocations="%d" \n', strctGridName,numGridPoints);
fprintf(hFileID,'           centerX="0" centerY="0" numModelPolygons="1">\n');
fprintf(hFileID,'        <POLYGON colorR="232" colorG="232" colorB="232" numPoints="%d">\n',numCirclePoints);
afAngles = linspace(0,2*pi,numCirclePoints);

afX = strctGridModel.m_strctGridParams.m_fGridInnerDiameterMM/2*cos(afAngles);
afY = strctGridModel.m_strctGridParams.m_fGridInnerDiameterMM/2*sin(afAngles);
for k=1:numCirclePoints
    fprintf(hFileID,'          <POLYGON_POINT x="%.3f" y="%.3f"/>\n',afX(k),afY(k));
end
fprintf(hFileID,'        </POLYGON>\n');
for k=1:numGridPoints
    fprintf(hFileID,'        <ADVANCER_LOCATION x="%.2f" y="%.2f" rad="%.3f"/>\n',...
        strctGridModel.m_strctGridParams.m_afGridHoleXMM(k),strctGridModel.m_strctGridParams.m_afGridHoleYMM(k),...
        strctGridModel.m_strctGridParams.m_fGridHoleDiameterMM/2);
end
fprintf(hFileID,'</CONTAINER>\n');

fclose(hFileID);


