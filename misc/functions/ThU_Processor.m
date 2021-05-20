function OUT = ThU_Processor(SType,ThUpar,SpikePar,WtPar,compute)

if ThUpar.ThURawPath(end) ~= filesep
    ThUpar.ThURawPath(end+1) = filesep;
end
FileList = dir([ThUpar.ThURawPath,'*.txt']);
for iF = 1 : numel(FileList)
    hiddenF(iF) = contains(FileList(iF).name,'._');
end
FileList(hiddenF) = [];

NameList.tot = {FileList.name}';

if ~isempty(ThUpar.pBID)
    NameList.procblank = NameList.tot(contains(NameList.tot,ThUpar.pBID));
    NameList.samples = NameList.tot(contains(NameList.tot,ThUpar.SID) & ~contains(NameList.tot,ThUpar.pBID));
else
    NameList.samples = NameList.tot(contains(NameList.tot,ThUpar.SID));
    NameList.procblank = NaN;
end
NameList.ICPblanks = NameList.tot(contains(NameList.tot,ThUpar.BID));
NameList.ICPnatU = NameList.tot(contains(NameList.tot,ThUpar.NatUID));

if length(ThUpar.NSamples) > 1 && length(ThUpar.NSamples) ~= ThUpar.NBlocks
    warndlg('Number of samples per block needs to be a single value or one value per block.','Incorrect input')
    OUT = NaN;
elseif isempty(NameList.samples)
    warndlg('Sample-ID character sequence not found.','Incorrect input')
    OUT = NaN;
elseif isempty(NameList.procblank)
    warndlg('Procedural blank-ID character sequence not found.','Incorrect input')
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
            if iB == 1
                if iscell(NameList.procblank)
                    SampleSeq(1:ThUpar.NSamples,iB) = [NameList.procblank;NameList.samples(1:ThUpar.NSamples-1)];
                else
                    SampleSeq(1:ThUpar.NSamples,iB) = NameList.samples(1:ThUpar.NSamples);
                end
            else
                if iscell(NameList.procblank)
                    SampleSeq(1:ThUpar.NSamples,iB) = NameList.samples(ThUpar.NSamples*(iB-1):ThUpar.NSamples*(iB-1)+ThUpar.NSamples-1);
                else
                    SampleSeq(1:ThUpar.NSamples,iB) = NameList.samples(ThUpar.NSamples*(iB-1)+1:ThUpar.NSamples*(iB-1)+ThUpar.NSamples);
                end
            end
        end
    elseif length(ThUpar.NSamples) > 1
        SampleSeq = cell(max(ThUpar.NSamples),ThUpar.NBlocks);
        for iB = 1 : ThUpar.NBlocks
            if iB == 1
                if iscell(NameList.procblank)
                    SampleSeq(1:ThUpar.NSamples(1),iB) = [NameList.procblank;NameList.samples(1:ThUpar.NSamples(1)-1)];
                else
                    SampleSeq(1:ThUpar.NSamples(1),iB) = NameList.samples(1:ThUpar.NSamples(1));
                end
            else
                if iscell(NameList.procblank)
                    SampleSeq(1:ThUpar.NSamples(iB),iB) = NameList.samples(sum(ThUpar.NSamples(1:iB-1)):sum(ThUpar.NSamples(1:iB-1))+ThUpar.NSamples(iB)-1);
                else
                    SampleSeq(1:ThUpar.NSamples(iB),iB) = NameList.samples(sum(ThUpar.NSamples(1:iB-1))+1:sum(ThUpar.NSamples(1:iB-1))+ThUpar.NSamples(iB));
                end
            end
        end
    end
    
%     if length(ThUpar.NSamples) == 1 && ThUpar.NSamples*ThUpar.NBlocks ~= numel(NameList.samples)+1
%         warning(['The number of samples in the raw data folder (',num2str(numel(NameList.samples)),...
%             ') does not match the number of samples to be processed (',num2str(sum(ThUpar.NSamples)),...
%             '). Please make sure that the "Number of samples per block" has been specified correctly: ',...
%             'If your analysis blocks contain a variable number of samples, a number has to be specified PER analysis block. ',...
%             '(Example: 8 blocks, 7 of which contain 3 samples and the last block contains 4. Number of samples per block: ',...
%             '3,3,3,3,3,3,3,4).'])
%         error('The processing has been terminated (see warning above).')
%     elseif length(ThUpar.NSamples) > 1 && sum(ThUpar.NSamples) ~= numel(NameList.samples)+1
%         warning(['The number of samples in the raw data folder (',num2str(numel(NameList.samples)),...
%             ') does not match the number of samples to be processed (',num2str(sum(ThUpar.NSamples)),...
%             '). Please make sure that the "Number of samples per block" has been specified correctly: ',...
%             'If your analysis blocks contain a variable number of samples, a number has to be specified PER analysis block. ',...
%             '(Example: 8 blocks, 7 of which contain 3 samples and the last block contains 4. Number of samples per block: ',...
%             '3,3,3,3,3,3,3,4).'])
%         error('The processing has been terminated (see warning above).')
%     end
    
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
        % Get list of isotopes analysed
        nSubMasses = 5; % number of submasses analysed per Isotope
        Isotopes = importdata([ThUpar.ThURawPath,SampleSeq{1,1}],Del,12);
        Isotopes = Isotopes.data(:,1);
        assert(rem(numel(Isotopes)/nSubMasses,1) == 0,'It appears that the number of submasses measured per isotope is not five. Contact support immediately!') % 
        IsotopeList = NaN(numel(Isotopes)/nSubMasses,1);
        for iI = 1 : numel(Isotopes)/nSubMasses
            IsotopeList(iI,1) = round(mean(Isotopes(iI+((nSubMasses-1)*(iI-1)):iI+((nSubMasses-1)*iI))),1);
        end
        % find row indices of Th229.5 and Th230.5 counts (for tailing correction)
        i229_5 = find(IsotopeList==229.5)+((nSubMasses-1)*(find(IsotopeList==229.5)-1)):find(IsotopeList==229.5)+((nSubMasses-1)*find(IsotopeList==229.5));
        i230_0 = find(IsotopeList==230.0)+((nSubMasses-1)*(find(IsotopeList==230.0)-1)):find(IsotopeList==230.0)+((nSubMasses-1)*find(IsotopeList==230.0));
        i230_5 = find(IsotopeList==230.5)+((nSubMasses-1)*(find(IsotopeList==230.5)-1)):find(IsotopeList==230.5)+((nSubMasses-1)*find(IsotopeList==230.5));
        
        %%% Sample blank correction
        Ratios.Sample.cpsTB = NaN(numel(Isotopes),nRuns,max(ThUpar.NSamples),ThUpar.NBlocks);
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
                if SType == 1
                    % Tailing Correction
                    Mlm = zeros(size(I_SampleA));
                    Mlm(i230_0,:) = (I_SampleA(i229_5,:)-I_SampleA(i230_5,:))./...
                        (log(I_SampleA(i229_5,:))-log(I_SampleA(i230_5,:)));
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
                if SType == 1
                    % Tailing Correction
                    Mlm = zeros(size(I_SampleB));
                    Mlm(i230_0,:) = (I_SampleB(i229_5,:)-I_SampleB(i230_5,:))./...
                        (log(I_SampleB(i229_5,:))-log(I_SampleB(i230_5,:)));
                    Mlm(isnan(Mlm)) = I_SampleB(find(isnan(Mlm))+5);
                    I_SampleB = I_SampleB - Mlm;
                end
                % Blank Correction
                Ratios.Sample.cpsTB(:,:,iBx,iB) = I_SampleB - I_SBlankB;
            end
        end
        
        %%% NatU blank correction
        Ratios.NatU.cpsB = NaN(numel(Isotopes) ,nRuns,ThUpar.NBlocks+2);
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
        
        Ratios.Sample.cpsMean = NaN(numel(Isotopes)/nSubMasses,max(ThUpar.NSamples),ThUpar.NBlocks);
        Ratios.NatU.cpsMean = NaN(numel(Isotopes)/nSubMasses,ThUpar.NBlocks+2);
        dRatios.Sample.cpsMean = NaN(numel(Isotopes)/nSubMasses,max(ThUpar.NSamples),ThUpar.NBlocks);
        dRatios.NatU.cpsMean = NaN(numel(Isotopes)/nSubMasses,ThUpar.NBlocks+2);
        for iI = 1 : numel(Isotopes)/nSubMasses
            %%% Mean sample and NatU CRM intensity (averaged over submasses and analysis runs)
            Ratios.Sample.cpsMean(iI,:,:) = permute(mean(Ratios.Sample.cpsTB(iI+((nSubMasses-1)*(iI-1)):iI+((nSubMasses-1)*iI),:,:,:),[1,2]),[1,3,4,2]);
            Ratios.NatU.cpsMean(iI,:) = permute(mean(Ratios.NatU.cpsB(iI+((nSubMasses-1)*(iI-1)):iI+((nSubMasses-1)*iI),:,:,:),[1,2]),[3,1,2]);
            %%% Standard deviation of mean sample and NatU CRM intensties (STD of submass averages)
            dRatios.Sample.cpsMean(iI,:,:) = permute(std(mean(Ratios.Sample.cpsTB(iI+((nSubMasses-1)*(iI-1)):iI+((nSubMasses-1)*iI),:,:,:),1),0,2),[1,3,4,2]);
            dRatios.NatU.cpsMean(iI,:) = permute(std(mean(Ratios.NatU.cpsB(iI+((nSubMasses-1)*(iI-1)):iI+((nSubMasses-1)*iI),:,:,:),1),0,2),[3,1,2]);
        end
        Ratios.Sample.cpsMean(Ratios.Sample.cpsMean < 0) = 0;
        Ratios.NatU.cpsMean(Ratios.NatU.cpsMean < 0) = 0;
        dRatios.Sample.cpsMean(dRatios.Sample.cpsMean < 0) = 0;
        dRatios.NatU.cpsMean(dRatios.NatU.cpsMean < 0) = 0;
        
%             %%% Mean sample and NatU CRM intensity (averaged over submasses and
%             %%% analysis runs)
%             Ratios.Sample.cpsMean = [mean(mean(Ratios.Sample.cpsTB(1:5,:,:,:)));...
%                 mean(mean(Ratios.Sample.cpsTB(6:10,:,:,:)));...
%                 mean(mean(Ratios.Sample.cpsTB(11:15,:,:,:)));...
%                 mean(mean(Ratios.Sample.cpsTB(16:20,:,:,:)));...
%                 mean(mean(Ratios.Sample.cpsTB(21:25,:,:,:)));...
%                 mean(mean(Ratios.Sample.cpsTB(26:30,:,:,:)));...
%                 mean(mean(Ratios.Sample.cpsTB(31:35,:,:,:)))];
%             Ratios.Sample.cpsMean(Ratios.Sample.cpsMean < 0) = 0;
%             Ratios.Sample.cpsMean = permute(Ratios.Sample.cpsMean,[1,3,4,2]);
%             
%             Ratios.NatU.cpsMean = [mean(mean(Ratios.NatU.cpsB(1:5,:,:)));...
%                 mean(mean(Ratios.NatU.cpsB(6:10,:,:)));...
%                 mean(mean(Ratios.NatU.cpsB(11:15,:,:)));...
%                 mean(mean(Ratios.NatU.cpsB(16:20,:,:)));...
%                 mean(mean(Ratios.NatU.cpsB(21:25,:,:)));...
%                 mean(mean(Ratios.NatU.cpsB(26:30,:,:)));...
%                 mean(mean(Ratios.NatU.cpsB(31:35,:,:)))];
%             Ratios.NatU.cpsMean(Ratios.NatU.cpsMean < 0) = 0;
%             Ratios.NatU.cpsMean = permute(Ratios.NatU.cpsMean,[1,3,2]);
%             
%             %%% Standard deviation of mean sample and NatU CRM intensties (STD of
%             %%% submass averages)
%             dRatios.Sample.cpsMean = [std(mean(Ratios.Sample.cpsTB(1:5,:,:,:)));...
%                 std(mean(Ratios.Sample.cpsTB(6:10,:,:,:)));...
%                 std(mean(Ratios.Sample.cpsTB(11:15,:,:,:)));...
%                 std(mean(Ratios.Sample.cpsTB(16:20,:,:,:)));...
%                 std(mean(Ratios.Sample.cpsTB(21:25,:,:,:)));...
%                 std(mean(Ratios.Sample.cpsTB(26:30,:,:,:)));...
%                 std(mean(Ratios.Sample.cpsTB(31:35,:,:,:)))];
%             dRatios.Sample.cpsMean(dRatios.Sample.cpsMean < 0) = 0;
%             dRatios.Sample.cpsMean = permute(dRatios.Sample.cpsMean,[1,3,4,2]);
%             
%             dRatios.NatU.cpsMean = [std(mean(Ratios.NatU.cpsB(1:5,:,:)));...
%                 std(mean(Ratios.NatU.cpsB(6:10,:,:)));...
%                 std(mean(Ratios.NatU.cpsB(11:15,:,:)));...
%                 std(mean(Ratios.NatU.cpsB(16:20,:,:)));...
%                 std(mean(Ratios.NatU.cpsB(21:25,:,:)));...
%                 std(mean(Ratios.NatU.cpsB(26:30,:,:)));...
%                 std(mean(Ratios.NatU.cpsB(31:35,:,:)))];
%             dRatios.NatU.cpsMean(dRatios.NatU.cpsMean < 0) = 0;
%             dRatios.NatU.cpsMean = permute(dRatios.NatU.cpsMean,[1,3,2]);
        
        %% STEP 3: RATIOS (+STD)
        i229_0 = find(IsotopeList==229.0);
        i230_0 = find(IsotopeList==230.0);
        i234_0 = find(IsotopeList==234.0);
        i235_0 = find(IsotopeList==235.0);
        i236_0 = find(IsotopeList==236.0);
        
        Ratios.Sample.R229_230 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        Ratios.Sample.R236_234 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        Ratios.NatU.R235_234 = NaN(ThUpar.NBlocks,1);
        dRatios.Sample.R229_230 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        dRatios.Sample.R236_234 = NaN(max(ThUpar.NSamples),ThUpar.NBlocks);
        dRatios.NatU.R235_234 = NaN(ThUpar.NBlocks,1);
        for iB = 1 : ThUpar.NBlocks
            if length(ThUpar.NSamples) == 1
                s = 1 : ThUpar.NSamples;
            else
                s = 1 : ThUpar.NSamples(iB);
            end
            
            for iB1 = s
                Ratios.Sample.R229_230(iB1,iB) = Ratios.Sample.cpsMean(i229_0,iB1,iB)./Ratios.Sample.cpsMean(i230_0,iB1,iB);
                Ratios.Sample.R236_234(iB1,iB) = Ratios.Sample.cpsMean(i236_0,iB1,iB)./Ratios.Sample.cpsMean(i234_0,iB1,iB);
                dRatios.Sample.R229_230(iB1,iB) = Ratios.Sample.R229_230(iB1,iB)*sqrt(...
                    (dRatios.Sample.cpsMean(i229_0,iB1,iB)/Ratios.Sample.cpsMean(i229_0,iB1,iB)).^2+...
                    (dRatios.Sample.cpsMean(i230_0,iB1,iB)/Ratios.Sample.cpsMean(i230_0,iB1,iB)).^2);
                dRatios.Sample.R236_234(iB1,iB) = Ratios.Sample.R236_234(iB1,iB)*sqrt(...
                    (dRatios.Sample.cpsMean(i236_0,iB1,iB)/Ratios.Sample.cpsMean(i236_0,iB1,iB))^2+...
                    (dRatios.Sample.cpsMean(i234_0,iB1,iB)/Ratios.Sample.cpsMean(i234_0,iB1,iB))^2);
            end
        end
        
        for iB = 1 : ThUpar.NBlocks+2
            Ratios.NatU.R235_234(iB,1) = Ratios.NatU.cpsMean(i235_0,iB)./Ratios.NatU.cpsMean(i234_0,iB);
            dRatios.NatU.R235_234(iB,1) = Ratios.NatU.R235_234(iB,1)*sqrt(...
                (dRatios.NatU.cpsMean(i235_0,iB)/Ratios.NatU.cpsMean(i235_0,iB))^2+...
                (dRatios.NatU.cpsMean(i234_0,iB)/Ratios.NatU.cpsMean(i234_0,iB))^2);
        end
        
        %% STEP 4: MASS BIAS CORRECTION
        
        CRM145 = 137.285066;
        % Isotope masses
        m229 = 229.031754;
        m230 = 230.033126;
        m234 = 234.0409468;
        m235 = 235.044;
        m236 = 236.045568;
        
        R235_234_mean = mean(Ratios.NatU.R235_234);
        dR235_234_mean = sqrt(sum((dRatios.NatU.R235_234./Ratios.NatU.R235_234).^2))/ThUpar.NBlocks+2;
        f = (log(CRM145/R235_234_mean))/log(m235/m234);
        df = abs((dR235_234_mean./R235_234_mean)/(log(m235/m234)));
        
        Ratios.Sample.R229_230_cMB = Ratios.Sample.R229_230*(m229/m230)^f;
        dRatios.Sample.R229_230_cMB = abs(Ratios.Sample.R229_230_cMB.*sqrt(((dRatios.Sample.R229_230)./(Ratios.Sample.R229_230)).^2+(log(m229/m230).*df).^2));
        
        Ratios.Sample.R236_234_cMB = Ratios.Sample.R236_234*(m236/m234)^f;
        dRatios.Sample.R236_234_cMB = abs(Ratios.Sample.R236_234_cMB.*sqrt(((dRatios.Sample.R236_234)./(Ratios.Sample.R236_234)).^2+(log(m236/m234).*df).^2));
        
        Ratios.NatU.R235_234_cMB = Ratios.NatU.R235_234*(m235/m234)^f;
        dRatios.NatU.R235_234_cMB = abs(Ratios.NatU.R235_234_cMB.*sqrt(((dRatios.NatU.R235_234)./(Ratios.NatU.R235_234)).^2+(log(m235/m234).*df).^2));
              
        %% STEP 5: BLANK CORRECTION & ISOTOPIC DILUTION
        dscale = 0.0001;
        
        % Thorium
        M229 = 229.031754;
        M230 = 230.033126;
        if ~isinf(SpikePar.Th229RY)
            % Isotopic dilution (without blank correction)
            ID.Th230 = (M230./M229) .* SpikePar.Th229CY .* (WtPar.m_ThBC./WtPar.m_sed)' .* (SpikePar.Th229RY - Ratios.Sample.R229_230(~isnan(Ratios.Sample.R229_230)))./(Ratios.Sample.R229_230(~isnan(Ratios.Sample.R229_230)) .* (SpikePar.Th229RY + 1));
            ID.Th230(ID.Th230 <= 0 | isnan(ID.Th230)) = 0;
            dID.Th230 = ID.Th230 .* sqrt((dscale./WtPar.m_ThBC').^2 + (dscale./WtPar.m_sed').^2 + (dRatios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))).^2*2);
            dID.Th230(dID.Th230 <= 0 | isnan(dID.Th230)) = 0;
            
            % Moles Th230 in sediment/blank
            Th230_n = (M230./M229)./M230 .* SpikePar.Th229CY .* (WtPar.m_ThBC)' .* (SpikePar.Th229RY - Ratios.Sample.R229_230(~isnan(Ratios.Sample.R229_230)))./(Ratios.Sample.R229_230(~isnan(Ratios.Sample.R229_230)) .* (SpikePar.Th229RY + 1)) * 10^-12;
            Th230_n(Th230_n <= 0 | isnan(Th230_n)) = 0;
            dTh230_n = Th230_n .* sqrt((dscale./WtPar.m_ThBC').^2 + (dRatios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))).^2*2);
            dTh230_n(dTh230_n <= 0 | isnan(dTh230_n)) = 0;
        else
            % Isotopic dilution (without blank correction)
            ID.Th230 = (M230./M229) .* SpikePar.Th229CY .* (WtPar.m_ThBC./WtPar.m_sed)' .* 1./Ratios.Sample.R229_230(~isnan(Ratios.Sample.R229_230));
            ID.Th230(ID.Th230 <= 0 | isnan(ID.Th230)) = 0;
            dID.Th230 = ID.Th230 .* sqrt((dscale./WtPar.m_ThBC').^2 + (dscale./WtPar.m_sed').^2 + (dRatios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))).^2);
            dID.Th230(dID.Th230 <= 0 | isnan(dID.Th230)) = 0;
            
            % Moles Th230 in sediment/blank
            Th230_n = (M230./M229)./M230 .* SpikePar.Th229CY .* (WtPar.m_ThBC)' .* 1./Ratios.Sample.R229_230(~isnan(Ratios.Sample.R229_230)) * 10^-12;
            Th230_n(Th230_n < 0 | isnan(Th230_n)) = 0;
            dTh230_n = Th230_n .* sqrt((dscale./WtPar.m_ThBC').^2 + (dRatios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R229_230_cMB(~isnan(Ratios.Sample.R229_230))).^2);
            dTh230_n(dTh230_n < 0 | isnan(dTh230_n)) = 0;
        end
        if iscell(NameList.procblank)
            % Blank correction
            Th230_nBC = Th230_n - Th230_n(1);
            dTh230_nBC = sqrt(dTh230_n.^2 + dTh230_n(1)^2);
            % Isotopic dilution (with blank correction)
            ID.Th230BC = Th230_nBC .* M230 ./ WtPar.m_sed' * 1E12;
            ID.Th230BC(ID.Th230BC <= 0 | isnan(ID.Th230BC)) = 0;
            dID.Th230BC = ID.Th230BC .* sqrt((dTh230_nBC./Th230_nBC).^2 + (dscale./WtPar.m_sed)'.^2);
            dID.Th230BC(dID.Th230BC <= 0 | isnan(dID.Th230BC)) = 0;
        else
            ID.Th230BC = nan(size(WtPar.m_sed))';
            dID.Th230BC = nan(size(WtPar.m_sed))';
        end
        
        % Uranium
        M234 = 234.0409468;
        M236 = 236.045568;
        if ~isinf(SpikePar.U236RY)
            % Isotopic dilution (without blank correction)
            ID.U234 = (M234./M236) .* SpikePar.U236CY .* (WtPar.m_UBC./WtPar.m_sed)' .* (SpikePar.U236RY - Ratios.Sample.R236_234(~isnan(Ratios.Sample.R229_230)))./(Ratios.Sample.R236_234(~isnan(Ratios.Sample.R229_230)) .* (SpikePar.U236RY + 1));
            ID.U234(ID.U234 <= 0 | isnan(ID.U234)) = 0;
            dID.U234 = ID.U234 .* sqrt((dscale./WtPar.m_UBC').^2 + (dscale./WtPar.m_sed').^2 + (dRatios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))).^2*2);
            
            % Moles U234 in sediment/blank
            U234_n = (M234./M236)./M234 .* SpikePar.U236CY .* (WtPar.m_UBC)' .* (SpikePar.U236RY - Ratios.Sample.R236_234(~isnan(Ratios.Sample.R229_230)))./(Ratios.Sample.R236_234(~isnan(Ratios.Sample.R229_230)) .* (SpikePar.U236RY + 1)) * 10^-12;
            U234_n(U234_n<0 | isnan(U234_n)) = 0;
            dU234_n = U234_n .* sqrt((dscale./WtPar.m_UBC').^2 + (dRatios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))).^2*2);
        else
            % Isotopic dilution (without blank correction)
            ID.U234 = (M234./M236) .* SpikePar.U236CY .* (WtPar.m_UBC./WtPar.m_sed)' .* 1./Ratios.Sample.R236_234(~isnan(Ratios.Sample.R229_230));
            ID.U234(ID.U234 <= 0 | isnan(ID.U234)) = 0;
            dID.U234 = ID.U234 .* sqrt((dscale./WtPar.m_UBC').^2 + (dscale./WtPar.m_sed').^2 + (dRatios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))).^2);
            
            % Moles U234 in sediment/blank
            U234_n = (M234./M236)./M234 .* SpikePar.U236CY .* (WtPar.m_UBC)' .* 1./Ratios.Sample.R236_234(~isnan(Ratios.Sample.R229_230)) * 10^-12;
            U234_n(U234_n<0 | isnan(U234_n)) = 0;
            dU234_n = U234_n .* sqrt((dscale./WtPar.m_UBC').^2 + (dRatios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))./Ratios.Sample.R236_234_cMB(~isnan(Ratios.Sample.R229_230))).^2);
        end
        
        if iscell(NameList.procblank)
            % Blank correction (only if Blank ID has been provided)
            U234_nBC = U234_n - U234_n(1);
            dU234_nBC = sqrt(dU234_n.^2 + dU234_n(1)^2);
            % Isotopic dilution (with blank correction)
            ID.U234BC = U234_nBC .* M234 ./ WtPar.m_sed' * 1E12;
            ID.U234BC(ID.U234BC <= 0 | isnan(ID.U234BC)) = 0;
            dID.U234BC = ID.U234BC .* sqrt((dU234_nBC./U234_nBC).^2 + (dscale./WtPar.m_sed)'.^2);
            dID.U234BC(dID.U234BC <= 0 | isnan(dID.U234BC)) = 0;
        else
            ID.U234BC = nan(size(WtPar.m_sed))';
            dID.U234BC = nan(size(WtPar.m_sed))';
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