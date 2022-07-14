function [featuresToInclude,featuresToNormalize,typeOfNormalization] = SelectFeaturesForAnalysisCRYPTO(configFile)
    

    % Need to generalize this part to make it easy to try other combos.

    marker = [2:4 6:8 10 13:14 16 18:20 23:40 54 93 153];
    
    featuresToNormalize = [2:4 6:8 10 13:14 16 18:20 23:40 54];
    typeOfNormalization = [4*ones(length(featuresToNormalize),1);2];

    featuresToInclude = marker;

end