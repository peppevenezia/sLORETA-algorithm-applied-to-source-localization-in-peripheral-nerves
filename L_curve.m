function best_lambda = L_curve(signals,leadfield,  noise, wmatrix)

lambda_range = logspace(-10,9, 50);


% Initialize arrays to store the residual norm and solution norm
residual_norm = zeros(length(lambda_range), 1);
solution_norm = zeros(length(lambda_range), 1);

% Loop over the range of lambda values
for i = 1:length(lambda_range)
    lambda = lambda_range(i);

    switch wmatrix
        case 'wmn'
            wmn = compute_wmn(leadfield);
            j_hat = find_sources_slices_together(signals, leadfield, noise, wmatrix,  lambda);
            residual_norm(i) = norm(leadfield*j_hat-signals'); %d should be the real values of the currents in the solution space
            solution_norm(i) = norm(j_hat);

        case 'loreta'
            wmn = compute_wmn(leadfield);
            loreta = imfilter(wmn, fspecial('laplacian'));
            j_hat = find_sources_slices_together(signals, leadfield, noise, wmatrix,  lambda );
            residual_norm(i) = norm(leadfield*j_hat-signals'); %d should be the real values of the currents in the solution space
            solution_norm(i) = norm(loreta*j_hat);
        case 'sloreta'
            j_hat = sLORETA(signals, leadfield, noise,  lambda );
            residual_norm(i) = norm(leadfield*j_hat-signals'); %d should be the real values of the currents in the solution space
            solution_norm(i) = norm(j_hat);
        case 'I'
            j_hat = find_sources_slices_together(signals, leadfield, noise, 'I',  lambda );
            residual_norm(i) = norm(leadfield*j_hat-signals'); %d should be the real values of the currents in the solution space
            solution_norm(i) = norm(j_hat);
    end
    
    % Compute the residual norm and solution norm
%     residual_norm(i) = norm(leadfield*j_hat-signals'); %d should be the real values of the currents in the solution space
%     solution_norm(i) = norm(j_hat);
end



% Plot the L-curve
figure;
loglog(residual_norm, solution_norm);
xlabel('Residual Norm');
ylabel('Solution Norm');
title('L-Curve for SLORETA and Tikhonov Regularization');


residual_norm = rescale(residual_norm);
solution_norm = rescale(solution_norm);

% Find the index of the corner of the L-curve
[~,index] = min(abs(residual_norm- solution_norm));

% Find the best lambda value
best_lambda = lambda_range(index);

end