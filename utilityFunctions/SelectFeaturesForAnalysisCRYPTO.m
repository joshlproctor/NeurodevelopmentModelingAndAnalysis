function [featuresToInclude,featuresToNormalize,typeOfNormalization] = SelectFeaturesForAnalysisCRYPTO(configFile)
    

    % Need to generalize this part to make it easy to try other combos.

    marker = [2:4 6:8 10 13:14 16 18:20 23:40 54 93 153];   %OLD
    marker = [2:4 6:8 9 10 13:14 16 18:20 23:40 54 93 153];  %Keep
    marker = [2:4 6:8 9 10 12 13:14 15 16 17 18:20 21 22 23:34 35 36:40 54 93 153];  %TEST

    featuresToNormalize = [2:4 6:8 10 13:14 16 18:20 23:40 54]; % OLD
    featuresToNormalize = [2:4 6:8 9 10 13:14 16 18:20 23:40 54]; % KEEP
    featuresToNormalize = [2:4 6:8 9 10 12 13:14 15 16 17 18:20 21 22 23:34 35 36:40 54]; % TEST

    typeOfNormalization = [4*ones(length(featuresToNormalize),1);2];

    featuresToInclude = marker;

end