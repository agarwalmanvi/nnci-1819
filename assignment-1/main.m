N = 20
alpha = 0.75
alpha_growth = 0.25
alpha_steps = 11
P = N*alpha
n_max = 500
n_d_list=[10 50 100 500]
n_d = 0

for num=1:4
    n_d = n_d_list(1,num)
    Q = [];
    alpha = 0.75;
    for i=1:alpha_steps
        alpha= alpha+alpha_growth;
        P = N*alpha;
        outcomes=[];

        for j=1:n_d
            D = data(N,P);
            outcomes=[outcomes perceptron(D,n_max)];
        end
        Q = [Q transpose([alpha, mean(outcomes), std(outcomes)])]
    end

    %errorbar(Q(1,:),Q(2,:),Q(3,:))
    plot(Q(1,:),Q(2,:),'LineWidth',1.5)
    hold on
end
xlabel("\alpha = P/N")
ylabel("Q_{l.s.} : proportion of successful runs")
lgd = legend("10","50","100","500")
title(lgd,'Value of n_d')
xlim([-inf 3])

hold off
% stairs(Q(1,:), Q(2,:))

