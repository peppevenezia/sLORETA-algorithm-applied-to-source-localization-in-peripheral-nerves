function coordinates = get_coord(n_circles, n_points)

r = 0.4*10^-3; %radius of the model used in Comsol 
r_i = r/(n_circles+1); %distance between points
count_point = 1;
x = []; %x coordinates
y = []; %y coordinates


%Store the coordinates of the points created
x(count_point) =0;
y(count_point) =0;
count_point=count_point+1;

for i=1:n_circles
    radius = r_i *i;
    angle = 2*pi/n_points(i);
    
    
    x(count_point) = radius;
    y(count_point) = 0;
    
    count_point=count_point+1;
    
    
    for j=1: (n_points(i)-1)
        
        
        x(count_point) = radius*cos(angle*j);
        y(count_point) = radius*sin(angle*j);
        
        count_point=count_point+1;
        
    end
end

coordinates= [x; y]'; %Transposition of the coordinates matrix.

for i=1:size(coordinates,1)  %Fix a problem of the sinus and cosine in Matlab which at some angles are not 0 as they should be
    if abs(coordinates(i,1))<1e-15
        coordinates(i,1)=0;
    end
     if abs(coordinates(i,2))<1e-15
        coordinates(i,2)=0;
     end
end 

end