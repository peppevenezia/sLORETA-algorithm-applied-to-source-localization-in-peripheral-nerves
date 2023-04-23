function j = find_sources_slices_together(signals,leadfield, noise, wmatrix,  lambda)
number_of_time_istants = size(signals,1);
number_of_total_sources = size(leadfield,2);
switch wmatrix
    case 'wmn'
        wmn = compute_wmn(leadfield);
        %wmn = inv(wmn);
        for i = 1:number_of_time_istants
               temp = Tikhonov_regularization(signals(i,:), leadfield, wmn, lambda, cov(noise(i,:)));
               %temp = Tikhonov_regularization_new(signals(i,:), leadfield, lambda);
               j(:,i) = temp;
        end
    case 'loreta'
        wmn = compute_wmn(leadfield);
        loreta = imfilter(wmn, fspecial('laplacian'));
         for i = 1:number_of_time_istants
               temp = Tikhonov_regularization(signals(i,:), leadfield, loreta, lambda, cov(noise(i,:)));
               j(:,i) = temp;
        end
    case 'I'
        for i = 1:number_of_time_istants
               temp = Tikhonov_regularization(signals(i,:), leadfield, eye(number_of_total_sources,number_of_total_sources), lambda, cov(noise(i,:)));
               j(:,i) = temp;
        end
    
end


end
