clear all, close all, clc
import klodsclass

%% Variable
l_p = 0;
l_0 = 1 + normrnd(0,1)*0.05; % Ligev?gtsl?ngde mellem blokkene
k_p = 1 + normrnd(0,1)*0.05; % Fjederkonstant - tr?kplade
k_x = 1 + normrnd(0,1)*0.05; % Fjederkonstant mellem klodser i x retning
k_y = 1 + normrnd(0,1)*0.05; % Fjederkonstant mellem klodser i y retning
alpha = 0.75 + normrnd(0,0.75)*0.05; % br?kdel af friktionskraft i fjeder efter flyting
N_xy = [100,100]; % Antal blokke i modellen
ee = 0.0001; % konvergenes kriterie for 2D model



%% Konstruerer klodser objekt i array

objarray(1:N_xy(1,1), 1:N_xy(1,2)) = klodsclass(l_0,k_x,k_y,k_p);


% giver en positions vektor til hvert object, basseret p? dets position,
% samt en friktionskraft til hver klods
for i = 1:size(objarray,1)
    
    for m = 1:size(objarray,2)
        objarray(i,m).pos = [l_0 * m, l_0 * size(objarray,2) - i];
        objarray(i,m).frik = 1 + normrnd(0,1) * 0.05;
    end
    
end


%% Find ustabile klodser 
