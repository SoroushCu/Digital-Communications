%In this part we perform the wanted simulation for the given source.
%First we calculate P in the same manner which we performed in entropy.m
transition_states = [ 0.5 0.5 ; 0.8 0.2];
ts_t = transpose(transition_states);
ts_len = length(transition_states);
ts_t = ts_t - eye(ts_len);
tsforsolving = [ts_t ; ones(1 , ts_len)];
Y = [zeros(ts_len, 1) ;1];
P = linsolve(tsforsolving , Y);

% We then proceed to calculate the total entropy with the help of the state
% entropies(as also done analytically)
H1 = -0.5 * log2(0.5)-0.5 * log2(0.5);
H2 = -0.2 * log2(0.2) -0.8 * log2(0.8);
Htot=H1*P(1,1)+H2*P(2,1);
%Now we shall produce the symbols(10 million to be exact)
% This is our preliminary chain.
Chain=zeros(1,10e7);
%Now we can easily set the source current state as follows
Num=rand;
if(Num<P(1,1))
    Chain(1,1)=1;
else
    Chain(1,1)=2;
end
%in the following loop considering the diagram of our source we create our
%symbols accordingly.
for i = 1 :10e7
    TempNum  = rand;
    if ( Chain(1,i) == 1 )
        if( TempNum < transition_states(1,1))
            Chain(1,i+1) = 1 ;
        else
            Chain(1,i+1) = 2 ;
        end
    elseif ( Chain(1,i) == 2)
        if( TempNum < transition_states(2,2) ) 
            Chain(1,i+1) = 2 ;
        else
            Chain(1,i+1) = 1 ;
        end 
    end
end
%Now we move on to calculating the average length and HkHat accordingly.
k=1:10;
AvgLen = zeros(1,length(k));
HkHat = zeros(1, length(k));
 for i = 1:length(k)
    AvgLen(1,i) = average_length(Chain, i);
    HkHat(1,i) = AvgLen(1,i)/i;
end
%Now we calculate G_k.
GMat=zeros(1,length(k));
for j = 1 : length(k)
    
    [G_k,Hs1_0] = entropy(transition_states,j);
    GMat(1,j)=G_k;
end
%Now we shall calculate the code efficiency. we know that eff=H/HkHat
H = zeros(1,length(k));
CodingEfficiency=zeros(1,length(k));
for i = 1:length(k)
    H(1,i) = Hs1_0;
end
for i = 1:length(k)
    CodingEfficiency(1,i) = H(1,i)/HkHat(1,i);
end
%Now we continue to the plots in two figures.
figure(1);
plot(k,GMat, 'r');
hold on ;
plot(k,AvgLen,' g');
hold on ;
plot(k,HkHat,'b');
title('Avg Code Length & G');
legend('Gk','Avg Length','HkHat')
grid on;

figure(2)
plot(k,CodingEfficiency , 'r');
hold on ;
plot(k,H,'g');
hold on ;
plot(k, HkHat, 'b');
title('Coding Efficiency & Entropy ');
legend('Coding Efficiency','Entropy','HkHat')
grid on;

