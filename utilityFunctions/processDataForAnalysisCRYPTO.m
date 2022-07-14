function [Outcome,X_SelectedFeatures,Names_SelectedFeatures,Names_FeatureToNormalize] = processDataForAnalysisCRYPTO(X,variableNames,featuresToInclude,featuresToNormalize,Option)
    
    % Resolving the sub Mullen scores, normalizing within cohort and time
    % period, and removing individuals that do not have both cognitive
    % assessments.  
    
    vrraw6 = find(strcmp('vrraw_6Month',variableNames)); 
    rlraw6 = find(strcmp('rlraw_6Month',variableNames)); 
    elraw6 = find(strcmp('elraw_6Month',variableNames)); 

    vrraw24 = find(strcmp('vrraw_24_24Month',variableNames)); 
    rlraw24 = find(strcmp('rlraw_24_24Month',variableNames)); 
    elraw24 = find(strcmp('elraw_24_24Month',variableNames)); 

    Scores = [(X(:,vrraw6)+X(:,rlraw6)+X(:,elraw6)) (X(:,vrraw24)+X(:,rlraw24)+X(:,elraw24))];
    
    % Remove individuals that have a nan in either 6 or 24 month assessment
    [u,~] = find(isnan(Scores));
    v1 = setdiff(1:length(X(:,1)),u);
    

    % Normalize within time assessment.
    norm6(:,1)  = (Scores(v1,1) - mean(Scores(v1,1)))/std(Scores(v1,1));
    norm24(:,1) = (Scores(v1,2) - mean(Scores(v1,2)))/std(Scores(v1,2));

    marker = [];
    if isnumeric(featuresToInclude(1))
        marker = featuresToInclude;
    else
        for j = 1 : length(featuresToInclude)
            
            v = find(strfind(featuresToInclude{1},variableNames));
            marker = [marker v];
        end
    end
    
    Data = [Scores X(:,marker)];

    [u,~] = find(isnan(Data)|(Data==-9));
    v = setdiff(1:130,u);

    DataForRegression = Data(v,:);
    DataForRegression(:,1) = (DataForRegression(:,1)- mean(Scores(v1,1)))/std(Scores(v1,1));
    DataForRegression(:,2) = (DataForRegression(:,2)- mean(Scores(v1,2)))/std(Scores(v1,2));

    if Option == 0
        Outcome = DataForRegression(:,2);
    elseif Option == 1
        Outcome = DataForRegression(:,2) - DataForRegression(:,1);
    end

    Names_FeatureToNormalize = variableNames(featuresToNormalize);
    Names_SelectedFeatures = ['SubMullen_6Months' variableNames(marker)];
    X_SelectedFeatures = DataForRegression(:,[1 3:end]);

end