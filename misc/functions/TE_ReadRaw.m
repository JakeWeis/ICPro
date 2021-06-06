function OUT = TE_ReadRaw(TEpar,mode)
% Extract ICP data from raw data spread sheet

%% Extract list of measurement run IDs
RunHeader = table2cell(readtable(TEpar.RawPath,'Range','1:1','ReadVariableNames',0))';
counter = 0;
for iC = 1 : length(RunHeader)
    if ischar(RunHeader{iC})
        counter = counter + 1;
        RunID.All{counter,1} = RunHeader{iC};
        RunIDColumn.All(counter,1) = iC;
    end
end
RunIDColumn.All(2:length(RunIDColumn.All(:,1)),2) = diff(RunIDColumn.All(:,1));
RunIDColumn.All(1,2) = RunIDColumn.All(2,2);

%% Sort runs into groups
RunID.AllInd = repmat('x',length(RunID.All),1);
for iR = 1 : length(RunID.All)
    if contains(RunID.All{iR},TEpar.SID) && ~contains(RunID.All{iR},TEpar.pBID) && ~contains(RunID.All{iR},TEpar.VID) % samples
        RunID.AllInd(iR) = 'S';
    elseif contains(RunID.All{iR},TEpar.pBID) % procedural blank
        RunID.AllInd(iR) = 'B';
    elseif contains(RunID.All{iR},TEpar.VID) % spiked samples
        RunID.AllInd(iR) = 'V';
    elseif contains(RunID.All{iR},TEpar.RID) % rinses
        RunID.AllInd(iR) = 'R';
    elseif contains(RunID.All{iR},TEpar.QID) % QC
        RunID.AllInd(iR) = 'Q';
    end
end

RunID.Sample = RunID.All(RunID.AllInd == 'S');
RunID.Blank = RunID.All(RunID.AllInd == 'B');
RunID.Spike = RunID.All(RunID.AllInd == 'V');
RunID.Rinse = RunID.All(RunID.AllInd == 'R');
RunID.QC = RunID.All(RunID.AllInd == 'Q');

RunIDColumn.Sample = RunIDColumn.All(RunID.AllInd == 'S',1);
RunIDColumn.Blank = RunIDColumn.All(RunID.AllInd == 'B',1);
RunIDColumn.Spike = RunIDColumn.All(RunID.AllInd == 'V',1);
RunIDColumn.Rinse = RunIDColumn.All(RunID.AllInd == 'R',1);
RunIDColumn.QC = RunIDColumn.All(RunID.AllInd == 'Q',1);

RunIDnColumn.Sample = RunIDColumn.All(RunID.AllInd == 'S',2);
RunIDnColumn.Blank = RunIDColumn.All(RunID.AllInd == 'B',2);
RunIDnColumn.Spike = RunIDColumn.All(RunID.AllInd == 'V',2);
RunIDnColumn.Rinse = RunIDColumn.All(RunID.AllInd == 'R',2);
RunIDnColumn.QC = RunIDColumn.All(RunID.AllInd == 'Q',2);

%% Extract list of isotopes
Isotopes = table2cell(readtable(TEpar.RawPath,'Range','A:A','ReadVariableNames',0));
rowS = find(contains(Isotopes,'LR'),1,'first');
rowE = find(contains(Isotopes,'MR'),1,'last');
Isotopes([1:rowS-1,rowE+1:end]) = [];
% find empty rows
rowNA = false(length(Isotopes),1);
for iI = 1 : length(Isotopes)
    rowNA(iI,1) = isempty(Isotopes{iI});
end
Isotopes(rowNA) = [];

if mode == 1
    %% Extract data of each measurement run and convert from ppb to ppm
    for iR = 1 : length(RunID.Sample)
        Data = readtable(TEpar.RawPath,'Range',[rowS,RunIDColumn.Sample(iR),rowE,RunIDColumn.Sample(iR)+RunIDnColumn.Sample(iR)-1],'ReadVariableNames',0);
        C.Raw.Sample(:,iR) = Data{:,1}/1000;
        dC.Raw.Sample(:,iR) = Data{:,ceil(RunIDnColumn.Sample(iR)/2)}/1000;
    end
    C.Raw.Sample(rowNA,:) = [];
    dC.Raw.Sample(rowNA,:) = [];
    for iR = 1 : length(RunID.Blank)
        Data = readtable(TEpar.RawPath,'Range',[rowS,RunIDColumn.Blank(iR),rowE,RunIDColumn.Blank(iR)+RunIDnColumn.Blank(iR)-1],'ReadVariableNames',0);
        C.Raw.Blank(:,iR) = Data{:,1}/1000;
        dC.Raw.Blank(:,iR) = Data{:,ceil(RunIDnColumn.Sample(iR)/2)}/1000;
    end
    C.Raw.Blank(rowNA,:) = [];
    dC.Raw.Blank(rowNA,:) = [];
    for iR = 1 : length(RunID.Spike)
        Data = readtable(TEpar.RawPath,'Range',[rowS,RunIDColumn.Spike(iR),rowE,RunIDColumn.Spike(iR)+RunIDnColumn.Spike(iR)-1],'ReadVariableNames',0);
        C.Raw.Spike(:,iR) = Data{:,1}/1000;
        dC.Raw.Spike(:,iR) = Data{:,ceil(RunIDnColumn.Sample(iR)/2)}/1000;
    end
    C.Raw.Spike(rowNA,:) = [];
    dC.Raw.Spike(rowNA,:) = [];
    for iR = 1 : length(RunID.Rinse)
        Data = readtable(TEpar.RawPath,'Range',[rowS,RunIDColumn.Rinse(iR),rowE,RunIDColumn.Rinse(iR)+RunIDnColumn.Rinse(iR)-1],'ReadVariableNames',0);
        C.Raw.Rinse(:,iR) = Data{:,1}/1000;
        dC.Raw.Rinse(:,iR) = Data{:,ceil(RunIDnColumn.Sample(iR)/2)}/1000;
    end
    C.Raw.Rinse(rowNA,:) = [];
    dC.Raw.Rinse(rowNA,:) = [];
    for iR = 1 : length(RunID.QC)
        Data = readtable(TEpar.RawPath,'Range',[rowS,RunIDColumn.QC(iR),rowE,RunIDColumn.QC(iR)+RunIDnColumn.QC(iR)-1],'ReadVariableNames',0);
        C.Raw.QC(:,iR) = Data{:,1}/1000;
        dC.Raw.QC(:,iR) = Data{:,ceil(RunIDnColumn.Sample(iR)/2)}/1000;
    end
    C.Raw.QC(rowNA,:) = [];
    dC.Raw.QC(rowNA,:) = [];
else
    C.Raw = NaN;
    dC.Raw = NaN;
end

%% Output variable
OUT.C = C;
OUT.dC = dC;
OUT.Isotopes = Isotopes;
OUT.RunID = RunID;

end