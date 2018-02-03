clear all; close all; clc
import klodsclass

%% Variable
l_p = [1.2,0];
l_0 = 1 + normrnd(0,1)*0.05; % Ligev?gtsl?ngde mellem blokkene
k_p = 1 + normrnd(0,1)*0.05; % Fjederkonstant - tr?kplade
k_x = 1 + normrnd(0,1)*0.05; % Fjederkonstant mellem klodser i x retning
k_y = 1 + normrnd(0,1)*0.05; % Fjederkonstant mellem klodser i y retning
alpha = 0.75 + normrnd(0,0.75)*0.05; % br?kdel af friktionskraft i fjeder efter flyting
N_xy = [100,100]; % Antal blokke i modellen
ee = 0.0001; % konvergenes kriterie for 2D model
Etot = 0; % Total energi i sk?lv
klodsamount = 0; % Antal klodser i sk?lv


%% Konstruerer klodser objekt i array

objarray(1:N_xy(1,1), 1:N_xy(1,2)) = klodsclass(l_0, l_p, k_x, k_y, k_p);


% giver en positions vektor til hvert object, basseret p? dets position,
% samt en friktionskraft til hver klods
for i = 1:size(objarray,1)
    
    for m = 1:size(objarray,2)
        objarray(i,m).pos = [l_0 * m, l_0 * (size(objarray,1)+1-i)];
        objarray(i,m).frik = 1 + normrnd(0,1) * 0.05;
    end
    
end


%% Find ustabile klodser 
[x,y] = size(objarray);
for i=(1:x)
    for m=(1:y)
        i_op = i-1;
        i_ned = i+1;
        m_v = m-1;
        m_h = m+1;
        
%       If statements til perriodic boundary conditions
        if(i == 1)
            i_op = x;
            F_o = objarray(i,m).fjedero(1,2) * (objarray(i_op,m).pos - (objarray(i,m).pos - [0,x*l_0]));
            F_n = objarray(i,m).fjedern(1,2) * (objarray(i_ned,m).pos - objarray(i,m).pos);
            
        elseif(i == x)
            i_ned = 1;
            F_n = objarray(i,m).fjedern(1,2) * (objarray(i_ned,m).pos - (objarray(i,m).pos + [0,x*l_0]));
            F_o = objarray(i,m).fjedero(1,2) * (objarray(i_op,m).pos - objarray(i,m).pos);   
        elseif(i~=1 && i~=x)
            F_n = objarray(i,m).fjedern(1,2) * (objarray(i_ned,m).pos - objarray(i,m).pos);
            F_o = objarray(i,m).fjedero(1,2) * (objarray(i_op,m).pos - objarray(i,m).pos);   
        end
        
                    
        if(m == 1)
            m_v = y;
            F_v = objarray(i,m).fjederv(1,2) * (objarray(i,m_v).pos - (objarray(i,m).pos + [y*l_0,0]));
            F_h = objarray(i,m).fjederh(1,2) * (objarray(i,m_h).pos - objarray(i,m).pos);
            
        elseif(m == y) 
            m_h = 1;
            F_h = objarray(i,m).fjederh(1,2) * (objarray(i,m_h).pos - (objarray(i,m).pos - [y*l_0,0]));
            F_v = objarray(i,m).fjederv(1,2) * (objarray(i,m_v).pos - objarray(i,m).pos);
        elseif(m~=1 && m~=y)
            F_h = objarray(i,m).fjederh(1,2) * (objarray(i,m_h).pos - objarray(i,m).pos);
            F_v = objarray(i,m).fjederv(1,2) * (objarray(i,m_v).pos - objarray(i,m).pos);
        end
 
        objarray(i,m).F_hori = objarray(i,m).k_p * objarray(i,m).l_p...
            + F_v + F_h + F_n + F_o;
        
        if(norm(objarray(i,m).F_hori) > objarray(i,m).frik)
            objarray(i,m).stable = false;
            
        else
            objarray(i,m).stable = true;
        end
            
        
        
        
        if(objarray(i,m).stable == false)
            while(norm(objarray(i,m).F_hori) > alpha*objarray(i,m).frik)
                objarray(i,m).dpos = objarray(i,m).F_hori*0.1*(norm(objarray(i,m).F_hori) - alpha*objarray(i,m).frik);
                objarray(i,m).pos = objarray(i,m).pos + objarray(i,m).dpos;
                Etot = Etot + (norm(objarray(i,m).dpos)*objarray(i,m).frik);
                if(i == 1)
                    i_op = x;
                    F_o = objarray(i,m).fjedero(1,2) * (objarray(i_op,m).pos - (objarray(i,m).pos - [0,x*l_0]));
                    F_n = objarray(i,m).fjedern(1,2) * (objarray(i_ned,m).pos - objarray(i,m).pos);
            
                elseif(i == x)
                    i_ned = 1;
                    F_n = objarray(i,m).fjedern(1,2) * (objarray(i_ned,m).pos - (objarray(i,m).pos + [0,x*l_0]));
                    F_o = objarray(i,m).fjedero(1,2) * (objarray(i_op,m).pos - objarray(i,m).pos);   
                elseif(i~=1 && i~=x)
                    F_n = objarray(i,m).fjedern(1,2) * (objarray(i_ned,m).pos - objarray(i,m).pos);
                    F_o = objarray(i,m).fjedero(1,2) * (objarray(i_op,m).pos - objarray(i,m).pos);   
                end

                if(m == 1)
                    m_v = y;
                    F_v = objarray(i,m).fjederv(1,2) * (objarray(i,m_v).pos - (objarray(i,m).pos + [y*l_0,0]));
                    F_h = objarray(i,m).fjederh(1,2) * (objarray(i,m_h).pos - objarray(i,m).pos);

                elseif(m == y) 
                    m_h = 1;
                    F_h = objarray(i,m).fjederh(1,2) * (objarray(i,m_h).pos - (objarray(i,m).pos - [y*l_0,0]));
                    F_v = objarray(i,m).fjederv(1,2) * (objarray(i,m_v).pos - objarray(i,m).pos);
                elseif(m~=1 && m~=y)
                    F_h = objarray(i,m).fjederh(1,2) * (objarray(i,m_h).pos - objarray(i,m).pos);
                    F_v = objarray(i,m).fjederv(1,2) * (objarray(i,m_v).pos - objarray(i,m).pos);
                end

                objarray(i,m).F_hori = objarray(i,m).k_p * objarray(i,m).l_p...
                    + F_v + F_h + F_n + F_o;
                           
                if(norm(objarray(i,m).F_hori) <= alpha*objarray(i,m).frik+0.01)
                    objarray(i,m).stable = true;
                    objarray(i,m).flyttet = true;
                    objarray(i,m).L = true;
                    klodsamount = klodsamount + 1;
                    
                    break
                end        
            
            end
            
                    
        end
                
    end
end
L = [objarray.L];

%%

