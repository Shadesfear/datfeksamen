function flytKlods(first ,second)
    global kloddser energy
    %disp('FINDER NY POS!')
    %Vi skal finde delta, dette er sv?rt i 2 dim
    %Har ikke fundet en metode til det endnu hmm
    %if (kloddser(first,second).isMoves == true)
    %    delta = 0;
    %    updateFhor();
    %else
%    kloddser(first,second).deltax = 0.1*kloddser(first,second).fhor(1);
%    kloddser(first,second).deltay = 0.1*kloddser(first,second).fhor(2);
    while (norm(kloddser(first,second).fhor) >= 0.75*kloddser(first,second).frik+0.01)
    %while (kloddser(first,second).isUnstable)    
        kloddser(first,second).deltadelta...
            = 0.05*kloddser(first,second).fhor...
            *(norm(kloddser(first,second).fhor)...
            - 0.75*kloddser(first,second).frik);
        
        updateKlods(first,second);
        
        energy = energy + (norm(kloddser(first,second).deltadelta)...
            *norm(kloddser(first,second).frik));
        %disp(first+second)
    end
    kloddser(first,second).isMoves = true;
    updateFhor();
    %end
    
    %disp('F?rdig med at finde ny position!')
end

