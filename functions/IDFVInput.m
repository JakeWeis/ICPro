function IDFVInput(sampleID,ResTab1,ResTab2,par)

%% UI Figure
UIFig2 = figure;
UIFig2.Position = [20 20 1050 485];
UIFig2.Name = 'Isotopic Dilution & Particle Flux Calculation Input';
UIFig2.NumberTitle = 'off';
UIFig2.ToolBar = 'none';
UIFig2.MenuBar = 'none';
posv = 80;
posh = 130;

%% Sample IDs (display)
for i = 1 : numel(sampleID)
   sampleID{i} = sampleID{i}(1:end-4); 
end
UItitle_SampleID = uicontrol(UIFig2,'Style','text','FontWeight','bold');
UItitle_SampleID.Position = [posh posv+330 80 40];
UItitle_SampleID.String = 'Sample ID';
UIcontr_SampleID = uicontrol(UIFig2,'Style','text');
UIcontr_SampleID.Position = [posh-100 posv+5 80 325];
UIcontr_SampleID.String = sampleID(1:end)';
UIcontr_SampleID.HorizontalAlignment = 'left';

%% Sample Data
% Box
uipanel(UIFig2,'Units','pixels',...
    'Position',[posh-10 posv 300 380],...
    'BackgroundColor',[.9 1 .9])

% Sample Weight Input
UItitle_SampWt = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 1 .9]);
UItitle_SampWt.Position = [posh posv+330 80 40];
UItitle_SampWt.String = 'Sediment wt. [g]';
UIcontr_SampWt = uicontrol(UIFig2,'Style','edit');
UIcontr_SampWt.Position = [posh posv+10 80 325];
UIcontr_SampWt.Min = 1;
UIcontr_SampWt.Max = 24;
UIcontr_SampWt.String = '0.0000';

% Sample Age Input
UItitle_SampAge = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 1 .9]);
UItitle_SampAge.Position = [posh+100 posv+330 80 40];
UItitle_SampAge.String = '  Sample age   [yr]';
UIcontr_SampAge = uicontrol(UIFig2,'Style','edit');
UIcontr_SampAge.Position = [posh+100 posv+10 80 325];
UIcontr_SampAge.Min = 1;
UIcontr_SampAge.Max = 24;

% Water Depth
UItitle_Depth = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 1 .9]);
UItitle_Depth.Position = [posh+200 posv+330 80 40];
UItitle_Depth.String = '  Water depth   [m]';
UIcontr_Depth = uicontrol(UIFig2,'Style','edit');
UIcontr_Depth.Position = [posh+200 posv+10 80 325];
UIcontr_Depth.Min = 1;
UIcontr_Depth.Max = 24;

%% Th Data Input
% Box
uipanel(UIFig2,'Units','pixels',...
    'Position',[posh+5+290 posv-50 300 430],...
    'BackgroundColor',[1 .9 .9])

% 229Th spike weight
UItitle_229Th = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[1 .9 .9]);
UItitle_229Th.Position = [posh+5+300 posv+330 80 40];
UItitle_229Th.String = '229Th spike wt. [g]';
UIcontr_229Th = uicontrol(UIFig2,'Style','edit');
UIcontr_229Th.Position = [posh+5+300 posv+10 80 325];
UIcontr_229Th.Min = 1;
UIcontr_229Th.Max = 24;

% 232Th concentration
UItitle_232Th = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[1 .9 .9]);
UItitle_232Th.Position = [posh+5+400 posv+330 80 40];
UItitle_232Th.String = '232Th conc. [ppm]';
UIcontr_232Th = uicontrol(UIFig2,'Style','edit');
UIcontr_232Th.Position = [posh+5+400 posv+10 80 325];
UIcontr_232Th.Min = 1;
UIcontr_232Th.Max = 24;

% 229Th/230Th ratio
% UItitle_ThRat = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[1 .9 .9]);
% UItitle_ThRat.Position = [posh+5+500 posv+330 80 40];
% UItitle_ThRat.String = '  229Th/230Th   [-]';
% UIcontr_ThRat = uicontrol(UIFig2,'Style','edit');
% UIcontr_ThRat.Position = [posh+5+500 posv+10 80 325];
% UIcontr_ThRat.Min = 1;
% UIcontr_ThRat.Max = 24;

% Th Spike RY
UItitle_RYTh = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[1 .9 .9]);
UItitle_RYTh.Position = [posh+5+300 posv-20 80 20];
UItitle_RYTh.String = 'RY';
UItitle_RYTh.Callback = "1+1";
UIcontr_RYTh = uicontrol(UIFig2,'Style','edit');
UIcontr_RYTh.Position = [posh+5+300 posv-40 80 20];
UIcontr_RYTh.String = '16115.6882923444';

% Th Spike RX
UItitle_RXTh = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[1 .9 .9]);
UItitle_RXTh.Position = [posh+5+400 posv-20 80 20];
UItitle_RXTh.String = 'RX';
UIcontr_RXTh = uicontrol(UIFig2,'Style','edit');
UIcontr_RXTh.Position = [posh+5+400 posv-40 80 20];
UIcontr_RXTh.String = '0';

% Th Spike CY
UItitle_CYTh = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[1 .9 .9]);
UItitle_CYTh.Position = [posh+5+500 posv-20 80 20];
UItitle_CYTh.String = 'CY';
UIcontr_CYTh = uicontrol(UIFig2,'Style','edit');
UIcontr_CYTh.Position = [posh+5+500 posv-40 80 20];
UIcontr_CYTh.String = '47.33';

%% U Data Input
% Box
uipanel(UIFig2,'Units','pixels','Position',[posh+5+595 posv-50 300 430],'BackgroundColor',[.9 .9 1])

% 236U spike weight
UItitle_236U = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 .9 1]);
UItitle_236U.Position = [posh+5+605 posv+330 80 40];
UItitle_236U.String = '236U spike wt. [g]';
UIcontr_236U = uicontrol(UIFig2,'Style','edit');
UIcontr_236U.Position = [posh+5+605 posv+10 80 325];
UIcontr_236U.Min = 1;
UIcontr_236U.Max = 24;

% 238Th concentration
UItitle_238U = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 .9 1]);
UItitle_238U.Position = [posh+5+705 posv+330 80 40];
UItitle_238U.String = '238U conc. [ppm]';
UIcontr_238U = uicontrol(UIFig2,'Style','edit');
UIcontr_238U.Position = [posh+5+705 posv+10 80 325];
UIcontr_238U.Min = 1;
UIcontr_238U.Max = 24;

% 236U/234U ratio
% UItitle_URat = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 .9 1]);
% UItitle_URat.Position = [posh+5+805 posv+330 80 40];
% UItitle_URat.String = '  236U/234U   [-]';
% UIcontr_URat = uicontrol(UIFig2,'Style','edit');
% UIcontr_URat.Position = [posh+5+805 posv+10 80 325];
% UIcontr_URat.Min = 1;
% UIcontr_URat.Max = 24;
% UIcontr_URat.Enable = 'off';

% U Spike RY
UItitle_RYU = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 .9 1]);
UItitle_RYU.Position = [posh+5+605 posv-20 80 20];
UItitle_RYU.String = 'RY';
UIcontr_RYU = uicontrol(UIFig2,'Style','edit');
UIcontr_RYU.Position = [posh+5+605 posv-40 80 20];
UIcontr_RYU.String = '818112390';

% U Spike RX
UItitle_RXU = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 .9 1]);
UItitle_RXU.Position = [posh+5+705 posv-20 80 20];
UItitle_RXU.String = 'RX';
UIcontr_RXU = uicontrol(UIFig2,'Style','edit');
UIcontr_RXU.Position = [posh+5+705 posv-40 80 20];
UIcontr_RXU.String = '0';

% U Spike CY
UItitle_CYU = uicontrol(UIFig2,'Style','text','FontWeight','bold','BackgroundColor',[.9 .9 1]);
UItitle_CYU.Position = [posh+5+805 posv-20 80 20];
UItitle_CYU.String = 'CY';
UIcontr_CYU = uicontrol(UIFig2,'Style','edit');
UIcontr_CYU.Position = [posh+5+805 posv-40 80 20];
UIcontr_CYU.String = '59228.1919551491';

%% INPUT BUTTON
InputB = uicontrol(UIFig2,'Style','pushbutton');
InputB.Position = [posh+100 posv-45 80 30];
InputB.String = char(8594);
InputB.FontWeight = 'bold';
InputB.FontSize = 24;
InputB.ForegroundColor = [0 0 0];
InputB.Callback = {@InputData,ResTab1,ResTab2,par};

    function IDinput = InputData(~,~,ResTab1,ResTab2,par)
        IDinput.SampleWeight = str2num(UIcontr_SampWt.String);
        IDinput.Age = str2num(UIcontr_SampAge.String);
        IDinput.Depth = str2num(UIcontr_Depth.String);
        IDinput.Th229Weight = str2num(UIcontr_229Th.String);
        IDinput.U236Weight = str2num(UIcontr_236U.String);
        IDinput.ThRatio = ResTab1{:,2};
        IDinput.URatio = ResTab1{:,5};
        IDinput.Th232Conc = str2num(UIcontr_232Th.String);
        IDinput.U238Conc = str2num(UIcontr_238U.String);
        IDinput.RY_Th = str2num(UIcontr_RYTh.String);
        IDinput.RX_Th = str2num(UIcontr_RXTh.String);
        IDinput.CY_Th = str2num(UIcontr_CYTh.String);
        IDinput.RY_U = str2num(UIcontr_RYU.String);
        IDinput.RX_U = str2num(UIcontr_RXU.String);
        IDinput.CY_U = str2num(UIcontr_CYU.String);
        run IDFVcal(IDinput,ResTab1,ResTab2,par)
    end
end