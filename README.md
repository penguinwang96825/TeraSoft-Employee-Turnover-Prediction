# TeraSoft-Employee-Turnover-Prediction

## Load Data

```
data = readtable('train.csv', 'PreserveVariableNames', true);
[~, colName] = xlsread('colName.xlsx');
data.Properties.VariableNames = colName;
```

## EDA

Turnover by year.
```
turnover = grpstats(data, 'yyyy', 'sum', 'DataVars', 'PerStatus');
turnover.rate = turnover.sum_PerStatus ./ turnover.GroupCount;
```

Grouping method.
```
[grp_id, g1, g2] = findgroups(data.yyyy, data.Section);
mean_comm = splitapply(@mean, data.CommCost, grp_id);
```

Remove missing value.
```
data_clean = rmmissing(data, 'DataVariables', {'TravelConcentrate'; 'PromoteSpeed'});
```

Get missing data.
```
missing_idx = ismissing(data);
```

Merging data. (innerjoin, outerjoin)
```
season = readtable('season.csv', 'PreserveVariableNames', true);
season.Properties.VariableNames = {'yyyy'; 'PerNo'; 'overWork'; 'TripA'; 'TripB'; 'LeaveA'; 'LeaveB'};
season_agg = grpstats(season, {'yyyy'; 'PerNo'}, 'sum', 'DataVars', {'overWork'; 'TripA'; 'TripB'; 'LeaveA'; 'LeaveB'});
data_outer = outerjoin(data, season_agg, ,'Keys', {'yyyy'; 'PerNo'}, 'Type', 'left', 'MergeKeys', true);
data_inner = innerjoin(data, season_agg, ,'Keys', {'yyyy'; 'PerNo'});
```

Sort data.
```
season_sort = sortrows(season, {'yyyy'; 'PerNo'}, 'descend')
```

## Classification Learner

```
yfit = trainedModel.predictFcn(train);
```

```
[yfit, score] = predict(trainedModel.ClassificationTree, train);
```
