clear all
global correspondences coord number_of_slice_sources number_of_electrodes number_of_time_istants number_of_slices percentage_noise
number_of_electrodes = 16;
number_of_slice_sources = 37;
number_of_time_istants = 301;
number_of_slices = 5;
number_of_total_sources = number_of_slices*number_of_slice_sources;
naxon = 5.3;

combinations = [1.2,2.2; 1.2,3.2; 1.2,5.3; 1.2,6.1; 5.7,2.2; 5.7, 3.2; 5.7,5.3; 5.7, 6.1 ];
correspondences = [4.1,3.1,6.1,6.2,5.1,3.2,2.1,7.1,7.2,6.3,1.1,1.2,6.4,5.2,7.3,8.1,2.2,4.2,9.1,8.2,5.3,3.3,4.3,5.4,5.5,5.6,4.4,3.4,5.7,4.5,4.6,4.7,7.4,4.8,5.8,5.9,5.11]';
correspondences = [4.1,9.1,5.1,1.1,7.1,4.2,8.1,3.1,7.2,3.2,7.3,7.4,6.1,4.3,5.2,5.3,8.2,4.4,6.2,5.4,4.5,5.5,4.6,6.3,5.6,5.7,6.4,3.3,2.1,4.7,5.8,3.4,4.8,2.2,5.9,1.2,5.11]';
combinations2 = nchoosek(correspondences, 2);

z_slices = [0.02+0.0027777500000000003, 0.02+0.0022222, 0.02+0.00166665, 0.02+0.0011111, 0.02+5.5555E-4, 0.02, 0.02-5.5555E-4, 0.02-0.0011111, 0.02-0.00166665, 0.02-0.0022222, 0.02-0.0027777500000000003 ]';
coord = get_coord(3,[6 12 18]);
percentage_noise = 0.60;


data1_185 = readmatrix("C:\Users\Giuseppe Venezia\OneDrive - Politecnico di Milano\PNRelay Loreta Giuseppe Venezia\2_materiale\COMSOL\Base model\BP\Leadfield\Surface_electrodes\37_axons\1-185.txt", "NumHeaderLines", 5);
leadfield = data1_185(:,2:17)';

%leadfield = rescale(leadfield);

clear  data1_185

Test{1} = correspondences;
Test{2} = combinations;


%%
cv = cvpartition(Test{1}, 'Holdout', 0.40);
cv1 = cvpartition(size(Test{2},1),'Holdout', 0.30 );
%cv2 = cvpartition(size(Test{3},1),'Holdout', 0.30 );
% Test{3}(training(cv2,1),:)
% Test{3}(test(cv2,1),:)
Training = {Test{1}(training(cv,1)), Test{2}(training(cv1,1),:)};
Testset = {Test{1}(test(cv,1)),Test{2}(test(cv1,1),:)};


%% Minimization of the minimum norm estimates using different weighthing functions


%dbstop if caught error 
lambda = CVE_modified1(Training, leadfield,'sloreta', 3,'simple');


%%


estimate(5.2, 'simple', leadfield, 'sloreta',1e07,'wsum', number_of_electrodes, number_of_slices, number_of_slice_sources, percentage_noise,'no','yes', 'no', 'no');



%%

%dbstop if caught error
calculate_trials_accuracy(Test, 5,'sloreta', 'neighbors','simple', leadfield, lambda);


