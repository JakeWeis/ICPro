function [C,dC,Isotopes,RunID] = ReadTMRaw(Dir)
% Extract ICP data from raw data spread sheet

%% ID strings
if ~contains(Dir,'rawfile2')
    % Example 1
    Sstr = 'GC';
    Bstr = 'Blk1';
    Vstr = 'spike';
    Rstr = 'Rinse';
    Qstr = 'QC';
else
    % Example 2
    Sstr = 'AD';
    Bstr = 'ADB';
    Vstr = 'spike';
    Rstr = 'Rinse';
    Qstr = 'QC';
end

%% Extract list of measurement run IDs
RunHeader = table2cell(readtable(Dir,'Range','1:1','ReadVariableNames',0))';
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
    if contains(RunID.All{iR},Sstr) && ~contains(RunID.All{iR},Bstr) && ~contains(RunID.All{iR},Vstr) % samples
        RunID.AllInd(iR) = 'S';
    elseif contains(RunID.All{iR},Bstr) % procedural blank
        RunID.AllInd(iR) = 'B';
    elseif contains(RunID.All{iR},Vstr) % spiked samples
        RunID.AllInd(iR) = 'V';
    elseif contains(RunID.All{iR},Rstr) % rinses
        RunID.AllInd(iR) = 'R';
    elseif contains(RunID.All{iR},Qstr) % QC
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
Isotopes = table2cell(readtable(Dir,'Range',[4,1,44,1]));
for iI = 1 : length(Isotopes)
    Isotopes{iI} = Isotopes{iI}(1:end-4);
end
Isotopes(1:2) = [];

%% Extract data of each measurement run and convert from ppb to ppm
for iR = 1 : length(RunID.Sample)
    Data = readtable(Dir,'Range',[4,RunIDColumn.Sample(iR),44,RunIDColumn.Sample(iR)+5],'ReadVariableNames',0);
    C.Sample(:,iR) = Data{:,1}/1000;
    dC.Sample(:,iR) = Data{:,3}/1000;
end
for iR = 1 : length(RunID.Blank)
    Data = readtable(Dir,'Range',[4,RunIDColumn.Blank(iR),44,RunIDColumn.Blank(iR)+5],'ReadVariableNames',0);
    C.Blank(:,iR) = Data{:,1}/1000;
    dC.Blank(:,iR) = Data{:,3}/1000;
end
for iR = 1 : length(RunID.Spike)
    Data = readtable(Dir,'Range',[4,RunIDColumn.Spike(iR),44,RunIDColumn.Spike(iR)+5],'ReadVariableNames',0);
    C.Spike(:,iR) = Data{:,1}/1000;
    dC.Spike(:,iR) = Data{:,3}/1000;
end
for iR = 1 : length(RunID.Rinse)
    Data = readtable(Dir,'Range',[4,RunIDColumn.Rinse(iR),44,RunIDColumn.Rinse(iR)+5],'ReadVariableNames',0);
    C.Rinse(:,iR) = Data{:,1}/1000;
    dC.Rinse(:,iR) = Data{:,3}/1000;
end
for iR = 1 : length(RunID.QC)
    Data = readtable(Dir,'Range',[4,RunIDColumn.QC(iR),44,RunIDColumn.QC(iR)+5],'ReadVariableNames',0);
    C.QC(:,iR) = Data{:,1}/1000;
    dC.QC(:,iR) = Data{:,3}/1000;
end

end