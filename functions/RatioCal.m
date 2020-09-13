function RatioCal(par)

FileList = dir([par.RawDataDir,'*.txt']);
NameList.tot = {FileList.name}';
NameList.samples = NameList.tot(contains(NameList.tot,par.sampleIDstr));
NameList.ICPblanks = NameList.tot(contains(NameList.tot,par.blankIDstr));
NameList.ICPnatU = NameList.tot(contains(NameList.tot,par.NatUIDstr));

if length(par.lSeq) > 1 && length(par.lSeq) ~= par.nBlocks
    errordlg('Number of samples per block needs to be a single value or one value per block (semicolon-separated).','Incorrect input')
elseif isempty(NameList.samples)
    errordlg('Sample-ID character sequence not found.','Incorrect input')
elseif isempty(NameList.ICPblanks)
    errordlg('Blank-ID character sequence not found.','Incorrect input')
elseif isempty(NameList.ICPnatU)
    errordlg('NatU-ID character sequence not found.','Incorrect input')
else
    
    % Determine delimiter of raw files
    Dels = {';','\t',',',' '};
    for i = 1 : length(Dels)
        DelCheck{i} = class(importdata([par.RawDataDir,NameList.samples{1}],Dels{i},12));
    end
    Del = Dels(strcmp(DelCheck,'struct'));Del = Del{1};
    
    nRunCheck = importdata([par.RawDataDir,NameList.samples{1}],Del,12);
    nRuns = size(nRunCheck.data(1,2:end),2);
    %% CREATE SEQUENCE: Sample Sequence
    if length(par.lSeq) == 1
        SampleSeq = cell(par.lSeq,par.nBlocks);
        for i = 1 : par.nBlocks
            SampleSeq(1:par.lSeq,i) = NameList.samples(1+par.lSeq*(i-1):1+par.lSeq*(i-1)+par.lSeq-1);
        end
    elseif length(par.lSeq) > 1
        SampleSeq = cell(max(par.lSeq),par.nBlocks);
        for i = 1 : par.nBlocks
            if i == 1
                SampleSeq(1:par.lSeq(1),i) = NameList.samples(1:par.lSeq(1));
            else
                SampleSeq(1:par.lSeq(i),i) = NameList.samples(sum(par.lSeq(1:i-1))+1:sum(par.lSeq(1:i-1))+par.lSeq(i));
            end
        end
    end
    
    if length(par.lSeq) == 1 && par.lSeq*par.nBlocks ~= numel(NameList.samples)
        warning(['The number of samples in the raw data folder (',num2str(numel(NameList.samples)),...
            ') does not match the number of samples to be processed (',num2str(sum(par.lSeq)),...
            '). Please make sure that the "Number of samples per block" has been specified correctly: ',...
            'If your analysis blocks contain a variable number of samples, a number has to be specified PER analysis block. ',...
            '(Example: 8 blocks, 7 of which contain 3 samples and the last block contains 4. Number of samples per block: ',...
            '3,3,3,3,3,3,3,4).'])
        error('The processing has been terminated (see warning above).')
    elseif length(par.lSeq) > 1 && sum(par.lSeq) ~= numel(NameList.samples)
        warning(['The number of samples in the raw data folder (',num2str(numel(NameList.samples)),...
            ') does not match the number of samples to be processed (',num2str(sum(par.lSeq)),...
            '). Please make sure that the "Number of samples per block" has been specified correctly: ',...
            'If your analysis blocks contain a variable number of samples, a number has to be specified PER analysis block. ',...
            '(Example: 8 blocks, 7 of which contain 3 samples and the last block contains 4. Number of samples per block: ',...
            '3,3,3,3,3,3,3,4).'])
        error('The processing has been terminated (see warning above).')
    end
    
    % Sample Blanks
    SBlankSeq = cell(2,par.nBlocks);
    for i = 1 : par.nBlocks
        SBlankSeq(1:2,i) = NameList.ICPblanks([2+2*(i-1),3+2*(i-1)]);
    end
    
    %% CREATE SEQUENCE: NatU CRM Sequence
    NatUSeq = cell(1,par.nBlocks+2);
    NBlankSeq = cell(1,par.nBlocks+2);
    for i = 1 : par.nBlocks+2
        NatUSeq(1,i) = NameList.ICPnatU(i);
        % NatU CRM Blanks
        if i == 1 || i == 2 || i == 3
            NBlankSeq(1,i) = NameList.ICPblanks(i);
        else
            NBlankSeq(1,i) = NameList.ICPblanks(2*(i-1)-1);
        end
    end
    
    %% CREATE SEQUENCE: Complete Sequence
    Sequence{1,1} = NBlankSeq{1};
    Sequence{2,1} = NatUSeq{1};
    Sequence{3,1} = NatUSeq{2};
    for i = 1 : par.nBlocks
        block{1,1} = SBlankSeq{1,i};
        for j = 1 : size(SampleSeq,1)
            if ~(isempty(SampleSeq{j,i}))
                block{end+1,1} = SampleSeq{j,i};
            end
        end
        block{end+1,1} = SBlankSeq{2,i};
        block{end+1,1} = NatUSeq{i+2};
        
        for k = 1 : length(block)
            Sequence{end+1,1} = block{k};
        end
        clearvars block
    end
    for i = 1 : length(Sequence)
        Sequence{i} = Sequence{i}(1:end-4);
    end
    if ~(exist([par.RawDataDir,'output/'],'dir'))
        mkdir([par.RawDataDir,'output'])
    end
    
    [~,SeqCheck] = listdlg('PromptString','Confirm sequence',...
        'SelectionMode','single',...
        'ListString',Sequence);
    
    %% PROCESSING
    if SeqCheck == 1
        TabSeq = table(Sequence);
        TabSeq.Properties.VariableNames = {'SEQUENCE'};
        writetable(TabSeq,[par.RawDataDir,'output/Sequence.txt'],'Delimiter',' ')
        
        %% STEP 1: TAILING & BLANK CORRECTION
        
        %%% Sample blank correction
        I_Sample_cTB = NaN(35,nRuns,max(par.lSeq),par.nBlocks);
        for i = 1 : par.nBlocks
            % Blank A raw intensities (correcting first half of sample block)
            DirBlankA = strcat(par.RawDataDir,SBlankSeq{1,i});
            I_SBlankA = importdata(DirBlankA,Del,12);
            I_SBlankA = I_SBlankA.data(:,2:end);
            % Blank B raw intensities (correcting second half of sample block)
            DirBlankB = strcat(par.RawDataDir,SBlankSeq{2,i});
            I_SBlankB = importdata(DirBlankB,Del,12);
            I_SBlankB = I_SBlankB.data(:,2:end);
            
            %%% Even & constant number of samples per block
            if length(par.lSeq) == 1 && ~(rem(par.lSeq,2))
                j = 1 : par.lSeq/2;
                k = par.lSeq/2+1 : par.lSeq;
            %%% Odd & constant number of samples per block
            elseif length(par.lSeq) == 1 && ~(~(rem(par.lSeq,2)))
                j = 1 : par.lSeq/2+0.5;
                k = par.lSeq/2+1.5 : par.lSeq;
            %%% Variable number of samples per block (even number of samples)
            elseif length(par.lSeq) > 1 && ~(rem(par.lSeq(i),2))
                j = 1 : par.lSeq(i)/2;
                k = par.lSeq(i)/2+1 : par.lSeq(i);
                %%% Variable number of samples per block (odd number of samples)
            elseif length(par.lSeq) > 1 && ~(~(rem(par.lSeq(i),2)))
                j = 1 : par.lSeq(i)/2+0.5;
                k = par.lSeq(i)/2+1.5 : par.lSeq(i);
            end
            
            % First half of sample block
            for j = j
                DirSampleA = strcat(par.RawDataDir,SampleSeq{j,i});
                I_SampleA = importdata(DirSampleA,Del,12);
                % Sample raw intensities
                I_SampleA = I_SampleA.data(:,2:end);
                nRuns = size(I_SampleA,2);
                if par.Type == 0
                    % Tailing Correction
                    Mlm = zeros(size(I_SampleA));
                    Mlm(11:15,:) = (I_SampleA(6:10,:)-I_SampleA(16:20,:))./...
                        (log(I_SampleA(6:10,:))-log(I_SampleA(16:20,:)));
                    Mlm(isnan(Mlm)) = I_SampleA(find(isnan(Mlm))+5);
                    I_SampleA = I_SampleA - Mlm;
                end
                % Blank Correction
                I_Sample_cTB(:,:,j,i) = I_SampleA - I_SBlankA;
            end
            
            % Second half of sample block
            for k = k
                DirSampleB = strcat(par.RawDataDir,SampleSeq{k,i});
                I_SampleB = importdata(DirSampleB,Del,12);
                % Sample raw intensities
                I_SampleB = I_SampleB.data(:,2:end);
                if par.Type == 0
                    % Tailing Correction
                    Mlm = zeros(size(I_SampleB));
                    Mlm(11:15,:) = (I_SampleB(6:10,:)-I_SampleB(16:20,:))./...
                        (log(I_SampleB(6:10,:))-log(I_SampleB(16:20,:)));
                    Mlm(isnan(Mlm)) = I_SampleB(find(isnan(Mlm))+5);
                    I_SampleB = I_SampleB - Mlm;
                end
                % Blank Correction
                I_Sample_cTB(:,:,k,i) = I_SampleB - I_SBlankB;
            end
        end
        
        %%% NatU blank correction
        I_NatU_cB = NaN(35,nRuns,par.nBlocks+2);
        for i = 1 : par.nBlocks+2
            % NatU Blank raw intensities
            DirNBlank = strcat(par.RawDataDir,NBlankSeq{i});
            I_NBlank = importdata(DirNBlank,Del,12);
            I_NBlank = I_NBlank.data(:,2:end);
            
            % NatU raw intensities
            DirNatU = strcat(par.RawDataDir,NatUSeq{i});
            I_NatU = importdata(DirNatU,Del,12);
            I_NatU = I_NatU.data(:,2:end);
            
            % Blank Correction
            I_NatU_cB(:,:,i) = I_NatU - I_NBlank;
        end
        
        %% STEP 2: INTENSITY AVERAGES (+STD)
        
        %%% Mean sample and NatU CRM intensity (averaged over submasses and
        %%% analysis runs)
        Im_Sample_cTB = [mean(mean(I_Sample_cTB(1:5,:,:,:)));...
            mean(mean(I_Sample_cTB(6:10,:,:,:)));...
            mean(mean(I_Sample_cTB(11:15,:,:,:)));...
            mean(mean(I_Sample_cTB(16:20,:,:,:)));...
            mean(mean(I_Sample_cTB(21:25,:,:,:)));...
            mean(mean(I_Sample_cTB(26:30,:,:,:)));...
            mean(mean(I_Sample_cTB(31:35,:,:,:)))];
        Im_Sample_cTB(Im_Sample_cTB < 0) = 0;
        
        Im_NatU_cB = [mean(mean(I_NatU_cB(1:5,:,:)));...
            mean(mean(I_NatU_cB(6:10,:,:)));...
            mean(mean(I_NatU_cB(11:15,:,:)));...
            mean(mean(I_NatU_cB(16:20,:,:)));...
            mean(mean(I_NatU_cB(21:25,:,:)));...
            mean(mean(I_NatU_cB(26:30,:,:)));...
            mean(mean(I_NatU_cB(31:35,:,:)))];
        Im_NatU_cB(Im_NatU_cB < 0) = 0;
        
        %%% Standard deviation of mean sample and NatU CRM intensties (STD of
        %%% submass averages)
        dIm_Sample_cTB = [std(mean(I_Sample_cTB(1:5,:,:,:)));...
            std(mean(I_Sample_cTB(6:10,:,:,:)));...
            std(mean(I_Sample_cTB(11:15,:,:,:)));...
            std(mean(I_Sample_cTB(16:20,:,:,:)));...
            std(mean(I_Sample_cTB(21:25,:,:,:)));...
            std(mean(I_Sample_cTB(26:30,:,:,:)));...
            std(mean(I_Sample_cTB(31:35,:,:,:)))];
        dIm_Sample_cTB(dIm_Sample_cTB < 0) = 0;
        
        dIm_NatU_cB = [std(mean(I_NatU_cB(1:5,:,:)));...
            std(mean(I_NatU_cB(6:10,:,:)));...
            std(mean(I_NatU_cB(11:15,:,:)));...
            std(mean(I_NatU_cB(16:20,:,:)));...
            std(mean(I_NatU_cB(21:25,:,:)));...
            std(mean(I_NatU_cB(26:30,:,:)));...
            std(mean(I_NatU_cB(31:35,:,:)))];
        dIm_NatU_cB(dIm_NatU_cB < 0) = 0;
        
        %% STEP 3: RATIOS (+STD)
        Th229_230 = NaN(max(par.lSeq),par.nBlocks);
        U236_234 = NaN(max(par.lSeq),par.nBlocks);
        U235_234 = NaN(par.nBlocks,1);
        dTh229_230 = NaN(max(par.lSeq),par.nBlocks);
        dU236_234 = NaN(max(par.lSeq),par.nBlocks);
        dU235_234 = NaN(par.nBlocks,1);
        for i = 1 : par.nBlocks
            if length(par.lSeq) == 1
                j = 1 : par.lSeq;
            else
                j = 1 : par.lSeq(i);
            end
            
            for j = j
                Th229_230(j,i) = Im_Sample_cTB(1,:,j,i)./Im_Sample_cTB(3,:,j,i);
                U236_234(j,i) = Im_Sample_cTB(7,:,j,i)./Im_Sample_cTB(5,:,j,i);
                dTh229_230(j,i) = Th229_230(j,i)*sqrt(...
                    (dIm_Sample_cTB(1,:,j,i)/Im_Sample_cTB(1,:,j,i))^2+...
                    (dIm_Sample_cTB(3,:,j,i)/Im_Sample_cTB(3,:,j,i))^2);
                dU236_234(j,i) = U236_234(j,i)*sqrt(...
                    (dIm_Sample_cTB(7,:,j,i)/Im_Sample_cTB(7,:,j,i))^2+...
                    (dIm_Sample_cTB(5,:,j,i)/Im_Sample_cTB(5,:,j,i))^2);
            end
        end
        
        for i = 1 : par.nBlocks+2
            U235_234(i,1) = Im_NatU_cB(6,:,i)./Im_NatU_cB(5,:,i);
            dU235_234(i,1) = U235_234(i,1)*sqrt(...
                (dIm_NatU_cB(6,:,i)/Im_NatU_cB(6,:,i))^2+...
                (dIm_NatU_cB(5,:,i)/Im_NatU_cB(5,:,i))^2);
        end
        
        %% STEP 4: MASS BIAS CORRECTION
        
        CRM145 = 137.285066;
        U235_234_mean = mean(U235_234);
        dU235_234_mean = sqrt(sum((dU235_234./U235_234).^2))/par.nBlocks+2;
        f = (log(CRM145/U235_234_mean))/log(235.044/234.0409468);
        df = abs((dU235_234_mean./U235_234_mean)/(log(235.044/234.0409468)));
        
        Th229_230_cMB = Th229_230*(229.031754/230.033126)^f;
        dTh229_230_cMB = abs(Th229_230_cMB.*sqrt(((dTh229_230)./(Th229_230)).^2+(log(229.031754/230.033126).*df).^2));
        
        U236_234_cMB = U236_234*(236.045568/234.0409468)^f;
        dU236_234_cMB = abs(U236_234_cMB.*sqrt(((dU236_234)./(U236_234)).^2+(log(236.045568/234.0409468).*df).^2));
        
        U235_234_cMB = U235_234*(235.044/234.0409468)^f;
        dU235_234_cMB = abs(U235_234_cMB.*sqrt(((dU235_234)./(U235_234)).^2+(log(235.044/234.0409468).*df).^2));    
        
        %% GENERATE OUTPUT TABLE A: Ratios
        Th229_230 = Th229_230_cMB(:);
        Th229_230(isnan(Th229_230_cMB(:))) = [];
        Th229_230(isinf(Th229_230)) = NaN;
        dTh229_230 = dTh229_230_cMB(:);
        dTh229_230(isnan(Th229_230_cMB(:))) = [];
        U236_234 = U236_234_cMB(:);
        U236_234(isnan(U236_234_cMB(:))) = [];
        U236_234(isinf(Th229_230)) = NaN;
        dU236_234 = dU236_234_cMB(:);
        dU236_234(isnan(U236_234_cMB(:))) = [];
        ResTab1 = table(NameList.samples,...
            Th229_230,dTh229_230,dTh229_230./Th229_230*100,...
            U236_234,dU236_234,dU236_234./U236_234*100);
        ResTab1.Properties.VariableNames = {'SampleID',...
            'Th229_230','sigma_Th229_230','sigmaP_Th229_230'...
            'U236_234' 'sigma_U236_234','sigmaP_U236_234'};
        
        U235_234 = U235_234_cMB(:);
        dU235_234 = dU235_234_cMB(:);
        ResTab2 = table(NameList.ICPnatU,...
            U235_234,dU235_234,dU235_234./U235_234*100);
        ResTab2.Properties.VariableNames = {'NatUID',...
            'Th229_230','sigma_Th229_230','sigmaP_U235_234'};
    
    end
end

if par.IDsel == 1
    %% ISOTOPIC DILUTION & PARTICLE FLUX
    run IDFVInput(SampleSeq,ResTab1,ResTab2,par)
else
    %% SAVE AND DISPLAY TABLE A
    writetable(ResTab1, [par.RawDataDir,'output/SampleRatios.xlsx'])
    writetable(ResTab2, [par.RawDataDir,'output/NatURatios.xlsx'])
    
    TableFig = figure;
    TableFig.Position = [100 100 640 652];
    TableFig.ToolBar = 'none';
    TableFig.MenuBar = 'none';
    TableFig.NumberTitle = 'off';
    TableFig.Name = 'Results';
    
    ColumnNames1 = {'229Th/230Th',char(963),[char(963), ' [%]'],...
        '236U/234U',char(963),[char(963), ' [%]']};
    ResTabUI1 = uitable(TableFig,'Data',ResTab1{:,2:end});
    ResTabUI1.ColumnName = ColumnNames1';
    ResTabUI1.RowName = ResTab1{:,1};
    ResTabUI1.Position = [10 212 620 430];
    
    ColumnNames2 = {'U235/U234',char(963),[char(963), ' [%]']};
    ResTabUI2 = uitable(TableFig,'Data',ResTab2{:,2:end});
    ResTabUI2.ColumnName = ColumnNames2';
    ResTabUI2.RowName = ResTab2{:,1};
    ResTabUI2.Position = [10 10 360 192];
end

end