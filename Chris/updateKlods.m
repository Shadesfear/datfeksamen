function updateKlods(i,o)
global kloddser kp;
k = kp;
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
kloddser(i,o).b = kloddser(i,o).b+kloddser(i,o).deltadelta;
        
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

