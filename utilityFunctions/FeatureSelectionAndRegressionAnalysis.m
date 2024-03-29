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

    elseif (strcmp(parameters.Method,'PLS')) || (strcmp(parameters.Method,'ALL'))
        
        mode = 5;
        ModelOutput.PLS.mode = mode;
        
        [XL,yl,XS,YS,beta,PCTVAR,MSE,stats] = plsregress(Predictors_Norm,Outcome_Norm,mode,'cv',parameters.CV);
        
        ModelOutput.PLS.XL = XL;
        ModelOutput.PLS.yl = yl;
        ModelOutput.PLS.XS = XS;
        ModelOutput.PLS.YS = YS;
        ModelOutput.PLS.beta = beta;
        ModelOutput.PLS.PCTVAR = PCTVAR;
        ModelOutput.PLS.MSE = MSE;
        ModelOutput.PLS.stats = stats;

        W0 = stats.W ./ sqrt(sum(stats.W.^2,1));
        ModelOutput.PLS.W0 = W0;

        p = size(XL,1);
        sumSq = sum(XS.^2,1).*sum(yl.^2,1);
        vipScore = sqrt(p* sum(sumSq.*(W0.^2),2) ./ sum(sumSq,2));
        
        ModelOutput.PLS.indVIP = find(vipScore >= 1);
        
        y = Outcome_Norm;

        yhat = [ones(size(Predictors_Norm,1),1) Predictors_Norm]*beta;

        yfitPLS = yhat;
        
        TSS = sum((y-mean(y)).^2);
        RSS_PLS = sum((y-yfitPLS).^2);
        ModelOutput.PLS.rsquaredPLS = 1 - RSS_PLS/TSS
        ModelOutput.PLS.vipScore = vipScore;

    elseif (strcmp(parameters.Method,'PCA')) || (strcmp(parameters.Method,'ALL'))
        
        X_t = Predictors_Norm(:,2:38)';

        [U,Sig,V] = svd(X_t);

        ModelOutput.PCAReg.U = U;
        ModelOutput.PCAReg.Sig = Sig;
        ModelOutput.PCAReg.V = V;  
        
        X_r = U(:,1:4)'*X_t;
        
       
        
        %v = find((X_r(2,:)>-3)&(X_r(2,:)<1));
        variables = [Predictors_Norm(:,1) X_r' Predictors_Norm(:,39:41)];
        
        mdl = fitlm(variables,Outcome_Norm); %,'VarNames',{[newNames3(v),"TotalMullen_24Month"]});
        
        yhat = variables * mdl.Coefficients.Estimate(2:end) + mdl.Coefficients.Estimate(1);

        ModelOutput.PCAReg.mdl = mdl;
        ModelOutput.PCAReg.yhat = yhat;
        ModelOutput.PCAReg.X_r = X_r;


    end

        ModelOutput.Data.Predictors_Norm = Predictors_Norm;
        ModelOutput.Data.Outcome_Norm=Outcome_Norm;
        ModelOutput.Data.Names_SelectedFeatures = Names_SelectedFeatures;

end