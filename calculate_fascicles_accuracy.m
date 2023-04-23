function [accuracy,tot] = calculate_fascicles_accuracy(predicted_values, true_values)
global coord correspondences
tot =0;
[theta, rho] = cart2pol(coord(:,1), coord(:,2));
polar = [theta,rho];

fourth  =  polar(((polar(:,1) >= -1.0472) & (polar(:,1) <= 0)) & polar(:,2) >= 0.000200000000000000, :);
first  =  polar(polar(:,2) <= 0.000150000000000000, :);
second  =  polar(((polar(:,1) > 0) & (polar(:,1) <= 2.094395102393196)) & polar(:,2) >= 0.000200000000000000, :);
third  =  polar(((polar(:,1) == 3.141592653589793) | (polar(:,1) <= -2.094395102393196)) & polar(:,2) >= 0.000200000000000000, :);
[first(:,1), first(:,2)] = pol2cart(first(:,1), first(:,2));
for i=1:size(first,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
    if abs(first(i,1))<1e-15
        first(i,1)=0;
    end
    if abs(first(i,2))<1e-15
        first(i,2)=0;
    end
end

[second(:,1), second(:,2)] = pol2cart(second(:,1), second(:,2));
for i=1:size(second,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
    if abs(second(i,1))<1e-15
        second(i,1)=0;
    end
    if abs(second(i,2))<1e-15
        second(i,2)=0;
    end
end

[third(:,1), third(:,2)] = pol2cart(third(:,1), third(:,2));
for i=1:size(third,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
    if abs(third(i,1))<1e-15
        third(i,1)=0;
    end
    if abs(third(i,2))<1e-15
        third(i,2)=0;
    end
end

[fourth(:,1), fourth(:,2)] = pol2cart(fourth(:,1), fourth(:,2));
for i=1:size(fourth,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
    if abs(fourth(i,1))<1e-15
        fourth(i,1)=0;
    end
    if abs(fourth(i,2))<1e-15
        fourth(i,2)=0;
    end
end

fourth(:,3) = correspondences(find(((polar(:,1) >= -1.0472) & (polar(:,1) <= 0)) & polar(:,2) >= 0.000200000000000000));
second(:,3) = correspondences(find(((polar(:,1) > 0) & (polar(:,1) <= 2.094395102393196)) & polar(:,2) >= 0.000200000000000000));
third(:,3) = correspondences(find(((polar(:,1) == 3.141592653589793) | (polar(:,1) <= -2.094395102393196)) & polar(:,2) >= 0.000200000000000000));
first(:,3) = correspondences(find(polar(:,2) <= 0.000150000000000000));

for k =1:size(predicted_values,1)
    switch size(predicted_values,2)
        case 1

            if all(ismember([true_values(k), predicted_values(k)], second(:,3))) == 1
                tot = tot+1;

            elseif all(ismember([true_values(k), predicted_values(k)], first(:,3))) == 1
                tot = tot+1;

            elseif all(ismember([true_values(k), predicted_values(k)], third(:,3))) == 1
                tot = tot+1;


            elseif all(ismember([true_values(k), predicted_values(k)], fourth(:,3))) == 1
                tot = tot+1;

            end

        case 2


            for j = 1:size(predicted_values,2)
                if ismember(predicted_values(k,j), second(:,3)) == 1
                    zones_pred(k,j)= 2;

                elseif ismember(predicted_values(k,j), first(:,3)) == 1
                    zones_pred(k,j)= 1;

                elseif ismember(predicted_values(k,j), third(:,3)) == 1
                    zones_pred(k,j)= 3;


                elseif ismember(predicted_values(k,j), fourth(:,3)) == 1
                    zones_pred(k,j)= 4;

                end

                if ismember(true_values(k,j), second(:,3)) == 1
                    zones_true(k,j)= 2;

                elseif ismember(true_values(k,j), first(:,3)) == 1
                    zones_true(k,j)= 1;

                elseif ismember(true_values(k,j), third(:,3)) == 1
                    zones_true(k,j)= 3;


                elseif ismember(true_values(k,j), fourth(:,3)) == 1
                    zones_true(k,j)= 4;

                end


            end
            
            if isequal(unique(zones_true(k,:)), unique(zones_pred(k,:)))
                tot = tot+1;
            end

        case 3

            for j = 1:size(predicted_values,2)
                if ismember(predicted_values(k,j), second(:,3)) == 1
                    zones_pred(k,j)= 2;

                elseif ismember(predicted_values(k,j), first(:,3)) == 1
                    zones_pred(k,j)= 1;

                elseif ismember(predicted_values(k,j), third(:,3)) == 1
                    zones_pred(k,j)= 3;


                elseif ismember(predicted_values(k,j), fourth(:,3)) == 1
                    zones_pred(k,j)= 4;

                end

                if ismember(true_values(k,j), second(:,3)) == 1
                    zones_true(k,j)= 2;

                elseif ismember(true_values(k,j), first(:,3)) == 1
                    zones_true(k,j)= 1;

                elseif ismember(true_values(k,j), third(:,3)) == 1
                    zones_true(k,j)= 3;


                elseif ismember(true_values(k,j), fourth(:,3)) == 1
                    zones_true(k,j)= 4;

                end


            end
            
            if isequal(unique(zones_true(k,:)), unique(zones_pred(k,:)))
                tot = tot+1;
            end
    end
end



accuracy = tot/size(predicted_values,1);
%disp(accuracy)




end