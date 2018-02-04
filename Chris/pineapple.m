clear; clc; close all;
N=10;
M=10;
global kloddser energy;
kloddser = struct;
l_0 = 1; %variation(1,5);
Lprime ={};
global kp;
kp = 1;
k = 1;
a = 0.75;
antalSkaelv = 0;
energy = 0;
deltap = 0;
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
        kloddser(i,o).isMoves = false;
        kloddser(i,o).kx = k;
        kloddser(i,o).ky = k;
        kloddser(i,o).ii  = i;
        kloddser(i,o).oo  = o;
        kloddser(i,o).deltax = 0;
        kloddser(i,o).deltay = 0;
        kloddser(i,o).delta  = [];
        kloddser(i,o).deltap = 0;
        kloddser(i,o).b = [kloddser(i,o).xpos,kloddser(i,o).ypos];
        kloddser(i,o).deltadelta = 0;%[kloddser(i,o).deltax, kloddser(i,o).deltay];
        kloddser(i,o).lp = [0,0];
            
        if (i == 1 || i == N)
            kloddser(i,o).fhor = 0;
            
        elseif (o == 1 || o == N)
            kloddser(i,o).fhor = 0;
        
        else
            %De steder med + virker koden ikke
            %jeg forst?r ikke hvorfor 
                
        end
    end
end
%%
% valuesfore = [kloddser.b];
% 
% figure(1)
% plot(valuesfore(1:2:200), valuesfore(2:2:200), '*')
%%

updateFhor();



%kloddser(4,4).fhor = [3,2];
%kloddser(2,4).fhor = [0.0];
kloddser(4,4).lp = [3.9,-3.3];
updateFhor();
L2  = tjekKlodser();
%updateFhor();


while(~isempty(L2) || ~isempty(Lprime))
    
    if (isempty(L2) && ~isempty(Lprime))
        %Er l tom og l' ikke tom
        L2 = Lprime;
        Lprime = [];
    end

    if (~isempty(L2))
        %Er der klodser tilbage i l?
        for i = 1:length(L2)
            %Tag n?ste klods i l

            if (isa(kloddser(L2{i}(1)+1 , L2{i}(2)),'struct')) %Tjekker for existens > 
                %Tjek naboer

                if(kloddser(L2{i}(1)+1 , L2{i}(2)).isUnstable && kloddser(L2{i}(1)+1,L2{i}(2)).isMoves == false)
                    %disp('WE ARE UNSTABLE')
                    flytKlods(L2{i}(1)+1, L2{i}(2))
                    updateFhor()
                    Lprime{end + 1} = [kloddser(L2{i}(1)+1,L2{i}(2)).ii,kloddser(L2{i}(1)+1,L2{i}(2)).oo];
                end

            end

            if (isa(kloddser(L2{i}(1)-1 , L2{i}(2)),'struct')) %Tjekker for existens < 

                if(kloddser(L2{i}(1)-1 , L2{i}(2)).isUnstable && kloddser(L2{i}(1)-1 , L2{i}(2)).isMoves == false)
                    flytKlods(L2{i}(1)-1, L2{i}(2))
                    updateFhor()
                    Lprime{end + 1} = [kloddser(L2{i}(1)-1,L2{i}(2)).ii,kloddser(L2{i}(1)-1,L2{i}(2)).oo];
                end

            end

            if (isa(kloddser(L2{i}(1) , L2{i}(2)+1),'struct')) %Tjekker for existens ^

                if(kloddser(L2{i}(1) , L2{i}(2)+1).isUnstable && kloddser(L2{i}(1) , L2{i}(2)+1).isMoves == false)
                    flytKlods(L2{i}(1), L2{i}(2)+1)
                    updateFhor()
                    Lprime{end + 1} = [kloddser(L2{i}(1) , L2{i}(2)+1).ii,kloddser(L2{i}(1) , L2{i}(2)+1).oo];
                end

            end

            if (isa(kloddser(L2{i}(1) , L2{i}(2)-1),'struct')) %Tjekker for existens v

                if(kloddser(L2{i}(1) , L2{i}(2)-1).isUnstable && kloddser(L2{i}(1) , L2{i}(2)-1).isMoves ==false)
                    flytKlods(L2{i}(1) , L2{i}(2)-1)
                    updateFhor()
                    Lprime{end + 1} = [kloddser(L2{i}(1) , L2{i}(2)-1).ii,kloddser(L2{i}(1) , L2{i}(2)-1).oo];
                end 

            end  

        end
        L2 = {};
    end
end

for i = 1:N
    for o = 1:M
        if (kloddser(i,o).isMoves == true)
            antalSkaelv = antalSkaelv + 1;
        end
    end
end
%%
% valuesfore2 = [kloddser.b];
% 
% figure(2)
% plot(valuesfore2(1:2:200), valuesfore2(2:2:200), '*')
