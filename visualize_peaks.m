function outcome = visualize_peaks(sum, color, axon_true, show)
global coord correspondences weight

d=1;
sum = sum./weight;



for f = 1:size(sum,1)
    dist = sqrt((coord(:,1)-coord(f,1)).^2 + (coord(f,2)-coord(:,2)).^2);
    ind = find(dist <= 1.8*10^-4);

    if sum(f) == max(sum(ind)) && sum(f) >= 2.3 %con 20,30,40 la soglia è 2, con 10 è 2.4 per config 1e 2 e 2.3 per la config 3, con 0 è 3 per config 2,2.6 per config 1 
        maximums(d) = f;
        d = d+1;
    end

end

%maximums = sort(maximums);
for s =1:length(maximums)
    outcome(s) = correspondences(maximums(s));
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
        for h = 1:length(maximums)

            [x,y] = circle_noplot(coord(maximums(h),1), coord(maximums(h), 2), 0.015e-3);
            fill(x,y,'r')


        end

        for a=1:size(axon_true,2)
            [x,y] = circle_noplot(coord(find(correspondences == axon_true(a)),1), coord(find(correspondences == axon_true(a)), 2), 0.015e-3);
            fill(x,y,'g')
        end
        

        
    

    otherwise
end

end