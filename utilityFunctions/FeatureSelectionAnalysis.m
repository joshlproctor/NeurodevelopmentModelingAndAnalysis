function [ModelOutput] = FeatureSelectionAndRegressionAnalysis(Outcome_Norm,Predictors_Norm,parameters)


    if (parameters.Method == 'LASSO') || Iparameters.Method == 'ALL')
    
        [B,FitInfo] = lasso(DataForRegressionNormalizedSelected,DataForRegressionNormalized(:,2),'alpha',parameters.alpha,'CV',parameters.CV,'PredictorNames',newNames3);
    
        ModelOutput.LASSO.FitInfo = FitInfo;
        ModelOutput.LASSO.B = B;
    
        idxLambdaMinMSE = FitInfo.IndexMinMSE;
        minMSEModelPredictors = FitInfo.PredictorNames(B(:,idxLambdaMinMSE)~=0);
    
        coef = B(:,idxLambdaMinMSE);
        coef0 = FitInfo.Intercept(idxLambdaMinMSE);
    
        v = find(coef~=0);
        mdl = fitlm(DataForRegressionNormalizedSelected(:,v),DataForRegressionNormalized(:,2));
        
        ModelOutput.LASSO.mdl = mdl;
    
    end


end