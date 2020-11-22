function [C,dC,IsotopesID] = TE_Processor(TEpar,C,dC,Isotopes,RunID,WtPar,SpikePar,cps)

%% 1) Concentrations and errors (in ppm), read from raw file

% Run locations
Sloc = find(RunID.AllInd == 'S'); % Sample locations in measurement sequence
Bloc = find(RunID.AllInd == 'B'); % procedural blank locations in measurement sequence
Vloc = find(RunID.AllInd == 'V'); % Spiked sample locations in measurement sequence
Rloc = find(RunID.AllInd == 'R'); % Rinse locations in measurement sequence
Qloc = find(RunID.AllInd == 'Q'); % QC locations in measurement sequence

%% 2) Rinse Correction (RC)
C.RC = C.Raw;
dC.RC = dC.Raw;

if TEpar.CCheck.RC == true
    % Samples
    for iS = 1 : length(Sloc)
        % find rinses measured before and after respective sample
        Rdiff = Rloc - Sloc(iS);
        R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
        R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
        % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
        C.RC.Sample(:,iS) = C.Raw.Sample(:,iS) - mean([C.Raw.Rinse(:,R1),C.Raw.Rinse(:,R2)],2);
        % propagate errors
        dC.RC.Sample(:,iS) = sqrt(dC.Raw.Sample(:,iS).^2 + (dC.Raw.Rinse(:,R1)/2).^2 + (dC.Raw.Rinse(:,R2)/2).^2);
        
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
        C.RC.Spike(:,iV) = C.Raw.Spike(:,iV) - mean([C.Raw.Rinse(:,R1),C.Raw.Rinse(:,R2)],2);
        % propagate errors
        dC.RC.Spike(:,iV) = sqrt(dC.Raw.Spike(:,iV).^2 + (dC.Raw.Rinse(:,R1)/2).^2 + (dC.Raw.Rinse(:,R2)/2).^2);
    end
    
    % Th & U raw intensities
    
    
    % +++++++++++++ CHECK IF REQUIRED ++++++++++++++++++++
    % Procedural blank
    % find rinses measured before and after respective procedural blank
    Rdiff = Rloc - Bloc;
    R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
    R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
    % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
    C.RC.Blank(:,1) = C.Raw.Blank(:,1) - mean([C.Raw.Rinse(:,R1),C.Raw.Rinse(:,R2)],2);
    % propagate errors
    dC.RC.Blank(:,1) = sqrt(dC.Raw.Blank(:,1).^2 + (dC.Raw.Rinse(:,R1)/2).^2 + (dC.Raw.Rinse(:,R2)/2).^2);
    
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
            C.RC.QC(:,iQ) = C.Raw.QC(:,iQ) - mean([C.Raw.Rinse(:,R1),C.Raw.Rinse(:,R2)],2);
            % propagate errors
            dC.RC.QC(:,iQ) = sqrt((dC.Raw.QC(:,iQ)).^2 + (dC.Raw.Rinse(:,R1)/2).^2 + (dC.Raw.Rinse(:,R2)/2).^2);
        else
            % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
            C.RC.QC(:,iQ) = C.Raw.QC(:,iQ) - C.Raw.Rinse(:,R2);
            % propagate errors
            dC.RC.QC(:,iQ) = sqrt(dC.Raw.QC(:,iQ).^2 + dC.Raw.Rinse(:,R2).^2);
        end
    end
end

%% 3) QC correction (QC)
C.QC = C.RC;
dC.QC = dC.RC;

if TEpar.CCheck.QC == true
    % Samples
    for iS = 1 : length(Sloc)
        % find QC measured before and after respective sample
        Qdiff = Qloc - Sloc(iS);
        Q1 = find(Qdiff == max(Qdiff(Qdiff<0)));
        Q2 = find(Qdiff == min(Qdiff(Qdiff>0)));
        % correct RC concentrations for QC
        f_QC = C.RC.QC(:,1)./mean([C.RC.QC(:,Q1),C.RC.QC(:,Q2)],2); % QC correction factor
        C.QC.Sample(:,iS) = C.RC.Sample(:,iS) .* f_QC;
        % propagate errors
        df_QC = abs(f_QC) .* sqrt((dC.RC.QC(:,1)./C.RC.QC(:,1)).^2 + (sqrt(dC.RC.QC(:,Q1).^2+dC.RC.QC(:,Q2).^2)./(C.RC.QC(:,Q1)+C.RC.QC(:,Q2))).^2);
        dC.QC.Sample(:,iS) = abs(C.QC.Sample(:,iS)) .* sqrt((dC.RC.Sample(:,iS)./C.RC.Sample(:,iS)).^2 + (df_QC./f_QC).^2);
    end
    
    % Spiked samples
    for iV = 1 : length(Vloc)
        % find QC measured before and after respective sample
        Qdiff = Qloc - Vloc(iV);
        Q1 = find(Qdiff == max(Qdiff(Qdiff<0)));
        Q2 = find(Qdiff == min(Qdiff(Qdiff>0)));
        % correct RC concentrations for QC
        f_QC = C.RC.QC(:,1)./mean([C.RC.QC(:,Q1),C.RC.QC(:,Q2)],2); % QC correction factor
        C.QC.Spike(:,iV) = C.RC.Spike(:,iV) .* f_QC;
        % propagate errors
        df_QC = abs(f_QC) .* sqrt((dC.RC.QC(:,1)./C.RC.QC(:,1)).^2 + (sqrt(dC.RC.QC(:,Q1).^2+dC.RC.QC(:,Q2).^2)./(C.RC.QC(:,Q1)+C.RC.QC(:,Q2))).^2);
        dC.QC.Spike(:,iV) = abs(C.QC.Spike(:,iV)) .* sqrt((dC.RC.Spike(:,iV)./C.RC.Spike(:,iV)).^2 + (df_QC./f_QC).^2);
    end
    
    % Procedural blank
    % find QC measured before and after respective sample
    Qdiff = Qloc - Bloc;
    Q1 = find(Qdiff == max(Qdiff(Qdiff<0)));
    Q2 = find(Qdiff == min(Qdiff(Qdiff>0)));
    % correct RC concentrations for QC
    f_QC = C.RC.QC(:,1)./mean([C.RC.QC(:,Q1),C.RC.QC(:,Q2)],2); % QC correction factor
    C.QC.Blank(:,1) = C.RC.Blank(:,1) .* f_QC;
    % propagate errors
    df_QC = abs(f_QC) .* sqrt((dC.RC.QC(:,1)./C.RC.QC(:,1)).^2 + (sqrt(dC.RC.QC(:,Q1).^2+dC.RC.QC(:,Q2).^2)./(C.RC.QC(:,Q1)+C.RC.QC(:,Q2))).^2);
    dC.QC.Blank(:,1) = abs(C.QC.Blank(:,1)) .* sqrt((dC.RC.Blank(:,1)./C.RC.Blank(:,1)).^2 + (df_QC./f_QC).^2);
end

%% 4) Spike correction (SC)
C.SC = C.QC;
dC.SC = dC.QC;

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
        f_SC = 0.1./(C.QC.Spike(:,V1) - C.QC.Sample(:,dsearchn(Sloc,Vloc(V1)))); % SC correction factor
        C.SC.Sample(:,iS) = C.QC.Sample(:,iS) .* f_SC;
        % propagate errors
        df_SC = 0.1 * sqrt(dC.QC.Spike(:,V1).^2+dC.QC.Sample(:,dsearchn(Sloc,Vloc(V1))).^2)./(C.QC.Spike(:,V1) - C.QC.Sample(:,dsearchn(Sloc,Vloc(V1)))).^2;
        dC.SC.Sample(:,iS) = abs(C.SC.Sample(:,iS)) .* sqrt((dC.QC.Sample(:,iS)./C.QC.Sample(:,iS)).^2 + (df_SC./f_SC).^2);
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
    f_SC = 0.1./(C.QC.Spike(:,V1) - C.QC.Blank(:,dsearchn(Bloc,Vloc(V1)))); % SC correction factor
    C.SC.Blank(:,1) = C.QC.Blank(:,1) .* f_SC;
    % propagate errors
    df_SC = 0.1 * sqrt(dC.QC.Spike(:,V1).^2+dC.QC.Blank(:,dsearchn(Bloc,Vloc(V1))).^2)./(C.QC.Spike(:,V1) - C.QC.Blank(:,dsearchn(Bloc,Vloc(V1)))).^2;
    dC.SC.Blank(:,1) = abs(C.SC.Blank(:,1)) .* sqrt((dC.QC.Blank(:,1)./C.QC.Blank(:,1)).^2 + (df_SC./f_SC).^2);
end

%% 5) RE correction due to oxide formation (OC)
C.OC = C.SC;
dC.OC = dC.SC;

if TEpar.CCheck.OC == true
    % Find array row of Re185, Re187, Tm169 and Yb171 concentrations
    for iI = 1 : length(Isotopes)
        if strcmp(Isotopes{iI},'Re185(LR)')
            Re185 = iI;
        elseif strcmp(Isotopes{iI},'Re187(LR)')
            Re187 = iI;
        elseif strcmp(Isotopes{iI},'Tm169(LR)')
            Tm169 = iI;
        elseif strcmp(Isotopes{iI},'Yb171(LR)')
            Yb171 = iI;
        end
    end
    
    % Samples
    C.OC.Sample(Re185,:) = C.SC.Sample(Re185,:) - C.SC.Sample(Tm169,:) * 0.003;
    C.OC.Sample(Re187,:) = C.SC.Sample(Re187,:) - C.SC.Sample(Yb171,:) * 0.0001;
    dC.OC.Sample(Re185,:) = sqrt(dC.SC.Sample(Re185,:).^2 + (dC.SC.Sample(Tm169,:) * 0.003).^2);
    dC.OC.Sample(Re187,:) = sqrt(dC.SC.Sample(Re187,:).^2 + (dC.SC.Sample(Yb171,:) * 0.0001).^2);
    
    % Procedural blank
    C.OC.Blank(Re185,:) = C.SC.Blank(Re185,:) - C.SC.Blank(Tm169,:) * 0.003;
    C.OC.Blank(Re187,:) = C.SC.Blank(Re187,:) - C.SC.Blank(Yb171,:) * 0.0001;
    dC.OC.Blank(Re185,:) = sqrt(dC.SC.Blank(Re185,:).^2 + (dC.SC.Blank(Tm169,:) * 0.003).^2);
    dC.OC.Blank(Re187,:) = sqrt(dC.SC.Blank(Re187,:).^2 + (dC.SC.Blank(Yb171,:) * 0.0001).^2);
end

%% 6) Procedural blank correction (BC)
C.BC = C.OC;
dC.BC = dC.OC;

if TEpar.CCheck.BC == true
    % Samples
    for iS = 1 : length(Sloc)
        C.BC.Sample(:,iS) = C.OC.Sample(:,iS) - C.OC.Blank;
        dC.BC.Sample(:,iS) = sqrt(dC.OC.Sample(:,iS).^2 + dC.OC.Blank.^2);
    end
end

%% 7) Dilution correction (DC)
C.DC = C.BC;
dC.DC = dC.BC;
ICPdilution = 5;
WtPar.m_unc = 1;

if TEpar.CCheck.DC == true
    C.DC.f_DC = (ICPdilution .* WtPar.m_4ml .* (WtPar.m_10ml + WtPar.m_ThSC + WtPar.m_USC)) ./ (WtPar.m_sed .* WtPar.m_400ul);
    C.DC.Sample = C.DC.f_DC .* C.BC.Sample;
    
    dC.DC.f_DC = abs(C.DC.f_DC) .* sqrt((WtPar.m_unc./WtPar.m_4ml).^2 + (sqrt(3*WtPar.m_unc^2)./(WtPar.m_10ml + WtPar.m_ThSC + WtPar.m_USC)).^2 + (WtPar.m_unc./WtPar.m_sed.^3).^2 + (WtPar.m_unc./WtPar.m_400ul.^3).^2);
    dC.DC.Sample = abs(C.DC.Sample) .* sqrt((dC.DC.f_DC./C.DC.f_DC).^2 + (dC.BC.Sample./C.BC.Sample).^2);
end

%% Isotopic dilution
C.ID = C.DC;
dC.ID = dC.DC;
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
dTh232InSample = ThRatioInSample .* dTh230InSample .* ThMassRatio;
dU238InSample = URatioInSample .* dU236InSample .* UMassRatio;

% Mass of Th232 and U238 in sediment (pg)
Th232InSediment = Th232InSample .* (WtPar.m_4ml./WtPar.m_400ul);
U238InSediment = U238InSample .* (WtPar.m_4ml./WtPar.m_400ul);
dTh232InSediment = sqrt((Th232InSample.^2 .* ((WtPar.m_4ml/1000).^2 .* (WtPar.m_unc/1000).^2 + (WtPar.m_400ul/1000).^2 .* (WtPar.m_unc/1000).^2) + dTh232InSample.^2 .* (WtPar.m_4ml/1000).^2 .* (WtPar.m_400ul/1000).^2)./((WtPar.m_400ul/1000).^4));
dU238InSediment = sqrt((U238InSample.^2 .* ((WtPar.m_4ml/1000).^2 .* (WtPar.m_unc/1000).^2 + (WtPar.m_400ul/1000).^2 .* (WtPar.m_unc/1000).^2) + dU238InSample.^2 .* (WtPar.m_4ml/1000).^2 .* (WtPar.m_400ul/1000).^2)./((WtPar.m_400ul/1000).^4));

% Concentration of Th232 and U238 in sediment (ppm)
if ThRY > 0
    C.ID.Sample(find(strcmp(Isotopes,'Th232(LR)')),:) = (Th232InSediment ./ (WtPar.m_sed*1000)) .* ((ThRY - 1./ThRatioInSample) ./ (1 + ThRY));
    dC.ID.Sample(find(strcmp(Isotopes,'Th232(LR)')),:) = sqrt((Th232InSediment.^2.*(WtPar.m_unc*1000).^2 + dTh232InSediment.^2.*(WtPar.m_sed*1000).^2)./Th232InSediment.^4) .* ((ThRY - 1./ThRatioInSample) ./ (1 + ThRY));
else
    C.ID.Sample(find(strcmp(Isotopes,'Th232(LR)')),:) = (Th232InSediment ./ (WtPar.m_sed*1000));
    dC.ID.Sample(find(strcmp(Isotopes,'Th232(LR)')),:) = sqrt((Th232InSediment.^2.*(WtPar.m_unc*1000).^2 + dTh232InSediment.^2.*(WtPar.m_sed*1000).^2)./Th232InSediment.^4);
end
if URY > 0
    C.ID.Sample(find(strcmp(Isotopes,'U238(LR)')),:) = (U238InSediment ./ (WtPar.m_sed*1000)) .* ((URY - 1./URatioInSample) ./ (1 + URY));
    dC.ID.Sample(find(strcmp(Isotopes,'U238(LR)')),:) = sqrt((U238InSediment.^2.*(WtPar.m_unc*1000).^2 + dU238InSediment.^2.*(WtPar.m_sed*1000).^2)./U238InSediment.^4) .* ((URY - 1./URatioInSample) ./ (1 + URY));
else
    C.ID.Sample(find(strcmp(Isotopes,'U238(LR)')),:) = (U238InSediment ./ (WtPar.m_sed*1000));
    dC.ID.Sample(find(strcmp(Isotopes,'U238(LR)')),:) = sqrt((U238InSediment.^2.*(WtPar.m_unc*1000).^2 + dU238InSediment.^2.*(WtPar.m_sed*1000).^2)./U238InSediment.^4);
end
IsotopesID = Isotopes;
IsotopesID{strcmp(Isotopes,'Th232(LR)')} = 'Th232(ID)';
IsotopesID{strcmp(Isotopes,'U238(LR)')} = 'U238(ID)';

%% Result
% C = array2table(C.DC.Sample,'VariableNames',RunID.Sample,'RowNames',Isotopes);
% dC = array2table(dC.DC.Sample,'VariableNames',RunID.Sample,'RowNames',Isotopes(1:end-2));