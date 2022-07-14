function [Outcome_Norm,Predictors_Norm] = NormalizeSelectedFeatures(Outcome,X_SelectedFeatures,Names_SelectedFeatures,FeaturesToNormalize,typeOfNormalization,Option)

   Predictors_Norm = X_SelectedFeatures;
   Outcome_Norm = Outcome;

if isempty(typeOfNormalization)
    if Option == 2
    
        for j = 1 : length(FeaturesToNormalize)
    
            index = find(strcmp(FeaturesToNormalize{j},Names_SelectedFeatures)==1);
    
            Predictors_Norm(:,j) = (X_SelectedFeatures(:,j)-mean(X_SelectedFeatures(:,j)))/std(X_SelectedFeatures(:,j));
        end
    
    elseif Option == 3
    
        for j = 1 : length(FeaturesToNormalize)
    
           index = find(strcmp(FeaturesToNormalize{j},Names_SelectedFeatures)==1);
                
            notZeroLocs = find(X_SelectedFeatures(:,index)~=0);
            minV = sort(X_SelectedFeatures(notZeroLocs,index)); 
            minV = minV(1)/2;
            Predictors_Norm(:,index) = log10(X_SelectedFeatures(:,index)+minV);
            
            Predictors_Norm(:,index) = (Predictors_Norm(:,index)-mean(Predictors_Norm(:,index)))/std(Predictors_Norm(:,index));
            
        end

    elseif Option == 4

        for j = 1 : length(FeaturesToNormalize)

           index = find(strcmp(FeaturesToNormalize{j},Names_SelectedFeatures)==1);
                
            notZeroLocs = find(X_SelectedFeatures(:,index)~=0);
            minV = sort(X_SelectedFeatures(notZeroLocs,index)); 
            minV = minV(1)/2;
            Predictors_Norm(:,index) = log10(X_SelectedFeatures(:,index)+minV);
            
            Predictors_Norm(:,index) = (Predictors_Norm(:,index)-mean(Predictors_Norm(:,index)))/std(Predictors_Norm(:,index));
            Predictors_Norm((Predictors_Norm(:,index)>2),index) = 2;
        end
    end

else

    for j = 1 : length(FeaturesToNormalize)

        index = find(strcmp(FeaturesToNormalize{j},Names_SelectedFeatures)==1);

        if typeOfNormalization(j) == 2
             Predictors_Norm(:,j) = (X_SelectedFeatures(:,j)-mean(X_SelectedFeatures(:,j)))/std(X_SelectedFeatures(:,j));

        elseif typeOfNormalization(j) == 3
            notZeroLocs = find(X_SelectedFeatures(:,index)~=0);
            minV = sort(X_SelectedFeatures(notZeroLocs,index)); 
            minV = minV(1)/2;
            Predictors_Norm(:,index) = log10(X_SelectedFeatures(:,index)+minV);
            
            Predictors_Norm(:,index) = (Predictors_Norm(:,index)-mean(Predictors_Norm(:,index)))/std(Predictors_Norm(:,index));

        elseif typeOfNormalization(j) == 4
                                 
            notZeroLocs = find(X_SelectedFeatures(:,index)~=0);
            minV = sort(X_SelectedFeatures(notZeroLocs,index)); 
            minV = minV(1)/2;
            Predictors_Norm(:,index) = log10(X_SelectedFeatures(:,index)+minV);
            
            Predictors_Norm(:,index) = (Predictors_Norm(:,index)-mean(Predictors_Norm(:,index)))/std(Predictors_Norm(:,index));
            Predictors_Norm((Predictors_Norm(:,index)>2),index) = 2;
        end
    end

end
end