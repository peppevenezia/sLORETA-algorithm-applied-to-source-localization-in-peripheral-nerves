function calculate_trials_accuracy(Test,n,algorithm, accuracy_type, geometry, leadfield, lambda)
global number_of_electrodes number_of_slices number_of_slice_sources percentage_noise
 
for h = 1:n
    for w= 1:1%size(Test,2)
        true_values = Test{w};
        %predicted_values = zeros([size(Test{w},1), size(Test{w},2)]);
        for i = 1:size(true_values,1)
            try
                predicted_values(i,:) = estimate(true_values(i,:),geometry, leadfield, algorithm,lambda,'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','no', 'no', 'no');

            catch
                predicted_values(i,:) = estimate(true_values(i,:),geometry, leadfield, algorithm,lambda,'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','no', 'no', 'no');

            end
        end

        switch accuracy_type
            case 'fascicle'
                [~,tot(w)] = calculate_fascicles_accuracy(predicted_values, true_values);
            case 'pointwise'
                [~,tot(w)] = calculate_accuracy_pointwise(predicted_values, true_values);
            case 'area'
                acc(h) = calculate_area_accuracy(predicted_values, true_values);
            case 'neighbors'
                [~,tot(w)] = calculate_accuracy_neighbors(predicted_values, true_values);
        end
                

    end

   acc(h) = sum(tot)/(size(Test{1},1));
%     avmiss(h) = sum(missed);
%     avsp(h) = sum(missed);


end

meanacc = mean(acc);
disp("The average accuracy is:"+meanacc)
stdacc = std(acc);
disp("The standard deviation of the accuracy is:"+stdacc)
maxacc = max(acc);
disp("The maximum accuracy is:"+maxacc)
minacc = min(acc);
disp("The minimum accuracy is:"+minacc)
% meanmiss = mean(avmiss);
% disp("The average number of missed pathways is:"+meanacc)
% stdmiss = std(avmiss);
% disp("The standard deviation of missed pathways is:"+stdacc)
% meansp = mean(avsp);
% disp("The average number of spourious pathways is:"+meanacc)
% stdsp = std(avsp);
% disp("The standard deviation of spourious pathways is:"+stdacc)



end