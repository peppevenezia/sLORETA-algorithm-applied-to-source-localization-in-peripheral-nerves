function f = visualize_active_axons_slicewise(currents,mode,geometry, number_of_slices,number_of_slice_sources,axon_true,show, visualize_3D)


%z_slices = [0.02+0.0027777500000000003, 0.02+0.0022222, 0.02+0.00166665, 0.02+0.0011111, 0.02+5.5555E-4, 0.02, 0.02-5.5555E-4, 0.02-0.0011111, 0.02-0.00166665, 0.02-0.0022222, 0.02-0.0027777500000000003 ]';
switch show
    case 'yes'
        switch mode
            case 'sum'
                sumtot = 0;

                f = figure;
                sgtitle(extractAfter(inputname(1), "_"))
                for slice = 1:number_of_slices
                    subplot(3,3,slice)
                    summ = sum(abs(currents(((slice-1)*number_of_slice_sources+1):(number_of_slice_sources*slice),:)),2);
                    sumtot = sumtot+summ;

                    switch geometry
                        case 'complex'
                            visualize_active_pathways_complex(summ, 'red',axon_true, show);
                        case 'simple'
                            visualize_active_pathways(summ, 'red',axon_true, show);
                    end



                end

                if visualize_3D == 1
                    figure('Name', "3D Slice-wise results axon "+axon_true, 'NumberTitle','off' )
                    for slic = 1:number_of_slices
                        somma = sum(abs(currents(((slic-1)*number_of_slice_sources+1):(number_of_slice_sources*slic),:)),2);
                        [xa, ya] = circle_noplot(0,0,0.4*10^-3);
                        index = find(somma == max(somma));
                        %disp(index);
                        [xp, yp] = circle_noplot(coord(index,1), coord(index, 2), 0.05e-3);
                        [xt,yt] = circle_noplot(coord(find(correspondences == axon_true),1), coord(find(correspondences == axon_true), 2), 0.05e-3);
                        hold on
                        grid on
                        plot3(xa, ya, z_slices(slic)*2*ones(size(xa,2),1), 'Color', 'b')
                        plot3(xp, yp, z_slices(slic)*2*ones(size(xp,2),1), 'Color', 'r')
                        plot3(xt, yt, z_slices(slic)*2*ones(size(xt,2),1), 'Color', 'g')



                    end
                end
            case 'mean'
                sumtot = 0;
                f = figure('Name', "Slice-wise results axon "+axon_true, 'NumberTitle','off' );
                sgtitle(extractAfter(inputname(1), "_"))
                for slice = 1:number_of_slices
                    subplot(3,3,slice)
                    summ = mean(abs(currents(((slice-1)*number_of_slice_sources+1):(number_of_slice_sources*slice),:)),2);
                    sumtot = sumtot+summ;
                    visualize_active_pathways_complex(summ, 'r', axon_true, show);

                end

                if visualize_3D == 1
                    figure('Name', "3D Slice-wise results axon "+axon_true, 'NumberTitle','off' )
                    for slic = 1:number_of_slices
                        med = mean(abs(currents(((slic-1)*number_of_slice_sources+1):(number_of_slice_sources*slic),:)),2);
                        [xa, ya] = circle_noplot(0,0,0.4*10^-3);
                        index = find(med == max(med));
                        %disp(index);
                        [xp, yp] = circle_noplot(coord(index,1), coord(index, 2), 0.05e-3);
                        [xt,yt] = circle_noplot(coord(find(correspondences == axon_true),1), coord(find(correspondences == axon_true), 2), 0.05e-3);
                        hold on
                        grid on
                        plot3(xa, ya, z_slices(slic)*2*ones(size(xa,2),1), 'Color', 'b')
                        plot3(xp, yp, z_slices(slic)*2*ones(size(xp,2),1), 'Color', 'r')
                        plot3(xt, yt, z_slices(slic)*2*ones(size(xt,2),1), 'Color', 'g')



                    end
                end



        end
    otherwise
end
end