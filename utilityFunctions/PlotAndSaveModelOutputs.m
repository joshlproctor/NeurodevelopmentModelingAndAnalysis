function [] = PlotAndSaveModelOutputs(ModelOutput,outputFileLocation,plotFigures,parameters)

        Predictors_Norm = ModelOutput.Data.Predictors_Norm;
        Outcome_Norm = ModelOutput.Data.Outcome_Norm;

   if (strcmp(parameters.Method,'LASSO')) || (strcmp(parameters.Method,'ALL'))
    
        FitInfo = ModelOutput.LASSO.FitInfo;
        B = ModelOutput.LASSO.B;

        idxLambdaMinMSE = FitInfo.IndexMinMSE;
        coef = B(:,idxLambdaMinMSE);
        coef0 = FitInfo.Intercept(idxLambdaMinMSE);
    
        h1 = figure;
        lassoPlot(B,FitInfo,'PlotType','CV');
        legend('show') % Show legend
        saveas(gcf,[outputFileLocation,'CVLASSOPlot.png'])
        close(h1)
        
        h1 = figure;
        lassoPlot(B,FitInfo,'PlotType','Lambda');
        saveas(gcf,[outputFileLocation,'CVLASSOLambda.png'])
        close(h1)
        
        
        idxLambdaMinMSE = FitInfo.IndexMinMSE;
        minMSEModelPredictors = FitInfo.PredictorNames(B(:,idxLambdaMinMSE)~=0)
        
        coef = B(:,idxLambdaMinMSE);
        coef0 = FitInfo.Intercept(idxLambdaMinMSE);
        

        yhat =  Predictors_Norm*coef + coef0;
        
        h1 = figure;      
        hold on
        scatter(Outcome_Norm,yhat)
        plot(Outcome_Norm,Outcome_Norm)
        xlabel('Actual Mullen Scores 24 Months')
        ylabel('Predicted Mullen Scores 24 Months')
        title('LASSO Coefficient Model')
        hold off
        saveas(gcf,[outputFileLocation,'ActualVSPredictedLASSO.png'])
        close(h1)

        v = find(coef~=0);

        mdl = ModelOutput.LASSO.mdl
        figure
        plotResiduals(mdl)
        set(gca,'XLim',[-4 3]);
        
        h1 = figure;
        for j = 1 : length(minMSEModelPredictors)
        subplot(4,ceil(length(minMSEModelPredictors)/4),j), plotAdjustedResponse(mdl,['x',num2str(j)]);
        end
        saveas(gcf,[outputFileLocation,'AdjustedResponsePlots.png'])
        %close(h1)
        
        yhat = Predictors_Norm(:,v) * mdl.Coefficients.Estimate(2:end) + mdl.Coefficients.Estimate(1);
        
        h1 = figure;
        hold on
        scatter(Outcome_Norm,yhat)
        plot(Outcome_Norm,Outcome_Norm)
        xlabel('Actual Mullen Scores 24 Months')
        ylabel('Predicted Mullen Scores 24 Months')
        title('Unbiased GLM Regression Using LASSO and CV selected markers')
        hold off
        saveas(gcf,[outputFileLocation,'UnbiasedGLMRegression.png'])
        close(h1)

        save([outputFileLocation,'ModelFits'])
 

    end

end