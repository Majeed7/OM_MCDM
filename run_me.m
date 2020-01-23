clear
close
clc

load OAEI_2018

distance = 1;%Euclidean Distance
normalization = 1;%1 Max method

track = 'anatomy';

if strcmp(track,'anatomy')
    matrix = Anatomy.Results;
    criteria_type = [-1 1 1 1 1];%benefit cost criteria
    systems = Anatomy.Participants;
    criteria_weight = Anatomy.Weight;
    scores = Anatomy.scores;
    weightSamples = Anatomy.WeightSamples;
elseif strcmp(track,'conference1')
    matrix = Conference.Results;
    criteria_type = [1 1 -1 -1];
    criteria_weight = Conference.Weight;
    systems = Conference.Participants;
    scores = Conference.scores;
    weightSamples = Conference.WeightSamples;
elseif strcmp(track,'conference2')
    matrix = Conference.ResultsUncertain;
    criteria_type =  [1 1 -1 -1];
    criteria_weight = Conference.Weight;
    systems = Conference.ParticipantsUncertain;
    scores = Conference.scores;
    weightSamples = Conference.WeightSamples;
elseif strcmp(track,'Multifarm')
    matrix = Multifarm.Results;
    criteria_type =  [-1 1 1];
    criteria_weight = Multifarm.Weight;
    systems = Multifarm.Participants;
    scores = Multifarm.scores;
    weightSamples = Multifarm.WeightSamples;
elseif strcmp(track,'LargB1')%FMANCI
    matrix = LargeBio.Results_FMANCI;
    criteria_type = [-1 1 1];%benefit cost criterai
    criteria_weight = LargeBio.Weight;
    systems = LargeBio.Participants_FMANCI;
    scores = LargeBio.scores;
    weightSamples = LargeBio.WeightSamples;
elseif strcmp(track,'LargB2')%FMASNOMED
    matrix = LargeBio.Results_FMASNOMED;
    criteria_type = [-1 1 1];%benefit cost criterai
    criteria_weight = LargeBio.Weight;
    systems = LargeBio.Participants_FMASNOMED;
    scores = LargeBio.scores;
    weightSamples = LargeBio.WeightSamples;
elseif strcmp(track,'LargB3')%NCISNOMED
   matrix = LargeBio.Results_NCISNOMED;
    criteria_type = [-1 1 1];%benefit cost criterai
    criteria_weight = LargeBio.Weight;
    systems = LargeBio.Participants_NCISNOMED;    
    scores = LargeBio.scores;
    weightSamples = LargeBio.WeightSamples;
elseif strcmp(track,'Pheno1')%HP MP
    matrix = Pheno.Results_HPMP;
    criteria_type = [-1 1 1];%benefit cost criterai
    criteria_weight = Pheno.Weight;
    systems = Pheno.Participants_HPMP;
    scores = Pheno.scores;
    weightSamples = Pheno.WeightSamples;
elseif strcmp(track,'Pheno2')%DOID ORDO
    matrix = Pheno.Results_DOIDORDO;
    criteria_type = [-1 1 1];%benefit cost criterai
    criteria_weight = Pheno.Weight;
    systems = Pheno.Participants_DOIDORDO;
    scores = Pheno.scores;
    weightSamples = Pheno.WeightSamples;
elseif strcmp(track,'Biodiv1')
    matrix = Biodiv_FLOPOPTO;
    criteria_type = [1 1 1]; 
elseif strcmp(track,'Biodiv2')
    matrix = Biodiv_ENVOSWEET;
    criteria_type = [1 1 1];
elseif strcmp(track,'Spimbench1')%Sandbox
     matrix = SPIMBENCH.ResultsSandbox;
    criteria_type = [-1 1 1];%benefit cost criterai
    criteria_weight = SPIMBENCH.Weight;
    systems = SPIMBENCH.ParticipantsSandbox;
    scores = SPIMBENCH.scores;
    weightSamples = SPIMBENCH.WeightSamples;
elseif strcmp(track,'Spimbench2')%MainBox
     matrix = SPIMBENCH.ResultsMainbox;
    criteria_type = [-1 1 1];%benefit cost criterai
    criteria_weight = SPIMBENCH.Weight;
    systems = SPIMBENCH.ParticipantsMainbox;
    scores = SPIMBENCH.scores;
    weightSamples = SPIMBENCH.WeightSamples;
end

%%ERC and F-measure computation
reInd = find(ismember(lower(scores),'recall'));
prInd = find(ismember(lower(scores),'precision'));

FMeasure =  @(pr,re) (2*pr.*re) ./ (pr+re);

EPC = ECPFunction(matrix,criteria_weight,criteria_type);

fmeasure = FMeasure(matrix(:,prInd),matrix(:,reInd));
%info = [matrix EPC fmeasure]
CredalOutranking(matrix,systems,weightSamples,criteria_type);
return;
