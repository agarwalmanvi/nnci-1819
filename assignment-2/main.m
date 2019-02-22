N = 8; % dimensions of input
alpha = 0.25;
alpha_growth = 0.25;
alpha_steps = 12;
P = N*alpha; % number of input vectors
n_max = 300; % max number of epochs to complete training
w_teacher = ones(N+1,1); % N+1 by 1
% test for 10, 50, 100, 200 datasets
n_d_list=[10 50 100 200]

for num=1:4
    n_d = n_d_list(1,num)
    % obtain an average value of the generalisation error over different
    % alpha
    avrErPerAlpha =[];
     for i=1:alpha_steps
        alpha= alpha+alpha_growth;
        P = N*alpha;
        genErrVector=[];
        for num=1:n_d
            % Initialization
            D = data(N,P, w_teacher); % P by N+2 matrix
            w = zeros(1,N+1);
            for epoch = 1:n_max
                stabilities = [];
                for t = 1:P
                    data_point = D(t,:);
                    stability = dot(w, data_point(1:N+1))*data_point(length(data_point))/norm(w);
                    stabilities = [stabilities stability];
                end
                [min_value,min_index] = min(stabilities);
                min_stability_data_point = D(min_index,:);
                vector_1 = w;
                w = w + ((1/N+1)*min_stability_data_point(1:N+1)*min_stability_data_point(length(min_stability_data_point)));
                vector_2 = w;
                angle = rad2deg(acos(dot(vector_1,vector_2)/dot(norm(vector_1),norm(vector_2))));
                if angle < 2
                    disp("YAY")
                    break 
                end
            end

            genErr = 1/pi*acos(dot(vector_2, w_teacher)/(norm(vector_2)*norm(w_teacher)));
            genErrVector= [genErrVector genErr];
        end
        avrErPerAlpha = [avrErPerAlpha transpose([alpha, mean(genErrVector)])]
        mgeer=mean(genErrVector)

     end
     plot(avrErPerAlpha(1,:),avrErPerAlpha(2,:),'LineWidth',1.5)
     hold on
end
xlabel("\alpha = P/N")
%not sure if this ylabel works!
ylabel("\epsilon_max")
lgd = legend("10","50","100","500")
title(lgd,'Value of n_d')
hold off

