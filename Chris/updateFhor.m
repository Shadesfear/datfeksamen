function updateFhor()
global kloddser;
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
kp = 1;
k = kp;
[N ,M] = size(kloddser);

for i = 2:N-1
    for o = 2:M-1
        %Finder her fhor
        %kloddser(i,o).deltadelta = [kloddser(i,o).deltax, kloddser(i,o).deltay];
        kloddser(i,o).b =kloddser(i,o).b+kloddser(i,o).deltadelta ;
        
        kloddser(i,o).fhor = kp*kloddser(i,o).lp...
        + k*(kloddser(i,o-1).b - k*(kloddser(i,o).b))...
        + k*(kloddser(i,o+1).b - k*(kloddser(i,o).b))...
        + k*(kloddser(i-1,o).b - k*(kloddser(i,o).b))... 
        + k*(kloddser(i+1,o).b - k*(kloddser(i,o).b));
        
        if (norm(kloddser(i,o).fhor) > kloddser(i,o).frik) 
            kloddser(i,o).isUnstable = true;
        else
            kloddser(i,o).isUnstable = false;
        end
    end
end
%outputArg1 = kloddser;

end

