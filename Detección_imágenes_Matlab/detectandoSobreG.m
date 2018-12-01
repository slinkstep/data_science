function D = detectandoSobreG(ArchivoDetector, G, visualizacion)
% Autor: Erik Zamora G�mez
% Fecha 06/08/2015
% Este c�digo es distribuido bajo la licencia CC BY-NC-SA

% Crear la lista de detecciones D para las imagenes referenciadas en la
% lista G

% Entradas
%   ArchivoDetector contiene la direcci�n del archivo del detector,
%                   extensi�n xml
%   G Lista de rectangulos de los objetos que realmente est�n en las imagenes
%   visualizacion es una var. booleana que activa o desactiva la visualizacion de
%                 los rectangulos detectados y de los objetos reales en la imagenes. 

% Salidas
%   D Lista de rect�ngulos de las detecciones 

%   Nota 1: G y D son una estructura estandar para listar los rectangulos
%          Campo 1: imageFilename
%          Campo 2: objectBoundingBoxes
%   Nota 2: presionar barra de espacio para saltar a la siguiente imagen

detector = vision.CascadeObjectDetector(ArchivoDetector);
D = struct('imageFilename',{},'objectBoundingBoxes',{});
for im= 1:length(G)
    img = imread(G(im).imageFilename);
    D(im).imageFilename = G(im).imageFilename;
    D(im).objectBoundingBoxes = step(detector, img);
    
    % Visualizaci�n 
    if visualizacion
        detectedImg = insertObjectAnnotation(img, 'rectangle',...
            D(im).objectBoundingBoxes, 'deteccion','Color','red');
        detectedImg = insertObjectAnnotation(detectedImg, 'rectangle',...
            G(im).objectBoundingBoxes, 'objeto','Color','blue');
        imshow(detectedImg);
        pause
    end
end