function [outputArg1] = tjekKlodser()
global kloddser;
%disp('Shiiet, vi tjekker klodser')

[x, y] = size(kloddser);
L = {};

for i = 1:x
    for o = 1:y 
        if (norm(kloddser(i,o).fhor) > kloddser(i,o).frik)
            kloddser(i,o).isUnstable = true;
            flytKlods(i, o)
            %Putter det ind i L
            L{end + 1} = [kloddser(i,o).ii, kloddser(i,o).oo];
        end
    end
end
outputArg1 = L;
%out2 = Ly;
%disp('Vi er sgu f?rdige med at tjekke klodser')
end

