function [F1, P, R] = evaluandoDetector(G,D)
% Autor: Erik Zamora Gómez
% Fecha 06/08/2015
% Este código es distribuido bajo la licencia CC BY-NC-SA

% Evalua el desempeño del detector dadas a listas G y D

% Entradas
%   G Lista de rectangulos de los objetos que realmente están en las imagenes
%   D Lista de rectángulos de las detecciones 
%     G y D son una estructura estandar para listar los rectangulos
%          Campo 1: imageFilename
%          Campo 2: objectBoundingBoxes
%     la longitud de D y de G es igual al numero de imagenes total

% Salidas
%   F1 = Medida F1 del detector
%   P = Precisión del detector
%   R = Sensibilidad (Recall) del detector

sumMejorTraslapeD = 0;
Ndet = 0;
sumMejorTraslapeG = 0;
Nobj = 0;
for im=1:length(D)
    % Calculando matriz de traslape
    IndiceTraslape = bboxOverlapRatio(G(im).objectBoundingBoxes,D(im).objectBoundingBoxes);
    
    ndet = size(D(im).objectBoundingBoxes,1);
    Ndet = Ndet + ndet;
    nobj = size(G(im).objectBoundingBoxes,1);
    Nobj = Nobj + nobj;
    if ndet>0 && nobj>0
        % Calculando Precisión 
        sumMejorTraslapeD = sumMejorTraslapeD + sum(max(IndiceTraslape,[],1));
        % Calculando Sensibilidad
        sumMejorTraslapeG = sumMejorTraslapeG + sum(max(IndiceTraslape,[],2));
    end
end
P = sumMejorTraslapeD/Ndet;
R = sumMejorTraslapeG/Nobj;
F1 = 2*P*R/(P+R);