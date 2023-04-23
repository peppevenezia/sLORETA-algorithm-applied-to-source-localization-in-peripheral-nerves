function lambdaout = CVE_modified1(Test, leadfield,algorithm, n, geometry)
global number_of_electrodes number_of_slices number_of_slice_sources percentage_noise

%c = cvpartition(size(combinations,1),'Leaveout');
lambda_range = logspace(3,8, 20);
tot = zeros(1,size(Test,2));

%crossval = zeros(length(lambda_range), 2);
cv1 = cvpartition(Test{1}, 'Kfold', n);
%cv2 = cvpartition(size(Test{2},1), 'Kfold', n);
%cv3 = cvpartition(size(Test{3},1), 'Kfold', n);
crossvalacc = [];




for q = 1:cv1.NumTestSets


    for w= 1:1%size(Test,2)
        true_values = Test{w};
        switch w
            case 1
                cv = cv1;
            case 2
                cv = cv2;
            case 3
                cv = cv3;
        end

        trainindex = training(cv,q);
        trainingset = true_values(trainindex,:);

        for i = 1:length(lambda_range)
            lambda = lambda_range(i);


            predicted_values = zeros([size(trainingset,1), size(trainingset,2)]);

            for s = 1:size(trainingset,1)
                try
                    predicted_values(s,:) = estimate(trainingset(s,:),geometry, leadfield, algorithm,lambda,'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','no', 'no', 'no');
                catch
                    predicted_values(s,:) = estimate(trainingset(s,:),geometry, leadfield, algorithm,lambda,'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','no', 'no', 'no');
                end
            end

            switch geometry
                case 'complex'
                    [~,tot(w,i)] = calculate_fascicles_accuracy(predicted_values, trainingset);
                    %[~,tot(w)] = calculate_accuracy_pointwise(predicted_values, true_values);


                case 'simple'
                    [~,tot(w,i)] = calculate_accuracy_pointwise(predicted_values, trainingset);

            end


        end

    end

    crossval = sum(tot,1)/(cv1.TrainSize(q));
    tot = [];
    lambdas = lambda_range(find(crossval == max(crossval)));

    if size(lambdas,2) > 1
        lambdafin(q) = mean(lambdas,2);
    else
        lambdafin(q) = lambdas;
    end
    %crossvaltrain(q) = crossval(find(crossval == max(crossval)));


    for w= 1:1%size(Test,2)
        true_values = Test{w};
        switch w
            case 1
                cv = cv1;
            case 2
                cv = cv2;
            case 3
                cv = cv3;
        end
        testindex = test(cv, q);
        testset = true_values(testindex,:);

        predicted_values = zeros([size(testset,1), size(testset,2)]);

        for a = 1:size(testset,1)
            try
                predicted_values(a,:) = estimate(testset(a,:),geometry, leadfield, algorithm,lambdafin(q),'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','no', 'no', 'no');
            catch
                predicted_values(a,:) = estimate(testset(a,:),geometry, leadfield, algorithm,lambdafin(q),'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','no', 'no', 'no');
            end
        end

        switch geometry
            case 'complex'
                [~,tot(w,q)] = calculate_fascicles_accuracy(predicted_values, testset);
                %[~,tot(w)] = calculate_accuracy_pointwise(predicted_values, true_values);


            case 'simple'
                [~,tot(w,q)] = calculate_accuracy_pointwise(predicted_values, testset);

        end

    end


    crossvaltest(q) = sum(tot(:,q),1)/(cv1.TestSize(q));

end

lambdaout = lambdafin(find(crossvaltest == max(crossvaltest)));

end
