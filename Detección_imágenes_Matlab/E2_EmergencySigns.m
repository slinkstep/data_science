% Autor: Erik Zamora G�mez
% Fecha 06/08/2015
% Este c�digo es distribuido bajo la licencia CC BY-NC-SA
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

% Desempe�o con los ejemplos de entrenamiento
Dtrain = detectandoSobreG(detectorName, Gtrain, false);
[F1_train, P, R] = evaluandoDetector(Gtrain,Dtrain)

% Validaci�n con otras imagenes
load('EmergencySigns_Test.mat');
Dtest = detectandoSobreG(detectorName, Gtest, false);
[F1_test, P, R] = evaluandoDetector(Gtest,Dtest)


%   'ObjectTrainingSize', 'Auto'(default) | [altura ancho] 
%          Si usas 'Auto', la funci�n autom�ticamente asigna la mediana de 
%          las relaciones de aspecto de las imagenes positivas. Para una buena 
%          detecci�n, asigna el tama�o real de los objetos en la imagen. Pero 
%          a mayor tama�o el entrenamento y la detecci�n ser�n mas lentas. 

%   'NegativeSamplesFactor' - 2 (default) | Numero real 
%          Numero de imagenes negativas que se usaran para entrenar, siendo 
%          un multiplo de la cantidad de imagenes positivas                   
%
%   'NumCascadeStages' - 20 (default) | Numero positivo entero
%          Numero de clasificadores fuertes o etapas. A m�s etapas, m�s
%          imagenes positivas necesitar�s. 
%
%   'FalseAlarmRate' - 0.5 (default) | 0 < Num. Real <= 1
%
%   'TruePositiveRate' - 0.995 (default) | 0 < Num. Real <= 1
%
%   'FeatureType' - 'HOG' (default) 
%                   'Haar' - Rasgos Haar
%                   'LBP'  - Patrones binarios locales
%                   'HOG'  - Histograma de gradientes orientados
