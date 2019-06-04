%data_dir = 'eclipseData/';
warning('off', 'all');
data_dir = '/Users/thomascolligan/Box/Eclipse 2019/Practice_Flight_Data';
t = fullfile(data_dir, "*.txt");
files = dir(t);
saveDirectory = 'gravityWaveData';
show = false;
save = false;
lowerCutOffAltitude = 9000;
upperCutOffAltitude = 40000;
for i=1:size(files)
    current = files(i).name;
    fprintf("Current file: %s\n", current);
    current = fullfile(data_dir, current);
    if contains(current, 'W4_L1') && ~contains(current, 'bad_data_removed')
        % removed the bad data manually
        continue;
    end
    try
        doAnalysis(current, save, saveDirectory, show, lowerCutOffAltitude, upperCutOffAltitude);
    catch e
        if (strcmp(e.identifier, 'MATLAB:table:UnrecognizedVarName'))
            fprintf("----------------------------\n");
            fprintf("Data file does not contain a variable needed for analysis:\n%s\n", current, e.message);
            fprintf("----------------------------\n");
            continue;
        end
        rethrow(e);
    end
        fprintf("----------------------------\n");
end