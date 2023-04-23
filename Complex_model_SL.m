clear all
global correspondences coord number_of_electrodes number_of_slice_sources number_of_time_istants number_of_slices percentage_noise
number_of_electrodes = 16;
number_of_slice_sources = 28;
number_of_time_istants = 301;
number_of_slices = 7;
number_of_total_sources = number_of_slices*number_of_slice_sources;

coord = get_coord(3,[6 12 18]);
coord([9, 13, 17, 21,22,27,28,33,34], :) = [];
correspondences = [1.1,5.4, 3.1,4.6,4.2, 5.8, 6.4, 5.7, 4.3,5.1, 7.1, 5.9, 5.6, 6.2, 4.1, 4.7, 6.3,5.5 , 1.2, 6.1, 3.2, 5.2, 2.1,4.4, 3.3, 4.5, 2.2,5.3 ]';

%axons_selected = [2.2, 4.4, 5.3, 6.1, 1.2, 3.1, 1.1,2.1];
combinations2 = nchoosek(correspondences, 2);
load("Combinations3.mat");
combinations = [2.1,2.2; 2.1,1.1; 1.2,2.1; 2.1,5.3;2.1,6.1;2.1,3.1;1.2,1.1; 1.2,3.1;1.2,4.4;1.2,5.3;6.1,1.1;6.1,2.2;6.1,3.1;6.1,5.3 ; 3.1,4.4;3.1,2.2;2.2,4.4;2.2,1.1;3.1,5.3];
%combinations([2,6,7,14, 15,16],:)= [];



z_slices = [0.02+0.0027777500000000003, 0.02+0.0022222, 0.02+0.00166665, 0.02+0.0011111, 0.02+5.5555E-4, 0.02, 0.02-5.5555E-4, 0.02-0.0011111, 0.02-0.00166665, 0.02-0.0022222, 0.02-0.0027777500000000003 ]';

percentage_noise = 0.60;

data1_196 = readmatrix("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Complex model\BP\Leadfield 1-196.txt", "NumHeaderLines", 5);
leadfield = data1_196(:,2:17)';

%leadfield = rescale(leadfield);

clear  data1_196


Test{1} = correspondences;


%% 
cv = cvpartition(Test{1}, 'Holdout', 0.50);
cv1 = cvpartition(size(Test{2},1),'Holdout', 0.30 );
%cv2 = cvpartition(size(Test{3},1),'Holdout', 0.30 );
% Test{3}(training(cv2,1),:)
% Test{3}(test(cv2,1),:)
Training = {Test{1}(training(cv,1)), Test{2}(training(cv1,1),:)};
Testset = {Test{1}(test(cv,1)),Test{2}(test(cv1,1),:)};

%%

%dbstop if caught error   
lambda1 = CVE_modified1(Training, leadfield,'sloreta', 4,'complex');


%%

for d=1:size(Testset{1},1)
    estimate(Testset{1}(1),'complex', leadfield, 'sloreta',lambda1(1),'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','yes', 'no', 'no');
end


%%

%dbstop if caught error
calculate_trials_accuracy(Testset, 5,'sloreta', 'neighbors','complex', leadfield,lambda1(1));

%calculate_fascicles_accuracy(predicted_values, combinations2);
