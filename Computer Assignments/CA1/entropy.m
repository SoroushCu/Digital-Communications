%In this section we shall implement the entropy.m function which calculates
%G_k given k and Transition States matrix.
function [G_k,Hs1_0] = entropy(transition_states,k)
%In the first part we shall calcuate P as follows. note that the steps
%taken below are to add P1+P2+P3+...+Pk=1 to the equation then we shall
%find P with linsolve
ts_t = transpose(transition_states);
ts_len = length(transition_states);
ts_t = ts_t - eye(ts_len);
tsforsolving = [ts_t ; ones(1 , ts_len)];
Y = [zeros(ts_len, 1) ;1];
P = linsolve(tsforsolving , Y);
%Here we display P.
disp(P)
%In the next section we shall calculate
Hs0 = 0 ;
Hs1_0 = 0;
Temp = 0;
for i = 1:ts_len
    Hs0 = Hs0 + ( -1 * ( P(i) * log2(P(i)) ) ); 
end
%Here we calcule Hs1_0 with the help of nested loops.
for i = 1:ts_len
    Temp = 0;
    for j = 1:ts_len
        if(transition_states(i,j)==0)
            transition_states(i,j)=1;
        end
        Temp = Temp + ( -1 * ( transition_states(i,j) * log2(transition_states(i,j)) ) );
       
    end
    Hs1_0 = Hs1_0 + (Temp * P(i,1) );
end
disp(Hs1_0)
%In the end we calculate G_k
G_k =( Hs0 + (k) * Hs1_0 )*(1/k);
end

