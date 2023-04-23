function outcome = visualize_active_pathways_complex(sum, color, axon_true, show)
global coord correspondences weight

%sum = sum./weight;


sorted = sort(sum, 'descend');
max1 = max(sum(1:7));
max2 = max(sum([9,10,11, 18,19,20,21]));
max3 = max(sum([12,13,14,22,23,24,25]));
max4 = max(sum([8,15,16,17,26,27,28]));

d= 1;


switch length(axon_true)
    case 1
        index = find(sum == sorted(1));
        outcome = correspondences(index);

        
    case 2
                maximums = sort([max1;max2;max3;max4], 'descend');
                index = find(sum == maximums(1));
                index2 = find(sum == maximums(2));
                outcome = [correspondences(index), correspondences(index2)];

%         for f = 1:size(sum,1)
%             dist = sqrt((coord(:,1)-coord(f,1)).^2 + (coord(:,2)-coord(f,2)).^2);
%             n = 7;
%             [~, ascendIdx] = sort(dist);
% 
%             if sum(f) == max(sum([ascendIdx(1:n)]))
%                 maximums(d) = f;
%                 d = d+1;
%             end
% 
%         end
%         if size(maximums,2) == 1
%             maximums(2) = 1;
%         end
%         maximums = sort(maximums);
%         index = maximums(1);
%         index2 = maximums(2);
%         outcome = [correspondences(index), correspondences(index2)];
    case 3
        maximums = sort([max1;max2;max3;max4], 'descend');
        index = find(sum == maximums(1));
        index2 = find(sum == maximums(2));
        index3 = find(sum == maximums(3));
        outcome = [correspondences(index), correspondences(index2), correspondences(index3)];
end


switch show
    case 'yes'
        circle(0,0,0.4*10^-3, 'k');
        circle(0,0,0.150*10^-3, 'k');
        circle(0,0.28*10^-3,0.080*10^-3, 'k');
        circle(-2.424871131E-4,-1.4E-4,0.080*10^-3, 'k');
        circle(2.424871131E-4,-1.4E-4,0.080*10^-3, 'k');
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
                [x,y] = circle_noplot(coord(index2,1), coord(index2, 2), 0.015e-3);
                fill(x,y,'r')
                [x,y] = circle_noplot(coord(find(correspondences == axon_true(1)),1), coord(find(correspondences == axon_true(1)), 2), 0.015e-3);
                fill(x,y,'g')


                [x,y] = circle_noplot(coord(find(correspondences == axon_true(2)),1), coord(find(correspondences == axon_true(2)), 2), 0.015e-3);
                fill(x,y,'g'),
            case 3
                [x,y] = circle_noplot(coord(index,1), coord(index, 2), 0.015e-3);
                fill(x,y,'r')
                [x,y] = circle_noplot(coord(index2,1), coord(index2, 2), 0.015e-3);
                fill(x,y,'r')
                [x,y] = circle_noplot(coord(index3,1), coord(index3, 2), 0.015e-3);
                fill(x,y,'r')
                [x,y] = circle_noplot(coord(find(correspondences == axon_true(1)),1), coord(find(correspondences == axon_true(1)), 2), 0.015e-3);
                fill(x,y,'g')
                [x,y] = circle_noplot(coord(find(correspondences == axon_true(2)),1), coord(find(correspondences == axon_true(2)), 2), 0.015e-3);
                fill(x,y,'g')

                [x,y] = circle_noplot(coord(find(correspondences == axon_true(3)),1), coord(find(correspondences == axon_true(2)), 2), 0.015e-3);
                fill(x,y,'g')
            
        end
    

    otherwise
end



end
