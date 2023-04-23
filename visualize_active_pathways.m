function outcome = visualize_active_pathways(sum, color, axon_true, show)
global coord correspondences
%coord = get_coord(1,8);
%correspondences = [2,9,6,4,3,7,8,5,1];
d =1;

switch length(axon_true)
    case 1
        index = find(sum == max(sum));
        outcome = correspondences(index);
    case 2
        for f = 1:size(sum,1)
            dist = sqrt((coord(:,1)-coord(f,1)).^2 + (coord(:,2)-coord(f,2)).^2);
            n = 7;
            [~, ascendIdx] = sort(dist);

            if sum(f) == max(sum([ascendIdx(1:n)]))
                maximums(d) = f;
                d = d+1;
            end

        end
        if size(maximums,2) == 1
            maximums(2) = 1;
        end
        maximums = sort(maximums);
        index = maximums(1);
        index2 = maximums(2);
        outcome = [correspondences(index), correspondences(index2)];
end




switch show
    case 'yes'
        circle(0,0,0.4*10^-3, 'k');
        for i=1:size(coord,1)

            circle(coord(i,1), coord(i,2), 0.015e-3, 'k')
            %plot(coord(i,1), coord(i,2), '.k', 'MarkerSize',20)

        end


         switch length(axon_true)
            case 1
                [x,y] = circle_noplot(coord(index,1), coord(index, 2), 0.015e-3);
                fill(x,y,'r')
                %title(index)
                [x,y] = circle_noplot(coord(find(correspondences == axon_true),1), coord(find(correspondences == axon_true), 2), 0.015e-3);
                fill(x,y,'g')
            case 2
                [x,y] = circle_noplot(coord(index,1), coord(index, 2), 0.015e-3);
                fill(x,y,'r')

                %[x,y] = circle_noplot(coord(find(correspondences == axon_true(1)),1), coord(find(correspondences == axon_true(1)), 2), 0.015e-3);
                %fill(x,y,'g')
                [x,y] = circle_noplot(coord(index2,1), coord(index2, 2), 0.015e-3);
                fill(x,y,'r')

                %[x,y] = circle_noplot(coord(find(correspondences == axon_true(2)),1), coord(find(correspondences == axon_true(2)), 2), 0.015e-3);
                %fill(x,y,'g'),
        end

    otherwise
end

% for i=1:9
%     circle(coord(i,1),coord(i,2), V(i))
% end

end
