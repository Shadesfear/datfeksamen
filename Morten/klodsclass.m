classdef klodsclass
    properties
       fjederv = [];
       fjederh = [];
       fjedero = [];
       fjedern = [];
       frik;
       k_p;
       l_p = [0,0];
       pos = [];
       dpos = [0,0];
       dplade = [0,0];
       F_hori = [0,0];
       stable;
       flyttet = false;
       Econt = 0;
       L;
       
    end
    
    methods
        function obj = klodsclass(l_0, l_p, kx, ky, k_p)
            obj.fjederv = [l_0, kx];
            obj.fjederh = [l_0, kx];
            obj.fjedero = [l_0, ky];
            obj.fjedern = [l_0, ky];
            obj.k_p = k_p;
            obj.l_p = l_p;
        end
        
            
%         function kraft = stable2d(oa)
%             
%             [x,y] = size(oa);
%             kraft = zeros(x,y);
%             size(kraft)
%             for i=(1:x)
%                 for m=(1:y)
%                     i_op = i-1;
%                     i_ned = i+1;
%                     m_v = m-1;
%                     m_h = m+1;
%                     objee = oa(i,m);
%                     
%                     if(i == 1)
%                        i_op = x;
%                        
%                     elseif(i == x)
%                         i_ned = 1;
%                     end
%                     
%                     if(m == 1)
%                         m_v = y;
%                         
%                     elseif(m == y) 
%                         m_h = 1;
%                         
%                     end
%                     
% 
%                     kraft = oa(i,m).k_p * oa(i,m).l_p...
%                         + oa(i,m).fjederv(1,2) * (oa(i,m_v).pos - oa(i,m).pos)...
%                         + oa(i,m).fjederh(1,2) * (oa(i,m_h).pos - oa(i,m).pos)...
%                         + oa(i,m).fjedern(1,2) * (oa(i_ned,m).pos - oa(i,m).pos)...
%                         + oa(i,m).fjedero(1,2) * (oa(i_op,m).pos - oa(i,m).pos);
%                     disp(kraft(i,m))
%                 end
%                 
%             end
            
        end
            
            
                                             
%    end
end