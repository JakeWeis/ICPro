function [C_RAW,dC_RAW,Isotopes,RunID] = TE_ReadRaw(TEpar,mode)
% Extract ICP data from raw data spread sheet

%% ID strings
% if ~contains(TEpar.RawPath,'rawfile2')
%     % Example 1
%     TEpar.SID = 'GC';
%     TEpar.BID = 'Blk1';
%     TEpar.VID = 'spike';
%     TEpar.RID = 'Rinse';
%     TEpar.QID = 'QC';
% else
%     % Example 2
%     TEpar.SID = 'AD';
%     TEpar.BID = 'ADB';
%     TEpar.VID = 'spike';
%     TEpar.RID = 'Rinse';
%     TEpar.QID = 'QC';
% end

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

%% Sort runs into groups
RunID.AllInd = repmat('x',length(RunID.All),1);
for iR = 1 : length(RunID.All)
    if contains(RunID.All{iR},TEpar.SID) && ~contains(RunID.All{iR},TEpar.BID) && ~contains(RunID.All{iR},TEpar.VID) % samples
        RunID.AllInd(iR) = 'S';
    elseif contains(RunID.All{iR},TEpar.BID) % procedural blank
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

RunIDColumn.Sample = RunIDColumn.All(RunID.AllInd == 'S');
RunIDColumn.Blank = RunIDColumn.All(RunID.AllInd == 'B');
RunIDColumn.Spike = RunIDColumn.All(RunID.AllInd == 'V');
RunIDColumn.Rinse = RunIDColumn.All(RunID.AllInd == 'R');
RunIDColumn.QC = RunIDColumn.All(RunID.AllInd == 'Q');

%% Extract list of isotopes
Isotopes = table2cell(readtable(TEpar.RawPath,'Range',[4,1,44,1]));
for iI = 1 : length(Isotopes)
    Isotopes{iI} = Isotopes{iI}(1:end-4);
end
Isotopes(1:2) = [];

if mode == 1
    %% Extract data of each measurement run and convert from ppb to ppm
    for iR = 1 : length(RunID.Sample)
        Data = readtable(TEpar.RawPath,'Range',[4,RunIDColumn.Sample(iR),44,RunIDColumn.Sample(iR)+5],'ReadVariableNames',0);
        C_RAW.Sample(:,iR) = Data{:,1}/1000;
        dC_RAW.Sample(:,iR) = Data{:,3}/1000;
    end
    for iR = 1 : length(RunID.Blank)
        Data = readtable(TEpar.RawPath,'Range',[4,RunIDColumn.Blank(iR),44,RunIDColumn.Blank(iR)+5],'ReadVariableNames',0);
        C_RAW.Blank(:,iR) = Data{:,1}/1000;
        dC_RAW.Blank(:,iR) = Data{:,3}/1000;
    end
    for iR = 1 : length(RunID.Spike)
        Data = readtable(TEpar.RawPath,'Range',[4,RunIDColumn.Spike(iR),44,RunIDColumn.Spike(iR)+5],'ReadVariableNames',0);
        C_RAW.Spike(:,iR) = Data{:,1}/1000;
        dC_RAW.Spike(:,iR) = Data{:,3}/1000;
    end
    for iR = 1 : length(RunID.Rinse)
        Data = readtable(TEpar.RawPath,'Range',[4,RunIDColumn.Rinse(iR),44,RunIDColumn.Rinse(iR)+5],'ReadVariableNames',0);
        C_RAW.Rinse(:,iR) = Data{:,1}/1000;
        dC_RAW.Rinse(:,iR) = Data{:,3}/1000;
    end
    for iR = 1 : length(RunID.QC)
        Data = readtable(TEpar.RawPath,'Range',[4,RunIDColumn.QC(iR),44,RunIDColumn.QC(iR)+5],'ReadVariableNames',0);
        C_RAW.QC(:,iR) = Data{:,1}/1000;
        dC_RAW.QC(:,iR) = Data{:,3}/1000;
    end
else
    C_RAW = NaN;
    dC_RAW = NaN;
end

end