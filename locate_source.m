function locate_source(Sumtot)
global correspondences coord

[xq, yq] = meshgrid(-0.4*10^-3:0.001*10^-3:0.4*10^-3, -0.4*10^-3:0.001*10^-3:0.4*10^-3);
vq = griddata(coord(:,1), coord(:,2), Sumtot, xq, yq, 'cubic');
vq(isnan(vq)) = 0;
mesh(xq, yq, vq)


%hold on 
%scatter3(coord(:,1),coord(:,2), Sumtot, 'o');
%plot3(xq, yq, vq)


% xq = xq(1,:);
% yq = yq(:,1);
% % 
% TF = islocalmax(Sumtot, 'MaxNumExtrema',2);
% %TFrow = islocalmax(vq,1, "MinSeparation",400,"MaxNumExtrema",2,'SamplePoints', yq);
% index = find(TF == 1);
% figure
% plot(1:28, Sumtot,index, Sumtot(TF),'r*')

%maximum = max(max(vq));
%pixels = imregionalmax(vq);


% circle(0,0,0.4*10^-3, 'b');
% circle(xq(col), yq(row), 0.005e-3, 'r');
% circle(coord(find(correspondences == naxon),1), coord(find(correspondences == naxon), 2), 0.005e-3, 'g');
% point = [xq(col), yq(row)];
% 
% for i=1:(size(coord,1))
%     dist(i) = pdist([point;coord(i,:)], 'euclidean');
%    
%     minimum_d = min(dist);
%     index = find(dist == minimum_d);
% end
% 
% disp(minimum_d)
% disp(index)
% disp(correspondences(index))

end