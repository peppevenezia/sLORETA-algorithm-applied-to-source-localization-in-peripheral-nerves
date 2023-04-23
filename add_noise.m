function [noisy, noise, standard2] = add_noise(data, times,  number_of_electrodes, percentage, show)

standard = std(data);
standard1 = mean(standard);
standard2 = percentage*standard1;
noise = standard2.*randn(size(data,1),number_of_electrodes);
%disp("The Signal-to-Noise Ratio in dB is :"+ snr(data, noise))
noisy = data+noise;
switch show
    case 'yes'
        subplot(1,2,2)
        plot(times, [data(:,1) noisy(:,1)]);
end
end