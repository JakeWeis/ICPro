function [IDC,dIDC] = ThU_ID(SpikePar,WtPar,ThU,dThU)

%% Isotopic Dilution
ThMassRatio = 229.031754/230.033126;
IDC.Th230 = 1/ThMassRatio .* SpikePar.Th229CY .* ...
    (WtPar.m_ThBC./WtPar.m_sed) .* ...
    ((SpikePar.Th229RY - ThU.Sample.R229_230(2:end))./(ThU.Sample.R229_230(2:end) - SpikePar.Th229RX)) .* ...
    1/(SpikePar.Th229RY + 1) .*...
    10^-6;
% lambda230 = 9.15771E-06;
% Th230Acti = Th230Conc * lambda230;

UMassRatio = 236.045568/234.0409468;
IDC.U234 = 1/UMassRatio .* SpikePar.U236CY .* ...
    (WtPar.m_UBC./WtPar.m_sed) .* ...
    ((SpikePar.U236RY - ThU.Sample.R236_234(2:end))./(ThU.Sample.R236_234(2:end) - SpikePar.U236RX)) .* ...
    1/(SpikePar.U236RY + 1) .* ...
    10^-6;
% lambda234 = 2.82629E-06;
% U230Acti = Th230Conc * lambda234;


% dScale = 0.0001;
dIDC.Th230 = NaN;
dIDC.U234 = NaN;
% dIDC.Th230Acti = NaN;
% dIDC.U234Acti = NaN;

% %% Conversion ppm --> dpm
% Th230dpm = Th230Conc * 45781.96174;
% Th232dpm = IDinput.Th232Conc * 0.244438092;
% U234dpm = U234Conc * 13792.06119;
% U238dpm = IDinput.U238Conc * 0.746240796;
% 
% s_Th230dpm = s_Th230Conc * 45781.96174;
% s_Th232dpm = NaN;
% s_U234dpm = s_U234Conc * 13792.06119;
% s_U238dpm = NaN;
% 
% %% xs_230Th calculation
% lambdaTh230 = 0.0000091577114620154;
% lambdaU234 = 2.82628819800182E-06;
% U234_U238_i = 1.147;
% corrDetr = Th232dpm * 0.4;
% s_corrDetr = s_Th232dpm * 0.4;
% corrAuth = (U238dpm - corrDetr) .* ...
%     ((1-exp(-lambdaTh230 .* IDinput.Age)) + ...
%     (lambdaTh230 ./ (lambdaTh230 - lambdaU234)) .* ...
%     (U234_U238_i - 1) .* ...
%     (exp(-lambdaU234 .* IDinput.Age) - ...
%     exp(-lambdaTh230 .* IDinput.Age)));
% s_corrAuth = NaN;
% corrDecay = exp(lambdaTh230 .* IDinput.Age);
% s_corrDecay = NaN;
% 
% xsTh230 = corrDecay .* (Th230dpm - corrDetr - corrAuth);
% s_xsTh230 = NaN;
% 
% %% Preserved  vertical particle flux (FV)
% betaTh230 = 0.0256;
% FV = betaTh230 .* IDinput.Depth ./ xsTh230;
% 
% s_FV = NaN;
% 
% %% GENERATE, SAVE & DISPLAY OUTPUT TABLE B:
% ResTab1{:,end+1} = Th230Conc;
% ResTab1{:,end+1} = s_Th230Conc;
% ResTab1{:,end+1} = s_Th230Conc./Th230Conc;
% ResTab1{:,end+1} = U234Conc;
% ResTab1{:,end+1} = s_U234Conc;
% ResTab1{:,end+1} = s_U234Conc ./ U234Conc;
% ResTab1{:,end+1} = FV;
% ResTab1{:,end+1} = s_FV;
% ResTab1{:,end+1} = s_FV ./ FV;
% ResTab1.Properties.VariableNames = {'SampleID',...
%     'Th229_230','sigma_Th229_230','sigmaP_Th229_230'...
%     'U236_234','sigma_U236_234','sigmaP_U236_234',...
%     'Th230Conc','sigma_Th230Conc','sigmaP_Th230Conc',...
%     'U234Conc','sigma_U234Conc','sigmaP_U234Conc',...
%     'FV','sigma_FV','sigmaP_FV'};
% 
% writetable(ResTab1, [par.RawDataDir,'output/SampleRatios.xlsx'])
% writetable(ResTab2, [par.RawDataDir,'output/NatURatios.xlsx'])
% 
% TableFig = figure;
% TableFig.Position = [100 100 740 667];
% TableFig.ToolBar = 'none';
% TableFig.MenuBar = 'none';
% TableFig.NumberTitle = 'off';
% TableFig.Name = 'Results';
% 
% ColumnNames1 = {'229Th/230Th',char(963),[char(963), ' [%]'],...
%     '236U/234U',char(963),[char(963), ' [%]'],...
%     '230Th conc. [ppm]',char(963),[char(963), ' [%]'],...
%     '234U conc. [ppm]',char(963),[char(963), ' [%]'],...
%     'Particle flux [g m-2 a-1]',char(963),[char(963), ' [%]']};
% ResTabUI1 = uitable(TableFig,'Data',ResTab1{:,2:end});
% ResTabUI1.ColumnName = ColumnNames1';
% ResTabUI1.RowName = ResTab1{:,1};
% ResTabUI1.Position = [10 212 720 445];
% 
% ColumnNames2 = {'U235/U234',char(963),[char(963), ' [%]']};
% ResTabUI2 = uitable(TableFig,'Data',ResTab2{:,2:end});
% ResTabUI2.ColumnName = ColumnNames2';
% ResTabUI2.RowName = ResTab2{:,1};
% ResTabUI2.Position = [10 10 360 192];

end