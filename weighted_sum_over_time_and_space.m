function [sumtot, f, outcome] = weighted_sum_over_time_and_space(currentest, mode,geometry,  number_of_slices, number_of_slice_sources, axon_true, show)

%global norm

switch mode
    case 'sum'
        sumtot = 0;

        for i=0:(number_of_slices-1)
            Data = currentest((i*number_of_slice_sources+1):(number_of_slice_sources*(i+1)), :);
            Sum(:,i+1) = sum(abs(Data), 2);
            norm = vecnorm(Sum(:,i+1));
            sumtot = sumtot+Sum(:,i+1)./norm;
            %norm_mean((i*number_of_slice_sources+1):(number_of_slice_sources*(i+1)));
            %sumtot = sumtot+Sum(:,i+1)./norm(:,i+1);
        end
        switch show
            case 'yes'
                f = figure;
                title(extractAfter(inputname(1), "_"))
            otherwise
                f=0;
        end


        switch geometry
            case 'complex'
                 outcome = visualize_active_pathways_complex(sumtot, 'red',axon_true, show);
                 %outcome = visualize_peaks(sumtot, 'red',axon_true, show);
            case 'simple'
                outcome = visualize_active_pathways(sumtot, 'red',axon_true, show);
                %outcome = visualize_peaks(sumtot, 'red',axon_true, show);
        end

    case 'mean'
        sumtot =0;
        for i=0:(number_of_slices-1)
            Data = currentest((i*number_of_slice_sources+1):(number_of_slice_sources*(i+1)), :);
            media = mean(abs(Data), 2);
            sumtot = sumtot+media;
        end

        switch show
            case 'yes'
                f = figure;
                title(extractAfter(inputname(1), "_"))
            otherwise
                f=0;
        end

        switch geometry
            case 'complex'
                outcome = visualize_active_pathways_complex(sumtot, 'red',axon_true, show);
            case 'simple'
                outcome = visualize_active_pathways(sumtot, 'red',axon_true, show);
        end
end

end