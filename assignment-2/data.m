function y = data(N, P, w_teacher)
y = randn(P,N);
bias_vector = ones(P,1);
y = [y bias_vector]; %P by N+1
output_vector = sign(y*w_teacher); % P by 1
y = [y output_vector];
end
