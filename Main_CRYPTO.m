clear all;
close all;
clc;
clear objects;
clear global variables;
cd(pwd);

%% Set paths 

ExperimentName = 'PCA_FeatureSelection';
setPathsAndConfigParameters;

%% Load configuration file

Config_CRYPTO;

%%  Load linked CRYPTO Data

load LinkedList

%% Load the set of features to include

[featuresToInclude,featuresToNormalize,typeOfNormalization] = SelectFeaturesForAnalysisCRYPTO(configFileLocation);

%% Process Data to include in analysis  

% Option = 0, Outcome is the 24 month score 
% Option = 1, Outcome is the difference between 24 and 6 months

[Outcome,X_SelectedFeatures,Names_SelectedFeatures,FeaturesToNormalize] = processDataForAnalysisCRYPTO(X,linkedVariableNames,featuresToInclude,featuresToNormalize,p_Option);

%%  Normalize Data 

% Option = 0, no normalization
% Option = 1, scale all features to 1 and mean subtract
% Option = 2, log10 transformation, scale features to 1 and mean subtract
% Option = 3, log10 transformation, scale features to 1 and mean subtract,
% cap at a normalized value of 2
% Option = 4, bespoke normalization based on the distribution of each
%             biomarkers

[Outcome_Norm,Predictors_Norm] = NormalizeSelectedFeatures(Outcome,X_SelectedFeatures,Names_SelectedFeatures,FeaturesToNormalize,typeOfNormalization,n_Option);

%%  Run feature selection and Regression

[ModelOutput] = FeatureSelectionAndRegressionAnalysis(Outcome_Norm,Predictors_Norm,parameters,Names_SelectedFeatures);

%%  Plot Outputs  

PlotAndSaveModelOutputs(ModelOutput,outputFileLocation,plotFigures,parameters)