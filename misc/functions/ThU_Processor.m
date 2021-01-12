function OUT = ThU_Processor(ThUpar,SpikePar,WtPar,SMatch,compute)
if ThUpar.ThURawPath(end) ~= filesep
    ThUpar.ThURawPath(end+1) = filesep;
end
FileList = dir([ThUpar.ThURawPath,'*.txt']);
for iF = 1 : numel(FileList)
    hiddenF(iF) = contains(FileList(iF).name,'._');
end
FileList(hiddenF) = [];

NameList.tot = {FileList.name}';
NameList.samples = NameList.tot(contains(NameList.tot,ThUpar.SID));
NameList.ICPblanks = NameList.tot(contains(NameList.tot,ThUpar.BID));
NameList.ICPnatU = NameList.tot(contains(NameList.tot,ThUpar.NatUID));

if length(ThUpar.NSamples) > 1 && length(ThUpar.NSamples) ~= ThUpar.NBlocks
    warndlg('Number of samples per block needs to be a single value or one value per block (semicolon-separated).','Incorrect input')
    OUT = NaN;
elseif isempty(NameList.samples)
    warndlg('Sample-ID character sequence not found.','Incorrect input')
    OUT = NaN;
elseif isempty(NameList.ICPblanks)
    warndlg('Blank-ID character sequence not found.','Incorrect input')
    OUT = NaN;
elseif isempty(NameList.ICPnatU)
    warndlg('NatU-ID character sequence not found.','Incorrect input')
    OUT = NaN;
else
    
    % Determine delimiter of raw files
    Dels = {';','\t',',',' '};
    for iB = 1 : length(Dels)
        DelCheck{iB} = class(importdata([ThUpar.ThURawPath,NameList.samples{1}],Dels{iB},12));
    end
    Del = Dels(strcmp(DelCheck,'struct'));Del = Del{1};
    
    nRunCheck = importdata([ThUpar.ThURawPath,NameList.samples{1}],Del,12);
    nRuns = size(nRunCheck.data(1,2:end),2);
    %% CREATE SEQUENCE: Sample Sequence
    if length(ThUpar.NSamples) == 1
        SampleSeq = cell(ThUpar.NSamples,ThUpar.NBlocks);
        for iB = 1 : ThUpar.NBlocks
            SampleSeq(1:ThUpar.NSamples,iB) = NameList.samples(1+ThUpar.NSamples*(iB-1):1+ThUpar.NSamples*(iB-1)+ThUpar.NSamples-1);
        end
    elseif length(ThUpar.NSamples) > 1
        SampleSeq = cell(max(ThUpar.NSamples),ThUpar.NBlocks);
        for iB = 1 : ThUpar.NBlocks
            if iB == 1
                SampleSeq(1:ThUpar.NSamples(1),iB) = NameList.samples(1:ThUpar.NSamples(1));
            else
                SampleSeq(1:ThUpar.NSamples(iB),iB) = NameList.samples(sum(ThUpar.NSamples(1:iB-1))+1:sum(ThUpar.NSamples(1:iB-1))+ThUpar.NSamples(iB));
            end
        end
    end
    
    if length(ThUpar.NSamples) == 1 && ThUpar.NSamples*ThUpar.NBlocks ~= numel(NameList.samples)
        warning(['The number of samples in the raw data folder (',num2str(numel(NameList.samples)),...
            ') does not match the number of samples to be processed (',num2str(sum(ThUpar.NSamples)),...
            '). Please make sure that the "Number of samples per block" has been specified correctly: ',...
            'If your analysis blocks contain a variable number of samples, a number has to be specified PER analysis block. ',...
            '(Example: 8 blocks, 7 of which contain 3 samples and the last block contains 4. Number of samples per block: ',...
            '3,3,3,3,3,3,3,4).'])
        error('The processing has been terminated (see warning above).')
    elseif length(ThUpar.NSamples) > 1 && sum(ThUpar.NSamples) ~= numel(NameList.samples)
        warning(['The number of samples in the raw data folder (',num2str(numel(NameList.samples)),...
            ') does not match the number of samples to be processed (',num2str(sum(ThUpar.NSamples)),...
            '). Please make sure that the "Number of samples per block" has been specified correctly: ',...
            'If your analysis blocks contain a variable number of samples, a number has to be specified PER analysis block. ',...
            '(Example: 8 blocks, 7 of which contain 3 samples and the last block contains 4. Number of samples per block: ',...
            '3,3,3,3,3,3,3,4).'])
        error('The processing has been terminated (see warning above).')
    end
    
    % Sample Blanks
    SBlankSeq = cell(2,ThUpar.NBlocks);
    for iB = 1 : ThUpar.NBlocks
        SBlankSeq(1:2,iB) = NameList.ICPblanks([2+2*(iB-1),3+2*(iB-1)]);
    end
    
    %% CREATE SEQUENCE: NatU CRM Sequence
    NatUSeq = cell(1,ThUpar.NBlocks+2);
    NBlankSeq = cell(1,ThUpar.NBlocks+2);
    for iB = 1 : ThUpar.NBlocks+2
        NatUSeq(1,iB) = NameList.ICPnatU(iB);
        % NatU CRM Blanks
        if iB == 1 || iB == 2 || iB == 3
            NBlankSeq(1,iB) = NameList.ICPblanks(iB);
        else
            NBlankSeq(1,iB) = NameList.ICPblanks(2*(iB-1)-1);
        end
    end
    
    %% CREATE SEQUENCE: Complete Sequence
    Sequence{1,1} = NBlankSeq{1};
    Sequence{2,1} = NatUSeq{1};
    Sequence{3,1} = NatUSeq{2};
    for iB = 1 : ThUpar.NBlocks
        block{1,1} = SBlankSeq{1,iB};
        for iB1 = 1 : size(SampleSeq,1)
            if ~(isempty(SampleSeq{iB1,iB}))
                block{end+1,1} = SampleSeq{iB1,iB};
            end
        end
        block{end+1,1} = SBlankSeq{2,iB};
        block{end+1,1} = NatUSeq{iB+2};
        
        for iB2 = 1 : length(block)
            Sequence{end+1,1} = block{iB2};
        end
        clearvars block
    end
    for iB = 1 : length(Sequence)
        Sequence{iB} = Sequence{iB}(1:end-4);
    end
    if ~(exist([ThUpar.ThURawPath,'output',filesep],'dir'))
        mkdir([ThUpar.ThURawPath,'output'])
    end
    
    %% PROCESSING
    if compute == 1
        %% STEP 1: TAILING & BLANK CORRECTION
        
        %%% Sample blank correction
        Ratios.Sample.cpsTB = NaN(35,nRuns,max(ThUpar.NSamples),ThUpar.NBlocks);
        for iB = 1 : ThUpar.NBlocks
            % Blank A raw intensities (correcting first half of sample block)
            DirBlankA = [ThUpar.ThURawPath,SBlankSeq{1,iB}];
            I_SBlankA = importdata(DirBlankA,Del,12);
            I_SBlankA = I_SBlankA.data(:,2:end);
            % Blank B raw intensities (correcting second half of sample block)
            DirBlankB = strcat(ThUpar.ThURawPath,SBlankSeq{2,iB});
            I_SBlankB = importdata(DirBlankB,Del,12);
            I_SBlankB = I_SBlankB.data(:,2:end);
            
            if length(ThUpar.NSamples) == 1 && ~(rem(ThUpar.NSamples,2))
                %%% Even & constant number of samples per block
                iB1 = 1 : ThUpar.NSamples/2;
                iB2 = ThUpar.NSamples/2+1 : ThUpar.NSamples;
            elseif length(ThUpar.NSamples) == 1 && ~(~(rem(ThUpar.NSamples,2)))
                %%% Odd & constant number of samples per block
                iB1 = 1 : ceil(ThUpar.NSamples/2);
                iB2 = ceil(ThUpar.NSamples/2)+1 : ThUpar.NSamples;
            elseif length(ThUpar.NSamples) > 1 && ~(rem(ThUpar.NSamples(iB),2))
                %%% Variable number of samples per block (even number of samples)
                iB1 = 1 : ThUpar.NSamples(iB)/2;
                iB2 = ThUpar.NSamples(iB)/2+1 : ThUpar.NSamples(iB);
            elseif length(ThUpar.NSamples) > 1 && ~(~(rem(ThUpar.NSamples(iB),2)))
                %%% Variable number of samples per block (odd number of samples)
                iB1 = 1 : ceil(ThUpar.NSamples(iB)/2);
                iB2 = ceil(ThUpar.NSamples(iB)/2)+1 : ThUpar.NSamples(iB);
            end
            
            % First half of sample block
            for iBx = iB1
                DirSampleA = strcat(ThUpar.ThURawPath,SampleSeq{iBx,iB});
                I_SampleA = importdata(DirSampleA,Del,12);
                % Sample raw intensities
                I_SampleA = I_SampleA.data(:,2:end);
                nRuns = size(I_SampleA,2);
                if ThUpar.SType == 0
                    % Tailing Correction
                    Mlm = zeros(size(I_SampleA));
                    Mlm(11:15,:) = (I_SampleA(6:10,:)-I_SampleA(16:20,:))./...
                        (log(I_SampleA(6:10,:))-log(I_SampleA(16:20,:)));
                    Mlm(isnan(Mlm)) = I_SampleA(find(isnan(Mlm))+5);
                    I_SampleA = I_SampleA - Mlm;
                end
                % Blank Correction
                Ratios.Sample.cpsTB(:,:,iBx,iB) = I_SampleA - I_SBlankA;
            end
            
            % Second half of sample block
            for iBx = iB2
                DirSampleB = strcat(ThUpar.ThURawPath,SampleSeq{iBx,iB});
                I_SampleB = importdata(DirSampleB,Del,12);
                % Sample raw intensities
                I_SampleB = I_SampleB.data(:,2:end);
                if ThUpar.SType == 0
                    % Tailing Correction
                    Mlm = zeros(size(I_SampleB));
                    Mlm(11:15,:) = (I_SampleB(6:10,:)-I_SampleB(16:20,:))./...
                        (log(I_SampleB(6:10,:))-log(I_SampleB(16:20,:)));
                    Mlm(isnan(Mlm)) = I_SampleB(find(isnan(Mlm))+5);
                    I_SampleB = I_SampleB - Mlm;
                end
                % Blank Correction
                Ratios.Sample.cpsTB(:,:,iBx,iB) = I_SampleB - I_SBlankB;
            end
        end
        
        %%% NatU blank correction
        Ratios.NatU.cpsB = NaN(35,nRuns,ThUpar.NBlocks+2);
        for iB = 1 : ThUpar.NBlocks+2
            % NatU Blank raw intensities
            DirNBlank = strcat(ThUpar.ThURawPath,NBlankSeq{iB});
            I_NBlank = importdata(DirNBlank,Del,12);
            I_NBlank = I_NBlank.data(:,2:end);
            
            % NatU raw intensities
            DirNatU = strcat(ThUpar.ThURawPath,NatUSeq{iB});
            I_NatU = importdata(DirNatU,Del,12);
            I_NatU = I_NatU.data(:,2:end);
            
            % Blank Correction
            Ratios.NatU.cpsB(:,:,iB) = I_NatU - I_NBlank;
        end
        
        %% STEP 2: INTENSITY AVERAGES (+STD)
        
        %%% Mean sample and NatU CRM intensity (averaged over submasses and
        %%% analysis runs)
        Ratios.Sample.cpsMean = [mean(mean(Ratios.Sample.cpsTB(1:5,:,:,:)));...
            mean(mean(Ratios.Sample.cpsTB(6:10,:,:,:)));...
            mean(mean(Ratios.Sample.cpsTB(11:15,:,:,:)));...
            mean(mean(Ratios.Sample.cpsTB(16:20,:,:,:)));...
            mean(mean(Ratios.Sample.cpsTB(21:25,:,:,:)));...
            mean(mean(Ratios.Sample.cpsTB(26:30,:,:,:)));...
            mean(mean(Ratios.Sample.cpsTB(31:35,:,:,:)))];
        Ratios.Sample.cpsMean(Ratios.Sample.cpsMean < 0) = 0;
        
        Ratios.NatU.cpsMean = [mean(mean(Ratios.NatU.cpsB(1:5,:,:)));...
            mean(mean(Ratios.NatU.cpsB(6:10,:,:)));...
            mean(mean(Ratios.NatU.cpsB(11:15,:,:)));...
            mean(mean(Ratios.NatU.cpsB(16:20,:,:)));...
            mean(mean(Ratios.NatU.cpsB(21:25,:,:)));...
            mean(mean(Ratios.NatU.cpsB(26:30,:,:)));...
            mean(mean(Ratios.NatU.cpsB(31:35,:,:)))];
        Ratios.NatU.cpsMean(Ratios.NatU.cpsMean < 0) = 0;
        
        %%% Standard deviation of mean sample and NatU CRM intensties (STD of
        %%% submass averages)
        dRatios.Sample.cpsMean = [std(mean(Ratios.Sample.cpsTB(1:5,:,:,:)));...
            std(mean(Ratios.Sample.cpsTB(6:10,:,:,:)));...
            std(mean(Ratios.Sample.cpsTB(11:15,:,:,:)));...
            std(mean(Ratios.Sample.cpsTB(16:20,:,:,:)));...
            std(mean(Ratios.Sample.cpsTB(21:25,:,:,:)));...
            std(mean(Ratios.Sample.cpsTB(26:30,:,:,:)));...
            std(mean(Ratios.Sample.cpsTB(31:35,:,:,:)))];
        dRatios.Sample.cpsMean(dRatios.Sample.cpsMean < 0) = 0;
        
        dRatios.NatU.cpsMean = [std(mean(Ratios.NatU.cpsB(1:5,:,:)));...
            std(mean(Ratios.NatU.cpsB(6:10,:,:)));...
            std(mean(Ratios.NatU.cpsB(11:15,:,:)));...
            std(mean(Ratios.NatU.cpsB(16:20,:,:)));...
            std(mean(Ratios.NatU.cpsB(21:25,:,:)));...
            std(mean(Ratios.NatU.cpsB(26:30,:,:)));...
            std(mean(Ratios.NatU.cpsB(31:35,:,:)))];
        dRatios.NatU.cpsMean(dRatios.NatU.cpsMean < 0) = 0;
        
        %% STEP 3: RATIOS (+STD)
        Ratios.Sample.R229_230 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        Ratios.Sample.R236_234 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        Ratios.NatU.R235_234 = NaN(ThUpar.NBlocks,1);
        dRatios.Sample.R229_230 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        dRatios.Sample.R236_234 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        dRatios.NatU.R235_234 = NaN(ThUpar.NBlocks,1);
        for iB = 1 : ThUpar.NBlocks
            if length(ThUpar.NSamples) == 1
                iB1 = 1 : ThUpar.NSamples;
            else
                iB1 = 1 : ThUpar.NSamples(iB);
            end
            
            for iB1 = iB1
                Ratios.Sample.R229_230(iB1,iB) = Ratios.Sample.cpsMean(1,:,iB1,iB)./Ratios.Sample.cpsMean(3,:,iB1,iB);
                Ratios.Sample.R236_234(iB1,iB) = Ratios.Sample.cpsMean(7,:,iB1,iB)./Ratios.Sample.cpsMean(5,:,iB1,iB);
                dRatios.Sample.R229_230(iB1,iB) = Ratios.Sample.R229_230(iB1,iB)*sqrt(...
                    (dRatios.Sample.cpsMean(1,:,iB1,iB)/Ratios.Sample.cpsMean(1,:,iB1,iB))^2+...
                    (dRatios.Sample.cpsMean(3,:,iB1,iB)/Ratios.Sample.cpsMean(3,:,iB1,iB))^2);
                dRatios.Sample.R236_234(iB1,iB) = Ratios.Sample.R236_234(iB1,iB)*sqrt(...
                    (dRatios.Sample.cpsMean(7,:,iB1,iB)/Ratios.Sample.cpsMean(7,:,iB1,iB))^2+...
                    (dRatios.Sample.cpsMean(5,:,iB1,iB)/Ratios.Sample.cpsMean(5,:,iB1,iB))^2);
            end
        end
        
        for iB = 1 : ThUpar.NBlocks+2
            Ratios.NatU.R235_234(iB,1) = Ratios.NatU.cpsMean(6,:,iB)./Ratios.NatU.cpsMean(5,:,iB);
            dRatios.NatU.R235_234(iB,1) = Ratios.NatU.R235_234(iB,1)*sqrt(...
                (dRatios.NatU.cpsMean(6,:,iB)/Ratios.NatU.cpsMean(6,:,iB))^2+...
                (dRatios.NatU.cpsMean(5,:,iB)/Ratios.NatU.cpsMean(5,:,iB))^2);
        end
        
        %% STEP 4: MASS BIAS CORRECTION
        
        CRM145 = 137.285066;
        R235_234_mean = mean(Ratios.NatU.R235_234);
        dR235_234_mean = sqrt(sum((dRatios.NatU.R235_234./Ratios.NatU.R235_234).^2))/ThUpar.NBlocks+2;
        f = (log(CRM145/R235_234_mean))/log(235.044/234.0409468);
        df = abs((dR235_234_mean./R235_234_mean)/(log(235.044/234.0409468)));
        
        Ratios.Sample.R229_230_cMB = Ratios.Sample.R229_230*(229.031754/230.033126)^f;
        dRatios.Sample.R229_230_cMB = abs(Ratios.Sample.R229_230_cMB.*sqrt(((dRatios.Sample.R229_230)./(Ratios.Sample.R229_230)).^2+(log(229.031754/230.033126).*df).^2));
        
        Ratios.Sample.R236_234_cMB = Ratios.Sample.R236_234*(236.045568/234.0409468)^f;
        dRatios.Sample.R236_234_cMB = abs(Ratios.Sample.R236_234_cMB.*sqrt(((dRatios.Sample.R236_234)./(Ratios.Sample.R236_234)).^2+(log(236.045568/234.0409468).*df).^2));
        
        Ratios.NatU.R235_234_cMB = Ratios.NatU.R235_234*(235.044/234.0409468)^f;
        dRatios.NatU.R235_234_cMB = abs(Ratios.NatU.R235_234_cMB.*sqrt(((dRatios.NatU.R235_234)./(Ratios.NatU.R235_234)).^2+(log(235.044/234.0409468).*df).^2));
        
        %% STEP 5: ISOTOPIC DILUTION
        dscale = 0.0001;
        ThMassRatio = 230.033126/229.031754;
        if ~isinf(SpikePar.Th229RY)
            ID.Th230 = ThMassRatio .* SpikePar.Th229CY .* (WtPar.m_ThBC(SMatch.TEind)./WtPar.m_sed(SMatch.TEind)) .* ...
                (SpikePar.Th229RY - Ratios.Sample.R229_230(SMatch.ThUind))./(Ratios.Sample.R229_230(SMatch.ThUind) .* (SpikePar.Th229RY + 1));
            dID.Th230 = ID.Th230 .* sqrt((dscale./WtPar.m_ThBC(SMatch.TEind)).^2 + (dscale./WtPar.m_sed(SMatch.TEind)).^2 + (dRatios.Sample.R229_230_cMB(SMatch.ThUind)./Ratios.Sample.R229_230_cMB(SMatch.ThUind)).^2*2);
        else
            ID.Th230 = ThMassRatio .* SpikePar.Th229CY .* (WtPar.m_ThBC(SMatch.TEind)./WtPar.m_sed(SMatch.TEind)) .* 1./Ratios.Sample.R229_230(SMatch.ThUind);
            dID.Th230 = ID.Th230 .* sqrt((dscale./WtPar.m_ThBC(SMatch.TEind)).^2 + (dscale./WtPar.m_sed(SMatch.TEind)).^2 + (dRatios.Sample.R229_230_cMB(SMatch.ThUind)./Ratios.Sample.R229_230_cMB(SMatch.ThUind)).^2);
        end
        
        UMassRatio = 234.0409468/236.045568;
        if ~isinf(SpikePar.Th229RY)
            ID.U234 = UMassRatio .* SpikePar.U236CY .* (WtPar.m_UBC(SMatch.TEind)./WtPar.m_sed(SMatch.TEind)) .* ...
                (SpikePar.U236RYb - Ratios.Sample.R236_234(SMatch.ThUind))./(Ratios.Sample.R236_234(SMatch.ThUind) .* (SpikePar.U236RYb + 1));
            dID.U234 = ID.U234 .* sqrt((dscale./WtPar.m_UBC(SMatch.TEind)).^2 + (dscale./WtPar.m_sed(SMatch.TEind)).^2 + (dRatios.Sample.R236_234_cMB(SMatch.ThUind)./Ratios.Sample.R236_234_cMB(SMatch.ThUind)).^2*2);
        else
            ID.U234 = UMassRatio .* SpikePar.U236CY .* (WtPar.m_UBC(SMatch.TEind)./WtPar.m_sed(SMatch.TEind)) .* 1./Ratios.Sample.R236_234(SMatch.ThUind);
            dID.U234 = ID.U234 .* sqrt((dscale./WtPar.m_UBC(SMatch.TEind)).^2 + (dscale./WtPar.m_sed(SMatch.TEind)).^2 + (dRatios.Sample.R236_234_cMB(SMatch.ThUind)./Ratios.Sample.R236_234_cMB(SMatch.ThUind)).^2);
        end
        
    else
        Ratios = NaN;
        dRatios = NaN;
        ID = NaN;
        dID = NaN;
    end

    %% Output variable
    OUT.Ratios = Ratios;
    OUT.dRatios = dRatios;
    OUT.ID = ID;
    OUT.dID = dID;
    OUT.SampleSeq = SampleSeq;
    for iL = 1 : numel(OUT.SampleSeq)
        OUT.SampleSeq{iL} = OUT.SampleSeq{iL}(1:strfind(OUT.SampleSeq{iL},'.')-1);
    end
    OUT.NatUSeq = NatUSeq;
    OUT.Sequence = Sequence;
    
end
end