for epoch = 1:n_max
    if success == 0
        count = 0
        for t = 1:P
            data_point = D(t,:)
            error = dot(w, data_point(1:N+1))*data_point(length(data_point))
            if error <= 0
                for weight = 1:length(w)
                   w(weight) = w(weight)+((1/(N+1))*data_point(weight)*data_point(length(data_point)))
                end
            else
                count = count + 1
            end
        end
        if count == P
            success = 1
        end
    end
end