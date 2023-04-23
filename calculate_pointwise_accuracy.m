function [accuracy,tot] = calculate_accuracy_pointwise(predicted_values, true_values)
tot =0;

for i=1:size(predicted_values,1)
    if isequal(unique(predicted_values(i,:)), unique(true_values(i,:)))
        tot = tot+1;
    end
   
end


accuracy = tot/length(predicted_values);
%disp(accuracy);

end
