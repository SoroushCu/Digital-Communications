%In this section we shall implement the average_length.m function which
%calculates the average length of the huffman code given the chain and k.
function AvgLen = average_length(chain , k)
%Here we check to see if the chain is divisible by k and make the necessary
%changes
 chainmdk = mod(length(chain),k);
 len = length(chain) - chainmdk;
 main_chain = zeros(1, len);
 %In the following loop we fill the modified chain in a new one.
    for i = 1:( length(chain) - chainmdk )
         main_chain(1,i) = chain(1,i);
    end
%Here we modify the shape of the chain into a somewhat matrician form in
%which each line has k elements in it.
Modified_chain = reshape(main_chain, [k length(main_chain)/k]);
chain_symbol = zeros(1,( length(main_chain)/k ));
sum = 0;
%Here we shall assing the Symbols to our k-bit sequences.(In the first loop
%we iterate over the columns)
for i = 1 :length(main_chain)/k
    TempforK = k;
    split_chain = Modified_chain(:,i);
%In this loop we assign values to each of the bits in the k-bit groups then
%we proceed to assign the sum of the values as the chain value.
    while TempforK > 0 
        for j = 1 : k
            sum = sum + split_chain(j,1)*10^(TempforK - 1); 
            TempforK = TempforK -1 ;
        end
    end
  %Here we save the sum value for each k-bit group
  chain_symbol(1,i) = sum ;
   sum = 0;
end
%Here we pull out the unique Symbols out, our goal is to calculate
%probability in due course.
Symbols = unique(chain_symbol);
%Here we count the occurence of the unique Symbols.
count = histc(chain_symbol, Symbols);
Symbols_Prob = zeros(1, length(Symbols));
for i = 1 : length(Symbols)
    Symbols_Prob(1,i) = (count(1, i) /( length(chain_symbol)) ) ;
end
 [~,AvgLen] = huffmandict(Symbols,Symbols_Prob) ;
end