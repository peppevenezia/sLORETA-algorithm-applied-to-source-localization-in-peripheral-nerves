function currents = sLORETA(data,leadfield, noise, l)


[T,R] = Pascual_marqui(leadfield, l);



for j =1:size(data,1)
    curr(:,j) = T*data(j,:)';
    for i = 1:size(R,2)
        cur(i) = curr(i,j)^2*R(i,i)^(-1);
        

    end
    currents(:,j) = cur';
end

end