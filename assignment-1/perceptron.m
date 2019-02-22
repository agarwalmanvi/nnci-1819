function y = perceptron(D, n_max)
	success = 0;
	count = 0;

	[rown, coln]=size(D);
	P=rown;
	N=coln-1; %removes - 1 for the target output, keeps the weight of the bias in N

	w = zeros(1,N);

	for epoch = 1:n_max
		if success == 0
			count = 0;
			for t = 1:P
				data_point = D(t,:);
				error = dot(w, data_point(1:N))*data_point(length(data_point));
				if error <= 0
					for weight = 1:length(w)
					   w(weight) = w(weight)+((1/(N))*data_point(weight)*data_point(length(data_point)));
					end
				else
					count = count + 1;
				end
			end
			if count == P
				success = 1;
				y=1;
				return
			end
		end
	end
	y=0;
end
