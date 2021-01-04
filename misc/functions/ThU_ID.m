function [IDC,dIDC] = ThU_ID(SpikePar,WtPar,OUT)

%% Isotopic Dilution
dscale = 0.0001;

%  Get ThU Sample IDs (ThU samples sorted into blocks with occasional NaN fields)
ThUSampleInd = find(~cellfun(@isempty,OUT.ThU.SampleSeq(2:end)))+1;
ThUSamples = OUT.ThU.SampleSeq(ThUSampleInd);

% Determine TE/ThU sample matchups for ID
if numel(ThUSamples) == numel(OUT.TE.RunID.Sample)
    % If # of ThU samples equals # of TE samples, match up against each TE sample
    IDC.TEMatchUpInd = 1 : numel(OUT.TE.RunID.Sample);
elseif numel(ThUSamples) < numel(OUT.TE.RunID.Sample)
    % If # of ThU samples is smaller than # of TE samples, ThU samples were likely analysed in separate batches
    % Determine TE sample ID numbers
    [s,e] = regexp(OUT.TE.RunID.Sample,'[0-9]*');
    TEIDnum = NaN(1,numel(OUT.TE.RunID.Sample));
    for i = 1 : numel(OUT.TE.RunID.Sample)
        TEIDnum(i) = str2double(OUT.TE.RunID.Sample{i}(s{i}(end):e{i}(end)));
    end
    % Determine ThU sample ID numbers & find corresponding TE sample matchups
    [s,e] = regexp(ThUSamples,'[0-9]*');
    ThUIDnum = NaN(1,numel(ThUSamples));
    IDC.TEMatchUpInd = NaN(1,numel(ThUSamples));
    for i = 1 : numel(ThUSamples)
        ThUIDnum(i) = str2double(ThUSamples{i}(s{i}(end):e{i}(end)));
        IDC.TEMatchUpInd(i) = find(ThUIDnum(i) == TEIDnum);
    end
end
% Create matchup table
ThUMatchUp = cell(numel(OUT.TE.RunID.Sample),1);ThUMatchUp(IDC.TEMatchUpInd) = ThUSamples';
IDC.SampleMatchUp = cell2table([OUT.TE.RunID.Sample,ThUMatchUp],'VariableNames',{'TE Samples','ThU Samples'});

ThMassRatio = 229.031754/230.033126;
IDC.Th230 = 1/ThMassRatio .* SpikePar.Th229CY .* ...
    (WtPar.m_ThBC(IDC.TEMatchUpInd)./WtPar.m_sed(IDC.TEMatchUpInd)) .* ...
    ((SpikePar.Th229RY - OUT.ThU.Ratios.Sample.R229_230(ThUSampleInd))./(OUT.ThU.Ratios.Sample.R229_230(ThUSampleInd) - SpikePar.Th229RX)) .* ...
    1/(SpikePar.Th229RY + 1) * 10^-6;
dIDC.Th230 = IDC.Th230 .* sqrt((dscale./WtPar.m_ThBC(IDC.TEMatchUpInd)).^2 + (dscale./WtPar.m_sed(IDC.TEMatchUpInd)).^2 + (OUT.ThU.dRatios.Sample.R229_230_cMB(ThUSampleInd)./OUT.ThU.Ratios.Sample.R229_230_cMB(ThUSampleInd)).^2*2);

UMassRatio = 236.045568/234.0409468;
IDC.U234 = 1/UMassRatio .* SpikePar.U236CY .* ...
    (WtPar.m_UBC(IDC.TEMatchUpInd)./WtPar.m_sed(IDC.TEMatchUpInd)) .* ...
    ((SpikePar.U236RYb - OUT.ThU.Ratios.Sample.R236_234(ThUSampleInd))./(OUT.ThU.Ratios.Sample.R236_234(ThUSampleInd) - SpikePar.U236RX)) .* ...
    1/(SpikePar.U236RYb + 1) .* ...
    10^-6;
dIDC.U234 = IDC.U234 .* sqrt((dscale./WtPar.m_UBC(IDC.TEMatchUpInd)).^2 + (dscale./WtPar.m_sed(IDC.TEMatchUpInd)).^2 + (OUT.ThU.dRatios.Sample.R236_234_cMB(ThUSampleInd)./OUT.ThU.Ratios.Sample.R236_234_cMB(ThUSampleInd)).^2*2);

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