% ---------------------------------------------------------------------
% ----- MACRO PARA PUBLICAR FIGURAS DE MATLAB EN .eps PARA LaTeX ------
% ---------------------------------------------------------------------
%
% Archivos: PublicarFigura.m
%
% Descripción: Macro que genera a partir de una figura de Matlab sendos
%              ficheros .tex y .eps con matlabfrag para publicar en
%              documentos de alta calidad.
%
% Versión: 1.0.0
%
% Fecha: 31/03/2010
%
% Autor: Jaime Boal Martín-Larrauri
%
%% Formato de la figura. Posicionamiento y tamaño de la imagen
hfig = figure(1);
clf(1);
set(hfig,'Units','centimeters','NumberTitle','off','Name','Figura 1');
set(hfig,'Position',[15,3,14,11]);              % Imagen de 14x11 cm
%set(gca, 'LooseInset', [.075,.1,0.025,.05]);   % Si hay título
set(gca, 'LooseInset', [.075,.1,0.025,0]);     % Si no hay título

%% Imagen que se va a convertir
s = tf('s');
hold on
step(100/(s^2+2*s+100),[0:.0001:5]);
step(1/(s/10+1));
grid on
xlabel('Tiempo','FontSize',11,'FontName','Times','VerticalAlignment','top');
ylabel('Velocidad \ (\%)','FontSize',11,'FontName','Times','VerticalAlignment','top','interpreter','latex');
title('','FontSize',11,'FontName','Times','VerticalAlignment','middle'); % En blanco si no lleva título
hleg = legend('1er orden', '2º orden', 'Location', 'SouthEast');
set(hleg,'FontSize',11,'FontName','Times');
set(gca,'Xcolor','k','Ycolor','k','GridLineStyle',':');  % - Línea continua, -- Línea discontinua, -. Punto y guión, : Puntos
set(gca,'FontSize',11,'FontName','Times');
set(gca,'XLim',[0 5],'YLim',[0 2]);

%% Nombre del archivo generado
matlabfrag('MatlabFigure01');