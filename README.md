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

Merge data. (innerjoin, outerjoin)
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

Simple class prediction without probability.
```
yfit = trainedModel.predictFcn(train);
```

Simple prediction with probability output.
```
[yfit, prob] = predict(trainedModel.ClassificationTree, train);
```

KFold prediction.
```
mdl = fitctree(train, 'PerStatus', 'KFold', 5);
y_hat = kfoldPredict(mdl);
confusionchart(train.PerStatus, y_hat);
```

Auto ML.
```
mdl = fitcauto(train, 'PerStatus', 'OptimizeHyperparameters', 'auto')
[yfit, prob] = predict(mdl, train);
```

### Validation
1. Holdout
2. KFold
3. Leave-one-out

### Feature Transformation
1. `pca`
2. `sequntialfs`
3. `factoran`
4. `predictorImportance`

### Feature Selection

Feature importance.
```
imp = predictorImportance(trainedModel.ClassificationTree)
bar(imp)
```

NCA (Neighborhood Component Analysis) using `fsrnca` from [MATLAB](https://www.mathworks.com/help/stats/neighborhood-component-analysis.html) website.

### Optimisation

Use `hyperparameters` to optimise parameters.

### Plot

```
view(mdl, 'mode', 'graph')
```
