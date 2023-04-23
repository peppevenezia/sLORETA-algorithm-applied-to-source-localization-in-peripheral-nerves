function [data, time] = read_and_plot_data(filename, show)
data_electrodes = readmatrix(filename, 'NumHeaderLines', 5);

data = [];
time = data_electrodes(:,1);
data(:,1:16) = data_electrodes(:,2:17);
switch show
    case 'yes'
        figure
        subplot(1,2,1)
        % Plots all the current plots superimposed
        for i = 1:16
            plot(time, data(:,i))
            hold on
        end
end
end