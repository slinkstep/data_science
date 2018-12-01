% Autor: Erik Zamora Gómez
% Fecha 06/08/2015
% Este código es distribuido bajo la licencia CC BY-NC-SA
clc, clear all, close all

% trainingImageLabeler para crear Gtrain y Gtest

% Nota: emergencySignsBristol 
%       Entrenado con ~1100 imagenes positivas y ~2200 imagenes negativas
%       Entrenado con OpenCV sobre Ubuntu

load('EmergencySigns.mat');
positiveFolder = 'positive';
negativeFolder = 'negative';
detectorName = 'emergencySignsBristol.xml';
% trainCascadeObjectDetector(detectorName,Gtrain,negativeFolder,...
%      'ObjectTrainingSize', 'Auto', 'NegativeSamplesFactor', 2,...
%      'NumCascadeStages', 10, 'FalseAlarmRate', 0.15,...
%      'TruePositiveRate', 0.995,'FeatureType', 'HOG');

% Desempeño con los ejemplos de entrenamiento
Dtrain = detectandoSobreG(detectorName, Gtrain, false);
[F1_train, P, R] = evaluandoDetector(Gtrain,Dtrain)

% Validación con otras imagenes
load('EmergencySigns_Test.mat');
Dtest = detectandoSobreG(detectorName, Gtest, false);
[F1_test, P, R] = evaluandoDetector(Gtest,Dtest)


%   'ObjectTrainingSize', 'Auto'(default) | [altura ancho] 
%          Si usas 'Auto', la función automáticamente asigna la mediana de 
%          las relaciones de aspecto de las imagenes positivas. Para una buena 
%          detección, asigna el tamaño real de los objetos en la imagen. Pero 
%          a mayor tamaño el entrenamento y la detección serán mas lentas. 

%   'NegativeSamplesFactor' - 2 (default) | Numero real 
%          Numero de imagenes negativas que se usaran para entrenar, siendo 
%          un multiplo de la cantidad de imagenes positivas                   
%
%   'NumCascadeStages' - 20 (default) | Numero positivo entero
%          Numero de clasificadores fuertes o etapas. A más etapas, más
%          imagenes positivas necesitarás. 
%
%   'FalseAlarmRate' - 0.5 (default) | 0 < Num. Real <= 1
%
%   'TruePositiveRate' - 0.995 (default) | 0 < Num. Real <= 1
%
%   'FeatureType' - 'HOG' (default) 
%                   'Haar' - Rasgos Haar
%                   'LBP'  - Patrones binarios locales
%                   'HOG'  - Histograma de gradientes orientados
