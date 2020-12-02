function [IDC,dIDC] = ThU_ID(SpikePar,WtPar,ThU,dThU)

%% Isotopic Dilution
dscale = 0.0001;

ThMassRatio = 229.031754/230.033126;
IDC.Th230 = 1/ThMassRatio .* SpikePar.Th229CY .* ...
    (WtPar.m_ThBC./WtPar.m_sed) .* ...
    ((SpikePar.Th229RY - ThU.Sample.R229_230(2:end))./(ThU.Sample.R229_230(2:end) - SpikePar.Th229RX)) .* ...
    1/(SpikePar.Th229RY + 1) .*...
    10^-6;
dIDC.Th230 = IDC.Th230 .* sqrt((dscale./WtPar.m_ThBC).^2 + (dscale./WtPar.m_sed).^2 + (dThU.Sample.R229_230_cMB(2:end)./ThU.Sample.R229_230_cMB(2:end)).^2*2);

UMassRatio = 236.045568/234.0409468;
IDC.U234 = 1/UMassRatio .* SpikePar.U236CY .* ...
    (WtPar.m_UBC./WtPar.m_sed) .* ...
    ((SpikePar.U236RY - ThU.Sample.R236_234(2:end))./(ThU.Sample.R236_234(2:end) - SpikePar.U236RX)) .* ...
    1/(SpikePar.U236RY + 1) .* ...
    10^-6;
dIDC.U234 = IDC.U234 .* sqrt((dscale./WtPar.m_UBC).^2 + (dscale./WtPar.m_sed).^2 + (dThU.Sample.R236_234_cMB(2:end)./ThU.Sample.R236_234_cMB(2:end)).^2*2);

%% FV Calculations
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

end