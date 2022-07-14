function [ModelOutput] = FeatureSelectionAndRegressionAnalysis(Outcome_Norm,Predictors_Norm,parameters,Names_SelectedFeatures)


    if (strcmp(parameters.Method,'LASSO')) || (strcmp(parameters.Method,'ALL'))
    
        [B,FitInfo] = lasso(Predictors_Norm,Outcome_Norm,'alpha',parameters.alpha,'CV',parameters.CV,'PredictorNames',Names_SelectedFeatures);
    
        ModelOutput.LASSO.FitInfo = FitInfo;
        ModelOutput.LASSO.B = B;
    
        idxLambdaMinMSE = FitInfo.IndexMinMSE;
        minMSEModelPredictors = FitInfo.PredictorNames(B(:,idxLambdaMinMSE)~=0);
    
        coef = B(:,idxLambdaMinMSE);
        coef0 = FitInfo.Intercept(idxLambdaMinMSE);
    
        v = find(coef~=0);
        mdl = fitlm(Predictors_Norm(:,v),Outcome_Norm);
        
        ModelOutput.LASSO.mdl = mdl;
    end

        ModelOutput.Data.Predictors_Norm = Predictors_Norm;
        ModelOutput.Data.Outcome_Norm=Outcome_Norm;

end