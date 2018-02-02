clear; clc; close all;
N=10;
M=10;
kloddser = struct;
l_0 = variation(1,5);
%Definer 
for i = 1:N
    for o = 1:M
        kloddser(i,o)=struct;
    end
end
for i = 1:N
    for o = 1:M
        kloddser(i,o).ypos = l_0*i;
        kloddser(i,o).xpos = l_0*o;
        kloddser(i,o).frik = 1*(1+normrnd(0,1)*0.05);
        kloddser(i,o).isUnstable = false;
        kloddser(i,o).kx = 1;
        kloddser(i,o).ky = 1;
        kloddser(i,o).i = i;
        kloddser(i,o).o = o;
    end
end



%%
TjekKlodser()
%L returned

if (isempty(L) && ~isempty(Lprime))
    %Er l tom og l' ikke tom
    L = Lprime;
    Lprime [];
end

if (~isempty(L))
    %Er der klodser tilbage i l?
    
    for i = 1:length(L)
        %Tag n?ste klods i l
        
        if (L(i+1) > 0)
            %Tjek naboer
            
            if(isUnstable(L(i)+1) && notMoved(L(i)+1))

               delta=nyForskydning();

               L(i+1).position = L(i+1).position + delta 
               Lprime.append(L())

               updateEnergy()
            end

        elseif (L(i-1) > 0)
               delta=nyForskydning();

               L(i-1).position = L(i-1).position + delta 
               Lprime.append(L())

               updateEnergy()

       end  
    end
end

