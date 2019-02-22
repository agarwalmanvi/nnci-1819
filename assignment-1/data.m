function y = data(N, P)
y = randn(P,N);
output_vector = transpose(randsample([1,-1],P,true));
%bias_vector = ones(P,1);
%y = [y bias_vector output_vector];
y = [y output_vector];
end
