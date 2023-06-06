


clc;
close all;

global gmdh

%% Load Data

Inputs = [0,0,0;0,0,2;0,0,4;0,0,6;0,0,8;0,0,10;2,1,6;2,1.50000000000000,6;2,2,6;4,1,6;4,1.50000000000000,6;4,2,6;6,1,6;6,1.50000000000000,6;6,2,6;8,1,6;8,1.50000000000000,6;8,2,6;10,1,6;10,1.50000000000000,6;10,2,6]';
Targets = [700;1500;2000;2700;1900;1800;6200;6300;6450;6220;6150;7500;7550;7600;7580;7450;6900;6950;7000;7980;6860]';

nData = size(Inputs,2);
Perm = randperm(nData);

% Train Data
pTrain = 0.85;
nTrainData = round(pTrain*nData);
TrainInd = Perm(1:nTrainData);
TrainInputs = Inputs(:,TrainInd);
TrainTargets = Targets(:,TrainInd);

% Test Data
pTest = 1 - pTrain;
nTestData = nData - nTrainData;
TestInd = Perm(nTrainData+1:end);
TestInputs = Inputs(:,TestInd);
TestTargets = Targets(:,TestInd);

%% Create and Train GMDH Network

params.MaxLayerNeurons = 15;   % Maximum Number of Neurons in a Layer
params.MaxLayers = 4;          % Maximum Number of Layers
params.alpha = 0.6;            % Selection Pressure (in Layers)
params.pTrain = 0.85;          % Train Ratio (vs. Validation Ratio)
gmdh = GMDH(params, TrainInputs, TrainTargets);

%% Evaluate GMDH Network

Outputs = ApplyGMDH(gmdh, Inputs);
TrainOutputs = Outputs(:,TrainInd);
TestOutputs = Outputs(:,TestInd);


