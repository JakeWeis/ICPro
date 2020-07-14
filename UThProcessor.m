function UThProcessor

% =============================
% UThProcessor v2.0.2
% Jake Weis, IMAS, November 2019
% email: jakemail73@aol.com
% =============================
%
% This function determines U and Th isotope ratios (229Th/230Th, 236U/234U,
% 235U/234U) in sediment/sea water digests based on raw count files
% obtained by ICP-MS. The following processing steps are undertaken (in
% this order):
%   (1) Tailing correction (only 230Th raw counts)
%   (2) Blank correction
%   (3) Averaging raw counts over submasses and analysis runs
%   (4) Calculating isotope ratios
%   (5) Mass bias correction
% Optionally, further processing steps can be undertaken to determine 230Th
% and 234U concentrations (isotopic dilution) as well as preserved vertical
% particle fluxes (230Th-normalisation). These steps require extra data
% input.
% 
% Please refer to the README Word file for detailed instruction. 

%% UI Figure
posh = 0;
posv = 440;
UIFig1 = uifigure;
UIFig1.Position = [200 200 400 posv];
UIFig1.Name = 'Parameter Input';

%% SAMPLE TYPE
UIcontr_TypeSwitch = uiswitch(UIFig1);
UIcontr_TypeSwitch.Position = [posh+180 posv-30 40 20];
UIcontr_TypeSwitch.Items = {'Sediment';'Sea Water'};
UIcontr_TypeSwitch.ItemsData = [0 1];
UIcontr_TypeSwitch.FontWeight = 'bold';

%% RAW DATA FOLDER DIRECTORY
UItitle_RawDataDir = uilabel(UIFig1);
UItitle_RawDataDir.Position = [posh+20 posv-60 360 20];
UItitle_RawDataDir.Text = 'Raw Data Folder';
UItitle_RawDataDir.HorizontalAlignment = 'left';

UIcontr_RawDataDir = uieditfield(UIFig1);
UIcontr_RawDataDir.Position = [posh+20 posv-80 310 20];
UIcontr_RawDataDir.HorizontalAlignment = 'left';
UIcontr_RawDataDir.ValueChangedFcn = @addslash; 

UIcontr_BrowseButton = uibutton(UIFig1);
UIcontr_BrowseButton.Position = [posh+340 posv-80 40 20];
UIcontr_BrowseButton.Text = char(8943);
UIcontr_BrowseButton.FontWeight = 'bold';
UIcontr_BrowseButton.ButtonPushedFcn = @BrowseFolder;

%% ANALYSIS BLOCKS
UItitle_Blocks = uilabel(UIFig1);
UItitle_Blocks.Position = [posh+20 posv-120 360 20];
UItitle_Blocks.Text = 'Number of analysis blocks:';
UItitle_Blocks.HorizontalAlignment = 'left';

UIcontr_Blocks = uieditfield(UIFig1);
UIcontr_Blocks.Position = [posh+20 posv-140 360 20];
UIcontr_Blocks.HorizontalAlignment = 'left';

%% SAMPLES PER BLOCKS
UItitle_SamplesPerBlock = uilabel(UIFig1);
UItitle_SamplesPerBlock.Position = [posh+20 posv-180 360 20];
UItitle_SamplesPerBlock.Text = 'Number of samples per block (single value or one value per block):';
UItitle_SamplesPerBlock.HorizontalAlignment = 'left';

UIcontr_SamplesPerBlock = uieditfield(UIFig1);
UIcontr_SamplesPerBlock.Position = [posh+20 posv-200 360 20];
UIcontr_SamplesPerBlock.HorizontalAlignment = 'left';

%% SAMPLES PER BLOCKS
UItitle_SampChars = uilabel(UIFig1);
UItitle_SampChars.Position = [posh+20 posv-240 360 20];
UItitle_SampChars.Text = 'Unique character sequence of sample-IDs:';
UItitle_SampChars.HorizontalAlignment = 'left';

UIcontr_SampChars = uieditfield(UIFig1);
UIcontr_SampChars.Position = [posh+20 posv-260 360 20];
UIcontr_SampChars.HorizontalAlignment = 'left';
UIcontr_SampChars.Value = 'XYZ';

%% SAMPLES PER BLOCKS
UItitle_BlankChars = uilabel(UIFig1);
UItitle_BlankChars.Position = [posh+20 posv-300 360 20];
UItitle_BlankChars.Text = 'Unique character sequence of blank-IDs:';
UItitle_BlankChars.HorizontalAlignment = 'left';

UIcontr_BlankChars = uieditfield(UIFig1);
UIcontr_BlankChars.Position = [posh+20 posv-320 360 20];
UIcontr_BlankChars.HorizontalAlignment = 'left';
UIcontr_BlankChars.Value = 'Blank';

%% SAMPLES PER BLOCKS
UItitle_NatUChars = uilabel(UIFig1);
UItitle_NatUChars.Position = [posh+20 posv-360 360 20];
UItitle_NatUChars.Text = 'Unique character sequence of NatU-IDs:';
UItitle_NatUChars.HorizontalAlignment = 'left';

UIcontr_NatUChars = uieditfield(UIFig1);
UIcontr_NatUChars.Position = [posh+20 posv-380 360 20];
UIcontr_NatUChars.HorizontalAlignment = 'left';
UIcontr_NatUChars.Value = 'NatU';

%% ID TICK
UIcontr_IDcalc = uicheckbox(UIFig1);
UIcontr_IDcalc.Position = [posh+20 posv-420 340 20];
UIcontr_IDcalc.Text = 'Perform ID & particle flux calculations (beta)';

%% GO BUTTON
UIcontr_ProceedButton = uibutton(UIFig1);
UIcontr_ProceedButton.Position = [posh+330 posv-420 50 20];
UIcontr_ProceedButton.FontWeight = 'bold';
UIcontr_ProceedButton.BackgroundColor = [.7 .8 .7];
UIcontr_ProceedButton.Text = char(11157);
UIcontr_ProceedButton.VerticalAlignment = 'center';
UIcontr_ProceedButton.FontSize = 10;
UIcontr_ProceedButton.ButtonPushedFcn = @Proceed;

%% NESTED FUNCTIONS
    function BrowseFolder(~,~)
        UIcontr_RawDataDir.Value = [uigetdir,'/'];
    end

    function addslash(~,~)
        if ~isempty(UIcontr_RawDataDir.Value) && ...
                UIcontr_RawDataDir.Value(end) ~= '/' 
            UIcontr_RawDataDir.Value(end+1) = '/';
        end
    end

    function Proceed(~,~)
        par.Type = UIcontr_TypeSwitch.Value;
        par.RawDataDir = UIcontr_RawDataDir.Value;
        par.nBlocks = str2num(UIcontr_Blocks.Value);
        par.lSeq = str2num(UIcontr_SamplesPerBlock.Value);
        par.sampleIDstr = UIcontr_SampChars.Value;
        par.blankIDstr = UIcontr_BlankChars.Value;
        par.NatUIDstr = UIcontr_NatUChars.Value;
        par.IDsel = UIcontr_IDcalc.Value;
        
        RatioCal(par)
    end

end