%% Merging two tables
season_col = ["yyyy";"Period";"PerNo";"overWork";"TripA";"TripB";"LeaveA";"LeaveB"];
season = readtable('season.csv');
season.Properties.VariableNames = season_col;

[~, train_col_eng] = xlsread('colName.xlsx');
[~, train_col] = xlsread('train.csv');
train = readtable('train.csv');
train.Properties.VariableNames = train_col_eng;


%% Combine two table
data = outerjoin(train, season_agg, 'Keys', {'yyyy', 'PerNo'}, 'Type', 'left', 'MergeKeys', true);