classdef kasse
    properties
        position;
        frik = variation(1,5)
        lp = 0; 
        l0 = 1;
        kp = 1; 
        kpp = 1; 
        km = 1; 
        a = 0.75; 
    end
    methods
        function obj = kasse()
            obj.position = 0;       
        end
        
        function m = shouldMove()
            if (fhor > obj.frik)
                m = true;
            else
                m = false;
            end
        end
        
        function deltab = move()
            deltab = (obj.a*obj.frik-obj.lp*obj.lp-obj.kpp*lplus+obj.km*lminus)/(obj.kp+obj.kpp+obj.km);
            obj.position = obj.position+deltab;
        end

        function y = yank()
            
        end
    end
end