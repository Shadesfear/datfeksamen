function [delta] = flytKlods()
    
    delta = -(a*frik - kp*lpb - kplus*lplus + kminus*lminus)/(kp + kplus + kminus);

    
end

