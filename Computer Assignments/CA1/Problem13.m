%In this part we shall simulate a memoryless source and its CodingEfficiency.
%Here we define the sources and their respective probabilities.
X = [1 , 2 , 3 ];
Pr_X = [ 0.7 , 0.29 , 0.01 ] ;
X2 = [11 , 12 ,13 , 21 , 22 , 23, 31 , 32 , 33 ];
Pr_X2 = [0.49 0.203 0.007 0.203 0.0841 0.0029 0.007 0.0029 0.0001];
X3 = [111,112,113,121,122,123,131,132,133,211,212,213,221,222,223,231,232,233,...
    311,312,313,321,322,323,331,332,333];

Pr_X3 = [(0.343) (0.203*0.7) (0.49*0.01) (0.203*0.7) (0.0841*0.7) (0.007*0.29) (0.007*0.7)...
    (0.007*0.29) (0.0001*0.7) (0.203*0.7) (0.0841*0.7) (0.007*0.29) (0.0841*0.7) (0.024389) (0.0841*0.01)...
    (0.007*0.29) (0.0841*0.01) (0.0001*0.29) (0.007*0.7) (0.007*0.29) (0.0001*0.7) (0.007*0.29) (0.0841*0.01)...
    (0.29*0.0001) (0.0001*0.7) (0.0001*0.29) (0.000001)];
%Now we calculate the entropies for each source.
HX=0;
HX2=0;
HX3=0;
for i = 1:length(Pr_X)
        HX = HX + ( -1 * ( Pr_X(i) * log2(Pr_X(i))));
end
for i = 1:length(Pr_X2)
        HX2 = HX2 + ( -1 * ( Pr_X2(i) * log2(Pr_X2(i))));
end
for i = 1:length(Pr_X3)
        HX3 = HX3 + ( -1 * ( Pr_X3(i) * log2(Pr_X3(i))));
end   
Harr=[HX HX2 HX3];
%Now we calculate the average length.
[~,Avglen1] = huffmandict(X,Pr_X); 
[~,Avglen2] = huffmandict(X2,Pr_X2); 
[~,Avglen3] = huffmandict(X3,Pr_X3);
%We now move on to calculating G and the coding efficiency.
k=1:10;
Avglen1=k*Avglen1;
Avglen2=k*Avglen2;
Avglen3=k*Avglen3;
AvglenArr=[Avglen1;Avglen2;Avglen3];
CodingEfficiency=zeros(3,length(k));
GMat=zeros(3,length(k));
for i =1:3
    for j =1:length(k)
        GMat(i,j)=Harr(1,i)*((j+1)/j);
        CodingEfficiency(i,j)=(j*Harr(i))/(AvglenArr(i,j));
    end
end
%Now we go on to plot the required graphs.
figure(1);
plot(k,GMat(1,:) , 'r' );
hold on ;
plot(k,Avglen1 , 'g');
title('G & Avg Length for X');
legend('Gk','Avg Length');
grid on;

figure(2);
plot(k,GMat(2,:) , 'r' );
hold on ;
plot(k,Avglen2 , 'g');
title('G & Avg Length for  X^2');
legend('Gk','Avg Length');
grid on;

figure(3);
plot(k,GMat(3,:) , 'r' );
hold on;
plot(k,Avglen3 , 'g');
title('G & Avg Length for X^3');
legend('Gk','Avg Length');
grid on;
%Coding efficiency Graphs
figure(4);
plot(k,Harr(1)*ones(1,10) , 'r');
hold on;
plot(k,CodingEfficiency(1,:) , 'g');
title('Coding Efficiency & Entropy for X ');
legend('Entropy','Coding Efficiency');
grid on;

figure(5);
plot(k,Harr(2)*ones(1,10) , 'r');
hold on;
plot(k,CodingEfficiency(2,:) , 'g');
title('Coding Efficiency & Entropy for  X^2 ');
legend('Entropy','Coding Efficiency');
grid on;

figure(6);
plot(k,Harr(3)*ones(1,10) , 'r');
hold on;
plot(k,CodingEfficiency(3,:) , 'g');
title('Coding Efficiency & Entropy for X^3 ');
legend('Entropy','Code Efficiency');
grid on;



