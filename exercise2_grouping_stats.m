%% Reading data
load data.mat train

%% Merging two tables
turnover_yyyy = grpstats(train,'yyyy','sum','DataVars','PerStatus');
turnover_yyyy.rate = turnover_yyyy.sum_PerStatus./turnover_yyyy.GroupCount;