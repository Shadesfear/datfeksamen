F0frik = variation(1,5); %Friktionskraft +- 5%
l_p = 0;
l_0 = variation(1,5);
k_p = variation(1,5);

a = 0.75; 

N = 1; 

e = 0.0001;
%% 

naboer = [1, 2, 3, 10 , -10 , -4, 2 , 3, 3, 2 ];
nb = sort(naboer);

nbb = nb(1);
i1=1; 
for i = 2:length(nb)   
    if nb(i1)~= nb(i)
        nbb=[nbb, nb(i)];
        i1=i;
    end
end