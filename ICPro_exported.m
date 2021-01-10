classdef ICPro_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        ICProUIFigure           matlab.ui.Figure
        ICProMenu               matlab.ui.container.Menu
        AboutMenu               matlab.ui.container.Menu
        GuideMenu               matlab.ui.container.Menu
        SampletypeMenu          matlab.ui.container.Menu
        SedimentMenu            matlab.ui.container.Menu
        SeawaterNAMenu          matlab.ui.container.Menu
        BatchMenu               matlab.ui.container.Menu
        SaveBatchMenu           matlab.ui.container.Menu
        SaveAsBatchMenu         matlab.ui.container.Menu
        LoadBatchMenu           matlab.ui.container.Menu
        DeleteBatchMenu         matlab.ui.container.Menu
        ClearBatchMenu          matlab.ui.container.Menu
        ExportMenu              matlab.ui.container.Menu
        IndResExp               matlab.ui.container.Menu
        TEIndRes                matlab.ui.container.Menu
        IDLRplots               matlab.ui.container.Menu
        IDexport                matlab.ui.container.Menu
        DCexport                matlab.ui.container.Menu
        BCexport                matlab.ui.container.Menu
        OCexport                matlab.ui.container.Menu
        SCexport                matlab.ui.container.Menu
        QCexport                matlab.ui.container.Menu
        RCexport                matlab.ui.container.Menu
        Rawexport               matlab.ui.container.Menu
        ThUIndRes               matlab.ui.container.Menu
        SamRatioExp             matlab.ui.container.Menu
        NatURatioExp            matlab.ui.container.Menu
        ThUIDExp                matlab.ui.container.Menu
        TEsheet                 matlab.ui.container.Menu
        ThUsheet                matlab.ui.container.Menu
        TEThUsheet              matlab.ui.container.Menu
        Panel_TE                matlab.ui.container.Panel
        Button_RawFile          matlab.ui.control.Button
        Field_RawFile           matlab.ui.control.EditField
        Field_SIDTE             matlab.ui.control.EditField
        Field_BlankID           matlab.ui.control.EditField
        Field_SpikeID           matlab.ui.control.EditField
        Label_SIDTE             matlab.ui.control.Label
        Label_BlankID           matlab.ui.control.Label
        Label_SpikeID           matlab.ui.control.Label
        Field_RinseID           matlab.ui.control.EditField
        Label_RinseID           matlab.ui.control.Label
        Field_QCID              matlab.ui.control.EditField
        Label_QCID              matlab.ui.control.Label
        Panel_TECorr            matlab.ui.container.Panel
        Check_RC                matlab.ui.control.CheckBox
        Check_QC                matlab.ui.control.CheckBox
        Check_SC                matlab.ui.control.CheckBox
        Check_OC                matlab.ui.control.CheckBox
        Check_BC                matlab.ui.control.CheckBox
        Check_DC                matlab.ui.control.CheckBox
        Panel_ThU               matlab.ui.container.Panel
        TabGroup2               matlab.ui.container.TabGroup
        InputTab                matlab.ui.container.Tab
        Field_NBlocks           matlab.ui.control.EditField
        Field_NSamples          matlab.ui.control.EditField
        Label_NBlocks           matlab.ui.control.Label
        Label_NSamples          matlab.ui.control.Label
        Field_ICPBlankID        matlab.ui.control.EditField
        Label_ICPBlankID        matlab.ui.control.Label
        Field_ICPNatUID         matlab.ui.control.EditField
        Label_ICPNatUID         matlab.ui.control.Label
        Field_SIDThU            matlab.ui.control.EditField
        Label_SIDThU            matlab.ui.control.Label
        Button_RawFolder        matlab.ui.control.Button
        Field_RawFolder         matlab.ui.control.EditField
        SequenceTab             matlab.ui.container.Tab
        SequenceList            matlab.ui.control.Table
        Panel_IsotopicDilution  matlab.ui.container.Panel
        SpikesPanel             matlab.ui.container.Panel
        UspikeDropDownLabel     matlab.ui.control.Label
        DropDown_236            matlab.ui.control.DropDown
        ThspikeDropDown_2Label  matlab.ui.control.Label
        DropDown_230            matlab.ui.control.DropDown
        ThspikeDropDownLabel    matlab.ui.control.Label
        DropDown_229            matlab.ui.control.DropDown
        Field_RY229             matlab.ui.control.NumericEditField
        Label_RX                matlab.ui.control.Label
        Field_RX229             matlab.ui.control.NumericEditField
        Label_CY                matlab.ui.control.Label
        Field_CY229             matlab.ui.control.NumericEditField
        Field_RY230             matlab.ui.control.NumericEditField
        Field_RY236             matlab.ui.control.NumericEditField
        Field_RX230             matlab.ui.control.NumericEditField
        Field_RX236             matlab.ui.control.NumericEditField
        Field_CY230             matlab.ui.control.NumericEditField
        Field_CY236             matlab.ui.control.NumericEditField
        Label_RY                matlab.ui.control.Label
        Button_EdtSve229        matlab.ui.control.Button
        Button_EdtSve230        matlab.ui.control.Button
        Button_EdtSve236        matlab.ui.control.Button
        Button_Delete229        matlab.ui.control.Button
        Button_Delete230        matlab.ui.control.Button
        Button_Delete236        matlab.ui.control.Button
        Footnote                matlab.ui.control.Label
        Field_RYb236            matlab.ui.control.NumericEditField
        TabGroup                matlab.ui.container.TabGroup
        Tab_IDWeights           matlab.ui.container.Tab
        Field_Sediment          matlab.ui.control.TextArea
        Label_Sediment          matlab.ui.control.Label
        Field_4ml               matlab.ui.control.TextArea
        Field_10ml              matlab.ui.control.TextArea
        Field_400ul             matlab.ui.control.TextArea
        Field_ThBC              matlab.ui.control.TextArea
        Label_4ml               matlab.ui.control.Label
        Label_10ml              matlab.ui.control.Label
        Label_400ul             matlab.ui.control.Label
        Label_ThBC              matlab.ui.control.Label
        Field_UBC               matlab.ui.control.TextArea
        Field_ThSC              matlab.ui.control.TextArea
        Label_UBC               matlab.ui.control.Label
        Label_ThSC              matlab.ui.control.Label
        Field_USC               matlab.ui.control.TextArea
        Label_USC               matlab.ui.control.Label
        Field_SampleList        matlab.ui.control.TextArea
        Label_SampleList        matlab.ui.control.Label
        Tab_RawIntensities      matlab.ui.container.Tab
        Field_cpsSampleList     matlab.ui.control.TextArea
        Label_cpsSampleList     matlab.ui.control.Label
        Field_cps230Th          matlab.ui.control.TextArea
        Label_cps230Th          matlab.ui.control.Label
        Field_cps232Th          matlab.ui.control.TextArea
        Field_cps236U           matlab.ui.control.TextArea
        Field_cps238U           matlab.ui.control.TextArea
        Label_cps232Th          matlab.ui.control.Label
        Label_cps236U           matlab.ui.control.Label
        Label_cps238U           matlab.ui.control.Label
        Label_cps230Th_R        matlab.ui.control.Label
        Label_cps232Th_R        matlab.ui.control.Label
        Label_cps236U_R         matlab.ui.control.Label
        Label_cps238U_R         matlab.ui.control.Label
        Field_cps230Th_R        matlab.ui.control.TextArea
        Field_cps232Th_R        matlab.ui.control.TextArea
        Field_cps236U_R         matlab.ui.control.TextArea
        Field_cps238U_R         matlab.ui.control.TextArea
        Footnote2               matlab.ui.control.Label
        Tab_TEresults           matlab.ui.container.Tab
        DataSelTE               matlab.ui.container.ButtonGroup
        RawButton               matlab.ui.control.ToggleButton
        RCButton                matlab.ui.control.ToggleButton
        QCButton                matlab.ui.control.ToggleButton
        SCButton                matlab.ui.control.ToggleButton
        OCButton                matlab.ui.control.ToggleButton
        BCButton                matlab.ui.control.ToggleButton
        DCButton                matlab.ui.control.ToggleButton
        IDButton                matlab.ui.control.ToggleButton
        CUSelTE                 matlab.ui.container.ButtonGroup
        ConcTE                  matlab.ui.control.RadioButton
        ErrTE                   matlab.ui.control.RadioButton
        ErrpTE                  matlab.ui.control.RadioButton
        Table_TEresults         matlab.ui.control.Table
        Tab_TEplot              matlab.ui.container.Tab
        UIDFig                  matlab.ui.control.UIAxes
        ThIDFig                 matlab.ui.control.UIAxes
        Tab_ThUresults          matlab.ui.container.Tab
        Table_ThUresults        matlab.ui.control.Table
        DataSelThU              matlab.ui.container.ButtonGroup
        RatioSButton            matlab.ui.control.ToggleButton
        RatioNButton            matlab.ui.control.ToggleButton
        ThUIDButton             matlab.ui.control.ToggleButton
        CUSelThU                matlab.ui.container.ButtonGroup
        ConcThU                 matlab.ui.control.RadioButton
        ErrThU                  matlab.ui.control.RadioButton
        ErrpThU                 matlab.ui.control.RadioButton
        Button_TEtoggle         matlab.ui.control.StateButton
        Button_ThUtoggle        matlab.ui.control.StateButton
        Button_Run              matlab.ui.control.Button
    end

    
    properties (Access = private)
        AppPath = dir([mfilename('fullpath'),'.mlapp']);    % Description
        Output = struct;                                    % Processing input
        Input = struct;                                     % Processing output
        BatchName = 'unsaved batch'                         % Batch name
        SMatch = struct;                                    % TE and Th/U sample match up
    end
    
    methods (Access = private)
        function IN = getInput(app)
            %---------------------------------------------------------------------------------
            % Function: Get input parameters
            % This function copies all input parameters and saves them locally as a batch
            % file.
            %% -------------------------------------------------------------------------------
            
            % Trace element input
            app.Input.TEpar.Toggle = app.Button_TEtoggle.Value;                             % Analysis toggle
            app.Input.TEpar.RawPath = app.Field_RawFile.Value;                              % Raw file directory
            app.Input.TEpar.SID = app.Field_SIDTE.Value;                                    % Sample ID
            app.Input.TEpar.BID = app.Field_BlankID.Value;                                  % Blank ID
            app.Input.TEpar.VID = app.Field_SpikeID.Value;                                  % Spike ID
            app.Input.TEpar.RID = app.Field_RinseID.Value;                                  % Rinse ID
            app.Input.TEpar.QID = app.Field_QCID.Value;                                     % QC ID
            app.Input.TEpar.CCheck.RC = app.Check_RC.Value;                                 % Rinse correction selection
            app.Input.TEpar.CCheck.QC = app.Check_QC.Value;                                 % QC correction selection
            app.Input.TEpar.CCheck.SC = app.Check_SC.Value;                                 % Spike correction selection
            app.Input.TEpar.CCheck.OC = app.Check_OC.Value;                                 % Oxide correction selection
            app.Input.TEpar.CCheck.BC = app.Check_BC.Value;                                 % Blank correction selection
            app.Input.TEpar.CCheck.DC = app.Check_DC.Value;                                 % Dilution correction selection
            
            % Th/U input
            app.Input.ThUpar.Toggle = app.Button_ThUtoggle.Value;                           % Analysis toggle
            app.Input.ThUpar.ThURawPath = app.Field_RawFolder.Value;                        % Raw data directory
            app.Input.ThUpar.SType = 'Sediment';                                            % Sample type
            if ~isempty(app.Field_NBlocks.Value)                                            % # of analysis blocks
                app.Input.ThUpar.NBlocks = str2double(app.Field_NBlocks.Value);
            else
                app.Input.ThUpar.NBlocks = [];
            end
            iNSamples = regexp(app.Field_NSamples.Value,'\d');                              % # of samples per block
            if ~isempty(iNSamples)
                for i = 1 : length(iNSamples)
                    app.Input.ThUpar.NSamples(i) = str2double(app.Field_NSamples.Value(iNSamples(i)));
                end
            else
                app.Input.ThUpar.NSamples = [];
            end
            app.Input.ThUpar.SID = app.Field_SIDThU.Value;                                  % Sample ID
            app.Input.ThUpar.BID = app.Field_ICPBlankID.Value;                              % Blank ID
            app.Input.ThUpar.NatUID = app.Field_ICPNatUID.Value;                            % NatU ID
            
            % Isotopic dilution input
            app.Input.WtPar.m_sed = str2double(app.Field_Sediment.Value)';                  % Sediment weights
            app.Input.WtPar.m_4ml = str2double(app.Field_4ml.Value)';                       % 4 mL weights
            app.Input.WtPar.m_10ml = str2double(app.Field_10ml.Value)';                     % 10 mL
            app.Input.WtPar.m_400ul = str2double(app.Field_400ul.Value)';                   % 400 uL
            app.Input.WtPar.m_ThSC = str2double(app.Field_ThSC.Value)';                     % Th spike weight (small cut)
            app.Input.WtPar.m_ThBC = str2double(app.Field_ThBC.Value)';                     % Th spike weight (big cut)
            app.Input.WtPar.m_USC = str2double(app.Field_USC.Value)';                       % U spike weight (small cut)
            app.Input.WtPar.m_UBC = str2double(app.Field_UBC.Value)';                       % U spike weight (big cut)
            app.Input.SpikePar.Th229RY = app.Field_RY229.Value;                             % Th229 RY
            app.Input.SpikePar.Th229RX = app.Field_RX229.Value;                             % Th229 RX
            app.Input.SpikePar.Th229CY = app.Field_CY229.Value;                             % Th229 CY
            app.Input.SpikePar.Th230RY = app.Field_RY230.Value;                             % Th230 RY
            app.Input.SpikePar.Th230RX = app.Field_RX230.Value;                             % Th230 RX
            app.Input.SpikePar.Th230CY = app.Field_CY230.Value;                             % Th230 CY
            app.Input.SpikePar.U236RY = app.Field_RY236.Value;                              % U236 RY (for 238U ID)
            app.Input.SpikePar.U236RYb = app.Field_RYb236.Value;                            % U236 RY (for 234U ID)
            app.Input.SpikePar.U236RX = app.Field_RX236.Value;                              % U236 RX
            app.Input.SpikePar.U236CY = app.Field_CY236.Value;                              % U236 CY
            app.Input.SpikeSel = [app.DropDown_229.Value,app.DropDown_230.Value,app.DropDown_236.Value];
            app.Input.cps.Sample = [str2double(app.Field_cps230Th.Value),...                % Th/U sample raw counts
                str2double(app.Field_cps232Th.Value),...
                str2double(app.Field_cps236U.Value),...
                str2double(app.Field_cps238U.Value)]';
            app.Input.cps.Rinse = [str2double(app.Field_cps230Th_R.Value),...               % Th/U rinse raw counts
                str2double(app.Field_cps232Th_R.Value),...
                str2double(app.Field_cps236U_R.Value),...
                str2double(app.Field_cps238U_R.Value)]';
            
            % Save to export variable 'IN'
            IN = app.Input;
            IN.BatchName{1} = app.BatchName;
        end
        
        function setInput(app,event,IN)
            %---------------------------------------------------------------------------------
            % Function: Import input parameters
            % This function creates Th232 and U238 isotopic diution vs linear regression
            % plots.
            %% -------------------------------------------------------------------------------
            
            % Save input to app property 'Input'
            app.Input = IN;
            clearvars('IN')
            
            % Set TE parameters
            app.Button_TEtoggle.Value = app.Input.TEpar.Toggle;                             % Analysis toggle
            app.Field_RawFile.Value = app.Input.TEpar.RawPath;                              % Raw file directory
            app.Field_SIDTE.Value = app.Input.TEpar.SID;                                    % Sample ID
            app.Field_BlankID.Value = app.Input.TEpar.BID;                                  % Blank ID
            app.Field_SpikeID.Value = app.Input.TEpar.VID;                                  % Spike ID
            app.Field_RinseID.Value = app.Input.TEpar.RID;                                  % Rinse ID
            app.Field_QCID.Value = app.Input.TEpar.QID;                                     % QC ID
            app.Check_RC.Value = app.Input.TEpar.CCheck.RC;                                 % Rinse correction check
            app.Check_QC.Value = app.Input.TEpar.CCheck.QC;                                 % QC correction check
            app.Check_SC.Value = app.Input.TEpar.CCheck.SC;                                 % Spike correction check
            app.Check_OC.Value = app.Input.TEpar.CCheck.OC;                                 % Oxide correction check
            app.Check_BC.Value = app.Input.TEpar.CCheck.BC;                                 % Blank correction check
            app.Check_DC.Value = app.Input.TEpar.CCheck.DC;                                 % Dilution correction check
            
            % Set Th/U parameters
            app.Button_ThUtoggle.Value = app.Input.ThUpar.Toggle;                           % Analysis toggle
            app.Field_RawFolder.Value = app.Input.ThUpar.ThURawPath;                        % Raw data directory
            app.Field_NBlocks.Value = num2str(app.Input.ThUpar.NBlocks);                    % # of analysis blocks
            app.Field_NSamples.Value = num2str(app.Input.ThUpar.NSamples);                  % # of samples per block
            app.Field_SIDThU.Value = app.Input.ThUpar.SID;                                  % Sample ID
            app.Field_ICPBlankID.Value = app.Input.ThUpar.BID;                              % Blank ID
            app.Field_ICPNatUID.Value = app.Input.ThUpar.NatUID;                            % NatU ID
            
            %% Set isotopic dilution parameters (where missing input replace NaN by empty field)
            if ~isnan(app.Input.WtPar.m_sed)
                app.Field_Sediment.Value = cellstr(num2str(app.Input.WtPar.m_sed'));            % Sediment weight
            else
                app.Field_Sediment.Value = {''};
            end
            if ~isnan(app.Input.WtPar.m_4ml)
                app.Field_4ml.Value = cellstr(num2str(app.Input.WtPar.m_4ml'));                 % 4 mL weight
            else
                app.Field_4ml.Value = {''};
            end
            if ~isnan(app.Input.WtPar.m_10ml)
                app.Field_10ml.Value = cellstr(num2str(app.Input.WtPar.m_10ml'));               % 10 mL weight
            else
                app.Field_10ml.Value = {''};
            end
            if ~isnan(app.Input.WtPar.m_400ul)
                app.Field_400ul.Value = cellstr(num2str(app.Input.WtPar.m_400ul'));             % 400 uL weight
            else
                app.Field_400ul.Value = {''};
            end
            if ~isnan(app.Input.WtPar.m_ThSC)
                app.Field_ThSC.Value = cellstr(num2str(app.Input.WtPar.m_ThSC'));               % Th spike weight (small cut)
            else
                app.Field_ThSC.Value = {''};
            end
            if ~isnan(app.Input.WtPar.m_ThBC)
                app.Field_ThBC.Value = cellstr(num2str(app.Input.WtPar.m_ThBC'));               % Th spike weight (big cut)
            else
                app.Field_ThBC.Value = {''};
            end
            if ~isnan(app.Input.WtPar.m_USC)
                app.Field_USC.Value = cellstr(num2str(app.Input.WtPar.m_USC'));                 % U spike weight (small cut)
            else
                app.Field_USC.Value = {''};
            end
            if ~isnan(app.Input.WtPar.m_UBC)
                app.Field_UBC.Value = cellstr(num2str(app.Input.WtPar.m_UBC'));                 % U spike weight (big cut)
            else
                app.Field_UBC.Value = {''};
            end
            if ~isnan(app.Input.cps.Sample(1,:))
                app.Field_cps230Th.Value = cellstr(num2str(app.Input.cps.Sample(1,:)'));        % Th/U sample raw counts
            else
                app.Field_cps230Th.Value = {''};
            end
            if ~isnan(app.Input.cps.Sample(2,:))
                app.Field_cps232Th.Value = cellstr(num2str(app.Input.cps.Sample(2,:)'));
            else
                app.Field_cps232Th.Value = {''};
            end
            if ~isnan(app.Input.cps.Sample(3,:))
                app.Field_cps236U.Value = cellstr(num2str(app.Input.cps.Sample(3,:)'));
            else
                app.Field_cps236U.Value = {''};
            end
            if ~isnan(app.Input.cps.Sample(4,:))
                app.Field_cps238U.Value = cellstr(num2str(app.Input.cps.Sample(4,:)'));
            else
                app.Field_cps238U.Value = {''};
            end
            if ~isnan(app.Input.cps.Rinse(1,:))
                app.Field_cps230Th_R.Value = cellstr(num2str(app.Input.cps.Rinse(1,:)'));       % Th/U rinse raw counts
            else
                app.Field_cps230Th_R.Value = {''};
            end
            if ~isnan(app.Input.cps.Rinse(2,:))
                app.Field_cps232Th_R.Value = cellstr(num2str(app.Input.cps.Rinse(2,:)'));
            else
                app.Field_cps232Th_R.Value = {''};
            end
            if ~isnan(app.Input.cps.Rinse(3,:))
                app.Field_cps236U_R.Value = cellstr(num2str(app.Input.cps.Rinse(3,:)'));
            else
                app.Field_cps236U_R.Value = {''};
            end
            if ~isnan(app.Input.cps.Rinse(4,:))
                app.Field_cps238U_R.Value = cellstr(num2str(app.Input.cps.Rinse(4,:)'));
            else
                app.Field_cps238U_R.Value = {''};
            end
            
            %% Set spikes and toggle analyses
            Spikes(app,event)
            AnalysisToggle(app,event)
            % Generate sample ID list
            SampleList(app)
        end
        
        function resetInput(app,event)
            %---------------------------------------------------------------------------------
            % Function: Reset all input fields
            % This function resets all input fields to initial conditions.
            %% -------------------------------------------------------------------------------
            
            app.BatchName = 'unsaved batch';
            % Reset TE parameters
            app.Button_TEtoggle.Value = 0;
            app.Field_RawFile.Value = char([]);
            app.Field_SIDTE.Value = char([]);
            app.Field_BlankID.Value = char([]);
            app.Field_SpikeID.Value = 'spike';
            app.Field_RinseID.Value = 'Rinse';
            app.Field_QCID.Value = 'QC';
            app.Check_RC.Value = 0;
            app.Check_QC.Value = 1;
            app.Check_SC.Value = 0;
            app.Check_OC.Value = 0;
            app.Check_BC.Value = 1;
            app.Check_DC.Value = 1;
            
            % Reset Th/U parameters
            app.Button_ThUtoggle.Value = 0;
            app.Field_RawFolder.Value = char([]);
            app.Field_NBlocks.Value = char([]);
            app.Field_NSamples.Value = char([]);
            app.Field_SIDThU.Value = char([]);
            app.Field_ICPBlankID.Value = 'Blank';
            app.Field_ICPNatUID.Value = 'NatU';
            
            % Reset isotopic dilution parameters
            app.Field_SampleList.Value = char([]);
            app.Field_SampleList.Visible = 0;
            app.Field_Sediment.Value = char([]);
            app.Field_4ml.Value = char([]);
            app.Field_10ml.Value = char([]);
            app.Field_400ul.Value = char([]);
            app.Field_ThSC.Value = char([]);
            app.Field_ThBC.Value = char([]);
            app.Field_USC.Value = char([]);
            app.Field_UBC.Value = char([]);
            app.Field_cpsSampleList.Value = char([]);
            app.Field_cpsSampleList.Visible = 0;
            app.Field_cps230Th.Value = char([]);
            app.Field_cps232Th.Value = char([]);
            app.Field_cps236U.Value = char([]);
            app.Field_cps238U.Value = char([]);
            app.Field_cps230Th_R.Value = char([]);
            app.Field_cps232Th_R.Value = char([]);
            app.Field_cps236U_R.Value = char([]);
            app.Field_cps238U_R.Value = char([]);
            app.DropDown_229.Value = 0;
            app.DropDown_230.Value = 0;
            app.DropDown_236.Value = 0;
            
            % Reset spikes and toggle analyses
            Spikes(app,event)
            AnalysisToggle(app,event)
            
            % Reset results
            app.Table_ThUresults.Data = [];
            app.Table_TEresults.Data = [];
            cla(app.ThIDFig)
            cla(app.UIDFig)
            app.Label_SampleList.Text = 'ID';
            app.Label_cpsSampleList.Text = 'ID';
        end
        
        function plotIDLR(app,isotope)
            %---------------------------------------------------------------------------------
            % Function: ID vs LR plot
            % This function creates Th232 and U238 isotopic diution vs linear regression
            % plots.
            %% -------------------------------------------------------------------------------
            
            if strcmp(isotope,'Th232(ID)')
                xIDFig = 'ThIDFig';
            elseif strcmp(isotope,'U238(ID)')
                xIDFig = 'UIDFig';
            end
            iRx = find(strcmp(app.Output.TE.IsotopesID,isotope));
            xLR = app.Output.TE.C.DC.Sample(iRx,~isnan(app.Output.TE.C.ID.Sample(iRx,1:end)));
            xID = app.Output.TE.C.ID.Sample(iRx,~isnan(app.Output.TE.C.ID.Sample(iRx,1:end)));
            dxLR = app.Output.TE.dC.DC.Sample(iRx,~isnan(app.Output.TE.C.ID.Sample(iRx,1:end)));
            dxID = app.Output.TE.dC.ID.Sample(iRx,~isnan(app.Output.TE.C.ID.Sample(iRx,1:end)));
            [px,~] = polyfit(xLR,xID,1);
            fTh = polyval(px,xLR);
            app.(xIDFig).NextPlot = 'replace';
            sca = errorbar(app.(xIDFig),xLR,xID,dxID,dxID,dxLR,dxLR,'.k','MarkerSize',10,'LineStyle','none');
            lin = line(app.(xIDFig),xLR,fTh,'LineStyle','-','Color','k');
            app.(xIDFig).XLim = [min([app.(xIDFig).XLim(1),app.(xIDFig).YLim(1)]),max([app.(xIDFig).XLim(2),app.(xIDFig).YLim(2)])];
            app.(xIDFig).YLim = [min([app.(xIDFig).XLim(1),app.(xIDFig).YLim(1)]),max([app.(xIDFig).XLim(2),app.(xIDFig).YLim(2)])];
            text(app.(xIDFig),app.(xIDFig).XLim(1)+(app.(xIDFig).XLim(2)-app.(xIDFig).XLim(1))*0.1,app.(xIDFig).YLim(1)+(app.(xIDFig).YLim(2)-app.(xIDFig).YLim(1))*0.9,4,['y = ',num2str(px(1),'%.2f'),'x + ',num2str(px(2),'%.2f')],'FontName','Courier')
            app.(xIDFig).XGrid = 'on';
            app.(xIDFig).YGrid = 'on';
            if strcmp(isotope,'Th232(ID)')
                app.(xIDFig).XLabel.String = '232Th, LR (ppm)';
                app.(xIDFig).YLabel.String = '232Th, ID (ppm)';
            elseif strcmp(isotope,'U238(ID)')
                app.(xIDFig).XLabel.String = '238U, LR (ppm)';
                app.(xIDFig).YLabel.String = '238U, ID (ppm)';
            end
            app.(xIDFig).FontName = 'Courier';
        end
        
        function discard = CheckForChanges(app,msg,button)
            %---------------------------------------------------------------------------------
            % Function: Check for unsaved changes
            % This function scans the input for unsaved changes. Executed prior to loading a
            % new batch file, clearing the current input, and quitting ICPro.
            %% -------------------------------------------------------------------------------
            
            % Get all input data, parameters and selections
            INx = getInput(app);
            
            % Get currently loaded batch file or new batch window state (saved as ~newbatch.mat)
            if ~strcmp(app.ICProUIFigure.Name,'ICPro - unnamed batch')
                load([app.AppPath.folder,'/misc/Batch Input Files/',app.BatchName],'IN');
            else
                INx.BatchName = {'~newbatch'};
                load([app.AppPath.folder,'/misc/Batch Input Files/~newbatch.mat'],'IN');
            end
            
            % Compare input to batch file, in case of difference initiate 'unsaved changes' prompt
            if ~isequaln(IN,INx)
                title = 'Unsaved changes';
                selection = questdlg(msg,title,button,'Cancel',button);
                if strcmp(selection,button)
                    discard = true;
                else
                    discard = false;
                end
            else
                discard = true;
            end
            
            clearvars('INx')
        end
        
        function notification(app,type)
            %---------------------------------------------------------------------------------
            % Function: Notification sound
            % This function plays a notification sound after successful and failed tasks.
            %% -------------------------------------------------------------------------------
            
            if strcmp(type,'fail')
                [x,Fs] = audioread([app.AppPath.folder,'/misc/sounds/Basso.aiff']);
                sound(x*2,Fs)
            elseif strcmp(type,'success')
                [x,Fs] = audioread([app.AppPath.folder,'/misc/sounds/Glass.aiff']);
                sound(x,Fs)
            end
        end
        
        function SampleMatch(app)
            %---------------------------------------------------------------------------------
            % Function: Match up TE and Th/U sample IDs
            % This function matches TE and Th/U sample IDs based on their numbering. Only if
            % both TE and Th/U analyses are performed.
            %% -------------------------------------------------------------------------------
            
            %  Get ThU Sample IDs (ThU samples sorted into blocks with occasional NaN fields)
            app.SMatch.ThUind = find(~cellfun(@isempty,app.Output.ThU.SampleSeq(2:end)))+1;
            ThUSamples = app.Output.ThU.SampleSeq(app.SMatch.ThUind);
            
            % Determine TE/ThU sample matchups for ID
            if numel(ThUSamples) == numel(app.Output.TE.RunID.Sample)
                % If # of ThU samples equals # of TE samples, match up against each TE sample
                app.SMatch.TEind = 1 : numel(app.Output.TE.RunID.Sample);
            elseif numel(ThUSamples) < numel(app.Output.TE.RunID.Sample)
                % If # of ThU samples is smaller than # of TE samples, ThU samples were likely analysed in separate batches
                % Determine TE sample ID numbers
                [s,e] = regexp(app.Output.TE.RunID.Sample,'[0-9]*');
                TEIDnum = NaN(1,numel(app.Output.TE.RunID.Sample));
                for i = 1 : numel(app.Output.TE.RunID.Sample)
                    TEIDnum(i) = str2double(app.Output.TE.RunID.Sample{i}(s{i}(end):e{i}(end)));
                end
                % Determine ThU sample ID numbers & find corresponding TE sample matchups
                [s,e] = regexp(ThUSamples,'[0-9]*');
                ThUIDnum = NaN(1,numel(ThUSamples));
                app.SMatch.TEind = NaN(1,numel(ThUSamples));
                for i = 1 : numel(ThUSamples)
                    ThUIDnum(i) = str2double(ThUSamples{i}(s{i}(end):e{i}(end)));
                    app.SMatch.TEind(i) = find(ThUIDnum(i) == TEIDnum);
                end
            end
            % Create matchup table
            ThUMatchUp = repmat({'<NA>'},numel(app.Output.TE.RunID.Sample),1);ThUMatchUp(app.SMatch.TEind) = ThUSamples';
            app.SMatch.Table = cell2table([app.Output.TE.RunID.Sample,ThUMatchUp],'VariableNames',{'TE Samples','ThU Samples'});
            app.SMatch.IDcat = strcat(app.SMatch.Table{:,1},'/',app.SMatch.Table{:,2});
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function Splash(app)
            
        end

        % Button pushed function: Button_Run
        function Execute(app, event)
            %---------------------------------------------------------------------------------
            % Callback: Execute data processing
            % This function initiates the processing of TE and/or ThU raw data based on the
            % provided input parameters and selections. Results displayed in UI.
            %% -------------------------------------------------------------------------------
            
            % Change working directory to functions sub-directory
            cd([app.AppPath.folder,'/misc/functions/'])
            % Get all input data, parameters and selections and save to app property 'Input' (no output)
            [~] = getInput(app);
            
            % Waitbar setup
            if app.Button_TEtoggle.Value && ~app.Button_TEtoggle.Value
                w(1) = 0;
                w(2) = 1;
                msg{1} = 'Trace Element processing ...';
                msg{2} = {['Trace Element processing ', char(hex2dec('2713'))];'Done!'};
            elseif ~app.Button_TEtoggle.Value && app.Button_TEtoggle.Value
                w(1) = 0;
                w(2) = 1;
                msg{1} = 'Th/U processing ...';
                msg{2} = {['Th/U processing ', char(hex2dec('2713'))];'Done!'};
            elseif app.Button_TEtoggle.Value && app.Button_TEtoggle.Value
                w(1) = 0;
                w(2) = .5;
                w(3) = 1;
                msg{1} = 'Trace Element processing ...';
                msg{2} = {['Trace Element processing ', char(hex2dec('2713'))];'Th/U processing ...'};
                msg{3} = {['Trace Element processing ', char(hex2dec('2713'))];['Th/U processing ', char(hex2dec('2713'))];'Done!'};
            end
            
            wb = waitbar(w(1),msg{1});
            pause(1)
            wb = waitbar(w(2),wb,msg{2});
            wb.Position(4) = wb.Position(4)+10;
            pause(1)
            wb = waitbar(w(3),wb,msg{3});
            wb.Position(4) = wb.Position(4)+10;
            
            % Trace Element processing
            if app.Button_TEtoggle.Value == 1
                % Read & process TE raw data
                app.Output.TE = TE_ReadRaw(app.Input.TEpar,1);
                app.Output.TE = TE_Processor(app.Input.TEpar,app.Output.TE.C,app.Output.TE.dC,app.Output.TE.Isotopes,app.Output.TE.RunID,app.Input.WtPar,app.Input.SpikePar,app.Input.cps);
                
                % Display results in table
                app.Table_TEresults.Data = [app.Output.TE.C.DC.f_DC',app.Output.TE.C.ID.Sample'];
                app.Table_TEresults.ColumnName = ['Dilution factor';app.Output.TE.IsotopesID];
                app.Table_TEresults.RowName = app.Output.TE.RunID.Sample;
                app.CUSelTE.SelectedObject = app.ConcTE;
                setappdata(app.ICProUIFigure,'ActiveResultTE',app.DataSelTE.SelectedObject.Tag);
                
                % Plot ID vs linear calibration
                plotIDLR(app,'Th232(ID)')
                plotIDLR(app,'U238(ID)')
                
                % Enable export menu items
                app.TEsheet.Enable = app.Check_DC.Value;        % TE result sheet export
                app.IndResExp.Enable = 'on';                    % Individual result export menu
                app.TEIndRes.Enable = 'on';                     % TE individual result export menu
                app.Rawexport.Enable = 'on';                    % Individual raw data export
                app.RCexport.Enable = app.Check_RC.Value;       % Individual rinse corrected data export
                app.QCexport.Enable = app.Check_QC.Value;       % Individual QC corrected data export
                app.SCexport.Enable = app.Check_SC.Value;       % Individual spike corrected data export
                app.OCexport.Enable = app.Check_OC.Value;       % Individual oxide corrected data export
                app.BCexport.Enable = app.Check_BC.Value;       % Individual blank corrected data export
                app.DCexport.Enable = app.Check_DC.Value;       % Individual dilution corrected data export
                app.IDexport.Enable = app.Check_DC.Value;       % Individual isotopic dilution corrected data export
                app.IDLRplots.Enable = 'on';                    % ID vs LR plot export
                
                % Enable result switcher buttons and preselect results to preview
                app.RawButton.Enable = 'on';                    % Raw data selection button
                app.RCButton.Enable = app.Check_RC.Value;       % Rinse correceted data selection button
                app.QCButton.Enable = app.Check_QC.Value;       % QC correceted data selection button
                app.SCButton.Enable = app.Check_SC.Value;       % Spike correceted data selection button
                app.OCButton.Enable = app.Check_OC.Value;       % Oxide correceted data selection button
                app.BCButton.Enable = app.Check_BC.Value;       % Blank correceted data selection button
                app.DCButton.Enable = app.Check_DC.Value;       % Dilution correceted data selection button
                app.IDButton.Enable = app.Check_DC.Value;       % Isotopic dilution correceted data selection button
                app.ConcTE.Enable = 'on';                       % Concentration selection button
                app.ErrTE.Enable = 'on';                        % Error selection button
                app.ErrpTE.Enable = 'on';                       % Percentage error selection button
                app.CUSelTE.SelectedObject = app.ConcTE;        % Preselect concentration display
                if app.Check_DC.Value
                    app.DataSelTE.SelectedObject = app.IDButton;    % Preselect isotopic dilution corrected data
                else
                    app.DataSelTE.SelectedObject = app.RawButton;   % Preselect raw data (if no dilution correction was performed)
                end
            end
            
            % Th/U processing
            if app.Button_ThUtoggle.Value == 1
                SampleMatch(app)
                % Calculate Th/U ratios from ICP-MS raw counts & Th230/U236 isotopic dilution
                app.Output.ThU = ThU_Processor(app.Input.ThUpar,app.Input.SpikePar,app.Input.WtPar,app.SMatch,1);
                
                % Display analysis sequence in 'Sequence' tab
                SeqTab = cell(ceil(numel(app.Output.ThU.Sequence)/3)*3,1);
                SeqTab(1:numel(app.Output.ThU.Sequence)) = app.Output.ThU.Sequence;
                SeqTab = reshape(SeqTab,[],3);
                app.SequenceList.Data = SeqTab;
                app.SequenceList.ColumnName = {'Seq. 1/3','Seq. 2/3','Seq 3/3'};
                
                % Display results in table
                app.ThUIDButton.Value = 1;
                app.ConcThU.Value = 1;
                app.Table_ThUresults.Data = [app.Output.ThU.ID.Th230',app.Output.ThU.ID.U234'];
                app.Table_ThUresults.ColumnName = {'Th230 (ID)','U234 (ID)'};
                ind = find(~cellfun(@isempty,app.Output.ThU.SampleSeq(2:end)))+1;
                app.Table_ThUresults.RowName = app.Output.ThU.SampleSeq(ind);
                app.CUSelThU.SelectedObject = app.ConcThU;
                app.ConcThU.Text = '  Conc. (pg/g)';
                app.ErrThU.Text = '  Errors (pg/g)';
                setappdata(app.ICProUIFigure,'ActiveResultThU',app.DataSelThU.SelectedObject.Tag);
                
                % Enable export menu items
                app.ThUsheet.Enable = 'on';                 % Th/U result sheet export
                app.IndResExp.Enable = 'on';                % Individual result export menu
                app.ThUIndRes.Enable = 'on';                % Th/U individual result export menu
                app.ThUIDExp.Enable = 'on';                 % Individual Th & U isotopic dilution export
                app.SamRatioExp.Enable = 'on';              % Individual sample Th & U ratio export
                app.NatURatioExp.Enable = 'on';             % Individual NatU Th & U ratio export
                
                % Enable result switcher buttons and preselect results to preview
                app.ThUIDButton.Enable = 'on';              % Th & U isotopic dilution button
                app.RatioSButton.Enable = 'on';             % Sample Th & U ratio button
                app.RatioNButton.Enable = 'on';             % NatU Th & U ratio button
                app.ConcThU.Enable = 'on';                  % Concentration/Ratio selection button
                app.ErrThU.Enable = 'on';                   % Error selection button
                app.ErrpThU.Enable = 'on';                  % Percentage error slection button
                app.CUSelThU.SelectedObject = app.ConcThU;       % Preselect concentration display
                app.DataSelThU.SelectedObject = app.ThUIDButton; % Preselect isotopic dilution display
            end
            
            % FLUX CALCULATIONS (TBD)
            if app.Button_ThUtoggle.Value == 1 && app.Button_TEtoggle.Value == 1
                
            end
            
            % notification(app,'success')
            
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
        end

        % Value changed function: Button_TEtoggle, 
        % Button_ThUtoggle, Check_DC
        function AnalysisToggle(app, event)
            %---------------------------------------------------------------------------------
            % Callback: (Un)toggle ThU and TE processing
            % This function toggles or untoggles the processing of TE and ThU. Based on the
            % processing steps selected, required and obsolete input fields will be enabled
            % and disbaled, respectively.
            %% -------------------------------------------------------------------------------
            
            % Determine analyses' toggle state
            State.TE = app.Button_TEtoggle.Value && ~app.Button_ThUtoggle.Value;
            State.ThU = ~app.Button_TEtoggle.Value && app.Button_ThUtoggle.Value;
            State.both = app.Button_TEtoggle.Value && app.Button_ThUtoggle.Value;
            State.none = ~app.Button_TEtoggle.Value && ~app.Button_ThUtoggle.Value;
            
            % Disable/Enable input fields
            % Get fields for enabling/disabling
            Th229SpikeFields = findall(app.SpikesPanel,'-regexp','Tag','229','-and','-regexp','Type','DropDown','-or','-regexp','Tag','229','-and','-regexp','Type','NumericEditField');
            Th229SpikeButtns = findall(app.SpikesPanel,'-regexp','Tag','229','-and','-regexp','Type','Button');
            Th230SpikeFields = findall(app.SpikesPanel,'-regexp','Tag','230','-and','-regexp','Type','DropDown','-or','-regexp','Tag','230','-and','-regexp','Type','NumericEditField');
            Th230SpikeButtns = findall(app.SpikesPanel,'-regexp','Tag','230','-and','-regexp','Type','Button');
            Th236SpikeFields = findall(app.SpikesPanel,'-regexp','Tag','236','-and','-regexp','Type','DropDown','-or','-regexp','Tag','236','-and','-regexp','Type','NumericEditField');
            Th236SpikeButtns = findall(app.SpikesPanel,'-regexp','Tag','236','-and','-regexp','Type','Button');
            WeightTabFields = findall(app.Tab_IDWeights,'-regexp','Type','TextArea','-not',{'-regexp','Tag','Field_ThBC','-or','-regexp','Tag','SC','-or','-regexp','Tag','BC'});
            RawIntTabFields = findall(app.Tab_RawIntensities,'-regexp','Type','TextArea','-or','-regexp','Type','Button');
            TEResuTabFields = findall(app.Tab_TEresults,'-regexp','Type','ButtonGroup','-or','-regexp','Type','Table');
            TEPlotTabFields = findall(app.Tab_TEplot,'-regexp','Type','DropDown');
            ThUResTabFields = findall(app.Tab_ThUresults,'-regexp','Type','ButtonGroup','-or','-regexp','Type','Table');
            
            % Change toggle button appearances & disable/enable panels
            if event.Source ~= app.Check_DC
                if State.TE
                    set(app.Panel_TE,'Enable','on')
                    set(app.Button_TEtoggle,'Icon','misc/icons/tick.png')
                    set(app.Button_TEtoggle,'BackgroundColor',[.5 1 .5])
                    set(app.Panel_ThU,'Enable','off')
                    set(app.Button_ThUtoggle,'Icon','misc/icons/x.png')
                    set(app.Button_ThUtoggle,'BackgroundColor',[1 .5 .5])
                elseif State.ThU
                    set(app.Panel_TE,'Enable','off')
                    set(app.Button_TEtoggle,'Icon','misc/icons/x.png')
                    set(app.Button_TEtoggle,'BackgroundColor',[1 .5 .5])
                    set(app.Panel_ThU,'Enable','on')
                    set(app.Button_ThUtoggle,'Icon','misc/icons/tick.png')
                    set(app.Button_ThUtoggle,'BackgroundColor',[.5 1 .5])
                elseif State.both
                    set(app.Panel_TE,'Enable','on')
                    set(app.Button_TEtoggle,'Icon','misc/icons/tick.png')
                    set(app.Button_TEtoggle,'BackgroundColor',[.5 1 .5])
                    set(app.Panel_ThU,'Enable','on')
                    set(app.Button_ThUtoggle,'Icon','misc/icons/tick.png')
                    set(app.Button_ThUtoggle,'BackgroundColor',[.5 1 .5])
                elseif State.none
                    set(app.Panel_TE,'Enable','off')
                    set(app.Button_TEtoggle,'Icon','misc/icons/x.png')
                    set(app.Button_TEtoggle,'BackgroundColor',[1 .5 .5])
                    set(app.Panel_ThU,'Enable','off')
                    set(app.Button_ThUtoggle,'Icon','misc/icons/x.png')
                    set(app.Button_ThUtoggle,'BackgroundColor',[1 .5 .5])
                end
            end
            
            % Specify fields to be disabled/enabled for each analysis selection state
            if State.TE
                if true(app.Check_DC.Value)
                    % DISABLE
                    DisableFields = [...
                        app.Field_ThBC;...                              % [-] Th(BC) weight field
                        ThUResTabFields;...                             % [-] Th/U results tab
                        Th229SpikeFields;Th229SpikeButtns...            % [-] Th229 spike fields and buttons (incl. U236 RYb)
                        ];
                    % ENABLE
                    EnableFields = [...
                        app.Button_Run;...                              % [+] Execute button
                        WeightTabFields;...                             % [+] All non-spike weight fields
                        RawIntTabFields;...                             % [+] All raw intensity input fields
                        app.Field_UBC;app.Field_ThSC;app.Field_USC;...  % [+] U(BC), Th(SC), U(SC) weight fields
                        TEResuTabFields;TEPlotTabFields;...             % [+] TE results and ID/LR plot tabs
                        app.SpikesPanel;...                             % [+] Spike panel
                        Th236SpikeFields;Th236SpikeButtns;...           % [+] Th236 spike fields and buttons (excl. U236 RYa/b)
                        Th230SpikeFields;Th230SpikeButtns...            % [+] Th230 spike fields and buttons (incl. U236 RYa)
                        ];
                else
                    % DISABLE
                    DisableFields = [...
                        WeightTabFields;...                             % [-] All non-spike weight fields
                        RawIntTabFields;...                             % [-] All raw intensity input fields
                        app.Field_ThBC;app.Field_ThSC;...               % [-] Th(BC), Th(SC) weight fields
                        app.Field_UBC;app.Field_USC;...                 % [-] U(BC), U(SC) weight fields
                        app.SpikesPanel;...                             % [-] Spike panel
                        Th229SpikeFields;Th229SpikeButtns;...           % [-] Th229 spike fields and buttons (incl. U236 RYb)
                        Th230SpikeFields;Th230SpikeButtns;...           % [-] Th230 spike fields and buttons (incl. U236 RYa)
                        Th236SpikeFields;Th236SpikeButtns;...           % [-] Th236 spike fields and buttons (excl. U236 RYa/b)
                        TEPlotTabFields;...                             % [-] ID/LR plot tabs
                        ThUResTabFields...                              % [-] Th/U results tab
                        ];
                    % ENABLE
                    EnableFields = [...
                        app.Button_Run;...                              % [+] Execute button
                        TEResuTabFields...                              % [+] TE results
                        ];
                end
            elseif State.ThU
                % DISABLE
                DisableFields = [...
                    app.Field_ThSC;app.Field_USC;...                    % [-] Th(SC), U(SC) weight field
                    RawIntTabFields;...                                 % [-] All raw intensity input fields
                    TEResuTabFields;TEPlotTabFields;...                 % [-] TE results and ID/LR plot tabs
                    Th230SpikeFields;Th230SpikeButtns...                % [-] Th230 spike fields and buttons (incl. U236 RYa)
                    ];
                % ENABLE
                EnableFields = [...
                    app.Button_Run;...                                  % [+] Execute button
                    WeightTabFields;...                                 % [+] All non-spike weight fields
                    app.Field_ThBC;app.Field_UBC;...                    % [+] Th(BC), U(BC) weight fields
                    ThUResTabFields;...                                 % [+] Th/U results tab
                    app.SpikesPanel;...                                 % [+] Spike panel
                    Th236SpikeFields;Th236SpikeButtns;...               % [+] Th236 spike fields and buttons (excl. U236 RYa/b)
                    Th229SpikeFields;Th229SpikeButtns...                % [+] Th229 spike fields and buttons (incl. U236 RYb)
                    ];
            elseif State.both
                if true(app.Check_DC.Value)
                    % DISABLE
                    DisableFields = [];
                    % ENABLE
                    EnableFields = [...
                        app.Button_Run;...                              % [+] Execute button
                        WeightTabFields;...                             % [+] All non-spike weight fields
                        RawIntTabFields;...                             % [+] All raw intensity input fields
                        app.Field_ThBC;app.Field_ThSC;...               % [+] Th(BC), Th(SC) weight fields
                        app.Field_UBC;app.Field_USC;...                 % [+] U(BC), U(SC) weight fields
                        TEResuTabFields;TEPlotTabFields;...             % [+] TE results and ID/LR plot tabs
                        ThUResTabFields;...                             % [+] Th/U results tab
                        app.SpikesPanel;...                             % [+] Spike panel
                        Th236SpikeFields;Th236SpikeButtns;...           % [+] Th236 spike fields and buttons (excl. U236 RYa/b)
                        Th230SpikeFields;Th230SpikeButtns;...           % [+] Th230 spike fields and buttons (incl. U236 RYa)
                        Th229SpikeFields;Th229SpikeButtns...            % [+] Th229 spike fields and buttons (incl. U236 RYb)
                        ];
                else
                    % DISABLE
                    DisableFields = [...
                        app.Field_ThSC;app.Field_USC;...                % [-] Th(SC), U(SC) weight field
                        TEResuTabFields;...                             % [-] TE results
                        Th230SpikeFields;Th230SpikeButtns...            % [-] Th230 spike fields and buttons (incl. U236 RYa)
                        ];
                    % ENABLE
                    EnableFields = [...
                        app.Button_Run;...                              % [+] Execute button
                        WeightTabFields;...                             % [+] All non-spike weight fields
                        app.Field_ThBC;app.Field_UBC;...                % [+] Th(BC), U(BC) weight fields
                        TEPlotTabFields;...                             % [+] ID/LR plot tabs
                        ThUResTabFields;...                             % [+] Th/U results tab
                        app.SpikesPanel;...                             % [+] Spike panel
                        Th236SpikeFields;Th236SpikeButtns;...           % [+] Th236 spike fields and buttons (excl. U236 RYa/b)
                        Th229SpikeFields;Th229SpikeButtns...            % [+] Th229 spike fields and buttons (incl. U236 RYb)
                        ];
                end
            elseif State.none
                % DISABLE
                DisableFields = [...
                    app.Button_Run;...                                  % [-] Execute button
                    WeightTabFields;...                                 % [-] All non-spike weight fields
                    RawIntTabFields;...                                 % [-] All raw intensity input fields
                    app.Field_ThBC;app.Field_ThSC;...                   % [-] Th(BC), Th(SC) weight fields
                    app.Field_UBC;app.Field_USC;...                     % [-] U(BC), U(SC) weight fields
                    app.SpikesPanel;...                                 % [-] Spike panel
                    Th236SpikeFields;Th236SpikeButtns;...               % [-] Th236 spike fields and buttons (excl. U236 RYa/b)
                    Th229SpikeFields;Th229SpikeButtns;...               % [-] Th229 spike fields and buttons (incl. U236 RYb)
                    Th230SpikeFields;Th230SpikeButtns;...               % [-] Th230 spike fields and buttons (incl. U236 RYa)
                    TEResuTabFields;TEPlotTabFields;...                 % [-] ID/LR plot tabs and TE results
                    ThUResTabFields...                                  % [-] Th/U results tab
                    ];
                % ENABLE
                EnableFields = [];
            end
            
            if app.DropDown_229.Value == 0
                DisableFields = [DisableFields;Th229SpikeButtns];
            else
                EnableFields = [EnableFields;Th229SpikeButtns];
            end
            if app.DropDown_230.Value == 0
                DisableFields = [DisableFields;Th230SpikeButtns];
            else
                EnableFields = [EnableFields;Th230SpikeButtns];
            end
            if app.DropDown_236.Value == 0
                DisableFields = [DisableFields;Th236SpikeButtns];
            else
                EnableFields = [EnableFields;Th236SpikeButtns];
            end
            
            for iE = 1 : length(EnableFields)
                EnableFields(iE).Enable = 'on';
            end
            for iD = 1 : length(DisableFields)
                DisableFields(iD).Enable = 'off';
            end
            
            SampleList(app,event)
        end

        % Button pushed function: Button_RawFile, Button_RawFolder
        function BrowseRawData(app, event)
            %---------------------------------------------------------------------------------
            % Callback: File browser UI
            % This function initiates a file browser UI, allowing the user to locate raw data
            % files and folders.
            %% -------------------------------------------------------------------------------
            
            if event.Source == app.Button_RawFile
                [TERawFile,TERawPath] = uigetfile('.xlsx','Pick a Trace Element raw file');
                if TERawPath ~= 0
                    set(app.Field_RawFile,'Value',[TERawPath,TERawFile])
                end
            elseif event.Source == app.Button_RawFolder
                ThURawPath = uigetdir('','Pick a Th/U raw data folder');
                if ThURawPath ~= 0
                    set(app.Field_RawFolder,'Value',[ThURawPath,'/'])
                end
            end
            
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
        end

        % Value changed function: Field_BlankID, Field_NBlocks, 
        % Field_NSamples, Field_RawFile, Field_RawFolder, 
        % Field_SIDTE, Field_SIDThU
        function SampleList(app, event)
            %---------------------------------------------------------------------------------
            % Callback: Generate sample ID list
            % This function generates a list of sample IDs next to input fields.
            %% -------------------------------------------------------------------------------
            [~] = getInput(app);
            
            TEallin = ~isempty(app.Field_RawFile.Value) && ~isempty(app.Field_SIDTE.Value) && ~isempty(app.Field_BlankID.Value);
            ThUallin = ~isempty(app.Field_RawFolder.Value) && ~isempty(app.Field_NBlocks.Value) && ~isempty(app.Field_NSamples.Value) && ~isempty(app.Field_SIDThU.Value);
            
            % CASE 1: TE + dilution correction
            if app.Button_TEtoggle.Value && ~app.Button_ThUtoggle.Value && app.Check_DC.Value
                % Change ID input title
                app.Label_SampleList.Text = 'TE ID';
                app.Label_cpsSampleList.Text = 'TE ID';
                % Only attempt to generate sample list if all required inputs are provided
                if TEallin
                    % Get TE IDs by running reduced version of TE_ReadRaw (input 0)
                    app.Output.TE = TE_ReadRaw(app.Input.TEpar,0);
                    
                    % If incorrect ID inputs were provided no Blank/Sample ID will be detected (error prompt)
                    if isempty(app.Output.TE.RunID.Blank)
                        warndlg('Procedural Blank ID not found in file. Check ID provided.','Incorrect input')
                        set(app.Field_SampleList,'Visible','off')
                    end
                    if isempty(app.Output.TE.RunID.Sample)
                        warndlg('Sample ID initials not found in file. Check sample initials provided.','Incorrect input')
                        set(app.Field_SampleList,'Visible','off')
                    end
                    
                    % If Sample and Blank ID were identified correctly proceed to generate list
                    if ~isempty(app.Output.TE.RunID.Sample) && ~isempty(app.Output.TE.RunID.Blank)
                        set(app.Field_SampleList,'Visible','on')
                        set(app.Field_SampleList,'Enable','on')
                        set(app.Field_SampleList,'Editable','off')
                        set(app.Field_SampleList,'Value',app.Output.TE.RunID.Sample)
                        set(app.Field_cpsSampleList,'Visible','on')
                        set(app.Field_cpsSampleList,'Value',app.Output.TE.RunID.Sample)
                    end
                else
                    set(app.Field_SampleList,'Visible','off')
                end
            end
            
            % CASE 2: ThU or ThU & TE-dilution correction
            if (~app.Button_TEtoggle.Value || (app.Button_TEtoggle.Value && ~app.Check_DC.Value)) && app.Button_ThUtoggle.Value
                % Change ID input title
                app.Label_SampleList.Text = 'Th/U ID';
                app.Label_cpsSampleList.Text = 'Th/U ID';
                % Only attempt to generate sample list if all required inputs are provided
                if ThUallin
                    app.Output.ThU = ThU_Processor(app.Input.ThUpar,app.Input.SpikePar,app.Input.WtPar,app.SMatch,0);
                    
                    % If Sample ID was identified correctly proceed to generate list
                    if isstruct(app.Output.ThU)
                        set(app.Field_SampleList,'Visible','on')
                        set(app.Field_SampleList,'Enable','on')
                        set(app.Field_SampleList,'Editable','off')
                        set(app.Field_SampleList,'Value',app.Output.ThU.SampleSeq(2:end))
                    else
                        set(app.Field_SampleList,'Visible','off')
                    end
                end
            end
            
            % CASE 3: ThU & TE+dilution correction
            if app.Button_TEtoggle.Value && app.Button_ThUtoggle.Value && app.Check_DC.Value
                % Change ID input title
                app.Label_SampleList.Text = 'TE & Th/U ID';
                app.Label_cpsSampleList.Text = 'TE & Th/U ID';
                % Only attempt to generate sample list if all required inputs are provided
                if TEallin && ThUallin
                    app.Output.TE = TE_ReadRaw(app.Input.TEpar,0);
                    app.Output.ThU = ThU_Processor(app.Input.ThUpar,app.Input.SpikePar,app.Input.WtPar,app.SMatch,0);
                    
                    % If incorrect ID inputs were provided no Blank/Sample ID will be detected (error prompt)
                    if isempty(app.Output.TE.RunID.Blank)
                        warndlg('Procedural Blank ID not found in file. Check ID provided.','Incorrect input')
                        set(app.Field_SampleList,'Visible','off')
                    end
                    if isempty(app.Output.TE.RunID.Sample)
                        warndlg('Sample ID initials not found in file. Check sample initials provided.','Incorrect input')
                        set(app.Field_SampleList,'Visible','off')
                    end
                    
                    if isstruct(app.Output.ThU) && ~isempty(app.Output.TE.RunID.Sample) && ~isempty(app.Output.TE.RunID.Blank)
                        SampleMatch(app)
                        set(app.Field_SampleList,'Visible','on')
                        set(app.Field_SampleList,'Enable','on')
                        set(app.Field_SampleList,'Editable','off')
                        set(app.Field_SampleList,'Value',app.SMatch.IDcat(1:end))
                    else
                        set(app.Field_SampleList,'Visible','off')
                    end
                end
            end
            
            % CASE 4: None or TE-dilution correction
            if (~app.Button_TEtoggle.Value && ~app.Button_ThUtoggle.Value) || (app.Button_TEtoggle.Value && ~app.Check_DC.Value && ~app.Button_ThUtoggle.Value)
                app.Field_SampleList.Value = char([]);
                app.Field_SampleList.Visible = 0;
                app.Label_SampleList.Text = 'ID';
                app.Field_cpsSampleList.Value = char([]);
                app.Field_cpsSampleList.Visible = 0;
                app.Label_cpsSampleList.Text = 'ID';
            end
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
        end

        % Callback function: Button_Delete229, Button_Delete230, 
        % Button_Delete236, Button_EdtSve229, Button_EdtSve230, 
        % Button_EdtSve236, DropDown_229, DropDown_229, 
        % DropDown_230, DropDown_230, DropDown_236, DropDown_236
        function Spikes(app, event)
            %---------------------------------------------------------------------------------
            % Callback: Spike control
            % This function collectively manages the user's interaction with the spike panel:
            % - Spike selection via dropdown menu
            % - Adding and deleting spikes
            % - Editing spike parameters
            % - Automatic spike selection from imported batch file
            %% -------------------------------------------------------------------------------
            
            % App directory
            SpikeSheetPath = [app.AppPath.folder,'/misc/spikes.xlsx'];
            
            % Determine spike function to run
            if event.Source ~= app.LoadBatchMenu && event.Source ~= app.ClearBatchMenu
                SpikeFun = event.Source.Tag(1:3);
                SpikeIso = event.Source.Tag(4:6);
                if strcmp(SpikeIso,'229')
                    SpikeIsoLong = 'Th229';
                elseif strcmp(SpikeIso,'230')
                    SpikeIsoLong = 'Th230';
                elseif strcmp(SpikeIso,'236')
                    SpikeIsoLong = 'U236';
                end
            elseif event.Source == app.LoadBatchMenu
                SpikeFun = 'loadbatch';
                SpikeIso = {'229','230','236'};
                SpikeIsoLong = {'Th229','Th230','U236'};
            elseif event.Source == app.ClearBatchMenu
                SpikeFun = 'clearbatch';
                SpikeIso = {'229','230','236'};
                SpikeIsoLong = {'Th229','Th230','U236'};
            end
            
            % Spike dropdown (get/select spikes)
            if strcmp(SpikeFun,'get')
                opts = detectImportOptions(SpikeSheetPath,'Sheet',SpikeIsoLong);
                spikes = readtable(SpikeSheetPath,opts);
                spikesInf = spikes{:,2:end};
                spikesInf(spikesInf == 65535) = Inf;
                spikes{:,2:end} = spikesInf;
                if strcmp(event.EventName,'DropDownOpening')
                    % Create spike list when dropdown is opened
                    set(app.(['DropDown_',SpikeIso]),'Items',['Select';spikes{:,1};'Add'])
                    set(app.(['DropDown_',SpikeIso]),'ItemsData',[0;(1:length(spikes{:,1}))';999])
                elseif strcmp(event.EventName,'ValueChanged')
                    % Change to selected spike
                    value = app.(['DropDown_',SpikeIso]).Value;
                    if value > 0 && value < 999
                        set(app.(['Field_RY',SpikeIso]),'Value',spikes{value,2})
                        set(app.(['Field_RX',SpikeIso]),'Value',spikes{value,3})
                        set(app.(['Field_CY',SpikeIso]),'Value',spikes{value,4})
                        if strcmp(SpikeIso,'236')
                            set(app.(['Field_RYb',SpikeIso]),'Value',spikes{value,5})
                        end
                        set(app.(['Field_CY',SpikeIso]),'Editable','off')
                        set(app.(['Field_RX',SpikeIso]),'Editable','off')
                        set(app.(['Field_RY',SpikeIso]),'Editable','off')
                        set(app.(['Button_Delete',SpikeIso]),'Enable','on')
                        set(app.(['Button_EdtSve',SpikeIso]),'Text','edit')
                        set(app.(['Button_EdtSve',SpikeIso]),'Tag',['edt',SpikeIso])
                        set(app.(['Button_EdtSve',SpikeIso]),'Enable','on')
                    elseif value == 0
                        set(app.(['Field_RY',SpikeIso]),'Value',0)
                        set(app.(['Field_RX',SpikeIso]),'Value',0)
                        set(app.(['Field_CY',SpikeIso]),'Value',0)
                        set(app.(['Field_CY',SpikeIso]),'Editable','off')
                        set(app.(['Field_RX',SpikeIso]),'Editable','off')
                        set(app.(['Field_RY',SpikeIso]),'Editable','off')
                        set(app.(['Button_Delete',SpikeIso]),'Enable','off')
                        set(app.(['Button_EdtSve',SpikeIso]),'Text','edit')
                        set(app.(['Button_EdtSve',SpikeIso]),'Tag',['edt',SpikeIso])
                        set(app.(['Button_EdtSve',SpikeIso]),'Enable','off')
                    elseif value == 999
                        set(app.(['Field_CY',SpikeIso]),'Editable','on')
                        set(app.(['Field_RX',SpikeIso]),'Editable','on')
                        set(app.(['Field_RY',SpikeIso]),'Editable','on')
                        set(app.(['Button_Delete',SpikeIso]),'Enable','off')
                        set(app.(['Button_EdtSve',SpikeIso]),'Text','save')
                        set(app.(['Button_EdtSve',SpikeIso]),'Tag',['sve',SpikeIso])
                        set(app.(['Button_EdtSve',SpikeIso]),'Enable','on')
                        newspikeID = inputdlg('Enter spike ID:');
                        if ~isempty(newspikeID)
                            set(app.(['DropDown_',SpikeIso]),'Items',['Select';spikes{:,1};newspikeID;'Add'])
                            set(app.(['DropDown_',SpikeIso]),'ItemsData',[0;(1:length(spikes{:,1})+1)';999])
                            set(app.(['DropDown_',SpikeIso]),'Value',length(spikes{:,1})+1)
                            set(app.(['Field_RY',SpikeIso]),'Value',0)
                            set(app.(['Field_RX',SpikeIso]),'Value',0)
                            set(app.(['Field_CY',SpikeIso]),'Value',0)
                        else
                            app.(['DropDown_',SpikeIso]).Value = 0;
                            set(app.(['Field_RY',SpikeIso]),'Value',0)
                            set(app.(['Field_RX',SpikeIso]),'Value',0)
                            set(app.(['Field_CY',SpikeIso]),'Value',0)
                            set(app.(['Field_CY',SpikeIso]),'Editable','off')
                            set(app.(['Field_RX',SpikeIso]),'Editable','off')
                            set(app.(['Field_RY',SpikeIso]),'Editable','off')
                            set(app.(['Button_Delete',SpikeIso]),'Enable','off')
                            set(app.(['Button_EdtSve',SpikeIso]),'Text','edit')
                            set(app.(['Button_EdtSve',SpikeIso]),'Tag',['edt',SpikeIso])
                            set(app.(['Button_EdtSve',SpikeIso]),'Enable','off')
                        end
                    end
                end
            end
            
            % Edit spikes
            if strcmp(SpikeFun,'edt')
                set(app.(['Field_CY',SpikeIso]),'Editable','on')
                set(app.(['Field_RX',SpikeIso]),'Editable','on')
                set(app.(['Field_RY',SpikeIso]),'Editable','on')
                if strcmp(SpikeIso,'236')
                    set(app.(['Field_RYb',SpikeIso]),'Editable','on')
                end
                set(app.(['Button_EdtSve',SpikeIso]),'Text','save')
                set(app.(['Button_EdtSve',SpikeIso]),'Tag',['sve',SpikeIso])
                set(app.(['Button_EdtSve',SpikeIso]),'Enable','on')
            end
            
            % Save spikes
            if strcmp(SpikeFun,'sve')
                value = app.(['DropDown_',SpikeIso]).Value;
                opts = detectImportOptions(SpikeSheetPath,'Sheet',SpikeIsoLong);
                spikes = readtable(SpikeSheetPath,opts);
                if value > length(spikes{:,1})
                    if strcmp(SpikeIso,'236')
                        spikes = [spikes;{0,0,0,0,0}];
                    else
                        spikes = [spikes;{0,0,0,0}];
                    end
                    spikes{end,1} = app.(['DropDown_',SpikeIso]).Items(app.(['DropDown_',SpikeIso]).Value+1);
                end
                spikes{value,2} = app.(['Field_RY',SpikeIso]).Value;
                spikes{value,3} = app.(['Field_RX',SpikeIso]).Value;
                spikes{value,4} = app.(['Field_CY',SpikeIso]).Value;
                if strcmp(SpikeIso,'236')
                    spikes{value,5} = app.(['Field_RYb',SpikeIso]).Value;
                end
                writetable(spikes,SpikeSheetPath,'Sheet',SpikeIsoLong,'WriteMode','overwritesheet')
                set(app.(['Field_CY',SpikeIso]),'Editable','off')
                set(app.(['Field_RX',SpikeIso]),'Editable','off')
                set(app.(['Field_RY',SpikeIso]),'Editable','off')
                if strcmp(SpikeIso,'236')
                    set(app.(['Field_RYb',SpikeIso]),'Editable','off')
                end
                set(app.(['Button_EdtSve',SpikeIso]),'Text','edit')
                set(app.(['Button_EdtSve',SpikeIso]),'Tag',['edt',SpikeIso])
                set(app.(['Button_EdtSve',SpikeIso]),'Enable','on')
                set(app.(['Button_Delete',SpikeIso]),'Enable','on')
            end
            
            % Delete spikes
            if strcmp(SpikeFun,'dlt')
                value = app.(['DropDown_',SpikeIso]).Value;
                % Confirm dialog
                msg = ['Do you want to delete spike ''',app.(['DropDown_',SpikeIso]).Items{value+1},''''];
                title = 'Confirm Delete';
                selection = questdlg(msg,title,'Ok','Cancel','Ok');
                if strcmp(selection,'Ok')
                    opts = detectImportOptions(SpikeSheetPath,'Sheet',SpikeIsoLong);
                    spikes = readtable(SpikeSheetPath,opts);
                    spikes(value,:) = [];
                    writetable(spikes,SpikeSheetPath,'Sheet',SpikeIsoLong,'WriteMode','overwritesheet')
                    set(app.(['DropDown_',SpikeIso]),'Items',['Select';spikes{:,1};'Add'])
                    set(app.(['DropDown_',SpikeIso]),'ItemsData',[0;(1:length(spikes{:,1}))';999])
                    app.(['DropDown_',SpikeIso]).Value = 0;
                    set(app.(['Field_RY',SpikeIso]),'Value',0)
                    set(app.(['Field_RX',SpikeIso]),'Value',0)
                    set(app.(['Field_CY',SpikeIso]),'Value',0)
                    set(app.(['Field_CY',SpikeIso]),'Editable','off')
                    set(app.(['Field_RX',SpikeIso]),'Editable','off')
                    set(app.(['Field_RY',SpikeIso]),'Editable','off')
                    if strcmp(SpikeIso,'236')
                        set(app.(['Field_RYb',SpikeIso]),'Value',0)
                        set(app.(['Field_RYb',SpikeIso]),'Editable','off')
                    end
                    set(app.(['Button_EdtSve',SpikeIso]),'Text','edit')
                    set(app.(['Button_EdtSve',SpikeIso]),'Tag',['edt',SpikeIso])
                    set(app.(['Button_EdtSve',SpikeIso]),'Enable','off')
                    set(app.(['Button_Delete',SpikeIso]),'Enable','off')
                end
            end
            
            % Load spikes of imported batch
            if strcmp(SpikeFun,'loadbatch')
                % Create spike list
                for i = 1 : 3
                    opts = detectImportOptions(SpikeSheetPath','Sheet',SpikeIsoLong{i});
                    spikes = readtable(SpikeSheetPath,opts);
                    spikesInf = spikes{:,2:end};
                    spikesInf(spikesInf == 65535) = Inf;
                    spikes{:,2:end} = spikesInf;
                    set(app.(['DropDown_',SpikeIso{i}]),'Items',['Select';spikes{:,1};'Add'])
                    set(app.(['DropDown_',SpikeIso{i}]),'ItemsData',[0;(1:length(spikes{:,1}))';999])
                    if isfield(app.Input,'SpikeSel')
                        set(app.(['DropDown_',SpikeIso{i}]),'Value',app.Input.SpikeSel(i))
                        if app.Input.SpikeSel(i) > 0 && app.Input.SpikeSel(i) < 999
                            set(app.(['Field_RY',SpikeIso{i}]),'Value',spikes{app.Input.SpikeSel(i),2})
                            set(app.(['Field_RX',SpikeIso{i}]),'Value',spikes{app.Input.SpikeSel(i),3})
                            set(app.(['Field_CY',SpikeIso{i}]),'Value',spikes{app.Input.SpikeSel(i),4})
                            if i == 3
                                set(app.(['Field_RYb',SpikeIso{i}]),'Value',spikes{app.Input.SpikeSel(i),5})
                            end
                            set(app.(['Button_Delete',SpikeIso{i}]),'Enable','on')
                            set(app.(['Button_EdtSve',SpikeIso{i}]),'Enable','on')
                        elseif app.Input.SpikeSel(i) == 0
                            set(app.(['Field_RY',SpikeIso{i}]),'Value',Inf)
                            set(app.(['Field_RX',SpikeIso{i}]),'Value',0)
                            set(app.(['Field_CY',SpikeIso{i}]),'Value',0)
                            if i == 3
                                set(app.(['Field_RYb',SpikeIso{i}]),'Value',Inf)
                            end
                            set(app.(['Button_Delete',SpikeIso{i}]),'Enable','off')
                            set(app.(['Button_EdtSve',SpikeIso{i}]),'Enable','off')
                        end
                        set(app.(['Field_CY',SpikeIso{i}]),'Editable','off')
                        set(app.(['Field_RX',SpikeIso{i}]),'Editable','off')
                        set(app.(['Field_RY',SpikeIso{i}]),'Editable','off')
                    else
                        set(app.(['DropDown_',SpikeIso{i}]),'Value',0)
                        set(app.(['Field_RY',SpikeIso{i}]),'Value',Inf)
                        set(app.(['Field_RX',SpikeIso{i}]),'Value',0)
                        set(app.(['Field_CY',SpikeIso{i}]),'Value',0)
                        if i == 3
                            set(app.(['Field_RYb',SpikeIso{i}]),'Value',Inf)
                        end
                        set(app.(['Button_Delete',SpikeIso{i}]),'Enable','off')
                        set(app.(['Button_EdtSve',SpikeIso{i}]),'Enable','off')
                    end
                    set(app.(['Field_CY',SpikeIso{i}]),'Editable','off')
                    set(app.(['Field_RX',SpikeIso{i}]),'Editable','off')
                    set(app.(['Field_RY',SpikeIso{i}]),'Editable','off')
                    if i == 3
                        set(app.(['Field_RYb',SpikeIso{i}]),'Editable','off')
                    end
                    set(app.(['Button_EdtSve',SpikeIso{i}]),'Text','edit')
                    set(app.(['Button_EdtSve',SpikeIso{i}]),'Tag',['edt',SpikeIso{i}])
                end
            end
            
            % Reset spikes for new batch
            if strcmp(SpikeFun,'clearbatch')
                % Create spike list
                for i = 1 : 3
                    set(app.(['DropDown_',SpikeIso{i}]),'Value',0)
                    set(app.(['Field_RY',SpikeIso{i}]),'Value',Inf)
                    set(app.(['Field_RX',SpikeIso{i}]),'Value',0)
                    set(app.(['Field_CY',SpikeIso{i}]),'Value',0)
                    set(app.(['Field_CY',SpikeIso{i}]),'Editable','off')
                    set(app.(['Field_RX',SpikeIso{i}]),'Editable','off')
                    set(app.(['Field_RY',SpikeIso{i}]),'Editable','off')
                    if i == 3
                        set(app.(['Field_RYb',SpikeIso{i}]),'Value',Inf)
                        set(app.(['Field_RYb',SpikeIso{i}]),'Editable','off')
                    end
                    set(app.(['Button_Delete',SpikeIso{i}]),'Enable','off')
                    set(app.(['Button_EdtSve',SpikeIso{i}]),'Text','edit')
                    set(app.(['Button_EdtSve',SpikeIso{i}]),'Tag',['edt',SpikeIso{i}])
                    set(app.(['Button_EdtSve',SpikeIso{i}]),'Enable','off')
                end
            end
            
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
        end

        % Selection changed function: CUSelTE, DataSelTE
        function SwitchResultTE(app, event)
            %---------------------------------------------------------------------------------
            % Callback: TE result selection
            % This function manages the selection and display of TE processing results.
            %% -------------------------------------------------------------------------------
            
            Selection = app.DataSelTE.SelectedObject.Tag;
            if strcmp(app.CUSelTE.SelectedObject.Tag,'Conc')
                if (strcmp(Selection,'ID') || strcmp(Selection,'DC')) && app.Check_DC.Value == 1
                    app.Table_TEresults.Data = [app.Output.TE.C.DC.f_DC',app.Output.TE.C.(Selection).Sample'];
                else
                    app.Table_TEresults.Data = app.Output.TE.C.(Selection).Sample';
                end
            elseif strcmp(app.CUSelTE.SelectedObject.Tag,'Err')
                if (strcmp(Selection,'ID') || strcmp(Selection,'DC')) && app.Check_DC.Value == 1
                    app.Table_TEresults.Data = [app.Output.TE.dC.DC.f_DC',app.Output.TE.dC.(Selection).Sample'];
                else
                    app.Table_TEresults.Data = app.Output.TE.dC.(Selection).Sample';
                end
            elseif strcmp(app.CUSelTE.SelectedObject.Tag,'Errp')
                if (strcmp(Selection,'ID') || strcmp(Selection,'DC')) && app.Check_DC.Value == 1
                    app.Table_TEresults.Data = [app.Output.TE.dC.DC.f_DC'./app.Output.TE.C.DC.f_DC',app.Output.TE.dC.(Selection).Sample'./app.Output.TE.C.(Selection).Sample'];
                else
                    app.Table_TEresults.Data = app.Output.TE.dC.(Selection).Sample'./app.Output.TE.C.(Selection).Sample';
                end
            end
            setappdata(app.ICProUIFigure,'ActiveResultTE',Selection);
            
            if (strcmp(Selection,'ID')) && app.Check_DC.Value == 1
                app.Table_TEresults.ColumnName = ['Dilution factor';app.Output.TE.IsotopesID];
            elseif (strcmp(Selection,'ID')) && app.Check_DC.Value == 0
                app.Table_TEresults.ColumnName = app.Output.TE.IsotopesID;
            elseif strcmp(Selection,'DC')
                app.Table_TEresults.ColumnName = ['Dilution factor';app.Output.TE.Isotopes];
            else
                app.Table_TEresults.ColumnName = app.Output.TE.Isotopes;
            end
        end

        % Selection changed function: CUSelThU, DataSelThU
        function SwitchResultThU(app, event)
            %---------------------------------------------------------------------------------
            % Callback: ThU result selection
            % This function manages the selection and display of ThU processing results.
            %% -------------------------------------------------------------------------------
            
            Selection = app.DataSelThU.SelectedObject.Tag;
            ThUSampleInd = find(~cellfun(@isempty,app.Output.ThU.SampleSeq(2:end)))+1;
            if strcmp(app.CUSelThU.SelectedObject.Tag,'Conc')
                if strcmp(Selection,'SampleMB')
                    app.Table_ThUresults.Data = [app.Output.ThU.Ratios.Sample.R229_230_cMB(ThUSampleInd)',app.Output.ThU.Ratios.Sample.R236_234_cMB(ThUSampleInd)'];
                elseif strcmp(Selection,'NatUMB')
                    app.Table_ThUresults.Data = app.Output.ThU.Ratios.NatU.R235_234_cMB;
                elseif strcmp(Selection,'ThUID')
                    app.Table_ThUresults.Data = [app.Output.ThU.ID.Th230',app.Output.ThU.ID.U234'];
                end
            elseif strcmp(app.CUSelThU.SelectedObject.Tag,'Err')
                if strcmp(Selection,'SampleMB')
                    app.Table_ThUresults.Data = [app.Output.ThU.dRatios.Sample.R229_230_cMB(ThUSampleInd)',app.Output.ThU.dRatios.Sample.R236_234_cMB(ThUSampleInd)'];
                elseif strcmp(Selection,'NatUMB')
                    app.Table_ThUresults.Data = app.Output.ThU.dRatios.NatU.R235_234_cMB;
                elseif strcmp(Selection,'ThUID')
                    app.Table_ThUresults.Data = [app.Output.ThU.dID.Th230',app.Output.ThU.dID.U234'];
                end
            elseif strcmp(app.CUSelThU.SelectedObject.Tag,'Errp')
                if strcmp(Selection,'SampleMB')
                    app.Table_ThUresults.Data = [app.Output.ThU.dRatios.Sample.R229_230_cMB(ThUSampleInd)'./app.Output.ThU.Ratios.Sample.R229_230_cMB(ThUSampleInd)',app.Output.ThU.dRatios.Sample.R236_234_cMB(ThUSampleInd)'./app.Output.ThU.Ratios.Sample.R236_234_cMB(ThUSampleInd)']*100;
                elseif strcmp(Selection,'NatUMB')
                    app.Table_ThUresults.Data = app.Output.ThU.dRatios.NatU.R235_234_cMB./app.Output.ThU.Ratios.NatU.R235_234_cMB*100;
                elseif strcmp(Selection,'ThUID')
                    app.Table_ThUresults.Data = [app.Output.ThU.dID.Th230'./app.Output.ThU.ID.Th230',app.Output.ThU.dID.U234'./app.Output.ThU.ID.U234']*100;
                end
            end
            
            if strcmp(Selection,'SampleMB')
                app.Table_ThUresults.ColumnName = {'Th229/Th230','U236/U234'};
                app.Table_ThUresults.RowName = app.Output.ThU.SampleSeq(ThUSampleInd);
                app.ConcThU.Text = '  Ratios';
                app.ErrThU.Text = '  Errors';
                app.Footnote3.Visible = 'off';
            elseif strcmp(Selection,'NatUMB')
                app.Table_ThUresults.ColumnName = {'U235/U234'};
                app.Table_ThUresults.RowName = app.Output.ThU.NatUSeq;
                app.ConcThU.Text = '  Ratios';
                app.ErrThU.Text = '  Errors';
                app.Footnote3.Visible = 'off';
            elseif strcmp(Selection,'ThUID')
                app.Table_ThUresults.ColumnName = {'Th230 (ID)','U234 (ID)'};
                app.Table_ThUresults.RowName = strcat(app.Output.ThU.SampleSeq(ThUSampleInd)',' (',app.Output.ThU.ID.SampleMatchUp{app.Output.ThU.ID.TEMatchUpInd,1},')');
                app.ConcThU.Text = '  Conc. (pg/g)';
                app.ErrThU.Text = '  Errors (pg/g)';
                app.Footnote3.Visible = 'on';
            end
            setappdata(app.ICProUIFigure,'ActiveResultThU',Selection);
        end

        % Menu selected function: BCexport, DCexport, IDLRplots, 
        % IDexport, NatURatioExp, OCexport, QCexport, RCexport, 
        % Rawexport, SCexport, SamRatioExp, TEThUsheet, TEsheet, 
        % ThUIDExp, ThUsheet
        function Export(app, event)
            %---------------------------------------------------------------------------------
            % Callback: Export results
            % This function exports selected results as an excel spread sheet.
            %% -------------------------------------------------------------------------------
            
            % If available, get batch name for default file name (generic name in case of unsaved Batch
            if ~strcmp(app.BatchName,'unsaved batch')
                BatchControl(app,event)
                FileName = app.BatchName;
            else
                FileName = '[EnterBatchName]';
            end
            
            % File output directory, default: TE raw file directory,
            defaultpath = dir(app.Input.TEpar.RawPath);
            [FilePath1,FilePath2] = uiputfile('*.*','Select File',[defaultpath.folder,'/',FileName]);
            
            if FilePath1 ~= 0
                if ~isfolder([FilePath2,'/ICPro Results/'])
                    mkdir([FilePath2,'/ICPro Results/'])
                end
                
                OutFile = [FilePath2,'/ICPro Results/',FilePath1,'.xlsx'];
                OutFig = [FilePath2,'/ICPro Results/',FilePath1,'.png'];
                if isfile(OutFile)
                    delete(OutFile)
                end
                if isfile(OutFig)
                    delete(OutFig)
                end
                
                % Info sheet [TBC]
                
                % Weight input sheet
                OutTableWt = array2table([app.Input.WtPar.m_sed;app.Input.WtPar.m_4ml;app.Input.WtPar.m_10ml;app.Input.WtPar.m_400ul;app.Input.WtPar.m_ThBC;app.Input.WtPar.m_UBC;app.Input.WtPar.m_ThSC;app.Input.WtPar.m_USC]',...
                    'RowNames',app.Output.TE.RunID.Sample,'VariableNames',{'Sediment wt. [mg]','4ml wt. [mg]','10ml wt. [mg]','400ul wt. [mg]','Th229 (BC) wt. [mg]','U236 (BC) wt. [mg]','Th230 (SC) wt. [mg]','U236 (SC) wt. [mg]'});
                OutTableWt.Properties.DimensionNames{1} = 'Sample ID';
                writetable(OutTableWt,OutFile,'Sheet','Sample weights','WriteMode','overwritesheet','WriteRowNames',true)
                
                % TE result sheets, concentration & errors (individual)
                if event.Source.Parent == app.TEIndRes || event.Source == app.TEsheet || event.Source == app.TEThUsheet
                    gettag = event.Source.Tag;
                    for i = 1 : length(app.Output.TE.IsotopesID)
                        app.Output.TE.IsotopesIDout{i} = [app.Output.TE.IsotopesID{i},' [ppm]'];
                        app.Output.TE.Isotopesout{i} = [app.Output.TE.Isotopes{i},' [ppm]'];
                    end
                    if strcmp(gettag,'ID') || event.Source == app.TEsheet || event.Source == app.TEThUsheet
                        OutTableC = array2table(app.Output.TE.C.ID.Sample','RowNames',app.Output.TE.RunID.Sample,'VariableNames',app.Output.TE.IsotopesIDout);
                        OutTableE = array2table(app.Output.TE.dC.ID.Sample','RowNames',app.Output.TE.RunID.Sample,'VariableNames',app.Output.TE.IsotopesIDout);
                        OutTableC.Properties.DimensionNames{1} = 'Sample ID';
                        OutTableE.Properties.DimensionNames{1} = 'Sample ID';
                        writetable(OutTableC,OutFile,'Sheet','{TE} Concentrations (ID)','WriteMode','overwritesheet','WriteRowNames',true)
                        writetable(OutTableE,OutFile,'Sheet','{TE} Errors (ID)','WriteMode','overwritesheet','WriteRowNames',true)
                    else
                        OutTableC = array2table(app.Output.TE.C.(gettag).Sample','RowNames',app.Output.TE.RunID.Sample,'VariableNames',app.Output.TE.Isotopesout);
                        OutTableE = array2table(app.Output.TE.dC.(gettag).Sample','RowNames',app.Output.TE.RunID.Sample,'VariableNames',app.Output.TE.Isotopesout);
                        OutTableC.Properties.DimensionNames{1} = 'Sample ID';
                        OutTableE.Properties.DimensionNames{1} = 'Sample ID';
                        writetable(OutTableC,OutFile,'Sheet',['{TE} Concentrations (',gettag,')'],'WriteMode','overwritesheet','WriteRowNames',true)
                        writetable(OutTableE,OutFile,'Sheet',['{TE} Errors (',gettag,')'],'WriteMode','overwritesheet','WriteRowNames',true)
                    end
                end
                
                % ID vs LR plots
                if event.Source == app.IDLRplots || event.Source == app.TEsheet || event.Source == app.TEThUsheet
                    fig = figure('Visible','off');
                    fig.Position = [0 0 1000 500];
                    h1 = copyobj(app.ThIDFig,fig);
                    set(h1,'ActivePositionProperty','outerposition')
                    set(h1,'Units','normalized')
                    set(h1,'OuterPosition',[0 0 1 1])
                    set(h1,'Position',[0.025 0.05 .45 .9])
                    set(h1,'Visible','on')
                    for iC = 1 : length(h1.Children)
                        h1.Children(iC).Visible = 'on';
                    end
                    h2 = copyobj(app.UIDFig,fig);
                    set(h2,'ActivePositionProperty','outerposition')
                    set(h2,'Units','normalized')
                    set(h2,'OuterPosition',[0 0 1 1])
                    set(h2,'Position',[0.525 0.05 .45 .9])
                    set(h2,'Visible','on')
                    for iC = 1 : length(h2.Children)
                        h2.Children(iC).Visible = 'on';
                    end
                    saveas(fig,OutFig)
                    close(fig)
                end
                
                % Th/U result sheets, concentration & errors (individual)
                if event.Source.Parent == app.ThUIndRes || event.Source == app.ThUsheet || event.Source == app.TEThUsheet
                    if event.Source == app.SamRatioExp || event.Source == app.ThUsheet || event.Source == app.TEThUsheet
                        OutTableCa = array2table([app.Output.ThU.Ratios.Sample.R229_230_cMB(2:end)',app.Output.ThU.Ratios.Sample.R236_234_cMB(2:end)'],'RowNames',app.Output.ThU.SampleSeq(2:end),'VariableNames',{'Th229/Th230','U236/U234'});
                        OutTableEa = array2table([app.Output.ThU.dRatios.Sample.R229_230_cMB(2:end)',app.Output.ThU.dRatios.Sample.R236_234_cMB(2:end)'],'RowNames',app.Output.ThU.SampleSeq(2:end),'VariableNames',{'Th229/Th230','U236/U234'});
                        OutTableCa.Properties.DimensionNames{1} = 'Sample ID';
                        OutTableEa.Properties.DimensionNames{1} = 'Sample ID';
                    end
                    if event.Source == app.NatURatioExp || event.Source == app.ThUsheet || event.Source == app.TEThUsheet
                        OutTableCb = array2table(app.Output.ThU.Ratios.NatU.R235_234_cMB,'RowNames',app.Output.ThU.NatUSeq,'VariableNames',{'U235/U234'});
                        OutTableEb = array2table(app.Output.ThU.dRatios.NatU.R235_234_cMB,'RowNames',app.Output.ThU.NatUSeq,'VariableNames',{'U235/U234'});
                        OutTableCb.Properties.DimensionNames{1} = 'Sample ID';
                        OutTableEb.Properties.DimensionNames{1} = 'Sample ID';
                    end
                    if event.Source == app.ThUIDExp || event.Source == app.ThUsheet || event.Source == app.TEThUsheet
                        OutTableCc = array2table([app.Output.ThU.ID.Th230',app.Output.ThU.ID.U234'],'RowNames',app.Output.ThU.SampleSeq(2:end),'VariableNames',{'Th230 (ID) [ppm]','U234 (ID) [ppm]'});
                        OutTableEc = array2table([app.Output.ThU.dID.Th230',app.Output.ThU.dID.U234'],'RowNames',app.Output.ThU.SampleSeq(2:end),'VariableNames',{'Th230 (ID) [ppm]','U234 (ID) [ppm]'});
                        OutTableCc.Properties.DimensionNames{1} = 'Sample ID';
                        OutTableEc.Properties.DimensionNames{1} = 'Sample ID';
                    end
                    
                    if event.Source == app.ThUsheet || event.Source == app.TEThUsheet
                        writetable(OutTableCa,OutFile,'Sheet','{Th & U} Ratios & Concentr.','WriteMode','inplace','WriteRowNames',true,'Range','A1')
                        writetable(OutTableCb,OutFile,'Sheet','{Th & U} Ratios & Concentr.','WriteMode','inplace','WriteRowNames',true,'Range','G1')
                        writetable(OutTableCc,OutFile,'Sheet','{Th & U} Ratios & Concentr.','WriteMode','inplace','WriteRowNames',false,'Range','D1')
                        writetable(OutTableEa,OutFile,'Sheet','{Th & U} Errors','WriteMode','inplace','WriteRowNames',true,'Range','A1')
                        writetable(OutTableEb,OutFile,'Sheet','{Th & U} Errors','WriteMode','inplace','WriteRowNames',true,'Range','G1')
                        writetable(OutTableEc,OutFile,'Sheet','{Th & U} Errors','WriteMode','inplace','WriteRowNames',false,'Range','D1')
                    elseif event.Source == app.SamRatioExp
                        writetable(OutTableCa,OutFile,'Sheet','{Th & U} Ratios & Concentr.','WriteMode','overwritesheet','WriteRowNames',true,'Range','A1')
                        writetable(OutTableEa,OutFile,'Sheet','{Th & U} Errors','WriteMode','overwritesheet','WriteRowNames',true,'Range','A1')
                    elseif event.Source == app.NatURatioExp
                        writetable(OutTableCb,OutFile,'Sheet','{Th & U} Ratios & Concentr.','WriteMode','overwritesheet','WriteRowNames',true,'Range','A1')
                        writetable(OutTableEb,OutFile,'Sheet','{Th & U} Errors','WriteMode','overwritesheet','WriteRowNames',true,'Range','A1')
                    elseif event.Source == app.ThUIDExp
                        writetable(OutTableCc,OutFile,'Sheet','{Th & U} Ratios & Concentr.','WriteMode','overwritesheet','WriteRowNames',true,'Range','A1')
                        writetable(OutTableEc,OutFile,'Sheet','{Th & U} Errors','WriteMode','overwritesheet','WriteRowNames',true,'Range','A1')
                    end
                end
            end
            
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
        end

        % Menu selected function: ClearBatchMenu, DeleteBatchMenu, 
        % LoadBatchMenu, SaveAsBatchMenu, SaveBatchMenu
        function BatchControl(app, event)
            %---------------------------------------------------------------------------------
            % Callback: Batch control
            % This function collectively manages the handling of batch files:
            % - Saving input parameters to a new/existing batch file
            % - Importing parameters from a saved batch file
            % - Deleting batch files
            % - Clearing current input
            % Prior to clearing the input and importing a batch the user will be notified of
            % unsaved changes.
            %% -------------------------------------------------------------------------------
            
            % Get list of all batch files
            AllBatchFiles = dir([app.AppPath.folder,'/misc/Batch Input Files/*.mat']);
            BFList = cell(length(AllBatchFiles),1);
            for iF = 1 : length(AllBatchFiles)
                BFList{iF} =  AllBatchFiles(iF).name;
            end
            BFList(end) = [];
            
            % CASE 1: Load previously saved batch from batch file
            if event.Source == app.LoadBatchMenu
                msg = 'Unsaved changes to will be discarded. Load new batch and discard changes?';
                button = 'Proceed';
                discard = CheckForChanges(app,msg,button);
                if true(discard)
                    % Select batch file
                    indx = listdlg('SelectionMode','single','ListString',BFList,'ListSize',[160 100]);
                    if ~isempty(indx)
                        % Get batch file name from selection and load input parameters
                        BatchFile = BFList{indx};
                        load([app.AppPath.folder,'/misc/Batch Input Files/',BatchFile],'IN');
                        % Save batch name to app property 'BatchName' and rename app window accordingly
                        app.BatchName = BatchFile(1:end-4);
                        app.ICProUIFigure.Name = ['ICPro - ',app.BatchName];
                        % Run function 'setInput'
                        setInput(app,event,IN)
                    end
                end
            end
            
            % CASE 2: Delete previously saved batch file
            if event.Source == app.DeleteBatchMenu
                % Select batch file
                indx = listdlg('SelectionMode','single','ListString',BFList,'ListSize',[160 100]);
                if ~isempty(indx)
                    % Get batch file name from selection
                    BatchFile = BFList{indx};
                    % Delete confirmation prompt
                    msg = ['Do you want to delete batch input file ''',BatchFile(1:end-4),'''?'];
                    title = 'Delete batch file';
                    selection = questdlg(msg,title,'Delete','Cancel','Delete');
                    if strcmp(selection,'Delete') % skip if selection was cancelled
                        delete([app.AppPath.folder,'/misc/Batch Input Files/',BatchFile]);
                    end
                end
            end
            
            % CASE 3: Clear current input and reset input window
            if event.Source == app.ClearBatchMenu
                msg = 'Unsaved changes will be discarded. Clear window and discard changes?';
                button = 'Proceed';
                discard = CheckForChanges(app,msg,button);
                if true(discard)
                    % Rename app window to 'unsaved batch'
                    app.ICProUIFigure.Name = 'ICPro - unnamed batch';
                    % Run function 'resetInput'
                    resetInput(app,event)
                    setInput(app,event)
                end
            end
            
            % CASE 4: Save as new file (in case of 'Save as...' OR unsaved batch)
            unsaved = event.Source == app.SaveBatchMenu && strcmp(app.ICProUIFigure.Name,'ICPro - unnamed batch');
            if event.Source == app.SaveAsBatchMenu || unsaved
                % Get all input data, parameters and selections
                IN = getInput(app);
                
                IN.BatchName = inputdlg('Specify batch name:');
                app.BatchName = IN.BatchName{1};
                if ~isempty(IN.BatchName)
                    BatchExist = zeros(numel(AllBatchFiles),1);
                    for iB = 1 : numel(AllBatchFiles)
                        BatchExist(iB) =  strcmp([IN.BatchName{1},'.mat'],AllBatchFiles(iB).name);
                    end
                    if sum(BatchExist) == 1
                        msg = 'Batch file already exists and will be overwritten.';
                        title = 'Overwrite batch file';
                        selection = questdlg(msg,title,'Save','Cancel','Save');
                        if strcmp(selection,'Save')
                            save([app.AppPath.folder,'/misc/Batch Input Files/',IN.BatchName{1},'.mat'],'IN');
                            app.ICProUIFigure.Name = ['ICPro - ',app.BatchName];
                        end
                    else
                        save([app.AppPath.folder,'/misc/Batch Input Files/',IN.BatchName{1},'.mat'],'IN');
                        app.ICProUIFigure.Name = ['ICPro - ',app.BatchName];
                    end
                end
                clearvars('IN')
            end
            
            % CASE 5: Save to previously saved batch file (in case of 'Save' AND previously saved batch file)
            presaved = event.Source == app.SaveBatchMenu && ~strcmp(app.ICProUIFigure.Name,'ICPro - unnamed batch');
            export = (event.Source.Parent == app.ExportMenu || event.Source.Parent == app.TEIndRes || event.Source.Parent == app.ThUIndRes) && ~strcmp(app.ICProUIFigure.Name,'ICPro - unnamed batch');
            if presaved || export
                % Get all input data, parameters and selections
                IN = getInput(app);
                save([app.AppPath.folder,'/misc/Batch Input Files/',IN.BatchName{1},'.mat'],'IN');
                app.ICProUIFigure.Name = ['ICPro - ',app.BatchName];
                clearvars('IN')
            end
            
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
        end

        % Close request function: ICProUIFigure
        function CloseApp(app, event)
            %---------------------------------------------------------------------------------
            % Callback: Quitting ICPro
            % This function quits ICPro. Prior to quitting the user will be notified of
            % unsaved changes.
            %% -------------------------------------------------------------------------------
            
            msg = 'Unsaved changes will be discarded. Quit and discard changes?';
            button = 'Quit';
            discard = CheckForChanges(app,msg,button);
            if true(discard)
                delete(app)
            end
            
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
        end

        % Menu selected function: AboutMenu
        function ShowInfo(app, event)
            %---------------------------------------------------------------------------------
            % Callback: Show ICPro info
            % This function opens an info window.
            %% -------------------------------------------------------------------------------
            
            d = dialog('Position',[500 500 250 350],'Name','About ICPro');
            
            axes('Parent',d,...
                'Units','normalized',...
                'Position',[.1 .6 .8 .3],...
                'XColor','none',...
                'YColor','none');
            [icon,~,alpha] = imread([app.AppPath.folder,'/misc/icons/appicon.png']);
            f = imshow(icon(:,:,1:3),'InitialMagnification',20);
            set(f, 'AlphaData', alpha);
            
            uicontrol('Parent',d,...
                'Style','text',...
                'Units','normalized',...
                'Position',[.1 .3 .8 .2],...
                'FontName','Avenir',...
                'FontWeight','bold',...
                'FontSize',24,...
                'String','ICPro');
            
            uicontrol('Parent',d,...
                'Style','text',...
                'Units','normalized',...
                'Position',[.1 .15 .8 .25],...
                'FontName','Avenir',...
                'FontWeight','bold',...
                'FontSize',14,...
                'String',{[char(hex2dec('A9')),' Jake Weis, 2021'];' ';'https://github.com/JakeWeis';'jakob.weis@utas.edu.au'});
            
            waitfor(d)
            % Bring ICPro to foreground
            figure(app.ICProUIFigure)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create ICProUIFigure and hide until all components are created
            app.ICProUIFigure = uifigure('Visible', 'off');
            app.ICProUIFigure.IntegerHandle = 'on';
            app.ICProUIFigure.Color = [0.9412 0.9412 0.9412];
            app.ICProUIFigure.Position = [100 100 1250 671];
            app.ICProUIFigure.Name = 'ICPro - unnamed batch';
            app.ICProUIFigure.Icon = 'appicon.png';
            app.ICProUIFigure.Resize = 'off';
            app.ICProUIFigure.CloseRequestFcn = createCallbackFcn(app, @CloseApp, true);
            app.ICProUIFigure.HandleVisibility = 'callback';

            % Create ICProMenu
            app.ICProMenu = uimenu(app.ICProUIFigure);
            app.ICProMenu.Text = 'ICPro';

            % Create AboutMenu
            app.AboutMenu = uimenu(app.ICProMenu);
            app.AboutMenu.MenuSelectedFcn = createCallbackFcn(app, @ShowInfo, true);
            app.AboutMenu.Text = 'About...';

            % Create GuideMenu
            app.GuideMenu = uimenu(app.ICProMenu);
            app.GuideMenu.Text = 'Guide';

            % Create SampletypeMenu
            app.SampletypeMenu = uimenu(app.ICProUIFigure);
            app.SampletypeMenu.Text = 'Sample type';

            % Create SedimentMenu
            app.SedimentMenu = uimenu(app.SampletypeMenu);
            app.SedimentMenu.Accelerator = '1';
            app.SedimentMenu.Checked = 'on';
            app.SedimentMenu.Text = 'Sediment';

            % Create SeawaterNAMenu
            app.SeawaterNAMenu = uimenu(app.SampletypeMenu);
            app.SeawaterNAMenu.Enable = 'off';
            app.SeawaterNAMenu.Accelerator = '2';
            app.SeawaterNAMenu.Text = 'Sea water (NA)';

            % Create BatchMenu
            app.BatchMenu = uimenu(app.ICProUIFigure);
            app.BatchMenu.Text = 'Batch';

            % Create SaveBatchMenu
            app.SaveBatchMenu = uimenu(app.BatchMenu);
            app.SaveBatchMenu.MenuSelectedFcn = createCallbackFcn(app, @BatchControl, true);
            app.SaveBatchMenu.Tooltip = {'Saves the current workspace to a batch file, which can later be imported.'};
            app.SaveBatchMenu.Accelerator = 'S';
            app.SaveBatchMenu.Text = 'Save';
            app.SaveBatchMenu.Tag = 'SaveBatch';

            % Create SaveAsBatchMenu
            app.SaveAsBatchMenu = uimenu(app.BatchMenu);
            app.SaveAsBatchMenu.MenuSelectedFcn = createCallbackFcn(app, @BatchControl, true);
            app.SaveAsBatchMenu.Text = 'Save as...';
            app.SaveAsBatchMenu.Tag = 'SaveBatch';

            % Create LoadBatchMenu
            app.LoadBatchMenu = uimenu(app.BatchMenu);
            app.LoadBatchMenu.MenuSelectedFcn = createCallbackFcn(app, @BatchControl, true);
            app.LoadBatchMenu.Tooltip = {'Loads a previously saved Batch.'};
            app.LoadBatchMenu.Accelerator = 'L';
            app.LoadBatchMenu.Text = 'Load';

            % Create DeleteBatchMenu
            app.DeleteBatchMenu = uimenu(app.BatchMenu);
            app.DeleteBatchMenu.MenuSelectedFcn = createCallbackFcn(app, @BatchControl, true);
            app.DeleteBatchMenu.Tooltip = {'Deletes a previously saved batch file.'};
            app.DeleteBatchMenu.Accelerator = 'K';
            app.DeleteBatchMenu.Text = 'Delete';

            % Create ClearBatchMenu
            app.ClearBatchMenu = uimenu(app.BatchMenu);
            app.ClearBatchMenu.MenuSelectedFcn = createCallbackFcn(app, @BatchControl, true);
            app.ClearBatchMenu.Tooltip = {'Clears the current workspace and resets it to initial settings.'};
            app.ClearBatchMenu.Accelerator = 'X';
            app.ClearBatchMenu.Text = 'Clear';

            % Create ExportMenu
            app.ExportMenu = uimenu(app.ICProUIFigure);
            app.ExportMenu.Tooltip = {'Export options'};
            app.ExportMenu.Text = 'Export';

            % Create IndResExp
            app.IndResExp = uimenu(app.ExportMenu);
            app.IndResExp.Tooltip = {''};
            app.IndResExp.Enable = 'off';
            app.IndResExp.Text = 'Individual results';

            % Create TEIndRes
            app.TEIndRes = uimenu(app.IndResExp);
            app.TEIndRes.Tooltip = {'Exports concentrations and uncertainties'};
            app.TEIndRes.Enable = 'off';
            app.TEIndRes.Text = 'Trace elements';

            % Create IDLRplots
            app.IDLRplots = uimenu(app.TEIndRes);
            app.IDLRplots.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.IDLRplots.Enable = 'off';
            app.IDLRplots.Accelerator = '[';
            app.IDLRplots.Text = 'ID vs LR plots';

            % Create IDexport
            app.IDexport = uimenu(app.TEIndRes);
            app.IDexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.IDexport.Enable = 'off';
            app.IDexport.Accelerator = 'E';
            app.IDexport.Text = 'Isotopic dilution';
            app.IDexport.Tag = 'ID';

            % Create DCexport
            app.DCexport = uimenu(app.TEIndRes);
            app.DCexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.DCexport.Enable = 'off';
            app.DCexport.Accelerator = 'R';
            app.DCexport.Text = 'Dilution corrected';
            app.DCexport.Tag = 'DC';

            % Create BCexport
            app.BCexport = uimenu(app.TEIndRes);
            app.BCexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.BCexport.Enable = 'off';
            app.BCexport.Accelerator = 'T';
            app.BCexport.Text = 'Blank corrected';
            app.BCexport.Tag = 'BC';

            % Create OCexport
            app.OCexport = uimenu(app.TEIndRes);
            app.OCexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.OCexport.Enable = 'off';
            app.OCexport.Accelerator = 'Y';
            app.OCexport.Text = 'Oxide corrected';
            app.OCexport.Tag = 'OC';

            % Create SCexport
            app.SCexport = uimenu(app.TEIndRes);
            app.SCexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.SCexport.Enable = 'off';
            app.SCexport.Accelerator = 'U';
            app.SCexport.Text = 'Spike corrected';
            app.SCexport.Tag = 'SC';

            % Create QCexport
            app.QCexport = uimenu(app.TEIndRes);
            app.QCexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.QCexport.Enable = 'off';
            app.QCexport.Accelerator = 'I';
            app.QCexport.Text = 'QC corrected';
            app.QCexport.Tag = 'QC';

            % Create RCexport
            app.RCexport = uimenu(app.TEIndRes);
            app.RCexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.RCexport.Enable = 'off';
            app.RCexport.Accelerator = 'O';
            app.RCexport.Text = 'Rinse corrected';
            app.RCexport.Tag = 'RC';

            % Create Rawexport
            app.Rawexport = uimenu(app.TEIndRes);
            app.Rawexport.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.Rawexport.Enable = 'off';
            app.Rawexport.Accelerator = 'P';
            app.Rawexport.Text = 'Raw data';
            app.Rawexport.Tag = 'Raw';

            % Create ThUIndRes
            app.ThUIndRes = uimenu(app.IndResExp);
            app.ThUIndRes.Tooltip = {'Exports ratios and uncertainties'};
            app.ThUIndRes.Enable = 'off';
            app.ThUIndRes.Text = 'Th/U';

            % Create SamRatioExp
            app.SamRatioExp = uimenu(app.ThUIndRes);
            app.SamRatioExp.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.SamRatioExp.Tooltip = {'Th230/Th229'; 'U236/U234'};
            app.SamRatioExp.Enable = 'off';
            app.SamRatioExp.Accelerator = 'D';
            app.SamRatioExp.Text = 'Sample ratios';

            % Create NatURatioExp
            app.NatURatioExp = uimenu(app.ThUIndRes);
            app.NatURatioExp.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.NatURatioExp.Tooltip = {'U235/U234'};
            app.NatURatioExp.Enable = 'off';
            app.NatURatioExp.Accelerator = 'F';
            app.NatURatioExp.Text = 'NatU ratio';

            % Create ThUIDExp
            app.ThUIDExp = uimenu(app.ThUIndRes);
            app.ThUIDExp.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.ThUIDExp.Tooltip = {'Th230 & U234'};
            app.ThUIDExp.Enable = 'off';
            app.ThUIDExp.Accelerator = 'G';
            app.ThUIDExp.Text = 'Isotopic Dilution';

            % Create TEsheet
            app.TEsheet = uimenu(app.ExportMenu);
            app.TEsheet.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.TEsheet.Tooltip = {'- TE concentrations and uncertainties (with isotopic dilution)'; '- ID vs LR plots (Th232, U238)'};
            app.TEsheet.Enable = 'off';
            app.TEsheet.Accelerator = '3';
            app.TEsheet.Text = 'TE result sheet';

            % Create ThUsheet
            app.ThUsheet = uimenu(app.ExportMenu);
            app.ThUsheet.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.ThUsheet.Tooltip = {'- Mass bias corrected sample ratios and uncertainties (Th229/Th230, U236/U234)'; '- Mass bias corrected NatU ratio and uncertainties (U236/U234)'};
            app.ThUsheet.Enable = 'off';
            app.ThUsheet.Accelerator = '4';
            app.ThUsheet.Text = 'Th/U result sheet';

            % Create TEThUsheet
            app.TEThUsheet = uimenu(app.ExportMenu);
            app.TEThUsheet.MenuSelectedFcn = createCallbackFcn(app, @Export, true);
            app.TEThUsheet.Tooltip = {'- TE concentrations and uncertainties (with isotopic dilution)'; '- ID vs LR plots (Th232, U238)'; '- Mass bias corrected sample ratios and uncertainties (Th229/Th230, U236/U234)'; '- Mass bias corrected NatU ratio and uncertainties (U236/U234)'};
            app.TEThUsheet.Enable = 'off';
            app.TEThUsheet.Accelerator = '5';
            app.TEThUsheet.Text = 'TE+Th/U result sheet';

            % Create Panel_TE
            app.Panel_TE = uipanel(app.ICProUIFigure);
            app.Panel_TE.Enable = 'off';
            app.Panel_TE.TitlePosition = 'centertop';
            app.Panel_TE.Title = 'Trace Element Input';
            app.Panel_TE.BackgroundColor = [0.902 0.902 0.902];
            app.Panel_TE.FontName = 'Avenir';
            app.Panel_TE.FontWeight = 'bold';
            app.Panel_TE.FontSize = 14;
            app.Panel_TE.Position = [51 292 310 360];

            % Create Button_RawFile
            app.Button_RawFile = uibutton(app.Panel_TE, 'push');
            app.Button_RawFile.ButtonPushedFcn = createCallbackFcn(app, @BrowseRawData, true);
            app.Button_RawFile.BackgroundColor = [1 0.949 0.949];
            app.Button_RawFile.Position = [241 297 50 22];
            app.Button_RawFile.Text = '...';

            % Create Field_RawFile
            app.Field_RawFile = uieditfield(app.Panel_TE, 'text');
            app.Field_RawFile.ValueChangedFcn = createCallbackFcn(app, @SampleList, true);
            app.Field_RawFile.FontName = 'Courier';
            app.Field_RawFile.FontWeight = 'bold';
            app.Field_RawFile.Position = [21 297 210 22];

            % Create Field_SIDTE
            app.Field_SIDTE = uieditfield(app.Panel_TE, 'text');
            app.Field_SIDTE.ValueChangedFcn = createCallbackFcn(app, @SampleList, true);
            app.Field_SIDTE.HorizontalAlignment = 'center';
            app.Field_SIDTE.FontName = 'Courier';
            app.Field_SIDTE.FontWeight = 'bold';
            app.Field_SIDTE.Position = [181 263 110 22];

            % Create Field_BlankID
            app.Field_BlankID = uieditfield(app.Panel_TE, 'text');
            app.Field_BlankID.ValueChangedFcn = createCallbackFcn(app, @SampleList, true);
            app.Field_BlankID.HorizontalAlignment = 'center';
            app.Field_BlankID.FontName = 'Courier';
            app.Field_BlankID.FontWeight = 'bold';
            app.Field_BlankID.Position = [181 233 110 22];

            % Create Field_SpikeID
            app.Field_SpikeID = uieditfield(app.Panel_TE, 'text');
            app.Field_SpikeID.HorizontalAlignment = 'center';
            app.Field_SpikeID.FontName = 'Courier';
            app.Field_SpikeID.FontWeight = 'bold';
            app.Field_SpikeID.Position = [181 203 110 22];
            app.Field_SpikeID.Value = 'spike';

            % Create Label_SIDTE
            app.Label_SIDTE = uilabel(app.Panel_TE);
            app.Label_SIDTE.FontName = 'Avenir';
            app.Label_SIDTE.Position = [21 263 98 22];
            app.Label_SIDTE.Text = 'Sample ID initials';

            % Create Label_BlankID
            app.Label_BlankID = uilabel(app.Panel_TE);
            app.Label_BlankID.FontName = 'Avenir';
            app.Label_BlankID.Position = [21 233 110 22];
            app.Label_BlankID.Text = 'Procedural blank ID';

            % Create Label_SpikeID
            app.Label_SpikeID = uilabel(app.Panel_TE);
            app.Label_SpikeID.FontName = 'Avenir';
            app.Label_SpikeID.Position = [21 203 99 22];
            app.Label_SpikeID.Text = 'Spiked sample ID';

            % Create Field_RinseID
            app.Field_RinseID = uieditfield(app.Panel_TE, 'text');
            app.Field_RinseID.HorizontalAlignment = 'center';
            app.Field_RinseID.FontName = 'Courier';
            app.Field_RinseID.FontWeight = 'bold';
            app.Field_RinseID.Position = [181 173 110 22];
            app.Field_RinseID.Value = 'Rinse';

            % Create Label_RinseID
            app.Label_RinseID = uilabel(app.Panel_TE);
            app.Label_RinseID.FontName = 'Avenir';
            app.Label_RinseID.Position = [21 173 49 22];
            app.Label_RinseID.Text = 'Rinse ID';

            % Create Field_QCID
            app.Field_QCID = uieditfield(app.Panel_TE, 'text');
            app.Field_QCID.HorizontalAlignment = 'center';
            app.Field_QCID.FontName = 'Courier';
            app.Field_QCID.FontWeight = 'bold';
            app.Field_QCID.Position = [181 143 110 22];
            app.Field_QCID.Value = 'QC';

            % Create Label_QCID
            app.Label_QCID = uilabel(app.Panel_TE);
            app.Label_QCID.FontName = 'Avenir';
            app.Label_QCID.Position = [21 143 39 22];
            app.Label_QCID.Text = 'QC ID';

            % Create Panel_TECorr
            app.Panel_TECorr = uipanel(app.Panel_TE);
            app.Panel_TECorr.TitlePosition = 'centertop';
            app.Panel_TECorr.Title = 'Select corrections to apply';
            app.Panel_TECorr.BackgroundColor = [0.949 0.949 0.949];
            app.Panel_TECorr.FontName = 'Avenir';
            app.Panel_TECorr.FontWeight = 'bold';
            app.Panel_TECorr.Position = [21 15 270 120];

            % Create Check_RC
            app.Check_RC = uicheckbox(app.Panel_TECorr);
            app.Check_RC.Tag = 'RC';
            app.Check_RC.Text = 'Rinse correction';
            app.Check_RC.FontName = 'Avenir';
            app.Check_RC.Position = [21 66 108 22];

            % Create Check_QC
            app.Check_QC = uicheckbox(app.Panel_TECorr);
            app.Check_QC.Tag = 'QC';
            app.Check_QC.Text = 'QC correction';
            app.Check_QC.FontName = 'Avenir';
            app.Check_QC.Position = [141 66 98 22];
            app.Check_QC.Value = true;

            % Create Check_SC
            app.Check_SC = uicheckbox(app.Panel_TECorr);
            app.Check_SC.Tag = 'SC';
            app.Check_SC.Text = 'Spike correction';
            app.Check_SC.FontName = 'Avenir';
            app.Check_SC.Position = [21 36 108 22];

            % Create Check_OC
            app.Check_OC = uicheckbox(app.Panel_TECorr);
            app.Check_OC.Tag = 'OC';
            app.Check_OC.Text = 'Oxide correction';
            app.Check_OC.FontName = 'Avenir';
            app.Check_OC.Position = [141 36 112 22];

            % Create Check_BC
            app.Check_BC = uicheckbox(app.Panel_TECorr);
            app.Check_BC.Tag = 'BC';
            app.Check_BC.Text = 'Blank correction';
            app.Check_BC.FontName = 'Avenir';
            app.Check_BC.Position = [21 6 108 22];
            app.Check_BC.Value = true;

            % Create Check_DC
            app.Check_DC = uicheckbox(app.Panel_TECorr);
            app.Check_DC.ValueChangedFcn = createCallbackFcn(app, @AnalysisToggle, true);
            app.Check_DC.Tag = 'DC';
            app.Check_DC.Text = 'Dilution correction';
            app.Check_DC.FontName = 'Avenir';
            app.Check_DC.Position = [141 6 121 22];
            app.Check_DC.Value = true;

            % Create Panel_ThU
            app.Panel_ThU = uipanel(app.ICProUIFigure);
            app.Panel_ThU.Enable = 'off';
            app.Panel_ThU.TitlePosition = 'centertop';
            app.Panel_ThU.Title = 'Th/U Input';
            app.Panel_ThU.BackgroundColor = [0.902 0.902 0.902];
            app.Panel_ThU.FontName = 'Avenir';
            app.Panel_ThU.FontWeight = 'bold';
            app.Panel_ThU.FontSize = 14;
            app.Panel_ThU.Position = [51 22 310 260];

            % Create TabGroup2
            app.TabGroup2 = uitabgroup(app.Panel_ThU);
            app.TabGroup2.Position = [1 -1 308 237];

            % Create InputTab
            app.InputTab = uitab(app.TabGroup2);
            app.InputTab.Title = 'Input';
            app.InputTab.BackgroundColor = [0.902 0.902 0.902];

            % Create Field_NBlocks
            app.Field_NBlocks = uieditfield(app.InputTab, 'text');
            app.Field_NBlocks.ValueChangedFcn = createCallbackFcn(app, @SampleList, true);
            app.Field_NBlocks.HorizontalAlignment = 'center';
            app.Field_NBlocks.FontName = 'Courier';
            app.Field_NBlocks.FontWeight = 'bold';
            app.Field_NBlocks.Position = [181 137 110 22];

            % Create Field_NSamples
            app.Field_NSamples = uieditfield(app.InputTab, 'text');
            app.Field_NSamples.ValueChangedFcn = createCallbackFcn(app, @SampleList, true);
            app.Field_NSamples.HorizontalAlignment = 'center';
            app.Field_NSamples.FontName = 'Courier';
            app.Field_NSamples.FontWeight = 'bold';
            app.Field_NSamples.Position = [181 107 110 22];

            % Create Label_NBlocks
            app.Label_NBlocks = uilabel(app.InputTab);
            app.Label_NBlocks.FontName = 'Avenir';
            app.Label_NBlocks.Position = [21 137 121 22];
            app.Label_NBlocks.Text = 'No. of analysis blocks';

            % Create Label_NSamples
            app.Label_NSamples = uilabel(app.InputTab);
            app.Label_NSamples.FontName = 'Avenir';
            app.Label_NSamples.Position = [21 107 140 22];
            app.Label_NSamples.Text = 'No. of samples per block';

            % Create Field_ICPBlankID
            app.Field_ICPBlankID = uieditfield(app.InputTab, 'text');
            app.Field_ICPBlankID.HorizontalAlignment = 'center';
            app.Field_ICPBlankID.FontName = 'Courier';
            app.Field_ICPBlankID.FontWeight = 'bold';
            app.Field_ICPBlankID.Position = [181 47 110 22];
            app.Field_ICPBlankID.Value = 'Blank';

            % Create Label_ICPBlankID
            app.Label_ICPBlankID = uilabel(app.InputTab);
            app.Label_ICPBlankID.FontName = 'Avenir';
            app.Label_ICPBlankID.Position = [21 47 72 22];
            app.Label_ICPBlankID.Text = 'ICP Blank ID';

            % Create Field_ICPNatUID
            app.Field_ICPNatUID = uieditfield(app.InputTab, 'text');
            app.Field_ICPNatUID.HorizontalAlignment = 'center';
            app.Field_ICPNatUID.FontName = 'Courier';
            app.Field_ICPNatUID.FontWeight = 'bold';
            app.Field_ICPNatUID.Position = [181 17 110 22];
            app.Field_ICPNatUID.Value = 'NatU';

            % Create Label_ICPNatUID
            app.Label_ICPNatUID = uilabel(app.InputTab);
            app.Label_ICPNatUID.FontName = 'Avenir';
            app.Label_ICPNatUID.Position = [21 17 71 22];
            app.Label_ICPNatUID.Text = 'ICP NatU ID';

            % Create Field_SIDThU
            app.Field_SIDThU = uieditfield(app.InputTab, 'text');
            app.Field_SIDThU.ValueChangedFcn = createCallbackFcn(app, @SampleList, true);
            app.Field_SIDThU.HorizontalAlignment = 'center';
            app.Field_SIDThU.FontName = 'Courier';
            app.Field_SIDThU.FontWeight = 'bold';
            app.Field_SIDThU.Position = [181 77 110 22];

            % Create Label_SIDThU
            app.Label_SIDThU = uilabel(app.InputTab);
            app.Label_SIDThU.FontName = 'Avenir';
            app.Label_SIDThU.Position = [21 77 98 22];
            app.Label_SIDThU.Text = 'Sample ID initials';

            % Create Button_RawFolder
            app.Button_RawFolder = uibutton(app.InputTab, 'push');
            app.Button_RawFolder.ButtonPushedFcn = createCallbackFcn(app, @BrowseRawData, true);
            app.Button_RawFolder.BackgroundColor = [0.9804 0.9804 1];
            app.Button_RawFolder.Position = [241 175 50 22];
            app.Button_RawFolder.Text = '...';

            % Create Field_RawFolder
            app.Field_RawFolder = uieditfield(app.InputTab, 'text');
            app.Field_RawFolder.ValueChangedFcn = createCallbackFcn(app, @SampleList, true);
            app.Field_RawFolder.FontName = 'Courier';
            app.Field_RawFolder.FontWeight = 'bold';
            app.Field_RawFolder.Position = [21 175 210 22];

            % Create SequenceTab
            app.SequenceTab = uitab(app.TabGroup2);
            app.SequenceTab.Title = 'Sequence';
            app.SequenceTab.BackgroundColor = [0.902 0.902 0.902];

            % Create SequenceList
            app.SequenceList = uitable(app.SequenceTab);
            app.SequenceList.ColumnName = '';
            app.SequenceList.RowName = {};
            app.SequenceList.Position = [11 12 290 190];

            % Create Panel_IsotopicDilution
            app.Panel_IsotopicDilution = uipanel(app.ICProUIFigure);
            app.Panel_IsotopicDilution.TitlePosition = 'centertop';
            app.Panel_IsotopicDilution.Title = 'Isotopic Dilution Input & Processing Results';
            app.Panel_IsotopicDilution.BackgroundColor = [0.902 0.902 0.902];
            app.Panel_IsotopicDilution.FontName = 'Avenir';
            app.Panel_IsotopicDilution.FontWeight = 'bold';
            app.Panel_IsotopicDilution.Scrollable = 'on';
            app.Panel_IsotopicDilution.FontSize = 14;
            app.Panel_IsotopicDilution.Position = [371 22 810 630];

            % Create SpikesPanel
            app.SpikesPanel = uipanel(app.Panel_IsotopicDilution);
            app.SpikesPanel.Enable = 'off';
            app.SpikesPanel.TitlePosition = 'centertop';
            app.SpikesPanel.Title = 'Spikes';
            app.SpikesPanel.BackgroundColor = [0.949 0.949 0.949];
            app.SpikesPanel.FontName = 'Avenir';
            app.SpikesPanel.FontWeight = 'bold';
            app.SpikesPanel.Position = [15 13 776 153];

            % Create UspikeDropDownLabel
            app.UspikeDropDownLabel = uilabel(app.SpikesPanel);
            app.UspikeDropDownLabel.HorizontalAlignment = 'right';
            app.UspikeDropDownLabel.FontName = 'Avenir';
            app.UspikeDropDownLabel.Position = [27 24 65 22];
            app.UspikeDropDownLabel.Text = '236U spike';

            % Create DropDown_236
            app.DropDown_236 = uidropdown(app.SpikesPanel);
            app.DropDown_236.Items = {'Select'};
            app.DropDown_236.ItemsData = 0;
            app.DropDown_236.DropDownOpeningFcn = createCallbackFcn(app, @Spikes, true);
            app.DropDown_236.ValueChangedFcn = createCallbackFcn(app, @Spikes, true);
            app.DropDown_236.Tag = 'get236';
            app.DropDown_236.FontName = 'Avenir';
            app.DropDown_236.Position = [101 24 140 22];
            app.DropDown_236.Value = 0;

            % Create ThspikeDropDown_2Label
            app.ThspikeDropDown_2Label = uilabel(app.SpikesPanel);
            app.ThspikeDropDown_2Label.HorizontalAlignment = 'right';
            app.ThspikeDropDown_2Label.FontName = 'Avenir';
            app.ThspikeDropDown_2Label.Position = [22 54 70 22];
            app.ThspikeDropDown_2Label.Text = '230Th spike';

            % Create DropDown_230
            app.DropDown_230 = uidropdown(app.SpikesPanel);
            app.DropDown_230.Items = {'Select'};
            app.DropDown_230.ItemsData = 0;
            app.DropDown_230.DropDownOpeningFcn = createCallbackFcn(app, @Spikes, true);
            app.DropDown_230.ValueChangedFcn = createCallbackFcn(app, @Spikes, true);
            app.DropDown_230.Tag = 'get230';
            app.DropDown_230.FontName = 'Avenir';
            app.DropDown_230.Position = [101 54 140 22];
            app.DropDown_230.Value = 0;

            % Create ThspikeDropDownLabel
            app.ThspikeDropDownLabel = uilabel(app.SpikesPanel);
            app.ThspikeDropDownLabel.HorizontalAlignment = 'right';
            app.ThspikeDropDownLabel.FontName = 'Avenir';
            app.ThspikeDropDownLabel.Position = [22 84 70 22];
            app.ThspikeDropDownLabel.Text = '229Th spike';

            % Create DropDown_229
            app.DropDown_229 = uidropdown(app.SpikesPanel);
            app.DropDown_229.Items = {'Select'};
            app.DropDown_229.ItemsData = 0;
            app.DropDown_229.DropDownOpeningFcn = createCallbackFcn(app, @Spikes, true);
            app.DropDown_229.ValueChangedFcn = createCallbackFcn(app, @Spikes, true);
            app.DropDown_229.Tag = 'get229';
            app.DropDown_229.FontName = 'Avenir';
            app.DropDown_229.Position = [101 84 140 22];
            app.DropDown_229.Value = 0;

            % Create Field_RY229
            app.Field_RY229 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_RY229.ValueDisplayFormat = '%.2f';
            app.Field_RY229.Tag = 'Field_229ThRY';
            app.Field_RY229.Editable = 'off';
            app.Field_RY229.HorizontalAlignment = 'center';
            app.Field_RY229.FontName = 'Courier';
            app.Field_RY229.Tooltip = {'Th229/230 ratio in spike (if unknown assume infinite, Inf)'};
            app.Field_RY229.Position = [381 84 180 22];
            app.Field_RY229.Value = Inf;

            % Create Label_RX
            app.Label_RX = uilabel(app.SpikesPanel);
            app.Label_RX.HorizontalAlignment = 'center';
            app.Label_RX.FontName = 'Avenir';
            app.Label_RX.FontWeight = 'bold';
            app.Label_RX.Tooltip = {'Isotope amount ratio of spiked isotope vs. TBD isotope in sediment (assume 0 unless known).'};
            app.Label_RX.Position = [586 107 25 22];
            app.Label_RX.Text = 'RX';

            % Create Field_RX229
            app.Field_RX229 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_RX229.ValueDisplayFormat = '%.2f';
            app.Field_RX229.Tag = 'Field_229ThRX';
            app.Field_RX229.Editable = 'off';
            app.Field_RX229.HorizontalAlignment = 'center';
            app.Field_RX229.FontName = 'Courier';
            app.Field_RX229.Tooltip = {'Th229/230 ratio in sediment (if unknown assume 0)'};
            app.Field_RX229.Position = [579 84 40 22];

            % Create Label_CY
            app.Label_CY = uilabel(app.SpikesPanel);
            app.Label_CY.HorizontalAlignment = 'center';
            app.Label_CY.FontName = 'Avenir';
            app.Label_CY.FontWeight = 'bold';
            app.Label_CY.Tooltip = {'spike concentration (pg/g)'};
            app.Label_CY.Position = [298 107 25 22];
            app.Label_CY.Text = 'CY';

            % Create Field_CY229
            app.Field_CY229 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_CY229.ValueDisplayFormat = '%.2f';
            app.Field_CY229.Tag = 'Field_229ThCY';
            app.Field_CY229.Editable = 'off';
            app.Field_CY229.HorizontalAlignment = 'center';
            app.Field_CY229.FontName = 'Courier';
            app.Field_CY229.Tooltip = {'229Th concentration in spike (pg/g)'};
            app.Field_CY229.Position = [261 84 100 22];

            % Create Field_RY230
            app.Field_RY230 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_RY230.ValueDisplayFormat = '%.2f';
            app.Field_RY230.Tag = 'Field_230ThRY';
            app.Field_RY230.Editable = 'off';
            app.Field_RY230.HorizontalAlignment = 'center';
            app.Field_RY230.FontName = 'Courier';
            app.Field_RY230.Tooltip = {'Th230/229 ratio in spike (if unknown assume infinite, Inf)'};
            app.Field_RY230.Position = [381 54 180 22];
            app.Field_RY230.Value = Inf;

            % Create Field_RY236
            app.Field_RY236 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_RY236.ValueDisplayFormat = '%.2f';
            app.Field_RY236.Tag = '230';
            app.Field_RY236.Editable = 'off';
            app.Field_RY236.HorizontalAlignment = 'center';
            app.Field_RY236.FontName = 'Courier';
            app.Field_RY236.Tooltip = {'U236/238 ratio in spike for isotopic dilution calculations of U238 (if unknown assume infinite, Inf)'};
            app.Field_RY236.Position = [381 24 80 22];
            app.Field_RY236.Value = Inf;

            % Create Field_RX230
            app.Field_RX230 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_RX230.ValueDisplayFormat = '%.2f';
            app.Field_RX230.Tag = 'Field_230ThRX';
            app.Field_RX230.Editable = 'off';
            app.Field_RX230.HorizontalAlignment = 'center';
            app.Field_RX230.FontName = 'Courier';
            app.Field_RX230.Tooltip = {'Th229/230 ratio in sediment (if unknown assume 0)'};
            app.Field_RX230.Position = [579 54 40 22];

            % Create Field_RX236
            app.Field_RX236 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_RX236.ValueDisplayFormat = '%.2f';
            app.Field_RX236.Tag = 'Field_236URX';
            app.Field_RX236.Editable = 'off';
            app.Field_RX236.HorizontalAlignment = 'center';
            app.Field_RX236.FontName = 'Courier';
            app.Field_RX236.Tooltip = {'Th229/230 ratio in sediment (if unknown assume 0)'};
            app.Field_RX236.Position = [579 24 40 22];

            % Create Field_CY230
            app.Field_CY230 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_CY230.ValueDisplayFormat = '%.2f';
            app.Field_CY230.Tag = 'Field_230ThCY';
            app.Field_CY230.Editable = 'off';
            app.Field_CY230.HorizontalAlignment = 'center';
            app.Field_CY230.FontName = 'Courier';
            app.Field_CY230.Tooltip = {'230Th concentration in spike (pg/g)'};
            app.Field_CY230.Position = [261 54 100 22];

            % Create Field_CY236
            app.Field_CY236 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_CY236.ValueDisplayFormat = '%.2f';
            app.Field_CY236.Tag = 'Field_236UCY';
            app.Field_CY236.Editable = 'off';
            app.Field_CY236.HorizontalAlignment = 'center';
            app.Field_CY236.FontName = 'Courier';
            app.Field_CY236.Tooltip = {'U236 concentration in spike (pg/g)'};
            app.Field_CY236.Position = [261 24 100 22];

            % Create Label_RY
            app.Label_RY = uilabel(app.SpikesPanel);
            app.Label_RY.HorizontalAlignment = 'center';
            app.Label_RY.FontName = 'Avenir';
            app.Label_RY.FontWeight = 'bold';
            app.Label_RY.Tooltip = {'Isotope amount ratio of spiked isotope vs. TBD isotope in spike.'};
            app.Label_RY.Position = [458 107 25 22];
            app.Label_RY.Text = 'RY';

            % Create Button_EdtSve229
            app.Button_EdtSve229 = uibutton(app.SpikesPanel, 'push');
            app.Button_EdtSve229.ButtonPushedFcn = createCallbackFcn(app, @Spikes, true);
            app.Button_EdtSve229.Tag = 'edt229';
            app.Button_EdtSve229.FontName = 'Avenir';
            app.Button_EdtSve229.FontSize = 10;
            app.Button_EdtSve229.Enable = 'off';
            app.Button_EdtSve229.Tooltip = {'Edit and save parameters of selected spike.'};
            app.Button_EdtSve229.Position = [639 84 50 22];
            app.Button_EdtSve229.Text = 'edit';

            % Create Button_EdtSve230
            app.Button_EdtSve230 = uibutton(app.SpikesPanel, 'push');
            app.Button_EdtSve230.ButtonPushedFcn = createCallbackFcn(app, @Spikes, true);
            app.Button_EdtSve230.Tag = 'edt230';
            app.Button_EdtSve230.FontName = 'Avenir';
            app.Button_EdtSve230.FontSize = 10;
            app.Button_EdtSve230.Enable = 'off';
            app.Button_EdtSve230.Tooltip = {'Edit and save parameters of selected spike.'};
            app.Button_EdtSve230.Position = [639 54 50 22];
            app.Button_EdtSve230.Text = 'edit';

            % Create Button_EdtSve236
            app.Button_EdtSve236 = uibutton(app.SpikesPanel, 'push');
            app.Button_EdtSve236.ButtonPushedFcn = createCallbackFcn(app, @Spikes, true);
            app.Button_EdtSve236.Tag = 'edt236';
            app.Button_EdtSve236.FontName = 'Avenir';
            app.Button_EdtSve236.FontSize = 10;
            app.Button_EdtSve236.Enable = 'off';
            app.Button_EdtSve236.Tooltip = {'Edit and save parameters of selected spike.'};
            app.Button_EdtSve236.Position = [639 24 50 22];
            app.Button_EdtSve236.Text = 'edit';

            % Create Button_Delete229
            app.Button_Delete229 = uibutton(app.SpikesPanel, 'push');
            app.Button_Delete229.ButtonPushedFcn = createCallbackFcn(app, @Spikes, true);
            app.Button_Delete229.Tag = 'dlt229';
            app.Button_Delete229.FontName = 'Avenir';
            app.Button_Delete229.FontSize = 10;
            app.Button_Delete229.Enable = 'off';
            app.Button_Delete229.Tooltip = {'Delete selected spike from list of preset spikes.'};
            app.Button_Delete229.Position = [699 84 55 22];
            app.Button_Delete229.Text = 'remove';

            % Create Button_Delete230
            app.Button_Delete230 = uibutton(app.SpikesPanel, 'push');
            app.Button_Delete230.ButtonPushedFcn = createCallbackFcn(app, @Spikes, true);
            app.Button_Delete230.Tag = 'dlt230';
            app.Button_Delete230.FontName = 'Avenir';
            app.Button_Delete230.FontSize = 10;
            app.Button_Delete230.Enable = 'off';
            app.Button_Delete230.Tooltip = {'Delete selected spike from list of preset spikes.'};
            app.Button_Delete230.Position = [699 54 55 22];
            app.Button_Delete230.Text = 'remove';

            % Create Button_Delete236
            app.Button_Delete236 = uibutton(app.SpikesPanel, 'push');
            app.Button_Delete236.ButtonPushedFcn = createCallbackFcn(app, @Spikes, true);
            app.Button_Delete236.Tag = 'dlt236';
            app.Button_Delete236.FontName = 'Avenir';
            app.Button_Delete236.FontSize = 10;
            app.Button_Delete236.Enable = 'off';
            app.Button_Delete236.Tooltip = {'Delete selected spike from list of preset spikes.'};
            app.Button_Delete236.Position = [699 24 55 22];
            app.Button_Delete236.Text = 'remove';

            % Create Footnote
            app.Footnote = uilabel(app.SpikesPanel);
            app.Footnote.FontName = 'Avenir';
            app.Footnote.FontSize = 10;
            app.Footnote.FontAngle = 'italic';
            app.Footnote.FontColor = [0.302 0.302 0.302];
            app.Footnote.Tooltip = {''};
            app.Footnote.Position = [111 0 465 22];
            app.Footnote.Text = 'CY: spike concentration (pg/g), RY: isotope amount ratio of spike, RX: isotope amount ratio of sample';

            % Create Field_RYb236
            app.Field_RYb236 = uieditfield(app.SpikesPanel, 'numeric');
            app.Field_RYb236.ValueDisplayFormat = '%.2f';
            app.Field_RYb236.Tag = '229';
            app.Field_RYb236.Editable = 'off';
            app.Field_RYb236.HorizontalAlignment = 'center';
            app.Field_RYb236.FontName = 'Courier';
            app.Field_RYb236.Tooltip = {'Th236/234 ratio in spike for isotopic dilution calculations of U234 (if unknown assume infinite, Inf)'};
            app.Field_RYb236.Position = [471 24 90 22];
            app.Field_RYb236.Value = Inf;

            % Create TabGroup
            app.TabGroup = uitabgroup(app.Panel_IsotopicDilution);
            app.TabGroup.Position = [14 185 777 404];

            % Create Tab_IDWeights
            app.Tab_IDWeights = uitab(app.TabGroup);
            app.Tab_IDWeights.Title = 'Weights [mg]';
            app.Tab_IDWeights.BackgroundColor = [0.949 0.949 0.949];
            app.Tab_IDWeights.Scrollable = 'on';

            % Create Field_Sediment
            app.Field_Sediment = uitextarea(app.Tab_IDWeights);
            app.Field_Sediment.Tag = 'Field_Sediment';
            app.Field_Sediment.HorizontalAlignment = 'center';
            app.Field_Sediment.FontName = 'Courier';
            app.Field_Sediment.Enable = 'off';
            app.Field_Sediment.Position = [132 14 70 330];

            % Create Label_Sediment
            app.Label_Sediment = uilabel(app.Tab_IDWeights);
            app.Label_Sediment.HorizontalAlignment = 'center';
            app.Label_Sediment.FontName = 'Avenir';
            app.Label_Sediment.FontWeight = 'bold';
            app.Label_Sediment.Position = [138 348 59 22];
            app.Label_Sediment.Text = 'Sediment';

            % Create Field_4ml
            app.Field_4ml = uitextarea(app.Tab_IDWeights);
            app.Field_4ml.Tag = 'Field_4ml';
            app.Field_4ml.HorizontalAlignment = 'center';
            app.Field_4ml.FontName = 'Courier';
            app.Field_4ml.Enable = 'off';
            app.Field_4ml.Position = [212 14 70 330];

            % Create Field_10ml
            app.Field_10ml = uitextarea(app.Tab_IDWeights);
            app.Field_10ml.Tag = 'Field_10ml';
            app.Field_10ml.HorizontalAlignment = 'center';
            app.Field_10ml.FontName = 'Courier';
            app.Field_10ml.Enable = 'off';
            app.Field_10ml.Position = [292 14 70 330];

            % Create Field_400ul
            app.Field_400ul = uitextarea(app.Tab_IDWeights);
            app.Field_400ul.Tag = 'Field_400ul';
            app.Field_400ul.HorizontalAlignment = 'center';
            app.Field_400ul.FontName = 'Courier';
            app.Field_400ul.Enable = 'off';
            app.Field_400ul.Position = [372 14 70 330];

            % Create Field_ThBC
            app.Field_ThBC = uitextarea(app.Tab_IDWeights);
            app.Field_ThBC.Tag = 'Field_ThBC';
            app.Field_ThBC.HorizontalAlignment = 'center';
            app.Field_ThBC.FontName = 'Courier';
            app.Field_ThBC.Enable = 'off';
            app.Field_ThBC.Position = [452 14 70 330];

            % Create Label_4ml
            app.Label_4ml = uilabel(app.Tab_IDWeights);
            app.Label_4ml.HorizontalAlignment = 'center';
            app.Label_4ml.FontName = 'Avenir';
            app.Label_4ml.FontWeight = 'bold';
            app.Label_4ml.Position = [222 347 50 23];
            app.Label_4ml.Text = '4 mL';

            % Create Label_10ml
            app.Label_10ml = uilabel(app.Tab_IDWeights);
            app.Label_10ml.HorizontalAlignment = 'center';
            app.Label_10ml.FontName = 'Avenir';
            app.Label_10ml.FontWeight = 'bold';
            app.Label_10ml.Position = [307 347 40 23];
            app.Label_10ml.Text = '10 mL';

            % Create Label_400ul
            app.Label_400ul = uilabel(app.Tab_IDWeights);
            app.Label_400ul.HorizontalAlignment = 'center';
            app.Label_400ul.FontName = 'Avenir';
            app.Label_400ul.FontWeight = 'bold';
            app.Label_400ul.Position = [386 347 44 23];
            app.Label_400ul.Text = '400 μL';

            % Create Label_ThBC
            app.Label_ThBC = uilabel(app.Tab_IDWeights);
            app.Label_ThBC.HorizontalAlignment = 'center';
            app.Label_ThBC.FontName = 'Avenir';
            app.Label_ThBC.FontWeight = 'bold';
            app.Label_ThBC.Position = [453 348 67 22];
            app.Label_ThBC.Text = '229Th (BC)';

            % Create Field_UBC
            app.Field_UBC = uitextarea(app.Tab_IDWeights);
            app.Field_UBC.Tag = 'Field_UBC';
            app.Field_UBC.HorizontalAlignment = 'center';
            app.Field_UBC.FontName = 'Courier';
            app.Field_UBC.Enable = 'off';
            app.Field_UBC.Position = [532 14 70 330];

            % Create Field_ThSC
            app.Field_ThSC = uitextarea(app.Tab_IDWeights);
            app.Field_ThSC.Tag = 'Field_ThSC';
            app.Field_ThSC.HorizontalAlignment = 'center';
            app.Field_ThSC.FontName = 'Courier';
            app.Field_ThSC.Enable = 'off';
            app.Field_ThSC.Position = [612 14 70 330];

            % Create Label_UBC
            app.Label_UBC = uilabel(app.Tab_IDWeights);
            app.Label_UBC.HorizontalAlignment = 'center';
            app.Label_UBC.FontName = 'Avenir';
            app.Label_UBC.FontWeight = 'bold';
            app.Label_UBC.Position = [536 348 62 22];
            app.Label_UBC.Text = '236U (BC)';

            % Create Label_ThSC
            app.Label_ThSC = uilabel(app.Tab_IDWeights);
            app.Label_ThSC.HorizontalAlignment = 'center';
            app.Label_ThSC.FontName = 'Avenir';
            app.Label_ThSC.FontWeight = 'bold';
            app.Label_ThSC.Position = [614 348 66 22];
            app.Label_ThSC.Text = '230Th (SC)';

            % Create Field_USC
            app.Field_USC = uitextarea(app.Tab_IDWeights);
            app.Field_USC.Tag = 'Field_USC';
            app.Field_USC.HorizontalAlignment = 'center';
            app.Field_USC.FontName = 'Courier';
            app.Field_USC.Enable = 'off';
            app.Field_USC.Position = [692 14 70 330];

            % Create Label_USC
            app.Label_USC = uilabel(app.Tab_IDWeights);
            app.Label_USC.HorizontalAlignment = 'center';
            app.Label_USC.FontName = 'Avenir';
            app.Label_USC.FontWeight = 'bold';
            app.Label_USC.Position = [698 348 61 22];
            app.Label_USC.Text = '236U (SC)';

            % Create Field_SampleList
            app.Field_SampleList = uitextarea(app.Tab_IDWeights);
            app.Field_SampleList.Tag = 'Field_SampleList';
            app.Field_SampleList.Editable = 'off';
            app.Field_SampleList.HorizontalAlignment = 'right';
            app.Field_SampleList.WordWrap = 'off';
            app.Field_SampleList.FontName = 'Courier';
            app.Field_SampleList.FontWeight = 'bold';
            app.Field_SampleList.FontAngle = 'italic';
            app.Field_SampleList.BackgroundColor = [0.9804 0.9804 0.9804];
            app.Field_SampleList.Visible = 'off';
            app.Field_SampleList.Position = [13 15 108 329];

            % Create Label_SampleList
            app.Label_SampleList = uilabel(app.Tab_IDWeights);
            app.Label_SampleList.HorizontalAlignment = 'center';
            app.Label_SampleList.FontName = 'Avenir';
            app.Label_SampleList.FontWeight = 'bold';
            app.Label_SampleList.FontAngle = 'italic';
            app.Label_SampleList.Position = [14 348 107 22];
            app.Label_SampleList.Text = 'ID';

            % Create Tab_RawIntensities
            app.Tab_RawIntensities = uitab(app.TabGroup);
            app.Tab_RawIntensities.Title = 'Th & U raw intensities [cps]';
            app.Tab_RawIntensities.BackgroundColor = [0.949 0.949 0.949];

            % Create Field_cpsSampleList
            app.Field_cpsSampleList = uitextarea(app.Tab_RawIntensities);
            app.Field_cpsSampleList.Editable = 'off';
            app.Field_cpsSampleList.HorizontalAlignment = 'right';
            app.Field_cpsSampleList.WordWrap = 'off';
            app.Field_cpsSampleList.FontName = 'Courier';
            app.Field_cpsSampleList.FontWeight = 'bold';
            app.Field_cpsSampleList.FontAngle = 'italic';
            app.Field_cpsSampleList.BackgroundColor = [0.9804 0.9804 0.9804];
            app.Field_cpsSampleList.Visible = 'off';
            app.Field_cpsSampleList.Position = [13 15 107 329];

            % Create Label_cpsSampleList
            app.Label_cpsSampleList = uilabel(app.Tab_RawIntensities);
            app.Label_cpsSampleList.HorizontalAlignment = 'center';
            app.Label_cpsSampleList.FontName = 'Avenir';
            app.Label_cpsSampleList.FontWeight = 'bold';
            app.Label_cpsSampleList.FontAngle = 'italic';
            app.Label_cpsSampleList.Position = [14 348 106 22];
            app.Label_cpsSampleList.Text = 'ID';

            % Create Field_cps230Th
            app.Field_cps230Th = uitextarea(app.Tab_RawIntensities);
            app.Field_cps230Th.HorizontalAlignment = 'center';
            app.Field_cps230Th.FontName = 'Courier';
            app.Field_cps230Th.Enable = 'off';
            app.Field_cps230Th.Position = [132 14 70 330];

            % Create Label_cps230Th
            app.Label_cps230Th = uilabel(app.Tab_RawIntensities);
            app.Label_cps230Th.HorizontalAlignment = 'center';
            app.Label_cps230Th.FontName = 'Avenir';
            app.Label_cps230Th.FontWeight = 'bold';
            app.Label_cps230Th.Position = [147 348 41 22];
            app.Label_cps230Th.Text = 'Th230';

            % Create Field_cps232Th
            app.Field_cps232Th = uitextarea(app.Tab_RawIntensities);
            app.Field_cps232Th.HorizontalAlignment = 'center';
            app.Field_cps232Th.FontName = 'Courier';
            app.Field_cps232Th.Enable = 'off';
            app.Field_cps232Th.Position = [212 14 70 330];

            % Create Field_cps236U
            app.Field_cps236U = uitextarea(app.Tab_RawIntensities);
            app.Field_cps236U.HorizontalAlignment = 'center';
            app.Field_cps236U.FontName = 'Courier';
            app.Field_cps236U.Enable = 'off';
            app.Field_cps236U.Position = [292 14 70 330];

            % Create Field_cps238U
            app.Field_cps238U = uitextarea(app.Tab_RawIntensities);
            app.Field_cps238U.HorizontalAlignment = 'center';
            app.Field_cps238U.FontName = 'Courier';
            app.Field_cps238U.Enable = 'off';
            app.Field_cps238U.Position = [372 14 70 330];

            % Create Label_cps232Th
            app.Label_cps232Th = uilabel(app.Tab_RawIntensities);
            app.Label_cps232Th.HorizontalAlignment = 'center';
            app.Label_cps232Th.FontName = 'Avenir';
            app.Label_cps232Th.FontWeight = 'bold';
            app.Label_cps232Th.Position = [222 348 50 22];
            app.Label_cps232Th.Text = '232Th';

            % Create Label_cps236U
            app.Label_cps236U = uilabel(app.Tab_RawIntensities);
            app.Label_cps236U.HorizontalAlignment = 'center';
            app.Label_cps236U.FontName = 'Avenir';
            app.Label_cps236U.FontWeight = 'bold';
            app.Label_cps236U.Position = [310 348 35 22];
            app.Label_cps236U.Text = '236U';

            % Create Label_cps238U
            app.Label_cps238U = uilabel(app.Tab_RawIntensities);
            app.Label_cps238U.HorizontalAlignment = 'center';
            app.Label_cps238U.FontName = 'Avenir';
            app.Label_cps238U.FontWeight = 'bold';
            app.Label_cps238U.Position = [390 348 35 22];
            app.Label_cps238U.Text = '238U';

            % Create Label_cps230Th_R
            app.Label_cps230Th_R = uilabel(app.Tab_RawIntensities);
            app.Label_cps230Th_R.HorizontalAlignment = 'center';
            app.Label_cps230Th_R.FontName = 'Avenir';
            app.Label_cps230Th_R.FontWeight = 'bold';
            app.Label_cps230Th_R.Position = [450 348 74 22];
            app.Label_cps230Th_R.Text = 'Th230 Rinse';

            % Create Label_cps232Th_R
            app.Label_cps232Th_R = uilabel(app.Tab_RawIntensities);
            app.Label_cps232Th_R.HorizontalAlignment = 'center';
            app.Label_cps232Th_R.FontName = 'Avenir';
            app.Label_cps232Th_R.FontWeight = 'bold';
            app.Label_cps232Th_R.Position = [530 348 74 22];
            app.Label_cps232Th_R.Text = '232Th Rinse';

            % Create Label_cps236U_R
            app.Label_cps236U_R = uilabel(app.Tab_RawIntensities);
            app.Label_cps236U_R.HorizontalAlignment = 'center';
            app.Label_cps236U_R.FontName = 'Avenir';
            app.Label_cps236U_R.FontWeight = 'bold';
            app.Label_cps236U_R.Position = [612 348 69 22];
            app.Label_cps236U_R.Text = '236U Rinse';

            % Create Label_cps238U_R
            app.Label_cps238U_R = uilabel(app.Tab_RawIntensities);
            app.Label_cps238U_R.HorizontalAlignment = 'center';
            app.Label_cps238U_R.FontName = 'Avenir';
            app.Label_cps238U_R.FontWeight = 'bold';
            app.Label_cps238U_R.Position = [693 348 69 22];
            app.Label_cps238U_R.Text = '238U Rinse';

            % Create Field_cps230Th_R
            app.Field_cps230Th_R = uitextarea(app.Tab_RawIntensities);
            app.Field_cps230Th_R.HorizontalAlignment = 'center';
            app.Field_cps230Th_R.FontName = 'Courier';
            app.Field_cps230Th_R.FontAngle = 'italic';
            app.Field_cps230Th_R.Enable = 'off';
            app.Field_cps230Th_R.Position = [452 179 70 165];

            % Create Field_cps232Th_R
            app.Field_cps232Th_R = uitextarea(app.Tab_RawIntensities);
            app.Field_cps232Th_R.HorizontalAlignment = 'center';
            app.Field_cps232Th_R.FontName = 'Courier';
            app.Field_cps232Th_R.FontAngle = 'italic';
            app.Field_cps232Th_R.Enable = 'off';
            app.Field_cps232Th_R.Position = [532 179 70 165];

            % Create Field_cps236U_R
            app.Field_cps236U_R = uitextarea(app.Tab_RawIntensities);
            app.Field_cps236U_R.HorizontalAlignment = 'center';
            app.Field_cps236U_R.FontName = 'Courier';
            app.Field_cps236U_R.FontAngle = 'italic';
            app.Field_cps236U_R.Enable = 'off';
            app.Field_cps236U_R.Position = [612 179 70 165];

            % Create Field_cps238U_R
            app.Field_cps238U_R = uitextarea(app.Tab_RawIntensities);
            app.Field_cps238U_R.HorizontalAlignment = 'center';
            app.Field_cps238U_R.FontName = 'Courier';
            app.Field_cps238U_R.FontAngle = 'italic';
            app.Field_cps238U_R.Enable = 'off';
            app.Field_cps238U_R.Position = [692 179 70 165];

            % Create Footnote2
            app.Footnote2 = uilabel(app.Tab_RawIntensities);
            app.Footnote2.WordWrap = 'on';
            app.Footnote2.FontName = 'Avenir';
            app.Footnote2.FontSize = 10;
            app.Footnote2.FontAngle = 'italic';
            app.Footnote2.FontColor = [0.302 0.302 0.302];
            app.Footnote2.Position = [453 130 310 42];
            app.Footnote2.Text = 'Rinse raw intensities are required for rinse correction. If not specified, Th and U raw intensities will not be rinse corrected (leave fields empty). Enter concentrations of each rinse (usually 1a-e, 2a/b, 3a/b)';

            % Create Tab_TEresults
            app.Tab_TEresults = uitab(app.TabGroup);
            app.Tab_TEresults.Title = 'Results (TE)';

            % Create DataSelTE
            app.DataSelTE = uibuttongroup(app.Tab_TEresults);
            app.DataSelTE.SelectionChangedFcn = createCallbackFcn(app, @SwitchResultTE, true);
            app.DataSelTE.BorderType = 'none';
            app.DataSelTE.TitlePosition = 'centertop';
            app.DataSelTE.Position = [11 17 140 320];

            % Create RawButton
            app.RawButton = uitogglebutton(app.DataSelTE);
            app.RawButton.Tag = 'Raw';
            app.RawButton.Enable = 'off';
            app.RawButton.Text = 'Raw data';
            app.RawButton.FontName = 'Avenir';
            app.RawButton.FontSize = 10;
            app.RawButton.Position = [11 9 120 22];

            % Create RCButton
            app.RCButton = uitogglebutton(app.DataSelTE);
            app.RCButton.Tag = 'RC';
            app.RCButton.Enable = 'off';
            app.RCButton.Text = 'Rinse corrected';
            app.RCButton.FontName = 'Avenir';
            app.RCButton.FontSize = 10;
            app.RCButton.Position = [11 39 120 22];

            % Create QCButton
            app.QCButton = uitogglebutton(app.DataSelTE);
            app.QCButton.Tag = 'QC';
            app.QCButton.Enable = 'off';
            app.QCButton.Text = 'QC corrected';
            app.QCButton.FontName = 'Avenir';
            app.QCButton.FontSize = 10;
            app.QCButton.Position = [11 69 120 22];

            % Create SCButton
            app.SCButton = uitogglebutton(app.DataSelTE);
            app.SCButton.Tag = 'SC';
            app.SCButton.Enable = 'off';
            app.SCButton.Text = 'Spike corrected';
            app.SCButton.FontName = 'Avenir';
            app.SCButton.FontSize = 10;
            app.SCButton.Position = [11 99 120 22];

            % Create OCButton
            app.OCButton = uitogglebutton(app.DataSelTE);
            app.OCButton.Tag = 'OC';
            app.OCButton.Enable = 'off';
            app.OCButton.Text = 'Oxide corrected';
            app.OCButton.FontName = 'Avenir';
            app.OCButton.FontSize = 10;
            app.OCButton.Position = [11 129 120 22];

            % Create BCButton
            app.BCButton = uitogglebutton(app.DataSelTE);
            app.BCButton.Tag = 'BC';
            app.BCButton.Enable = 'off';
            app.BCButton.Text = 'Blank corrected';
            app.BCButton.FontName = 'Avenir';
            app.BCButton.FontSize = 10;
            app.BCButton.Position = [11 159 120 22];

            % Create DCButton
            app.DCButton = uitogglebutton(app.DataSelTE);
            app.DCButton.Tag = 'DC';
            app.DCButton.Enable = 'off';
            app.DCButton.Text = 'Dilution corrected';
            app.DCButton.FontName = 'Avenir';
            app.DCButton.FontSize = 10;
            app.DCButton.Position = [11 189 120 22];

            % Create IDButton
            app.IDButton = uitogglebutton(app.DataSelTE);
            app.IDButton.Tag = 'ID';
            app.IDButton.Enable = 'off';
            app.IDButton.Tooltip = {'Th232 and U238 concentrations determined via isotopic dilution'};
            app.IDButton.Text = 'Isotopic Dilution';
            app.IDButton.FontName = 'Avenir';
            app.IDButton.FontSize = 10;
            app.IDButton.Position = [11 219 120 22];
            app.IDButton.Value = true;

            % Create CUSelTE
            app.CUSelTE = uibuttongroup(app.DataSelTE);
            app.CUSelTE.SelectionChangedFcn = createCallbackFcn(app, @SwitchResultTE, true);
            app.CUSelTE.BorderType = 'none';
            app.CUSelTE.Position = [1 251 130 66];

            % Create ConcTE
            app.ConcTE = uiradiobutton(app.CUSelTE);
            app.ConcTE.Tag = 'Conc';
            app.ConcTE.Enable = 'off';
            app.ConcTE.Text = '  Conc. (μg/g)';
            app.ConcTE.FontName = 'Avenir';
            app.ConcTE.FontWeight = 'bold';
            app.ConcTE.Position = [11 44 99 23];
            app.ConcTE.Value = true;

            % Create ErrTE
            app.ErrTE = uiradiobutton(app.CUSelTE);
            app.ErrTE.Tag = 'Err';
            app.ErrTE.Enable = 'off';
            app.ErrTE.Text = '  Errors (μg/g)';
            app.ErrTE.FontName = 'Avenir';
            app.ErrTE.FontWeight = 'bold';
            app.ErrTE.Position = [11 24 100 23];

            % Create ErrpTE
            app.ErrpTE = uiradiobutton(app.CUSelTE);
            app.ErrpTE.Tag = 'Errp';
            app.ErrpTE.Enable = 'off';
            app.ErrpTE.Text = '  Errors (%)';
            app.ErrpTE.FontName = 'Avenir';
            app.ErrpTE.FontWeight = 'bold';
            app.ErrpTE.Position = [11 5 85 22];

            % Create Table_TEresults
            app.Table_TEresults = uitable(app.Tab_TEresults);
            app.Table_TEresults.ColumnName = {'Column 1'; 'Column 2'; 'Column 3'; 'Column 4'};
            app.Table_TEresults.RowName = {};
            app.Table_TEresults.Enable = 'off';
            app.Table_TEresults.FontName = 'Courier';
            app.Table_TEresults.Position = [161 9 607 354];

            % Create Tab_TEplot
            app.Tab_TEplot = uitab(app.TabGroup);
            app.Tab_TEplot.Title = 'ID vs LR plots (TE)';
            app.Tab_TEplot.BackgroundColor = [0.949 0.949 0.949];

            % Create UIDFig
            app.UIDFig = uiaxes(app.Tab_TEplot);
            xlabel(app.UIDFig, '238U, LR (ppm)')
            ylabel(app.UIDFig, '238U, ID (ppm)')
            zlabel(app.UIDFig, 'Z')
            app.UIDFig.Toolbar.Visible = 'off';
            app.UIDFig.PlotBoxAspectRatio = [1 1 1];
            app.UIDFig.FontName = 'Courier';
            app.UIDFig.FontWeight = 'bold';
            app.UIDFig.XGrid = 'on';
            app.UIDFig.YGrid = 'on';
            app.UIDFig.Box = 'on';
            app.UIDFig.Position = [399 17 360 348];

            % Create ThIDFig
            app.ThIDFig = uiaxes(app.Tab_TEplot);
            xlabel(app.ThIDFig, '232Th, LR (ppm)')
            ylabel(app.ThIDFig, '232Th, ID (ppm)')
            zlabel(app.ThIDFig, 'Z')
            app.ThIDFig.Toolbar.Visible = 'off';
            app.ThIDFig.PlotBoxAspectRatio = [1 1 1];
            app.ThIDFig.FontName = 'Courier';
            app.ThIDFig.FontWeight = 'bold';
            app.ThIDFig.XGrid = 'on';
            app.ThIDFig.YGrid = 'on';
            app.ThIDFig.Box = 'on';
            app.ThIDFig.Position = [14 17 367 348];

            % Create Tab_ThUresults
            app.Tab_ThUresults = uitab(app.TabGroup);
            app.Tab_ThUresults.Title = 'Results (Th/U)';

            % Create Table_ThUresults
            app.Table_ThUresults = uitable(app.Tab_ThUresults);
            app.Table_ThUresults.ColumnName = {'Column 1'; 'Column 2'; 'Column 3'; 'Column 4'};
            app.Table_ThUresults.RowName = {};
            app.Table_ThUresults.Enable = 'off';
            app.Table_ThUresults.FontName = 'Courier';
            app.Table_ThUresults.Position = [161 9 606 354];

            % Create DataSelThU
            app.DataSelThU = uibuttongroup(app.Tab_ThUresults);
            app.DataSelThU.SelectionChangedFcn = createCallbackFcn(app, @SwitchResultThU, true);
            app.DataSelThU.BorderType = 'none';
            app.DataSelThU.TitlePosition = 'centertop';
            app.DataSelThU.Position = [11 147 140 110];

            % Create RatioSButton
            app.RatioSButton = uitogglebutton(app.DataSelThU);
            app.RatioSButton.Tag = 'SampleMB';
            app.RatioSButton.Enable = 'off';
            app.RatioSButton.Text = 'Sample ratios';
            app.RatioSButton.FontName = 'Avenir';
            app.RatioSButton.FontSize = 10;
            app.RatioSButton.Position = [11 59 120 22];

            % Create RatioNButton
            app.RatioNButton = uitogglebutton(app.DataSelThU);
            app.RatioNButton.Tag = 'NatUMB';
            app.RatioNButton.Enable = 'off';
            app.RatioNButton.Text = 'NatU ratio';
            app.RatioNButton.FontName = 'Avenir';
            app.RatioNButton.FontSize = 10;
            app.RatioNButton.Position = [11 29 120 22];

            % Create ThUIDButton
            app.ThUIDButton = uitogglebutton(app.DataSelThU);
            app.ThUIDButton.Tag = 'ThUID';
            app.ThUIDButton.Enable = 'off';
            app.ThUIDButton.Text = 'Th230 & U234 ID';
            app.ThUIDButton.FontName = 'Avenir';
            app.ThUIDButton.FontSize = 10;
            app.ThUIDButton.Position = [11 89 120 22];
            app.ThUIDButton.Value = true;

            % Create CUSelThU
            app.CUSelThU = uibuttongroup(app.Tab_ThUresults);
            app.CUSelThU.SelectionChangedFcn = createCallbackFcn(app, @SwitchResultThU, true);
            app.CUSelThU.BorderType = 'none';
            app.CUSelThU.Position = [11 259 140 76];

            % Create ConcThU
            app.ConcThU = uiradiobutton(app.CUSelThU);
            app.ConcThU.Tag = 'Conc';
            app.ConcThU.Enable = 'off';
            app.ConcThU.Text = '  Conc. (pg/g)';
            app.ConcThU.FontName = 'Avenir';
            app.ConcThU.FontWeight = 'bold';
            app.ConcThU.Position = [11 52 99 23];
            app.ConcThU.Value = true;

            % Create ErrThU
            app.ErrThU = uiradiobutton(app.CUSelThU);
            app.ErrThU.Tag = 'Err';
            app.ErrThU.Enable = 'off';
            app.ErrThU.Text = '  Errors (pg/g)';
            app.ErrThU.FontName = 'Avenir';
            app.ErrThU.FontWeight = 'bold';
            app.ErrThU.Position = [11 32 100 23];

            % Create ErrpThU
            app.ErrpThU = uiradiobutton(app.CUSelThU);
            app.ErrpThU.Tag = 'Errp';
            app.ErrpThU.Enable = 'off';
            app.ErrpThU.Text = '  Errors (%)';
            app.ErrpThU.FontName = 'Avenir';
            app.ErrpThU.FontWeight = 'bold';
            app.ErrpThU.Position = [11 13 85 22];

            % Create Button_TEtoggle
            app.Button_TEtoggle = uibutton(app.ICProUIFigure, 'state');
            app.Button_TEtoggle.ValueChangedFcn = createCallbackFcn(app, @AnalysisToggle, true);
            app.Button_TEtoggle.Tooltip = {''};
            app.Button_TEtoggle.Icon = 'x.png';
            app.Button_TEtoggle.Text = '';
            app.Button_TEtoggle.BackgroundColor = [1 0.502 0.502];
            app.Button_TEtoggle.Position = [21 630 20 22];

            % Create Button_ThUtoggle
            app.Button_ThUtoggle = uibutton(app.ICProUIFigure, 'state');
            app.Button_ThUtoggle.ValueChangedFcn = createCallbackFcn(app, @AnalysisToggle, true);
            app.Button_ThUtoggle.Tooltip = {''};
            app.Button_ThUtoggle.Icon = 'x.png';
            app.Button_ThUtoggle.Text = '';
            app.Button_ThUtoggle.BackgroundColor = [1 0.502 0.502];
            app.Button_ThUtoggle.Position = [21 260 20 22];

            % Create Button_Run
            app.Button_Run = uibutton(app.ICProUIFigure, 'push');
            app.Button_Run.ButtonPushedFcn = createCallbackFcn(app, @Execute, true);
            app.Button_Run.Icon = 'go.png';
            app.Button_Run.Enable = 'off';
            app.Button_Run.Position = [1191 22 40 630];
            app.Button_Run.Text = '';

            % Show the figure after all components are created
            app.ICProUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = ICPro_exported
            % Execute the startup function
            runStartupFcn(app, @Splash)
            
            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.ICProUIFigure)


            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.ICProUIFigure)
        end
    end
end