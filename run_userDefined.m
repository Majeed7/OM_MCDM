%--------------------------------------------------------------------------
% This file includes an example of how to compute the expert-based
% collective performance (ECP) and the credal rankings of performance
% metrics and ontology alingment systems. Any user can define a set of
% performance metrics and compare them using Bayesian Best-Worst Method,
% according to which the alignment systems can be compared and evaluated.
% For more information on how to provide the input to the model, see the
% comments in the code.
%--------------------------------------------------------------------------
% Copyright @ Majid Mohammadi, 2020
% For more information, see the corresponding paper:
%   Mohammadi and Rezaei (2020), Evaluating and Comparing Ontology
%      Alignment Systems: An MCDM Approach, Journal of Web Semantics, 2020,
% and for Bayesian Best-Worst Method, see:
%   Mohammadi and Rezaei (2019), Bayesian Best-Worst Method: A Probabilistic 
%     Group Decision-making Model, Omega, 2019.
%--------------------------------------------------------------------------

clear
close
clc

addpath('BayesianBWM')
load OAEI_2018

%% Bayesian Best-Worst Method for identifying the importance of criteria

% Step 1: Define the performance metrics
perf_metrics = {'Time','Precision','Recall','Recall+','Consistency'};

% Step 2: The best-to-others vectors of K experts
% A_B is a matrix whose rows are the best-to-others vector of each expert
A_B = [5,2,2,1,9;
       5,1,1,1,4;
       5,4,1,3,4;
       7,1,2,4,8;
       9,2,2,1,7;
       5,3,3,5,1;
       5,3,3,5,1;
       9,2,2,1,8;
       9,3,3,1,9;
       9,3,4,1,6];

% Step 3: The others-to-worst vectors of K experts
% A_W is a matrix whose rows are the others-to-worst vector of each expert
A_W = [2,4,4,9,1;
       1,7,4,5,5;
       1,5,5,4,4;
       3,8,7,6,1;
       1,7,7,9,2;
       2,2,2,1,2;
       2,2,2,1,2;
       1,5,5,9,2;
       1,7,7,9,1;
       1,7,6,9,5];



% Running the Bayesian BWM
[w_final,wall] = BayesianBWM(A_B,A_W);
 
% Ploting the credal ranking of performance metrics
figure(1)
Probability = plotGraph(w_final,perf_metrics);



%% Evaluating the alignment systems according to multiple metrics defined in "perf_metrics" and theri importance

% specifying the alignment systems 
systems = {'LogMapBio','DOME','POMAP++','Holontology','ALIN','AML','XMap','LogMap','ALOD2Vec','FCAMapX','KEPLER',...
    'LogMapLite','SANOM','Lily'};

% types of metrics: 1 for benefit metrics like recall whose higher values
% are desired, and -1 for cost metrics like time whose lower values are desired
metric_type = [-1 1 1 1 1];

% Enterin the values of each alingment systems for the specified
% performance metrics: each row corresponds to the performance scores of a
% system, e.g., the first row contains the scores of LoMapBio
scores =  [  808	0.888	0.908	0.756	1;
              22	0.997	0.615	0.009	0;
             210	0.919	0.877	0.695	0;
             265	0.976	0.294	0.005	0;
             271	0.998	0.611	0	    1;
              42	0.95	0.936	0.832	1;
              37	0.929	0.865	0.647	1;
              23	0.918	0.846	0.593	1;
              75	0.996	0.648	0.086	0;
             118	0.941	0.791	0.455	0;
             244	0.958	0.741	0.316	0;
              18	0.962	0.728	0.288	0;
              48 	0.888	0.844	0.632	0;
             278	0.872	0.795	0.518	0;];

% Computing ECP
EPC = ECPFunction(scores,mean(w_final),metric_type);

% COmputing the ranking of alignment systems
figure(2)
CredalOutranking(scores,systems,w_final,metric_type);
