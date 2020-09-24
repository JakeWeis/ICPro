function TM_beta

%% 1) Concentrations and errors (in ppm), read from raw file
clear
[C,dC,Isotopes,RunID] = ReadTMRaw('/Users/jweis/Documents/Study/5 - PHD/5 - Misc/RA/rawfile.xlsx');

% Run locations
Sloc = find(RunID.AllInd == 'S'); % Sample locations in measurement sequence
Bloc = find(RunID.AllInd == 'B'); % procedural blank locations in measurement sequence
Vloc = find(RunID.AllInd == 'V'); % Spiked sample locations in measurement sequence
Rloc = find(RunID.AllInd == 'R'); % Rinse locations in measurement sequence
Qloc = find(RunID.AllInd == 'Q'); % QC locations in measurement sequence

% Correction info
RCcheck = false;
QCcheck = true;
SCcheck = false;
OCcheck = false;
BCcheck = true;
DCcheck = true;

%% Additional data input
%++++++++++ sample & spike weights ++++++++++++
d_ICP = 5;
wtpar.m_sed = ones(1,length(Sloc))*200;
wtpar.m_4ml = ones(1,length(Sloc))*5100;
wtpar.m_10ml = ones(1,length(Sloc))*10500;
wtpar.m_400ul = ones(1,length(Sloc))*520;
wtpar.m_ThSC = ones(1,length(Sloc))*41;
wtpar.m_USC = ones(1,length(Sloc))*153;
wtpar.m_ThBC = ones(1,length(Sloc))*505;
wtpar.m_UBC = ones(1,length(Sloc))*28;
wtpar.dm = 1;

%++++++++++ Th230, Th232, U236, U238 raw intensities ++++++++++++
% --> Will be supplied via csv raw file!
cps.Sample = [8503.9	186363.75	33354.1	45652.85
8235.7	27328.45	34814.1	9481.95
8736.7	72983.25	35520.1	23137.15
8741.7	84170.85	35742.8	26510.05
8660.8	113679.25	36345.1	74619.95
9354.0	109613.35	37438.2	75457.75
8974.5	89276.25	35651.8	83035.75
9359.0	887075.45	38751.5	201125.05
8655.7	30038.35	36233.7	11900.65
9523.5	689747.05	37739.3	110260.75
8495.0	36898.45	35213.9	12624.35
9550.0	31589.65	37628	15660.55
10020.6	32738.45	40705.1	18142.55
8935.2	30529.45	35968	17993.25
9527.2	26746.55	38154.3	19071.15
9251.5	31397.35	36747.4	25055.15
9107.2	31119.05	37048.5	18592.95
9739.7	31040.55	37802.6	17882.05
9203.4	35590.25	36251.4	20862.55
9165.4	33849.25	37412.9	14225.95
8985.8	34365.55	36147.7	14069.05
9582.9	392518.55	37774.7	299044.35
8046.0	26307.25	33441.45	24003.4]';

%% 2) Rinse Correction (RC)
C_RC = C;
dC_RC = dC;

if RCcheck == true
    % Samples
    for iS = 1 : length(Sloc)
        % find rinses measured before and after respective sample
        Rdiff = Rloc - Sloc(iS);
        R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
        R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
        % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
        C_RC.Sample(:,iS) = C.Sample(:,iS) - mean([C.Rinse(:,R1),C.Rinse(:,R2)],2);
        % propagate errors
        dC_RC.Sample(:,iS) = sqrt(dC.Sample(:,iS).^2 + (dC.Rinse(:,R1)/2).^2 + (dC.Rinse(:,R2)/2).^2);
        
        % correct raw intensities of Th and U (for isotopic dilution)
        % +++++++++++++ Requires rinse raw counts ++++++++++++++++++++
        cps.Rinse = [0 0 0 0
            0 0 0 0
            0 0 0 0
            0.0	207.3	2.5	73.3
            2.5	91	0	166.9
            0.0	1160.9	0	1456.8
            5.1	632.2	5.1	1079.9
            10.1	998.9	5.1	811.8
            0 0 0 0]';
        % +++++++++++++ Requires rinse raw counts ++++++++++++++++++++
        cps.Sample(:,iS) = cps.Sample(:,iS) - mean([cps.Rinse(:,R1),cps.Rinse(:,R2)],2);
    end
    
    % Spiked samples
    for iV = 1 : length(Vloc)
        % find rinses measured before and after respective spiked sample
        Rdiff = Rloc - Vloc(iV);
        R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
        R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
        % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
        C_RC.Spike(:,iV) = C.Spike(:,iV) - mean([C.Rinse(:,R1),C.Rinse(:,R2)],2);
        % propagate errors
        dC_RC.Spike(:,iV) = sqrt(dC.Spike(:,iV).^2 + (dC.Rinse(:,R1)/2).^2 + (dC.Rinse(:,R2)/2).^2);
    end
    
    % Th & U raw intensities
    
    
    % +++++++++++++ CHECK IF REQUIRED ++++++++++++++++++++
    % Procedural blank
    % find rinses measured before and after respective procedural blank
    Rdiff = Rloc - Bloc;
    R1 = find(Rdiff == max(Rdiff(Rdiff<0)));
    R2 = find(Rdiff == min(Rdiff(Rdiff>0)));
    % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
    C_RC.Blank(:,1) = C.Blank(:,1) - mean([C.Rinse(:,R1),C.Rinse(:,R2)],2);
    % propagate errors
    dC_RC.Blank(:,1) = sqrt(dC.Blank(:,1).^2 + (dC.Rinse(:,R1)/2).^2 + (dC.Rinse(:,R2)/2).^2);
    
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
            C_RC.QC(:,iQ) = C.QC(:,iQ) - mean([C.Rinse(:,R1),C.Rinse(:,R2)],2);
            % propagate errors
            dC_RC.QC(:,iQ) = sqrt((dC.QC(:,iQ)).^2 + (dC.Rinse(:,R1)/2).^2 + (dC.Rinse(:,R2)/2).^2);
        else
            % correct raw concentrations for mean rinse concentration (mean of R1 and R2)
            C_RC.QC(:,iQ) = C.QC(:,iQ) - C.Rinse(:,R2);
            % propagate errors
            dC_RC.QC(:,iQ) = sqrt(dC.QC(:,iQ).^2 + dC.Rinse(:,R2).^2);
        end
    end
end

%% 3) QC correction (QC)
C_QC = C_RC;
dC_QC = dC_RC;

if QCcheck == true
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

if SCcheck == true && ~isempty(Vloc)
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

if OCcheck == true
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

if BCcheck == true
    % Samples
    for iS = 1 : length(Sloc)
        C_BC.Sample(:,iS) = C_OC.Sample(:,iS) - C_OC.Blank;
        dC_BC.Sample(:,iS) = sqrt(dC_OC.Sample(:,iS).^2 + dC_OC.Blank.^2);
    end
end

%% 7) Dilution correction (DC)
C_DC = C_BC;
dC_DC = dC_BC;

if DCcheck == true
    f_DC = (d_ICP .* wtpar.m_4ml .* (wtpar.m_10ml + wtpar.m_ThSC + wtpar.m_USC)) ./ (wtpar.m_sed .* wtpar.m_400ul);
    C_DC.Sample = f_DC .* C_BC.Sample;
    
    df_DC = abs(f_DC) .* sqrt((wtpar.dm./wtpar.m_4ml).^2 + (sqrt(3*wtpar.dm^2)./(wtpar.m_10ml + wtpar.m_ThSC + wtpar.m_USC)).^2 + (wtpar.dm./wtpar.m_sed.^3).^2 + (wtpar.dm./wtpar.m_400ul.^3).^2);
    dC_DC.Sample = abs(C_DC.Sample) .* sqrt((df_DC./f_DC).^2 + (dC_BC.Sample./C_BC.Sample).^2);
end

%% Isotopic dilution
% Parameters
ThMassRatio = 232.0380553/230.0331338;  % Th232:Th233 mass ratio
UMassRatio = 238.0565/236.04987;        % U238:U236 mass ratio
ThRY = 99.85/0.15;          % isotope amount ratio of 236U spike (236:238)
ThRX = 0;                   % isotope amount ratio of sample (236:238)
ThCY = 49156.8784392196;    % concentration of U236 in spike (pg/g, ppt)
URY = 99.973334/0.022544;   % isotope amount ratio of 230Th spike (230:232)
URX = 0;                    % isotope amount ratio of sample (230:232)
UCY = 59228.1919551491;     % concentration of Th230 in spike (pg/g, ppt)

% Mass of spiked isotopes Th230 & U236 in sample, calculated from added spike weights (pg)
Th230InSample = ThCY .* wtpar.m_ThSC/1000;
U236InSample = UCY .* wtpar.m_USC/1000 + UCY .* wtpar.m_UBC/1000 .* wtpar.m_400ul./wtpar.m_4ml;

% Raw count ratios Th232:Th230 & U238:U236
ThRatioInSample = cps.Sample(2,:) ./ cps.Sample(1,:);
URatioInSample = cps.Sample(4,:) ./ cps.Sample(3,:);

% Mass of Th232 and U238 in sample, derived from raw count ratio and the amount of spiked isotope (pg)
Th232InSample = ThRatioInSample .* Th230InSample .* ThMassRatio;
U238InSample = URatioInSample .* U236InSample .* UMassRatio;

% Mass of Th232 and U238 in sediment (pg)
Th232InSediment = Th232InSample .* (wtpar.m_4ml./wtpar.m_400ul);
U238InSediment = U238InSample .* (wtpar.m_4ml./wtpar.m_400ul);

% Concentration of Th232 and U238 in sediment (ppm)
C_DC.Sample(end+1,:) = (Th232InSediment ./ (wtpar.m_sed*1000)) .* ((ThRY - 1./ThRatioInSample) ./ (1 + ThRY));
C_DC.Sample(end+1,:) = (U238InSediment ./ (wtpar.m_sed*1000)) .* ((URY - 1./URatioInSample) ./ (1 + URY));
Isotopes{end+1} = 'Th232(ID)';
Isotopes{end+1} = 'U238(ID)';