function [accuracy,tot] = calculate_accuracy_neighbors(predicted_values, true_values)
global coord correspondences
tot =0;

true_values = sort(true_values,2);

for i = 1: size(predicted_values,1)
    first = 0;
    second =0;
    for h =1:size(predicted_values,2)

        dist = sqrt((coord(:,1)-coord(find(correspondences == true_values(i,h)),1)).^2 + (coord(:,2)-coord(find(correspondences == true_values(i,h)),2)).^2);
        n = 7;
        [~, ascendIdx] = sort(dist);
        %ascendIdx(ascendIdx==find(correspondences == predicted_values(i))) = [];
        %xyNearest = coord(ascendIdx(1:n),:);

        switch size(predicted_values,2)
            case 1
                if ismember(find(correspondences == predicted_values(i)), ascendIdx(1:n))
                    tot = tot+1;
                end
            case 2
                if ismember(find(correspondences == predicted_values(i, 1)), ascendIdx(1:n)) && first ==0
                    first= 1;
                elseif ismember(find(correspondences == predicted_values(i, 2)), ascendIdx(1:n)) && second == 0
                    second = 1;
                end

                if (first == second) && (first ==1)
                    tot = tot+1;
                end


        end

    end


end


accuracy = tot/length(predicted_values);
%disp(accuracy)


end

