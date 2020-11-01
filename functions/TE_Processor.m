function [C,dC] = TE_Processor(TEpar,C_RAW,dC_RAW,Isotopes,RunID,WtPar,SpikePar,cps)

%% 1) Concentrations and errors (in ppm), read from raw file
% clear
% [C,dC,Isotopes,RunID] = ReadTMRaw('/Users/jweis/Documents/Study/5 - PHD/5 - Misc/RA/rawfile.xlsx');

% Run locations
Sloc = find(RunID.AllInd == 'S'); % Sample locations in measurement sequence
Bloc = find(RunID.AllInd == 'B'); % procedural blank locations in measurement sequence
Vloc = find(RunID.AllInd == 'V'); % Spiked sample locations in measurement sequence
Rloc = find(RunID.AllInd == 'R'); % Rinse locations in measurement sequence
Qloc = find(RunID.AllInd == 'Q'); % QC locations in measurement sequence

%% 2) Rinse Correction (RC)
C_RC = C_RAW;
dC_RC = dC_RAW;

if TEpar.CCheck.RC == true
    % Samples
    for iS = 1 : length(Sloc)
        % find rinses measured before and after respective sample
        Rdiff = Rloc - Sloc(iS);
        R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
        R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
        % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
        C_RC.Sample(:,iS) = C_RAW.Sample(:,iS) - mean([C_RAW.Rinse(:,R1),C_RAW.Rinse(:,R2)],2);
        % propagate errors
        dC_RC.Sample(:,iS) = sqrt(dC_RAW.Sample(:,iS).^2 + (dC_RAW.Rinse(:,R1)/2).^2 + (dC_RAW.Rinse(:,R2)/2).^2);
        
        % correct raw intensities of Th and U (for isotopic dilution)
        % +++++++++++++ Requires rinse raw counts ++++++++++++++++++++
        if isempty(find(isnan(cps.Rinse),1))
            cps.Sample(:,iS) = cps.Sample(:,iS) - mean([cps.Rinse(:,R1),cps.Rinse(:,R2)],2);
        else
            if iS == 1
                disp('Raw intensities were not rinse corrected.')
            end
        end
    end
    
    % Spiked samples
    for iV = 1 : length(Vloc)
        % find rinses measured before and after respective spiked sample
        Rdiff = Rloc - Vloc(iV);
        R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
        R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
        % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
        C_RC.Spike(:,iV) = C_RAW.Spike(:,iV) - mean([C_RAW.Rinse(:,R1),C_RAW.Rinse(:,R2)],2);
        % propagate errors
        dC_RC.Spike(:,iV) = sqrt(dC_RAW.Spike(:,iV).^2 + (dC_RAW.Rinse(:,R1)/2).^2 + (dC_RAW.Rinse(:,R2)/2).^2);
    end
    
    % Th & U raw intensities
    
    
    % +++++++++++++ CHECK IF REQUIRED ++++++++++++++++++++
    % Procedural blank
    % find rinses measured before and after respective procedural blank
    Rdiff = Rloc - Bloc;
    R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
    R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
    % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
    C_RC.Blank(:,1) = C_RAW.Blank(:,1) - mean([C_RAW.Rinse(:,R1),C_RAW.Rinse(:,R2)],2);
    % propagate errors
    dC_RC.Blank(:,1) = sqrt(dC_RAW.Blank(:,1).^2 + (dC_RAW.Rinse(:,R1)/2).^2 + (dC_RAW.Rinse(:,R2)/2).^2);
    
    % QC
    for iQ = 1 : length(Qloc)
        % find rinses measured before and after respective QC
        Rdiff = Rloc - Qloc(iQ);
        if ~isempty(find(Rdiff < 0,1))
            R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
        end
        R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
        if iQ > 1
            % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
            C_RC.QC(:,iQ) = C_RAW.QC(:,iQ) - mean([C_RAW.Rinse(:,R1),C_RAW.Rinse(:,R2)],2);
            % propagate errors
            dC_RC.QC(:,iQ) = sqrt((dC_RAW.QC(:,iQ)).^2 + (dC_RAW.Rinse(:,R1)/2).^2 + (dC_RAW.Rinse(:,R2)/2).^2);
        else
            % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
            C_RC.QC(:,iQ) = C_RAW.QC(:,iQ) - C_RAW.Rinse(:,R2);
            % propagate errors
            dC_RC.QC(:,iQ) = sqrt(dC_RAW.QC(:,iQ).^2 + dC_RAW.Rinse(:,R2).^2);
        end
    end
end

%% 3) QC correction (QC)
C_QC = C_RC;
dC_QC = dC_RC;

if TEpar.CCheck.QC == true
    % Samples
    for iS = 1 : length(Sloc)
        % find QC measured before and after respective sample
        Qdiff = Qloc - Sloc(iS);
        Q1 = find(Qdiff == max(Qdiff(Qdiff<0)));
        Q2 = find(Qdiff == min(Qdiff(Qdiff>0)));
        % correct RC concentrations for QC
        f_QC = C_RC.QC(:,1)./mean([C_RC.QC(:,Q1),C_RC.QC(:,Q2)],2); % QC correction factor
        C_QC.Sample(:,iS) = C_RC.Sample(:,iS) .* f_QC;
        % propagate errors
        df_QC = abs(f_QC) .* sqrt((dC_RC.QC(:,1)./C_RC.QC(:,1)).^2 + (sqrt(dC_RC.QC(:,Q1).^2+dC_RC.QC(:,Q2).^2)./(C_RC.QC(:,Q1)+C_RC.QC(:,Q2))).^2);
        dC_QC.Sample(:,iS) = abs(C_QC.Sample(:,iS)) .* sqrt((dC_RC.Sample(:,iS)./C_RC.Sample(:,iS)).^2 + (df_QC./f_QC).^2);
    end
    
    % Spiked samples
    for iV = 1 : length(Vloc)
        % find QC measured before and after respective sample
        Qdiff = Qloc - Vloc(iV);
        Q1 = find(Qdiff == max(Qdiff(Qdiff<0)));
        Q2 = find(Qdiff == min(Qdiff(Qdiff>0)));
        % correct RC concentrations for QC
        f_QC = C_RC.QC(:,1)./mean([C_RC.QC(:,Q1),C_RC.QC(:,Q2)],2); % QC correction factor
        C_QC.Spike(:,iV) = C_RC.Spike(:,iV) .* f_QC;
        % propagate errors
        df_QC = abs(f_QC) .* sqrt((dC_RC.QC(:,1)./C_RC.QC(:,1)).^2 + (sqrt(dC_RC.QC(:,Q1).^2+dC_RC.QC(:,Q2).^2)./(C_RC.QC(:,Q1)+C_RC.QC(:,Q2))).^2);
        dC_QC.Spike(:,iV) = abs(C_QC.Spike(:,iV)) .* sqrt((dC_RC.Spike(:,iV)./C_RC.Spike(:,iV)).^2 + (df_QC./f_QC).^2);
    end
    
    % Procedural blank
    % find QC measured before and after respective sample
    Qdiff = Qloc - Bloc;
    Q1 = find(Qdiff == max(Qdiff(Qdiff<0)));
    Q2 = find(Qdiff == min(Qdiff(Qdiff>0)));
    % correct RC concentrations for QC
    f_QC = C_RC.QC(:,1)./mean([C_RC.QC(:,Q1),C_RC.QC(:,Q2)],2); % QC correction factor
    C_QC.Blank(:,1) = C_RC.Blank(:,1) .* f_QC;
    % propagate errors
    df_QC = abs(f_QC) .* sqrt((dC_RC.QC(:,1)./C_RC.QC(:,1)).^2 + (sqrt(dC_RC.QC(:,Q1).^2+dC_RC.QC(:,Q2).^2)./(C_RC.QC(:,Q1)+C_RC.QC(:,Q2))).^2);
    dC_QC.Blank(:,1) = abs(C_QC.Blank(:,1)) .* sqrt((dC_RC.Blank(:,1)./C_RC.Blank(:,1)).^2 + (df_QC./f_QC).^2);
end

%% 4) Spike correction (SC)
C_SC = C_QC;
dC_SC = dC_QC;

if TEpar.CCheck.SC == true && ~isempty(Vloc)
    % Samples
    for iS = 1 : length(Sloc)
        if length(Vloc) == 1
            % if only one spiked sample was measured correct every sample using the respective sample
            V1 = 1;
        else
            % else correct samples using the spiked sample measured after the respective sample
            Vdiff = Vloc - Sloc(iS);
            V1 = find(Vdiff == min(Vdiff(Vdiff>0)));
        end
        % correct RC concentrations for QC
        f_SC = 0.1./(C_QC.Spike(:,V1) - C_QC.Sample(:,dsearchn(Sloc,Vloc(V1)))); % SC correction factor
        C_SC.Sample(:,iS) = C_QC.Sample(:,iS) .* f_SC;
        % propagate errors
        df_SC = 0.1 * sqrt(dC_QC.Spike(:,V1).^2+dC_QC.Sample(:,dsearchn(Sloc,Vloc(V1))).^2)./(C_QC.Spike(:,V1) - C_QC.Sample(:,dsearchn(Sloc,Vloc(V1)))).^2;
        dC_SC.Sample(:,iS) = abs(C_SC.Sample(:,iS)) .* sqrt((dC_QC.Sample(:,iS)./C_QC.Sample(:,iS)).^2 + (df_SC./f_SC).^2);
    end
    
    % Procedural Blank
    if length(Vloc) == 1
        % if only one spiked sample was measured correct every sample using the respective sample
        V1 = 1;
    else
        % else correct samples using the spiked sample measured after the respective sample
        Vdiff = Vloc - Bloc(1);
        V1 = find(Vdiff == min(Vdiff(Vdiff>0)));
    end
    % correct RC concentrations for QC
    f_SC = 0.1./(C_QC.Spike(:,V1) - C_QC.Blank(:,dsearchn(Bloc,Vloc(V1)))); % SC correction factor
    C_SC.Blank(:,1) = C_QC.Blank(:,1) .* f_SC;
    % propagate errors
    df_SC = 0.1 * sqrt(dC_QC.Spike(:,V1).^2+dC_QC.Blank(:,dsearchn(Bloc,Vloc(V1))).^2)./(C_QC.Spike(:,V1) - C_QC.Blank(:,dsearchn(Bloc,Vloc(V1)))).^2;
    dC_SC.Blank(:,1) = abs(C_SC.Blank(:,1)) .* sqrt((dC_QC.Blank(:,1)./C_QC.Blank(:,1)).^2 + (df_SC./f_SC).^2);
end

%% 5) RE correction due to oxide formation (OC)
C_OC = C_SC;
dC_OC = dC_SC;

if TEpar.CCheck.OC == true
    % Find array row of Re185, Re187, Tm169 and Yb171 concentrations
    for iI = 1 : length(Isotopes)
        if strcmp(Isotopes{iI},'Re185')
            Re185 = iI;
        elseif strcmp(Isotopes{iI},'Re187')
            Re187 = iI;
        elseif strcmp(Isotopes{iI},'Tm169')
            Tm169 = iI;
        elseif strcmp(Isotopes{iI},'Yb171')
            Yb171 = iI;
        end
    end
    
    % Samples
    C_OC.Sample(Re185,:) = C_SC.Sample(Re185,:) - C_SC.Sample(Tm169,:) * 0.003;
    C_OC.Sample(Re187,:) = C_SC.Sample(Re187,:) - C_SC.Sample(Yb171,:) * 0.0001;
    dC_OC.Sample(Re185,:) = sqrt(dC_SC.Sample(Re185,:).^2 + (dC_SC.Sample(Tm169,:) * 0.003).^2);
    dC_OC.Sample(Re187,:) = sqrt(dC_SC.Sample(Re187,:).^2 + (dC_SC.Sample(Yb171,:) * 0.0001).^2);
    
    % Procedural blank
    C_OC.Blank(Re185,:) = C_SC.Blank(Re185,:) - C_SC.Blank(Tm169,:) * 0.003;
    C_OC.Blank(Re187,:) = C_SC.Blank(Re187,:) - C_SC.Blank(Yb171,:) * 0.0001;
    dC_OC.Blank(Re185,:) = sqrt(dC_SC.Blank(Re185,:).^2 + (dC_SC.Blank(Tm169,:) * 0.003).^2);
    dC_OC.Blank(Re187,:) = sqrt(dC_SC.Blank(Re187,:).^2 + (dC_SC.Blank(Yb171,:) * 0.0001).^2);
end

%% 6) Procedural blank correction (BC)
C_BC = C_OC;
dC_BC = dC_OC;

if TEpar.CCheck.BC == true
    % Samples
    for iS = 1 : length(Sloc)
        C_BC.Sample(:,iS) = C_OC.Sample(:,iS) - C_OC.Blank;
        dC_BC.Sample(:,iS) = sqrt(dC_OC.Sample(:,iS).^2 + dC_OC.Blank.^2);
    end
end

%% 7) Dilution correction (DC)
C_DC = C_BC;
dC_DC = dC_BC;
ICPdilution = 5;
WtPar.m_unc = 1;

if TEpar.CCheck.DC == true
    f_DC = (ICPdilution .* WtPar.m_4ml .* (WtPar.m_10ml + WtPar.m_ThSC + WtPar.m_USC)) ./ (WtPar.m_sed .* WtPar.m_400ul);
    C_DC.Sample = f_DC .* C_BC.Sample;
    
    df_DC = abs(f_DC) .* sqrt((WtPar.m_unc./WtPar.m_4ml).^2 + (sqrt(3*WtPar.m_unc^2)./(WtPar.m_10ml + WtPar.m_ThSC + WtPar.m_USC)).^2 + (WtPar.m_unc./WtPar.m_sed.^3).^2 + (WtPar.m_unc./WtPar.m_400ul.^3).^2);
    dC_DC.Sample = abs(C_DC.Sample) .* sqrt((df_DC./f_DC).^2 + (dC_BC.Sample./C_BC.Sample).^2);
end

%% Isotopic dilution
% Parameters
ThMassRatio = 232.0380553/230.0331338;  % Th232:Th233 mass ratio
UMassRatio = 238.0565/236.04987;        % U238:U236 mass ratio
ThRY = SpikePar.Th230RY;
% ThRX = SpikePar.Th230RX;
ThCY = SpikePar.Th230CY;
URY = SpikePar.U236RY;
% URX = SpikePar.U236RX;
UCY = SpikePar.U236CY;

% Mass of spiked isotopes Th230 & U236 in sample, calculated from added spike weights (pg)
Th230InSample = ThCY .* WtPar.m_ThSC/1000;
U236InSample = UCY .* WtPar.m_USC/1000 + UCY .* WtPar.m_UBC/1000 .* WtPar.m_400ul./WtPar.m_4ml;
dTh230InSample = ThCY .* WtPar.m_unc/1000;
dU236InSample = sqrt((UCY .* WtPar.m_unc/1000)^2 + (UCY .* WtPar.m_UBC/1000 .* WtPar.m_400ul./WtPar.m_4ml .* sqrt(UCY .* WtPar.m_unc/1000 .* WtPar.m_unc./WtPar.m_unc)));

% Raw count ratios Th232:Th230 & U238:U236
ThRatioInSample = cps.Sample(2,:) ./ cps.Sample(1,:);
URatioInSample = cps.Sample(4,:) ./ cps.Sample(3,:);

% Mass of Th232 and U238 in sample, derived from raw count ratio and the amount of spiked isotope (pg)
Th232InSample = ThRatioInSample .* Th230InSample .* ThMassRatio;
U238InSample = URatioInSample .* U236InSample .* UMassRatio;

% Mass of Th232 and U238 in sediment (pg)
Th232InSediment = Th232InSample .* (WtPar.m_4ml./WtPar.m_400ul);
U238InSediment = U238InSample .* (WtPar.m_4ml./WtPar.m_400ul);

% Concentration of Th232 and U238 in sediment (ppm)
C_DC.Sample(end+1,:) = (Th232InSediment ./ (WtPar.m_sed*1000)) .* ((ThRY - 1./ThRatioInSample) ./ (1 + ThRY));
C_DC.Sample(end+1,:) = (U238InSediment ./ (WtPar.m_sed*1000)) .* ((URY - 1./URatioInSample) ./ (1 + URY));
Isotopes{end+1} = 'Th232(ID)';
Isotopes{end+1} = 'U238(ID)';


%% Result
C = array2table(C_DC.Sample,'VariableNames',RunID.Sample,'RowNames',Isotopes);
dC = array2table(dC_DC.Sample,'VariableNames',RunID.Sample,'RowNames',Isotopes(1:end-2));

%%
figure(4)
plot(C{18,2:end},C{end-1,2:end},'o')
axis square